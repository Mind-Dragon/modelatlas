#!/usr/bin/env bash
# launch-deerflow-modeldb.sh — Re-run the ModelAtlas DeerFlow research swarm
#
# Requires: hermes CLI with DeerFlow swarm capability
# Launches 7 parallel domain research agents, then a synthesis agent
# that normalises findings into FINAL-SYNTHESIS.md.
#
# Usage:  bash .swarm/launch-deerflow-modeldb.sh

set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "--- Domain 1: OpenAI ---"
(cd "$DIR" && hermes run .swarm/domain1-openai.txt --out DOMAIN1-OPENAI.md &)
PID1=$!

echo "--- Domain 2: Anthropic ---"
(cd "$DIR" && hermes run .swarm/domain2-anthropic.txt --out DOMAIN2-ANTHROPIC.md &)
PID2=$!

echo "--- Domain 3: Google ---"
(cd "$DIR" && hermes run .swarm/domain3-google.txt --out DOMAIN3-GOOGLE.md &)
PID3=$!

echo "--- Domain 4: xAI + DeepSeek ---"
(cd "$DIR" && hermes run .swarm/domain4-xai-deepseek.txt --out DOMAIN4-XAI-DEEPSEEK.md &)
PID4=$!

echo "--- Domain 5: Chinese Providers ---"
(cd "$DIR" && hermes run .swarm/domain5-chinese-providers.txt --out DOMAIN5-CHINESE-PROVIDERS.md &)
PID5=$!

echo "--- Domain 6: Mistral + Aggregators ---"
(cd "$DIR" && hermes run .swarm/domain6-mistral-aggregators.txt --out DOMAIN6-MISTRAL-AGGREGATORS.md &)
PID6=$!

echo "--- Domain 7: Others ---"
(cd "$DIR" && hermes run .swarm/domain7-others.txt --out DOMAIN7-OTHERS.md &)
PID7=$!

echo "Waiting for domain agents..."
for pid in "$PID1" "$PID2" "$PID3" "$PID4" "$PID5" "$PID6" "$PID7"; do
    wait "$pid"
done

echo "--- Synthesis ---"
(cd "$DIR" && hermes run .swarm/synthesis-modeldb.txt --out FINAL-SYNTHESIS.md)

echo "--- Generating exports ---"
python3 "$DIR/generate-exports.py"

echo "Done."

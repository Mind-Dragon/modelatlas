#!/bin/bash
# launch-deerflow-modeldb.sh — Hermes Modeler DeerFlow Research Swarm
# Spawns 7 parallel domain research agents, then synthesis when all done.

set -euo pipefail

OUTDIR=/home/work/hermesfixes/deerflow-modeldb
SWARMDIR=$OUTDIR/.swarm
LOGDIR=/tmp/deerflow-modeldb
PIDFILE=$SWARMDIR/PIDLIST.md
MANIFEST=$SWARMDIR/lanes-manifest.tsv

mkdir -p "$LOGDIR"

echo "# PIDLIST - DeerFlow ModelDB Swarm" > "$PIDFILE"
echo "launched_at: $(date)" >> "$PIDFILE"
echo "" > "$MANIFEST"

# Domain | provider | model | log | output
DOMAINS=(
  "DOMAIN1-OPENAI|openai-codex|gpt-5.4-mini|$LOGDIR/d1-openai.log|$OUTDIR/DOMAIN1-OPENAI.md"
  "DOMAIN2-ANTHROPIC|opencode|claude-haiku-4-5|$LOGDIR/d2-anthropic.log|$OUTDIR/DOMAIN2-ANTHROPIC.md"
  "DOMAIN3-GOOGLE|opencode|gemini-3-flash|$LOGDIR/d3-google.log|$OUTDIR/DOMAIN3-GOOGLE.md"
  "DOMAIN4-XAI-DEEPSEEK|crof.ai|deepseek-v4-flash|$LOGDIR/d4-xai-deepseek.log|$OUTDIR/DOMAIN4-XAI-DEEPSEEK.md"
  "DOMAIN5-CHINESE-PROVIDERS|crof.ai|qwen3.6-27b|$LOGDIR/d5-chinese.log|$OUTDIR/DOMAIN5-CHINESE-PROVIDERS.md"
  "DOMAIN6-MISTRAL-AGGREGATORS|opencode|big-pickle|$LOGDIR/d6-mistral.log|$OUTDIR/DOMAIN6-MISTRAL-AGGREGATORS.md"
  "DOMAIN7-OTHERS|opencode|hy3-preview-free|$LOGDIR/d7-others.log|$OUTDIR/DOMAIN7-OTHERS.md"
)

PIDS=()

echo "=== DeerFlow ModelDB Swarm Launch $(date) ==="
echo "Target: $OUTDIR"
echo ""

for entry in "${DOMAINS[@]}"; do
  IFS='|' read -r domain provider model logfile output <<< "$entry"

  # Map domain name to prompt file
  num="${domain#DOMAIN}"
  num="${num%%-*}"
  prompt_file="$SWARMDIR/domain${num}-*"

  # Find the actual prompt file
  prompt_path=""
  case "$num" in
    1) prompt_path="$SWARMDIR/domain1-openai.txt" ;;
    2) prompt_path="$SWARMDIR/domain2-anthropic.txt" ;;
    3) prompt_path="$SWARMDIR/domain3-google.txt" ;;
    4) prompt_path="$SWARMDIR/domain4-xai-deepseek.txt" ;;
    5) prompt_path="$SWARMDIR/domain5-chinese-providers.txt" ;;
    6) prompt_path="$SWARMDIR/domain6-mistral-aggregators.txt" ;;
    7) prompt_path="$SWARMDIR/domain7-others.txt" ;;
  esac

  if [ ! -f "$prompt_path" ]; then
    echo "  [SKIP] $domain - prompt missing at $prompt_path"
    continue
  fi

  echo "  Spawning $domain ($provider/$model) -> $(basename "$output")"

  hermes chat -q "$(cat "$prompt_path")" \
    --provider "$provider" -m "$model" \
    -t terminal,file,search,web \
    --max-turns 99999 \
    > "$logfile" 2>&1 &
  
  pid=$!
  PIDS+=("$pid")
  echo "- $domain: PID $pid ($provider/$model)" >> "$PIDFILE"
  echo "$domain|$pid|$provider|$model|spawned|$(date +%s)" >> "$MANIFEST"
done

echo ""
echo "=== All ${#PIDS[@]} domain agents spawned at $(date) ==="
echo "PIDs: ${PIDS[*]}"

# Wait for all domain agents
echo "Waiting for domain agents to finish..."
for pid in "${PIDS[@]}"; do
  wait "$pid" 2>/dev/null || true
  echo "  PID $pid completed"
done

echo "=== All domain agents finished at $(date) ==="

# Check which output files exist
echo ""
echo "=== Output file status ==="
ALL_PRESENT=true
for entry in "${DOMAINS[@]}"; do
  IFS='|' read -r domain _ _ _ output <<< "$entry"
  if [ -f "$output" ] && [ -s "$output" ]; then
    lines=$(wc -l < "$output")
    echo "  [OK] $(basename "$output") ($lines lines)"
  else
    echo "  [MISSING] $(basename "$output")"
    ALL_PRESENT=false
  fi
done

if [ "$ALL_PRESENT" = false ]; then
  echo ""
  echo "WARNING: Some domain output files missing. Synthesis may be incomplete."
  echo "Check logs in $LOGDIR for details."
fi

# Now launch synthesis agent
echo ""
echo "=== Launching synthesis agent ==="

hermes chat -q "$(cat "$SWARMDIR/synthesis-modeldb.txt")" \
  --provider crof.ai -m deepseek-v4-flash \
  -t terminal,file,search,web \
  --max-turns 99999 \
  > "$LOGDIR/synthesis.log" 2>&1

echo "=== Synthesis agent finished at $(date) ==="

# Final status
echo ""
echo "=== FINAL DELIVERABLES ==="
ls -lh "$OUTDIR/"*.md 2>/dev/null
echo ""
echo "=== DeerFlow ModelDB Swarm Complete ==="

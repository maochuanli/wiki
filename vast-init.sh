#!/bin/bash
set -e

echo "=== Starting custom onstart script ==="

mkdir -p /workspace/models
cd /workspace/models

echo "Downloading Qwen3.5-35B-A3B Q4_K_S.gguf (this may take 10-40 minutes depending on network)..."
huggingface-cli download unsloth/Qwen3.5-35B-A3B-GGUF \
  Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --local-dir . --local-dir-use-symlinks False

echo "✅ Download finished. Starting llama-server..."

llama-server \
  -m /workspace/models/Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --port 18000 \
  -c 8192 \
  --jinja \
  -ngl 99 \
  --host 0.0.0.0 \
  --flash-attn \
  > /workspace/llama-server.log 2>&1 &

echo "llama-server is running in background."
echo "Monitor logs with: tail -f /workspace/llama-server.log"

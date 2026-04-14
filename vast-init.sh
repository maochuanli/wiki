#!/bin/bash
set -e

echo "=== Starting custom onstart script for Qwen3.5-35B-A3B ==="

mkdir -p /workspace/models
cd /workspace/models

echo "Downloading Qwen3.5-35B-A3B Q4_K_S.gguf (this may take 10-40 minutes)..."
huggingface-cli download unsloth/Qwen3.5-35B-A3B-GGUF \
  Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --local-dir . --local-dir-use-symlinks False

echo "✅ Model download finished. Starting llama-server..."

llama-server \
  -m /workspace/models/Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --port 18000 \
  -c 8192 \
  --jinja \
  -ngl 99 \
  --host 0.0.0.0 \
  --flash-attn \
  > /workspace/llama-server.log 2>&1 &

echo "llama-server started in background (PID: $!)."
echo "Monitor logs with: tail -f /workspace/llama-server.log"
echo "Server should be available at port 18000 shortly."

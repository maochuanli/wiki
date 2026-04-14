#!/bin/bash
set -e

echo "=== Starting custom onstart script for Qwen3.5-35B-A3B Q4_K_S ==="

mkdir -p /workspace/models
cd /workspace/models

echo "Downloading Qwen3.5-35B-A3B Q4_K_S.gguf (~21 GB, this may take 10-40 minutes)..."

# Enable faster download if possible
export HF_HUB_ENABLE_HF_TRANSFER=1

huggingface-cli download unsloth/Qwen3.5-35B-A3B-GGUF \
  Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --local-dir . --local-dir-use-symlinks False

echo "✅ Model successfully downloaded!"

echo "Starting llama-server on port 18000..."

llama-server \
  -m /workspace/models/Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --port 18000 \
  -c 8192 \
  --jinja \
  -ngl 99 \
  --host 0.0.0.0 \
  --flash-attn \
  > /workspace/llama-server.log 2>&1 &

SERVER_PID=$!
echo "llama-server started in background (PID: $SERVER_PID)"
echo "Monitor logs: tail -f /workspace/llama-server.log"

# Optional: Simple health check (uncomment if you want)
# echo "Waiting for server to be ready..."
# for i in {1..60}; do
#   if curl -s http://localhost:18000/health > /dev/null; then
#     echo "✅ Server is ready and responding!"
#     break
#   fi
#   sleep 10
# done

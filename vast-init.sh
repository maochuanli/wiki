#!/bin/bash
set -e

echo "=== Starting custom onstart script for Qwen3.5-35B-A3B Q4_K_S ==="

mkdir -p /workspace/models
cd /workspace/models

echo "Downloading Qwen3.5-35B-A3B-Q4_K_S.gguf using llama.cpp built-in downloader..."
echo "(This may take 15-50 minutes depending on network speed)"

# Use llama-server's built-in HF downloader (most reliable in this image)
llama-server \
  -hf unsloth/Qwen3.5-35B-A3B-GGUF:Qwen3.5-35B-A3B-Q4_K_S.gguf \
  --port 18000 \
  -c 8192 \
  --jinja \
  -ngl 99 \
  --host 0.0.0.0 \
  --flash-attn \
  > /workspace/llama-server.log 2>&1 &

SERVER_PID=$!
echo "llama-server started in background (PID: $SERVER_PID)"
echo "It is downloading the model automatically..."
echo "Monitor progress with: tail -f /workspace/llama-server.log"
echo "Server will be ready on port 18000 once download + loading completes."

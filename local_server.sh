#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate llamacpp

#MODEL_NAME=dolphin-gguf/dolphin-2.9.1-yi-1.5-34b.Q8_0.gguf
#MODEL_NAME=dolphin-gguf/dolphin-2.9-llama3-70b.Q4_K_M.gguf
#MODEL_NAME=DeepSeek-R1-Distill-Qwen-32B-GGUF/DeepSeek-R1-Distill-Qwen-32B-Q4_K_M.gguf
#MODEL_NAME=Qwen/Qwen3-30B-A3B-Thinking-2507-Deepseek-v3.1-Distill-Q8_0.gguf
MODEL_NAME=Qwen/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf

NGL_NUM=9999
#NGL_NUM=40 #9999


MODEL_PATH=/media/home/hangyu5/Documents/Hugging-Face/$MODEL_NAME

./build/bin/llama-server \
    -v \
    -m $MODEL_PATH \
    -c 8192 \
    -cb \
    --port 5051 \
    -ngl $NGL_NUM
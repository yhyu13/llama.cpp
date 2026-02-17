#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate llamacpp

#MODEL_NAME=dolphin-gguf/dolphin-2.9.1-yi-1.5-34b.Q8_0.gguf
#MODEL_NAME=dolphin-gguf/dolphin-2.9-llama3-70b.Q4_K_M.gguf
#MODEL_NAME=DeepSeek-R1-Distill-Qwen-32B-GGUF/DeepSeek-R1-Distill-Qwen-32B-Q4_K_M.gguf
#MODEL_NAME=Qwen/Qwen3-30B-A3B-Thinking-2507-Deepseek-v3.1-Distill-Q8_0.gguf
#MODEL_NAME=Qwen/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf
#MODEL_NAME=Qwen/Qwen3-Omni-30B-A3B-Thinking-GGUF-mmproj-q4_k_s.gguf
#MODEL_NAME=CPM/MiniCPM-o-4_5-gguf/MiniCPM-o-4_5-Q8_0.gguf
MODEL_NAME=CPM/MiniCPM-o-4_5-gguf/MiniCPM-o-4_5-Q6_K.gguf

NGL_NUM=9999
#NGL_NUM=40 #9999


MODEL_PATH=/media/home/hangyu5/Documents/Hugging-Face/$MODEL_NAME

CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 CUDA_VISIBLE_DEVICES=1 ./build/bin/llama-server \
    -v \
    -m $MODEL_PATH \
    --rope-scaling yarn --rope-scale 8 \
    -c 32000 -cb -n -1 \
    --cache-ram -1 --mlock \
    -ctk q4_1 -ctv q4_1 -kvu \
    --port 5051 \
    -ngl $NGL_NUM
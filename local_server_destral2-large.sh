#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate llamacpp

#MODEL_NAME=dolphin-gguf/dolphin-2.9.1-yi-1.5-34b.Q8_0.gguf
#MODEL_NAME=dolphin-gguf/dolphin-2.9-llama3-70b.Q4_K_M.gguf
#MODEL_NAME=DeepSeek-R1-Distill-Qwen-32B-GGUF/DeepSeek-R1-Distill-Qwen-32B-Q4_K_M.gguf
#MODEL_NAME=Qwen/Qwen3-30B-A3B-Thinking-2507-Deepseek-v3.1-Distill-Q8_0.gguf
#MODEL_NAME=Qwen/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf
#MODEL_NAME=GLM/AutoGLM-Phone-9B.Q8_0.gguf
#MODEL_NAME=GLM/GLM-4.7-Flash-Q6_K.gguf
#MODEL_NAME=GLM/GLM-4.7-Flash-REAP-23B-A3B-Q8_0.gguf
#MODEL_NAME=GLM/GLM-4.7-Flash-REAP-23B-A3B-UD-IQ1_M.gguf
#MODEL_NAME=Qwen/Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf
#MODEL_NAME=Nvidia/Nemotron-3-Nano-30B-A3B-Q4_K_M.gguf
#MODEL_NAME=Nvidia/Nemotron-3-Nano-30B-A3B-Q8_0.gguf
#MODEL_NAME=Qwen/Qwen3-Coder-Next-GGUF/Q6_K_merge.gguf
#MODEL_NAME=Qwen/Qwen3-Coder-Next-GGUF/Q8_0_merge.gguf
#MODEL_NAME=Qwen/Qwen3-Coder-Next-GGUF/Qwen3-Coder-Next-UD-Q3_K_XL.gguf
MODEL_NAME=mistral/Devstral-2-123B-Instruct-2512-GGUF/Devstral-2-123B-Instruct-2512-UD-IQ2_XXS.gguf

NGL_NUM=9999
#NGL_NUM=40 #9999


MODEL_PATH=/media/home/hangyu5/Documents/Hugging-Face/$MODEL_NAME

#https://unsloth.ai/docs/models/qwen3-coder-next#llama-server-serving-and-deployment
#-v \
#-sm row # row split is slower than pipeline split 
#--special
#--temp 0.6 --top-k 20 --top-p 0.95 --min-p 0
#--cpu-moe
# 500p/s 10t/s (can code very good)
CUDA_SCALE_LAUNCH_QUEUES=4x GGML_CUDA_ENABLE_UNIFIED_MEMORY=1 CUDA_VISIBLE_DEVICES=0,1 ./build/bin/llama-server \
    -m $MODEL_PATH \
    -c 128000 \
    --cache-ram -1 \
    --host 127.0.0.1 --port 5051 \
    -ngl $NGL_NUM -fa on \
    -ctk q4_1 -ctv q4_1 -kvu  \
    -t 23 -tb 23 \
    --jinja --reasoning-format deepseek --reasoning-budget -1 \
    --temp 1.0 --top-k 40 --top-p 0.95 --min-p 0.01 --seed 3407
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
MODEL_NAME=Nvidia/Nemotron-3-Nano-30B-A3B-Q8_0.gguf


NGL_NUM=9999
#NGL_NUM=40 #9999


MODEL_PATH=/media/home/hangyu5/Documents/Hugging-Face/$MODEL_NAME

#https://qwen.readthedocs.io/en/latest/run_locally/llama.cpp.html
#-v \
#-sm row # row split is slower than pipeline split 
#--special
#--temp 0.6 --top-k 20 --top-p 0.95 --min-p 0
./build/bin/llama-server \
    -m $MODEL_PATH \
    -c 1048576 -cb -n -1 \
    --cache-ram -1 --mlock \
    -ctk q8_0 -ctv q8_0 \
    --host 127.0.0.1 --port 5051 --parallel -1 \
    -ngl $NGL_NUM -fa on \
    --threads 32 \
    --jinja --reasoning-format deepseek \
    --temp 0.6 --top-k 20 --top-p 0.95 --min-p 0
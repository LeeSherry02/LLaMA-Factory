#!/bin/bash

# 设置环境变量
export CUDA_VISIBLE_DEVICES=0,1
export FORCE_TORCHRUN=1

# 运行训练命令
llamafactory-cli train /remote-home/xiaoyili/2025-Medical/LLaMA-Factory/lxy/train/qwen_full_sft.yaml
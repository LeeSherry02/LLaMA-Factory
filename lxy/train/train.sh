#!/bin/bash

DATASET="huatuo_26m_lite"
# 'MedThoughts-8K'
PER_DEVICE_TRAIN_BATCH_SIZE=1
GRADIENT_ACCUMULATION_STEPS=16
NUM_TRAIN_EPOCHS=5.0  # 添加 num_train_epochs 变量
LEARNING_RATE=1.0e-6  # 添加 learning_rate 变量
CUTOFF_LEN=1024

# wandb信息
WANDB_PROJECT="qwen_full_sft"
WANDB_NAME="${DATASET}_${LEARNING_RATE}_${CUTOFF_LEN}"

# 修改yaml文件配置
YAML_FILE="/remote-home/xiaoyili/2025-Medical/LLaMA-Factory/lxy/train/qwen_full_sft_wandb.yaml"
MODEL_NAME_OR_PATH='/remote-home/xiaoyili/2025-Medical/model/Qwen/Qwen2___5-1___5B'
OUTPUT_DIR="/remote-home/xiaoyili/2025-Medical/LLaMA-Factory/lxy/saves/qwen2.5-1.5b/${DATASET}/${LEARNING_RATE}/${CUTOFF_LEN}"

# 备份文件名称
YAML_FILE_BAK="${YAML_FILE}.bak"

# 2、设置环境变量
export CUDA_VISIBLE_DEVICES=0,1
export FORCE_TORCHRUN=1

export WANDB_MODE=online
export WANDB_PROJECT="${WANDB_PROJECT}"
export WANDB_NAME="${WANDB_NAME}"

# 设置 PYTORCH_CUDA_ALLOC_CONF 环境变量
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

# 备份原始 YAML 文件
cp "${YAML_FILE}" "${YAML_FILE_BAK}"

# 使用 sed 命令替换 YAML 文件中的变量
sed -i "s|dataset: .*|dataset: ${DATASET}|" "${YAML_FILE}"
sed -i "s|model_name_or_path: .*|model_name_or_path: ${MODEL_NAME_OR_PATH}|" "${YAML_FILE}"
sed -i "s|output_dir: .*|output_dir: ${OUTPUT_DIR}|" "${YAML_FILE}"
sed -i "s|per_device_train_batch_size: .*|per_device_train_batch_size: ${PER_DEVICE_TRAIN_BATCH_SIZE}|" "${YAML_FILE}"
sed -i "s|gradient_accumulation_steps: .*|gradient_accumulation_steps: ${GRADIENT_ACCUMULATION_STEPS}|" "${YAML_FILE}"
sed -i "s|run_name: .*|run_name: ${WANDB_NAME}|" "${YAML_FILE}"
sed -i "s|num_train_epochs: .*|num_train_epochs: ${NUM_TRAIN_EPOCHS}|" "${YAML_FILE}"  # 添加 num_train_epochs 替换
sed -i "s|learning_rate: .*|learning_rate: ${LEARNING_RATE}|" "${YAML_FILE}"  # 添加 learning_rate 替换
sed -i "s|cutoff_len: .*|cutoff_len: ${CUTOFF_LEN}|" "${YAML_FILE}"  # 添加 cutoff_len 替换

# 3、运行训练命令
llamafactory-cli train "${YAML_FILE}"

# 恢复原始 YAML 文件（可选）
# mv "${YAML_FILE_BAK}" "${YAML_FILE}"
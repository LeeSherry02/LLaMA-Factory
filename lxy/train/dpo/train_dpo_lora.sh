
DATASET="Medcraft-dpo-2000-random"
# 'Medcraft-dpo-2172'
MODEL_NAME_OR_PATH="/data/lxy/LLaMA-Factory/lxy/saves/llama_3.1_8b/Med-BM,Medcraft-28655,Medcraft-9928/5.0e-6/1024"

MODEL='llama_3.1_8b'
OUTPUT_DIR="/data/lxy/LLaMA-Factory/lxy/saves/${MODEL}/dpo/${DATASET}"

# wandb信息
WANDB_PROJECT="llama_lora_dpo"
WANDB_NAME="${DATASET}"


# 环境变量
export CUDA_VISIBLE_DEVICES=4,5,6,7
export FORCE_TORCHRUN=1

export WANDB_MODE=online
export WANDB_PROJECT="${WANDB_PROJECT}"
export WANDB_NAME="${WANDB_NAME}"

export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

# 修改yaml文件配置
YAML_FILE="/data/lxy/LLaMA-Factory/lxy/train/dpo/llama3_lora_dpo.yaml"

sed -i "s|output_dir: .*|output_dir: ${OUTPUT_DIR}|" "${YAML_FILE}"
sed -i "s|model_name_or_path: .*|model_name_or_path: ${MODEL_NAME_OR_PATH}|" "${YAML_FILE}"


llamafactory-cli train "${YAML_FILE}"
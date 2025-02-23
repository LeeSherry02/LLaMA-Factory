import torch

args_file = '/remote-home/xiaoyili/2025-Medical/LLaMA-Factory/lxy/saves/qwen2.5-1.5b/full/sft/training_args.bin'
args = torch.load(args_file, weights_only=False)
print(args)
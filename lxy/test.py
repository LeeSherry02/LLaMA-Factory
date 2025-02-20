import subprocess

# 终止所有进程（除了发起该命令的进程）
subprocess.run(['pkill', '-9', '-f', 'python'])
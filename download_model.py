"""Download WAN 2.6 I2V model weights for baking into Docker image."""
import os, sys, time
from huggingface_hub import snapshot_download

MODEL_ID = "Wan-AI/Wan2.2-I2V-A14B-Diffusers"
TARGET = "/models/wan26-i2v"

os.makedirs(TARGET, exist_ok=True)
os.environ["HF_HUB_ENABLE_HF_TRANSFER"] = "1"

print(f"[BAKE] Downloading {MODEL_ID}...", flush=True)
t0 = time.time()

for attempt in range(1, 4):
    try:
        snapshot_download(
            repo_id=MODEL_ID,
            local_dir=TARGET,
            local_dir_use_symlinks=False,
            resume_download=True,
            ignore_patterns=["*.safetensors.md5", "*.git*"]
        )
        print(f"[BAKE] Done in {time.time()-t0:.1f}s", flush=True)
        break
    except Exception as e:
        print(f"[BAKE] Attempt {attempt} failed: {e}", flush=True)
        if attempt < 3:
            time.sleep(attempt * 10)
else:
    print("[BAKE] All attempts failed!", flush=True)
    sys.exit(1)

# Verify
file_count = sum(len(files) for _, _, files in os.walk(TARGET))
print(f"[BAKE] {file_count} files in {TARGET}", flush=True)

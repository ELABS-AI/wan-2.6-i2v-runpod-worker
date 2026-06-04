FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
LABEL maintainer="E-Labs AI Studio" description="Wan 2.6 Image-to-Video — flashboot-ready, model cached on first request"

ENV DEBIAN_FRONTEND=noninteractive PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1
ENV PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir torch==2.6.0 torchvision==0.21.0 \
    --index-url https://download.pytorch.org/whl/cu124

WORKDIR /workspace
COPY requirements-runpod.txt requirements-runpod.txt
RUN pip install --no-cache-dir -r requirements-runpod.txt

COPY handler.py /workspace/handler.py

# Model cache directory for persistent storage across flashboot restarts
ENV HF_HOME=/models/hf_cache

CMD ["python", "-u", "handler.py"]

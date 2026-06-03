FROM ghcr.io/andrewembry312-hub/elabs-server/wan26-i2v-runpod:latest
LABEL maintainer="E-Labs AI Studio" description="Wan 2.6 I2V RunPod Worker"
ENV DEBIAN_FRONTEND=noninteractive PYTHONUNBUFFERED=1
WORKDIR /workspace
COPY handler.py /workspace/handler.py
CMD ["python", "-u", "handler.py"]

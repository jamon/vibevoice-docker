# NVIDIA PyTorch base
FROM nvcr.io/nvidia/pytorch:24.07-py3

ENV DEBIAN_FRONTEND=noninteractive

# System deps: git for cloning, ffmpeg for the demo
RUN apt-get update && \
    apt-get install -y --no-install-recommends git ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Clone VibeVoice
WORKDIR /opt
RUN git clone https://github.com/microsoft/VibeVoice.git

# Install
WORKDIR /opt/VibeVoice
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -e .

# Demo port
EXPOSE 7860

# Launch demo
CMD ["python", "demo/gradio_demo.py", "--model_path", "WestZhang/VibeVoice-Large-pt", "--share"]

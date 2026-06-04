# elabs / Wan 2.6 Image-to-Video

[![Deploy on RunPod](https://img.shields.io/badge/RunPod-Deploy-orange?logo=runpod)](https://console.runpod.io/hub)
[![CUDA 12.4](https://img.shields.io/badge/CUDA-12.4-green)](https://developer.nvidia.com/cuda-toolkit)
[![Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue)](https://opensource.org/licenses/Apache-2.0)

**Image-to-video generation** with Wan 2.6. Animate any image with natural motion. Configurable duration (2-8 seconds), frame rate, and motion strength.

![Wan I2V](https://pub-796a08821c1c483aaf5e274e0d03e350.r2.dev/hub-icons/wan-i2v.svg)

## Highlights

- Single image to video -- animate any photo or illustration
- 2-8 second output -- configurable duration
- Natural motion -- smooth temporal consistency, no flickering
- Motion strength control -- subtle to dramatic animation
|- Lazy model download from HuggingFace -- efficient image size (~4GB)

## Quick Start

```bash
curl -X POST https://api.runpod.ai/v2/{ENDPOINT_ID}/run \
  -H "Authorization: Bearer $RUNPOD_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"input": {"image_base64": "<base64 PNG>", "prompt": "Camera slowly pans right", "duration_seconds": 4}}'
```

## API

### Input

```json
{
  "input": {
    "image_base64": "<base64 PNG or JPG>",
    "prompt": "Camera slowly pans right, cinematic",
    "duration_seconds": 4,
    "fps": 24,
    "motion_strength": 0.8,
    "seed": -1
  }
}
```

### Output

```json
{
  "video_base64": "<base64 MP4>",
  "prompt": "Camera slowly pans right, cinematic",
  "duration_s": 4,
  "fps": 24,
  "seed": 12345,
  "wall_time_s": 45.0
}
```

### Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `image_base64` | string | required | Base64 PNG/JPG input image |
| `prompt` | string | `""` | Motion description |
| `duration_seconds` | float | `4.0` | Video length in seconds (2.0-8.0) |
| `fps` | int | `24` | Frames per second (16, 24) |
| `motion_strength` | float | `0.8` | Motion intensity (0.1=subtle, 1.0=strong) |
| `seed` | int | `-1` | Seed (-1 = random) |
| `width` | int | `832` | Output width |
| `height` | int | `480` | Output height |

## Supported Resolutions

| Resolution | Width | Height |
|---|---|---|
| 480p 16:9 | 832 | 480 |
| 720p 16:9 | 1280 | 720 |
| 480p 1:1 | 480 | 480 |

## GPU Requirements

- Minimum: >=16GB VRAM
- Recommended: RTX 4090, L40S, A6000 (>=24GB)
- CUDA: 12.4+

## License

Apache-2.0. Based on [Wan-AI/Wan2.1-I2V](https://huggingface.co/Wan-AI).

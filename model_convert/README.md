# Environment Setup Guide

## 1. YOLO Model Preparation
First, install the required Python packages, prepare the YOLO model in ONNX format, and perform preprocessing for AXERA.

```bash
# Install required packages
UbuntuPC$ pip install ultralytics onnx
# Export and preprocess YOLO model
UbuntuPC$ python yolo_export.py
UbuntuPC$ python yolo_onnx_cut.py
```

## 2. Starting Pulsar2 Docker Container
Launch the Pulsar2 compiler as a Docker container. You need to download the image file beforehand.

**Loading the image**
```bash
UbuntuPC$ sudo docker load -i ax_pulsar2_4.0.tar.gz
```

**Starting the container**
```bash
UbuntuPC$ sudo docker run -it --net host --rm -v $PWD:/data pulsar2:4.0
```

## Model Conversion Execution
Use the pulsar2 command inside the Docker container to convert the model. Please select appropriate parameters according to your target hardware and NPU configuration.

### Conversion Example for AX630C
```bash
## Generate 8-bit quantized version
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u8.json --target_hardware AX620E --npu_mode NPU1 --input yolo11n-cut.onnx --output_name yolo11n_u8_AX620E_NPU1.axmodel
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u8.json --target_hardware AX620E --npu_mode NPU2 --input yolo11n-cut.onnx --output_name yolo11n_u8_AX620E_NPU2.axmodel
## Generate 16-bit quantized version
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u16.json --target_hardware AX620E --npu_mode NPU1 --input yolo11n-cut.onnx --output_name yolo11n_u16_AX620E_NPU1.axmodel
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u16.json --target_hardware AX620E --npu_mode NPU2 --input yolo11n-cut.onnx --output_name yolo11n_u16_AX620E_NPU2.axmodel
```
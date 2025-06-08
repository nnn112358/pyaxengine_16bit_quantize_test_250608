# YOLO11/12 16-bit quantization n/s-size model error

## Issue Description
When attempting to run 16-bit quantized YOLO11/12 models (n and s sizes) on M5Stack LLM630, the models fail to load and execute, while 8-bit quantized versions work correctly. Larger models (m, l, x) work fine with both 8-bit and 16-bit quantization.
This issue does not appear to be related to pyaxengine. The root cause is suspected to be in pulsar2 or the SDK.

## Environment
- **Hardware**: M5Stack LLM630 Compute KIT(AX620E)
- **Pulsar2 version**: 4.0 64a0e58f

## Repository
Test code and models are available at: https://github.com/nnn112358/pyaxengine_16bit_quantize_test_250608/tree/master

## Test Results
| Chip | Model | int8 NPU1 | int8 NPU2 | int16 NPU1 | int16 NPU2 |
|------|-------|-----------|-----------|------------|------------|
| M5Stack LLM630 (AX620E) | yolo11n | ✅ | ✅ | ❌ ERROR | ❌ ERROR |
| - | yolo11s | ✅ | ✅ | ❌ ERROR | ❌ ERROR |
| - | yolo11m | ✅ | ✅ | ✅ | ✅ |
| - | yolo11l | ✅ | ✅ | ✅ | ✅ |
| - | yolo11x | ✅ | ✅ | ✅ | ✅ |
| - | yolo12n | ✅ | ✅ | ❌ ERROR | ❌ ERROR |
| - | yolo12s | ✅ | ✅ | ❌ ERROR | ❌ ERROR |
| - | yolo12m | ✅ | ✅ | ✅ | ✅ |
| - | yolo12l | ✅ | ✅ | ✅ | ✅ |
| - | yolo12x | ✅ | ✅ | ✅ | ✅ |

## Observations
- **Working**: All 8-bit quantized models (n, s, m, l, x sizes) work correctly
- **Working**: 16-bit quantized models for larger sizes (m, l, x) work correctly  
- **Failing**: Only 16-bit quantized models for smaller sizes (n, s) fail to run


When I try to load the 16-bit quantized model of yolo11n (12n) and yolo11s (11s) in pyaxengine, an error occurs. Everything else is OK.

https://github.com/nnn112358/pyaxengine_16bit_quantize_test_250608/tree/master

```
root@m5stack-kit: #  python ax_inference_benchmark.py axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel
[INFO] Available providers:  ['AxEngineExecutionProvider']
[INFO] Using provider: AxEngineExecutionProvider
[INFO] Chip type: ChipType.MC20E
[INFO] VNPU type: VNPUType.DISABLED
[INFO] Engine version: 2.6.3sp
[INFO] Model type: 1 (full core)
[INFO] Compiler version: 4.0 64a0e58f
モデル: axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel
入力形状: [1, 640, 640, 3]
入力型: uint8

測定中...
エラー: Failed to run model.
```

The same happens if you do not use pyaxengine but use the ax_run_model command.
````
root@m5stack-kit:# ax_run_model -m axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel -r 1
   Run AxModel:
         model: axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel
          type: Full
          vnpu: Disable
      affinity: 0b01
        warmup: 1
        repeat: 1
         batch: { auto: 0 }
   pulsar2 ver: 4.0 64a0e58f
    engine ver: 2.6.3sp
      tool ver: 2.3.3sp
      cmm size: 12437212 Bytes
[ERROR] Run model failed.
[ERROR] Run model in warmup failed.
[ERROR] Run model {axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel} failed.
````




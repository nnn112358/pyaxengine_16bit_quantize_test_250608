


| chip| axmodel| int8�ʎq�� NPU1 | int8�ʎq�� NPU2 | int16�ʎq�� NPU1 | int16�ʎq�� NPU2 |
|--------|--------|-----------------|-----------------|------------------|------------------|
|M5Stack LLM630( AX620E) | yolo11n | �Z | �Z | ERROR | ERROR |
| - | yolo11s | �Z | �Z | ERROR | ERROR |
| - | yolo11m | �Z | �Z | �Z | �Z |
| - | yolo11l | �Z | �Z | �Z | �Z |
| - | yolo11x | �Z | �Z | �Z | �Z |
| - | yolo12n | �Z | �Z | ERROR | ERROR |
| - | yolo12s | �Z | �Z | ERROR | ERROR |
| - | yolo12m | �Z | �Z | �Z | �Z |
| - | yolo12l | �Z | �Z | �Z | �Z |
| - | yolo12x | �Z | �Z | �Z | �Z |


```
# python ax_inference_benchmark.py axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel
[INFO] Available providers:  ['AxEngineExecutionProvider']
[INFO] Using provider: AxEngineExecutionProvider
[INFO] Chip type: ChipType.MC20E
[INFO] VNPU type: VNPUType.DISABLED
[INFO] Engine version: 2.6.3sp
[INFO] Model type: 1 (full core)
[INFO] Compiler version: 4.0 19f40f01
���f��: yolo11n_config_u16_AX620E_NPU2.axmodel
���͌`��: [1, 640, 640, 3]
���͌^: uint8

���蒆...
�G���[: Failed to run model.
```


````
# ax_run_model -m axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel -r 1
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




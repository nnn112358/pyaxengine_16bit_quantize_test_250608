


| chip| axmodel| int8ó éqâª NPU1 | int8ó éqâª NPU2 | int16ó éqâª NPU1 | int16ó éqâª NPU2 |
|--------|--------|-----------------|-----------------|------------------|------------------|
|M5Stack LLM630( AX620E) | yolo11n | ÅZ | ÅZ | ERROR | ERROR |
| - | yolo11s | ÅZ | ÅZ | ERROR | ERROR |
| - | yolo11m | ÅZ | ÅZ | ÅZ | ÅZ |
| - | yolo11l | ÅZ | ÅZ | ÅZ | ÅZ |
| - | yolo11x | ÅZ | ÅZ | ÅZ | ÅZ |
| - | yolo12n | ÅZ | ÅZ | ERROR | ERROR |
| - | yolo12s | ÅZ | ÅZ | ERROR | ERROR |
| - | yolo12m | ÅZ | ÅZ | ÅZ | ÅZ |
| - | yolo12l | ÅZ | ÅZ | ÅZ | ÅZ |
| - | yolo12x | ÅZ | ÅZ | ÅZ | ÅZ |


```
# python ax_inference_benchmark.py axmodel/yolo11n_config_u16_AX620E_NPU2.axmodel
[INFO] Available providers:  ['AxEngineExecutionProvider']
[INFO] Using provider: AxEngineExecutionProvider
[INFO] Chip type: ChipType.MC20E
[INFO] VNPU type: VNPUType.DISABLED
[INFO] Engine version: 2.6.3sp
[INFO] Model type: 1 (full core)
[INFO] Compiler version: 4.0 19f40f01
ÉÇÉfÉã: yolo11n_config_u16_AX620E_NPU2.axmodel
ì¸óÕå`èÛ: [1, 640, 640, 3]
ì¸óÕå^: uint8

ë™íËíÜ...
ÉGÉâÅ[: Failed to run model.
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




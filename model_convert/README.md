
## 環境構築手順

### 1. YOLOモデルの準備

まず、必要なPythonパッケージをインストールし、ONNXフォーマットのYOLOモデルを準備し、AXERA向けに前処理を行います。

```bash
# 必要なパッケージのインストール
UbuntuPC$ pip install ultralytics onnx

# YOLOモデルのエクスポートと前処理
UbuntuPC$ python yolo_export.py
UbuntuPC$ python yolo_onnx_cut.py
```

### 2. Pulsar2 Dockerコンテナの起動

Pulsar2コンパイラをDockerコンテナとして起動します。事前にイメージファイルをダウンロードしておく必要があります。

**イメージの読み込み**
```bash
UbuntuPC$ sudo docker load -i ax_pulsar2_4.0.tar.gz
```

**コンテナの起動**
```bash
UbuntuPC$ sudo docker run -it --net host --rm -v $PWD:/data pulsar2:4.0
```

## モデル変換の実行

Dockerコンテナ内でpulsar2コマンドを使用してモデルを変換します。ターゲットハードウェアとNPU構成に応じて、適切なパラメータを選択してください。

### AX630C向けの変換例

```bash
## 8ビット量子化版の生成

root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u8.json --target_hardware AX620E --npu_mode NPU1 --input yolo11n-cut.onnx --output_name yolo11n_u8_AX620E_NPU1.axmodel
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u8.json --target_hardware AX620E --npu_mode NPU2 --input yolo11n-cut.onnx --output_name yolo11n_u8_AX620E_NPU2.axmodel

## 16ビット量子化版の生成
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u16.json --target_hardware AX620E --npu_mode NPU1 --input yolo11n-cut.onnx --output_name yolo11n_u16_AX620E_NPU1.axmodel
root@pulsar2:/data# pulsar2 build --config config/yolo11_config_u16.json --target_hardware AX620E --npu_mode NPU2 --input yolo11n-cut.onnx --output_name yolo11n_u16_AX620E_NPU2.axmodel
```


#!/usr/bin/env python3
import axengine as axe
import numpy as np
import time
import argparse

def create_random_input(session):
    """モデルの入力に合わせた乱数データを生成"""
    input_info = session.get_inputs()[0]
    shape = input_info.shape
    dtype = input_info.dtype
    
    # 動的次元を固定値に変換
    fixed_shape = []
    for dim in shape:
        if dim is None or dim == -1:
            fixed_shape.append(1 if len(fixed_shape) == 0 else 224)
        else:
            fixed_shape.append(dim)
    
    # データ型に応じて乱数生成
    if dtype == 'uint8':
        return np.random.randint(0, 256, size=fixed_shape, dtype=np.uint8)
    elif dtype in ['float32', 'float64']:
        return np.random.rand(*fixed_shape).astype(np.float32)
    else:
        return np.random.rand(*fixed_shape).astype(np.float32)

def measure_inference(session, runs=100):
    """推論時間を測定"""
    input_info = session.get_inputs()[0]
    input_name = input_info.name
    input_data = create_random_input(session)
    
    # ウォームアップ
    for _ in range(5):
        session.run(None, {input_name: input_data})
    
    # 測定
    times = []
    for _ in range(runs):
        start = time.time()
        session.run(None, {input_name: input_data})
        times.append((time.time() - start) * 1000)  # ミリ秒
    
    return np.mean(times), np.min(times), np.max(times)

def main():
    parser = argparse.ArgumentParser(description='axengine推論時間測定')
    parser.add_argument('model_path', help='ONNXモデルファイルのパス')
    parser.add_argument('--runs', type=int, default=100, help='実行回数 (デフォルト: 100)')
    
    args = parser.parse_args()
    
    try:
        # モデル読み込み
        session = axe.InferenceSession(args.model_path)
        
        # モデル情報表示
        input_info = session.get_inputs()[0]
        print(f"モデル: {args.model_path}")
        print(f"入力形状: {input_info.shape}")
        print(f"入力型: {input_info.dtype}")
        print()
        
        # 推論時間測定
        print("測定中...")
        avg_time, min_time, max_time = measure_inference(session, args.runs)
        
        # 結果表示
        print(f"実行回数: {args.runs}")
        print(f"平均時間: {avg_time:.2f} ms")
        print(f"最小時間: {min_time:.2f} ms")
        print(f"最大時間: {max_time:.2f} ms")
        print(f"スループット: {1000/avg_time:.1f} FPS")
        
    except Exception as e:
        print(f"エラー: {e}")

if __name__ == "__main__":
    main()



#!/bin/bash

# AX650 Model Benchmark Script
# Usage: ./benchmark_models.sh [folder_path] [repeat_times] [output_file]

# デフォルト値の設定
FOLDER_PATH=${1:-"."}
REPEAT_TIMES=${2:-10}
OUTPUT_FILE=${3:-"benchmark_results.txt"}

# 出力ファイルの初期化
echo "AX630C Model Benchmark Results" > "$OUTPUT_FILE"
echo "Generated on: $(date)" >> "$OUTPUT_FILE"
echo "Folder: $FOLDER_PATH" >> "$OUTPUT_FILE"
echo "Repeat times: $REPEAT_TIMES" >> "$OUTPUT_FILE"
echo "----------------------------------------" >> "$OUTPUT_FILE"

# カウンター初期化
total_models=0
successful_models=0

echo "Starting benchmark for .axmodel files in: $FOLDER_PATH"
echo "Results will be saved to: $OUTPUT_FILE"
echo ""

# .axmodelファイルを検索してソートして処理
find "$FOLDER_PATH" -name "*.axmodel" -type f | sort | while read -r model_file; do
    total_models=$((total_models + 1))
    model_name=$(basename "$model_file")
    
    echo "Processing: $model_name"
    
    # axcl_run_modelを実行
    output=$(ax_run_model --model "$model_file" -r "$REPEAT_TIMES" 2>&1)
    exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        # avgの値を抽出（最後の行から）
        avg_time=$(echo "$output" | grep -E "min.*max.*avg" | tail -1 | sed -n 's/.*avg = *\([0-9.]*\) ms.*/\1/p')
        
        if [ -n "$avg_time" ]; then
            echo "$model_name: ${avg_time}ms" >> "$OUTPUT_FILE"
            echo "  → Success: ${avg_time}ms"
            successful_models=$((successful_models + 1))
        else
            echo "$model_name: ERROR - Could not extract avg time" >> "$OUTPUT_FILE"
            echo "  → Error: Could not extract avg time"
        fi
    else
        echo "$model_name: ERROR - Execution failed" >> "$OUTPUT_FILE"
        echo "  → Error: Execution failed"
        # エラーログも保存
        echo "    Error output: $output" >> "$OUTPUT_FILE"
    fi
    echo ""
done

# 統計情報を追加
echo "----------------------------------------" >> "$OUTPUT_FILE"
echo "Summary:" >> "$OUTPUT_FILE"
echo "Total models found: $total_models" >> "$OUTPUT_FILE"
echo "Successfully benchmarked: $successful_models" >> "$OUTPUT_FILE"
echo "Failed: $((total_models - successful_models))" >> "$OUTPUT_FILE"

echo "Benchmark completed!"
echo "Results saved to: $OUTPUT_FILE"
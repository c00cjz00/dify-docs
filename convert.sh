#!/bin/bash

# 定義輸入和輸出目錄
input_dir="zh_TW"
output_dir="zh_TW"

# 如果輸出目錄不存在，則創建它
mkdir -p "$output_dir"

# 遞迴遍歷所有 .md 文件
find "$input_dir" -type f -name "*.md" | while read file; do
    # 提取相對路徑
    relative_path="${file#$input_dir/}"

    # 確保輸出目錄結構與輸入目錄相同
    output_file="$output_dir/$relative_path"
    output_dirname=$(dirname "$output_file")
    mkdir -p "$output_dirname"

    # 使用 OpenCC 進行轉換
    opencc -i "$file" -o "$output_file" -c s2tw.json

    echo "轉換完成: $file -> $output_file"
done

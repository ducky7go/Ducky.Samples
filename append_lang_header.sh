#!/bin/bash
# =============================================================================
# append_lang_header.sh - 为多语言文档添加语言切换导航头部
# =============================================================================
# 用法：
#   chmod +x append_lang_header.sh  # 首次使用时设置可执行权限
#   ./append_lang_header.sh         # 运行脚本
#
# 此脚本会自动搜索仓库中的文档文件（README.md、docs/*.md 等），
# 识别不同语言版本，并在每个文件顶部插入/更新语言切换导航块。
#
# 新的文件结构（同目录）：
# - 原文件：README.md（默认简体中文）
# - 翻译文件：README_en.md、README_de.md 等（同目录下）
#
# 特性：
# - 自动识别同目录下的语言变体文件（_en、_de 等后缀）
# - 支持任意深度的子目录结构
# - 排除所有 AGENTS 文件（AGENTS.md、AGENTS_en.md 等）
# - 使用唯一标记包裹导航块，支持更新已存在的导航
# - 链接文字使用目标语言的本地名称
# - 相对路径跳转，保证在 GitHub 上可用
# =============================================================================

set -euo pipefail

# 语言代码到显示名称的映射
declare -A LANG_NAMES=(
    ["zh"]="简体中文"
    ["en"]="English"
    ["de"]="Deutsch"
    ["fr"]="Français"
    ["es"]="Español"
    ["ja"]="日本語"
    ["ko"]="한국어"
    ["pt"]="Português"
    ["ru"]="Русский"
    ["zh-hant"]="繁體中文"
)

# 语言代码到文件后缀的映射
declare -A LANG_SUFFIXES=(
    ["zh"]=""           # 简体中文为原文，无后缀
    ["en"]="_en"
    ["de"]="_de"
    ["fr"]="_fr"
    ["es"]="_es"
    ["ja"]="_ja"
    ["ko"]="_ko"
    ["pt"]="_pt"
    ["ru"]="_ru"
    ["zh-hant"]="_zh"   # 繁体中文
)

# 标记常量
MARKER_START="<!-- LANG_HEADER_START -->"
MARKER_END="<!-- LANG_HEADER_END -->"

# 工作目录（仓库根目录）
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 统计变量
declare -a PROCESSED_FILES=()
declare -a SKIPPED_FILES=()
declare -A DOCUMENT_GROUPS=()

# =============================================================================
# 辅助函数
# =============================================================================

# 检查文件是否应该被排除（AGENTS 文件）
should_exclude_file() {
    local filepath="$1"
    local filename=$(basename "$filepath")
    local basename="${filename%.*}"
    
    # 排除所有以 AGENTS 开头的文件
    if [[ "$basename" =~ ^AGENTS(_.*)?$ ]]; then
        return 0  # 应该排除
    fi
    
    return 1  # 不排除
}

# 获取文件的 canonical key（用于聚合同一文档的不同语言版本）
# 移除文件名中的语言后缀，得到基础文件名
get_canonical_key() {
    local filepath="$1"
    local rel_path="${filepath#$REPO_ROOT/}"
    
    # 获取文件名和目录
    local filename=$(basename "$rel_path")
    local dirpath=$(dirname "$rel_path")
    local basename="${filename%.*}"
    local ext="${filename##*.}"
    
    # 尝试移除所有可能的语言后缀
    local canonical_basename="$basename"
    for lang in "${!LANG_SUFFIXES[@]}"; do
        local suffix="${LANG_SUFFIXES[$lang]}"
        if [[ -n "$suffix" ]] && [[ "$basename" == *"$suffix" ]]; then
            canonical_basename="${basename%$suffix}"
            break
        fi
    done
    
    # 构建 canonical key
    if [[ "$dirpath" == "." ]]; then
        echo "${canonical_basename}.${ext}"
    else
        echo "${dirpath}/${canonical_basename}.${ext}"
    fi
}

# 计算相对路径
get_relative_path() {
    local from="$1"
    local to="$2"
    local from_dir=$(dirname "$from")
    
    # 使用 Python 计算相对路径（如果可用）
    if command -v python3 &> /dev/null; then
        python3 -c "import os.path; print(os.path.relpath('$to', '$from_dir'))" 2>/dev/null && return
    fi
    
    # 回退：简单的相对路径计算
    local from_rel="${from_dir#$REPO_ROOT}"
    local to_rel="${to#$REPO_ROOT}"
    
    # 去掉前导斜杠
    from_rel="${from_rel#/}"
    to_rel="${to_rel#/}"
    
    # 如果 from 在根目录
    if [[ -z "$from_rel" ]]; then
        echo "$to_rel"
        return
    fi
    
    # 计算需要返回的层级数
    local levels=$(echo "$from_rel" | tr -cd '/' | wc -c)
    local prefix=""
    for ((i=0; i<levels; i++)); do
        prefix="../$prefix"
    done
    
    echo "${prefix}${to_rel}"
}

# 生成语言导航头部
generate_lang_header() {
    local current_file="$1"
    shift
    local -a version_entries=("$@")
    
    # 按特定顺序排列语言链接（简体中文优先）
    local -a ordered_langs=("zh" "en" "de" "fr" "es" "ja" "ko" "pt" "ru" "zh-hant")
    local -a links=()
    
    # 构建语言链接列表（按顺序）
    for lang in "${ordered_langs[@]}"; do
        for entry in "${version_entries[@]}"; do
            IFS=':' read -r entry_lang filepath <<< "$entry"
            if [[ "$entry_lang" == "$lang" ]]; then
                local lang_name="${LANG_NAMES[$lang]}"
                local rel_path=$(get_relative_path "$current_file" "$filepath")
                links+=("[$lang_name]($rel_path)")
                break
            fi
        done
    done
    
    # 生成单行 Markdown 表格（无表头行）
    local table_row="| "
    for link in "${links[@]}"; do
        table_row+="$link | "
    done
    
    # 生成完整的头部块
    cat <<EOF
$MARKER_START
$table_row
$MARKER_END
EOF
}

# 在文件中插入或替换语言头部
insert_or_replace_header() {
    local filepath="$1"
    local header_content="$2"
    
    # 创建临时文件
    local temp_file="${filepath}.tmp"
    
    # 检查文件是否已有标记
    if grep -q "$MARKER_START" "$filepath" 2>/dev/null; then
        # 替换现有标记之间的内容
        awk -v marker_start="$MARKER_START" -v marker_end="$MARKER_END" -v new_content="$header_content" '
        BEGIN { in_marker = 0; replaced = 0 }
        {
            if ($0 ~ marker_start) {
                if (!replaced) {
                    print new_content
                    replaced = 1
                }
                in_marker = 1
                next
            }
            if ($0 ~ marker_end) {
                in_marker = 0
                next
            }
            if (!in_marker) {
                print
            }
        }
        ' "$filepath" > "$temp_file"
    else
        # 在文件开头插入头部
        {
            echo "$header_content"
            echo ""
            cat "$filepath"
        } > "$temp_file"
    fi
    
    # 替换原文件
    mv "$temp_file" "$filepath"
}

# =============================================================================
# 主处理逻辑
# =============================================================================

echo "======================================"
echo "开始处理文档语言导航头部"
echo "仓库根目录: $REPO_ROOT"
echo "======================================"
echo ""

# 第一步：递归扫描所有 .md 文件并分组
echo "扫描所有 .md 文件..."

# 扫描所有 .md 文件
while IFS= read -r -d '' filepath; do
    if should_exclude_file "$filepath"; then
        SKIPPED_FILES+=("${filepath#$REPO_ROOT/}:排除 AGENTS 文件")
        continue
    fi
    
    # 获取文件的 canonical key
    canonical_key=$(get_canonical_key "$filepath")
    
    # 确定文件的语言代码
    filename=$(basename "$filepath")
    basename="${filename%.*}"
    lang_code="zh"  # 默认为简体中文（无后缀）
    
    # 检查文件名是否有语言后缀
    for lang in "${!LANG_SUFFIXES[@]}"; do
        suffix="${LANG_SUFFIXES[$lang]}"
        if [[ -n "$suffix" ]] && [[ "$basename" == *"$suffix" ]]; then
            lang_code="$lang"
            break
        fi
    done
    
    # 将文件添加到对应的文档组
    if [[ -z "${DOCUMENT_GROUPS[$canonical_key]:-}" ]]; then
        DOCUMENT_GROUPS[$canonical_key]="${lang_code}:${filepath}"
    else
        DOCUMENT_GROUPS[$canonical_key]="${DOCUMENT_GROUPS[$canonical_key]}|${lang_code}:${filepath}"
    fi
done < <(find "$REPO_ROOT" -name "*.md" -type f -print0)

echo "找到 ${#DOCUMENT_GROUPS[@]} 组文档"
echo ""

# 第二步：为每组文档生成并插入语言导航头部
echo "为每组文档生成语言导航头部..."
echo ""

for canonical_key in "${!DOCUMENT_GROUPS[@]}"; do
    echo "处理文档组: $canonical_key"
    
    # 解析该组的所有语言版本
    IFS='|' read -ra versions <<< "${DOCUMENT_GROUPS[$canonical_key]}"
    
    # 显示该组包含的文件
    for version in "${versions[@]}"; do
        IFS=':' read -r lang filepath <<< "$version"
        echo "  - ${LANG_NAMES[$lang]}: ${filepath#$REPO_ROOT/}"
    done
    
    # 为该组的每个文件生成并插入头部
    for version in "${versions[@]}"; do
        IFS=':' read -r lang filepath <<< "$version"
        
        header=$(generate_lang_header "$filepath" "${versions[@]}")
        insert_or_replace_header "$filepath" "$header"
        
        PROCESSED_FILES+=("${filepath#$REPO_ROOT/}")
    done
    
    echo ""
done

echo "======================================"
echo "处理完成"
echo "======================================"
echo ""
echo "已处理文件数: ${#PROCESSED_FILES[@]}"

if [[ ${#PROCESSED_FILES[@]} -gt 0 ]]; then
    echo ""
    echo "已处理的文件列表（前 15 个）:"
    for ((i=0; i<${#PROCESSED_FILES[@]} && i<15; i++)); do
        echo "  - ${PROCESSED_FILES[$i]}"
    done
    
    if [[ ${#PROCESSED_FILES[@]} -gt 15 ]]; then
        echo "  ... 还有 $((${#PROCESSED_FILES[@]} - 15)) 个文件"
    fi
fi

if [[ ${#SKIPPED_FILES[@]} -gt 0 ]]; then
    echo ""
    echo "跳过的文件数: ${#SKIPPED_FILES[@]}"
    echo "跳过的文件列表:"
    for skipped in "${SKIPPED_FILES[@]}"; do
        IFS=':' read -r filepath reason <<< "$skipped"
        echo "  - $filepath ($reason)"
    done
fi

echo ""
echo "✅ 所有操作已完成！"
echo ""
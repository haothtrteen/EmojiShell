#!/bin/sh
#================配置区==================
text="example.sh"  # 原脚本绝对路径
sed_d="|"          # Sed分隔符
log_file="zz_log.txt"
#======================================

# 你的Zz变量名生成函数（原封不动）
generate_variable_name() {
    local length=16
    local charset="___Z__z"
    local variable_name=""
    local i=1
    while [ $i -le $length ]; do
        local rand_idx=$(( RANDOM % ${#charset} ))
        variable_name="${variable_name}${charset:$rand_idx:1}"
        i=$((i+1))
    done
    echo "$variable_name"
}

# 生成emoji函数名（原封不动）
gen_emoji() {
    local cs="💦🛑🍒💜🎋🐬🏡🏟🏜🔔🐞🐗🌍💝🏕🍆💖❤🚤💛🐯🐣💚💞🚁🐸🔕🐷💜🏝💛💔🔕🎁🏗💗💔🐳💚💜🏕🌶🍭🛑🖤💦🍁🌍🌛🚤🍒💦🏕💚🐯💜🐬🌍🐸🎋💞🐬🛑🍄🎋💗💞💙🍄🌛🌍🐗🐸🚫🐯💦🏝🐳🍁🐷🏕🚀🏗🚀🏟🐗🌶🚀💞🍎🌤🖤🌶🍆💕💗🐬💜💛🐮💙🏝🌟💔💕🍒🐞🍒🐮💔🏗🐗❣🏡🏡🐮🐗🖤🍆💕🐯💙🍆💖💙❤🏗🖤🛑🌛🍎🐮🍆🖤🐯🚁🚫🐞🖤💞🐣🐯💙💙🐸💦🚫🐝🏟🌤❤❤️🍎🎁🏝🐷💝🍷🍎🏕💜💙🐬🛑🐷💙💔🎋🏝💚🐳💕🌶🌛🔔🌍💕🐮🐬🍭💞🏡🎁🍒🍒🏕🍷🐳🚀🐗🎁💦🎋🍭💙🐮🌍💛🚁🍁💚🍒🚀🐳💝💜🔔💙🌍❤💙💙🌛🏗🍎🐮🚀🐮🌛🍄🐳🌛🔥🚫🐣🐬💞💝🍭🏗🏗🐣❣🚁🌍🌶🛑💕🎁🐯🚫💙🖤🐷🐸🐯❤"
    local fn=""
    local i=1
    while [ $i -le 12 ]; do
        local r=$(( RANDOM % ${#cs} ))
        fn="${fn}${cs:$r:1}"
        i=$((i+1))
    done
    echo "$fn"
}

# 核心流程：保护Shebang+优化Sed排除（仅新增双引号加密步骤+合并emoji函数为一行）
encrypt_fixed_final() {
    local txt="$1"
    local tmp="temp_${txt}"
    local map="zz_map.txt"
    local emoji="emoji_funcs.sh"
    local used_zz=" "
    > "$log_file"

    # 初始化：复制原文件，保护Shebang（第一行）
    [ ! -f "$txt" ] && { echo "错误：原文件 $txt 不存在！"; return 1; }
    cp "$txt" "$tmp"
    > "$map"
    > "$emoji"  # 清空emoji文件，后续统一写入合并后的函数
    local emoji_funcs=""  # 新增：用于拼接所有emoji函数（一行）
    echo "===== Zz标记日志 =====" >> "$log_file"

    # --------------------------
    # 步骤1：标记变量名（和之前一致）
    # --------------------------
    local vars=$(grep -v '^#' "$tmp" | grep '^[a-zA-Z_][a-zA-Z0-9_]*=' | cut -d'=' -f1 | sort -u)
    for var in $vars; do
        local zz_mark=$(generate_variable_name)
        while echo "$used_zz" | grep -q " ${zz_mark} "; do
            zz_mark=$(generate_variable_name)
        done
        used_zz="${used_zz}${zz_mark} "
        echo "${zz_mark} ${var} var" >> "$map"
        echo "标记：${var} → ${zz_mark}" >> "$log_file"
        sed -i "s${sed_d}^${var}=${zz_mark}=${sed_d}" "$tmp"
    done

    local brace_vars=$(grep -v '^#' "$tmp" | grep -o '\$\{[a-zA-Z_][a-zA-Z0-9_]*\}' | \
        sed "s${sed_d}\$\{${sed_d}${sed_d}\}${sed_d}" | sort -u)
    for var in $brace_vars; do
        if echo "$used_zz" | grep -q " ${var} "; then continue; fi
        local zz_mark=$(generate_variable_name)
        while echo "$used_zz" | grep -q " ${zz_mark} "; do
            zz_mark=$(generate_variable_name)
        done
        used_zz="${used_zz}${zz_mark} "
        echo "${zz_mark} ${var} brace" >> "$map"
        echo "标记：${var} → ${zz_mark}" >> "$log_file"
        sed -i "s${sed_d}\$\{${var}\\}${sed_d}\$\{${zz_mark}\\}${sed_d}g" "$tmp"
    done

    local bracket_vars=$(grep -v '^#' "$tmp" | grep -o '\[[a-zA-Z_][a-zA-Z0-9_]*\]' | \
        sed "s${sed_d}\[${sed_d}${sed_d}\]${sed_d}" | sort -u)
    for var in $bracket_vars; do
        if echo "$used_zz" | grep -q " ${var} "; then continue; fi
        local zz_mark=$(generate_variable_name)
        while echo "$used_zz" | grep -q " ${zz_mark} "; do
            zz_mark=$(generate_variable_name)
        done
        used_zz="${used_zz}${zz_mark} "
        echo "${zz_mark} ${var} bracket" >> "$map"
        echo "标记：${var} → ${zz_mark}" >> "$log_file"
        sed -i "s${sed_d}\[${var}\]${sed_d}\[${zz_mark}\]${sed_d}g" "$tmp"
    done

    # --------------------------
    # 关键修复1：保护Shebang+原加密步骤（修改emoji函数为拼接）
    # --------------------------
    echo -e "\n===== 原加密日志（保护Shebang） =====" >> "$log_file"
    local target_chars=$(
        tail -n +2 "$tmp" | sed "s${sed_d}#.*${sed_d}${sed_d}" | \
        grep -oE '"[^"]*"|[a-zA-Z0-9]+' | tr -d '"' | fold -w1 | \
        grep -E '[a-zA-Z0-9]' | grep -v -E '[Zz_]' | sort -u | grep -v '^$'
    )

    # 原逻辑：循环追加单行 → 新逻辑：拼接成字符串（用分号分隔函数）
    for char in $target_chars; do
        local ej=$(gen_emoji)
        # 拼接函数到变量，而非直接写入文件
        emoji_funcs+="${ej}() { printf \"%s\" \"${char}\"; };"
        echo "原加密：${char} → ${ej}" >> "$log_file"
        sed -i "1! { /[Zz_]/! s${sed_d}${char}${sed_d}\$\(${ej}\)${sed_d}g; }" "$tmp"
    done

    # --------------------------
    # 【新增步骤：还原前加密双引号内字符（同样拼接emoji函数）】
    # --------------------------
    echo -e "\n===== 新增：还原前加密双引号内字符 =====" >> "$log_file"
    local quote_chars=$(
        tail -n +2 "$tmp" | grep -v -E '^#|[Zz_]' | \
        grep -o '"[^"]*"' | tr -d '"' | \
        fold -w1 | grep -E '[a-zA-Z0-9]' | sort -u | grep -v '^$'
    )

    # 同样拼接函数到变量，而非直接写入文件
    for char in $quote_chars; do
        local ej_quote=$(gen_emoji)
        emoji_funcs+="${ej_quote}() { printf \"%s\" \"${char}\"; };"
        echo "双引号加密：${char} → ${ej_quote}" >> "$log_file"
        sed -i "1! { /^#/! { /[Zz_]/! { /\"[^\"]*\"/ s${sed_d}\(${char}\)${sed_d}\$\(${ej_quote}\)${sed_d}g; } } }" "$tmp"
    done

    # 关键：将所有拼接好的emoji函数（一行）写入文件
    echo "$emoji_funcs" > "$emoji"

    # --------------------------
    # 关键修复2：确保还原生效（和之前一致）
    # --------------------------
    echo -e "\n===== 还原日志 =====" >> "$log_file"
    while read -r line; do
        local zz_mark=$(echo "$line" | cut -d' ' -f1)
        local var=$(echo "$line" | cut -d' ' -f2)
        local type=$(echo "$line" | cut -d' ' -f3)
        [ -z "$zz_mark" ] || [ -z "$var" ] && continue

        echo "还原前检查：临时文件中 ${zz_mark} → $(grep -c "$zz_mark" "$tmp" || echo "未找到")" >> "$log_file"
        case $type in
            var)
                sed -i "s${sed_d}^${zz_mark}=${var}=${sed_d}" "$tmp"
                ;;
            brace)
                sed -i "s${sed_d}\$\{${zz_mark}\\}${sed_d}\$\{${var}\\}${sed_d}g" "$tmp"
                ;;
            bracket)
                sed -i "s${sed_d}\[${zz_mark}\]${sed_d}\[${var}\]${sed_d}g" "$tmp"
                ;;
        esac
        echo "还原：${zz_mark} → ${var}" >> "$log_file"
    done < "$map"

    # --------------------------
    # 生成最终脚本（和之前一致）
    # --------------------------
    local shebang=$(head -n1 "$tmp")
    if [ "$shebang" != "#!/bin/sh" ]; then
        echo "警告：Shebang异常，修复为#!/bin/sh" >> "$log_file"
        sed -i '1c #!/bin/sh' "$tmp"
    fi

    cat "$emoji" "$tmp" > "protected_${txt}"
    rm "$tmp" "$map" "$emoji"

    echo "✅ 修复完成！已在还原前新增双引号加密步骤，且emoji函数合并为一行"
    echo "1. 加密脚本：protected_${txt}（Shebang已修复为#!/bin/sh）"
    echo "2. 日志文件：${log_file}（含新增双引号加密记录）"
}

# 调用函数
encrypt_fixed_final "$text"

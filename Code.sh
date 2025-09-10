

#================配置区==================

# 示例文本
text="example.sh"
# 定义非法字符串
str_variable="ifthenelse"  #对应if语法，如果if被emoji加密会直接无法运行

#======================================


# 生成随机的8个字母的变量名
generate_variable_name() {
    local length=12
    local charset="💦️🛑🍒💜🎋🐬🏡🏟🏜🔔🐞🐗🌍💝🏕🍆️🏕💝💖❤🌍️🚤💛🐯🐣💚💞🚁🐸🔕🐷💜🏝💛💔🔕🎁🏗🏡💗💔🚤🏡🐳💚💜🏕🌶🍆🍭🛑🖤💦🍁🌍🌛🚤🍒🏡💦🏕💚🐯💜🐬🌍🐸🎋💞🐬🛑🍄🎋️💗💞️💙️🍄🌛🌍🐗🐸🚫🐯💦🏝🐳🍁🐷️🏕🚀🏗🚀🏟🐗🌶🚀💞🍎🌤🖤🌶🍆💕💗🐬💜💛🐮💙🏝🌟💔💕🍒🐞️🍒🐮💔🏗🐗❣🏡🏡🐮🐗🖤🍆💕🐯💙🍆💖💙❤🏗🖤🛑🌛🍎🐮🍆🖤🐯🚁🚫🐞🖤💞🐣🐯💙💙🐸💦️🚫🐝🏟🌤❤❤️🍎🎁🏝🐷💝🍷🍎🏕💜💙🐬🛑🐷💙💔🎋🏝💚🐳💕🌶🌛🔔🌍💕🐮🐬🍭💞🏡🎁🍒🍒🏕🍷🐳🚀🐗🎁💦🎋🍭💙🐮🌍💛🚁🍁💚🍒🚀🐳💝💜🔔💙🌍❤💙💙🌛🏗️🍎🐮🚀🐮🌛🍄🐳🌛🔥🚫🐣🐬💞💝🍭🏗🏗🐣❣🚁🌍🌶️🛑💕🎁🐯🚫💙️🖤🐷🐸🐯❤"
    # local variable_name=""

    for i in $(seq 1 $length); do
        variable_name="${variable_name}${charset:$RANDOM%${#charset}:1}"
    done

    echo "$variable_name"
}

# 使用变量名替换文本中的字母和数字
replace_chars_with_variable_names() {
      local text="$1"
    # local variable_names=""   
     
    # echo $1
    echo "$text"
# 遍历26个字母、10个数字和大写26个字母
for letter in {a..z} {0..9} {A..Z}; do
     variable_names="$(generate_variable_name)"
     variable_namess="\"""$""(""$variable_names"")""\""
     echo $letter
     echo $variable_names
    # local letters=$(base64 $letters) 可以进行进一步加密
       
    # 定义需要检查的字符
    check_char="$letter"
    
    # 使用test命令进行判断
    if [ "${str_variable#*$check_char}" != "$str_variable" ]; then
        echo "无法替换的指令"
    else
        echo "$variable_names() { echo \"${letter}\"; };" >> passaward
    sed -i "s/$letter/"$variable_namess"/g" $text 
    fi    
    
done

    # echo "$text"
}


    
# 替换字符并输出结果
# echo "$(replace_chars_with_variable_names "$text")"

replace_chars_with_variable_names $text


echo "$(cat passaward)""$(cat $text)" > protect.sh


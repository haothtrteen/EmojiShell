


workp="12.sh"
Outputp="12.p.sh"

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



# 提取所有变量名并存入文件
grep -o '\$[a-zA-Z_][a-zA-Z_0-9]*' $workp | sed 's/\$//' 
# > var_names.txt
# 或存入 Shell 数组
var_names=($(grep -o '\$[a-zA-Z_][a-zA-Z_0-9]*' $workp | sed 's/\$//'))

# 使用数组中的变量名
echo "所有变量名: ${var_names[@]}"
echo "所有变量名: ${var_names[3]}"
# # 定义数组
# array=("apple" "banana" "cherry")
# 循环遍历数组


sed 's/\$\([a-zA-Z_][a-zA-Z_0-9]*\)/$(\1)/g' $workp > 1234.sh


sed 's/^\([a-zA-Z_][a-zA-Z0-9_]*\)=\(.*\)/\1(){ echo \2;}/g' 1234.sh > $Outputp



for ((i = 0; i < ${#var_names[@]}; i++)); do

    # 进行替换操作
    variable_names="$(generate_variable_name)"

    # array[$i]=${array[$i]/a/@}
    
     echo ${var_names[$i]}
     echo $variable_names
    # local letters=$(base64 $letters)
        #!/system/bin/sh
       
     # echo "$variable_names() { echo \"${letter}\"; };" >> passaward
     sed -i "s/"${var_names[$i]}"/"$variable_names"/g" $Outputp
    
    
done


# sed 's/\$\([a-zA-Z_][a-zA-Z_0-9]*\)/$(\1)/g' $workp > 1234.sh


# sed 's/^\([a-zA-Z_][a-zA-Z0-9_]*\)=\(.*\)/\1(){ echo \2;}/g' 1234.sh > 12345.sh

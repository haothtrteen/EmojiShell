# 生成随机的8个字母的变量名
generate_variable_name() {
    local length=16
    local charset="___Z__z"
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
for letter in {a..y} {0..9} {A..Y}; do
     variable_names="$(generate_variable_name)"
     variable_namess="\"""$""$variable_names""\""
     echo $letter
    echo $variable_names
    local letters=$(base64 $letters)
    echo "$variable_names=\"${letter}\";" >> passaward
    sed -i "s/$letter/"$variable_namess"/g" $text 
done

    # echo "$text"
}

# 示例文本
text="12.sh"

# 替换字符并输出结果
# echo "$(replace_chars_with_variable_names "$text")"

replace_chars_with_variable_names $text
# 将每一个字符后添加反斜杠（\）和换行符（\n）
# sed 's/./&\\\n/g' 3.sh > output_file.txt.sh


echo "$(cat passaward)""$(cat $text)" > protect.sh


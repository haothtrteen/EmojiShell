#!/bin/bash
# 测试加密脚本样本 - 数据库备份脚本
# 包含明文密码、IP地址等敏感信息（用于加密效果验证）

# 配置参数（敏感信息明文展示）
DB_USER="admin"
DB_PASS="P@ssw0rd_2025"
DB_HOST="192.168.1.100"
BACKUP_DIR="./mnt/backup"
DATE=$(date +%Y%m%d)

# 创建备份目录
mkdir -p ${BACKUP_DIR}/${DATE}

# 执行数据库备份（模拟操作）
echo "开始备份数据库 [${DB_USER}@${DB_HOST}] ..."
sleep 2  # 模拟备份耗时
touch ${BACKUP_DIR}/${DATE}/db_backup.sql  # 模拟备份文件生成

# 输出测试信息（用于验证解密后脚本执行）
echo "备份完成！文件保存路径：${BACKUP_DIR}/${DATE}"
echo "测试字符串：This is a test string for encryption verification."

# 敏感操作模拟（加密后应无法直接查看）
echo "执行敏感操作：删除7天前的备份..."

exit 0


echo "https://github.com/haothtrteen/"
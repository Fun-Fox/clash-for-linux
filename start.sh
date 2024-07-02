#!/bin/bash

# 定义简单的action函数用于输出消息和状态
action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1: $2"
}

# 加载系统函数库
[ -f /etc/init.d/functions ] && source /etc/init.d/functions

Server_Dir="./"
Conf_Dir="$Server_Dir/conf"
Temp_Dir="$Server_Dir/temp"
Log_Dir="$Server_Dir/logs"
URL='https://connect.applecross.link/classic/1114467/72VaSrZ7PhLs'

# 临时取消环境变量
unset http_proxy
unset https_proxy

# 拉取更新config.yml文件，并直接显示下载状态
echo "开始下载配置文件config.yaml..."
wget -q --show-progress -O $Temp_Dir/clash.yaml $URL 
if [ $? -eq 0 ]; then
    action "INFO" "配置文件config.yaml下载成功！"
else
    action "ERROR" "配置文件config.yaml下载失败，退出启动！"
    exit 1
fi

# 后续操作保持不变，但建议在关键操作后直接使用echo或action函数输出状态信息
sed -n '/^proxies:/,$p' $Temp_Dir/clash.yaml > $Temp_Dir/proxy.txt

echo "合并配置文件..."
cat $Temp_Dir/templete_config.yaml > $Temp_Dir/config.yaml
cat $Temp_Dir/proxy.txt >> $Temp_Dir/config.yaml
\cp $Temp_Dir/config.yaml $Conf_Dir/

# 启动Clash服务，并通过nohup重定向输出到日志文件，同时在终端显示启动状态
echo "正在启动Clash服务..."
nohup $Server_Dir/clash-linux-amd64-v1.3.5 -d $Conf_Dir > $Log_Dir/clash.log 2>&1 &
sleep 2 # 等待片刻以检查服务是否成功启动
if ps aux | grep -q 'clash-linux-amd64-v1.3.5'; then
    action "INFO" "服务启动成功！"
else
    action "ERROR" "服务启动失败！"
    exit 1
fi

# 添加环境变量
echo  "export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890" > /etc/profile.d/clash.sh
echo "环境变量设置完成。请手动执行 'source /etc/profile.d/clash.sh' 以应用更改。"

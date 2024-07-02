
# 使用教程

## 下载
- git clone clash-for-liunx包
- 本地zip压缩后上传服务器

## 启动

进入服务器
```
unzip  clash-for-liunx.zip
cd clash-for-liunx
chmod 777 clash-linux-amd64-v1.3.5
sh start.sh
source /etc/profile.d/clash.sh

```
## 验证
- 检查服务端口

```bash
$ netstat -tln | grep -E '9090|789.'
tcp        0      0 127.0.0.1:9090          0.0.0.0:*               LISTEN     
tcp6       0      0 :::7890                 :::*                    LISTEN     
tcp6       0      0 :::7891                 :::*                    LISTEN     
tcp6       0      0 :::7892                 :::*                    LISTEN
```

- 检查环境变量

```bash
$ env | grep -E 'http_proxy|https_proxy'
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
```

以上步鄹如果正常，说明服务clash程序启动成功，现在就可以体验高速下载github资源了。


## 停止

- 进入项目目录

```bash
$ cd clash-for-linux
```

- 关闭服务

```bash
$ sh shutdown.sh
服务关闭成功，请在已打开的窗口执行以下命令：
unset http_proxy
unset https_proxy
```

```bash
$ unset http_proxy
$ unset https_proxy
```

然后检查程序端口、进程以及环境变量`http_proxy|https_proxy`，若都没则说明服务正常关闭。


# 使用须知

- 此项目不提供任何订阅信息，请自行准备Clash订阅地址。
- 运行前请手动更改`start.sh`脚本中的URL变量值，否则无法正常运行。
- 当前只在RHEL系列Linux系统中测试过，其他系列可能需要适当修改脚本。

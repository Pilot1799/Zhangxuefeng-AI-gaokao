@echo off
chcp 65001 >nul
title 高考志愿系统 - 一键安装初始环境
color 0A

echo ==================================================
echo   🚀 张雪峰 AI 高考志愿系统 - 环境自动安装工具
echo ==================================================
echo.
echo 本工具将自动为你搞定最恶心的环境配置：
echo 1. 自动检测并安装 Node.js (如果不报错就不装)
echo 2. 自动下载 Qdrant 数据库软件
echo 3. 自动安装所有的系统依赖包
echo.
echo ⚠️ 请确保电脑连着网！过程中如果有弹窗问是否允许，请点“是”。
echo 期间可能会有点慢（因为要下载），请耐心等待不要关掉黑框！
echo.
pause

echo.
echo ------------- [1/3] 检查 Node.js 环境 -------------
node -v >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ❌ 没找到 Node.js，正在命令系统帮你自动下载安装，请稍候...
    winget install OpenJS.NodeJS -e --silent
    echo.
    echo ⚠️ 注意：Node.js 刚装完可能没这么快生效！
    echo 如果后面的步骤一直报错，请【重启一下电脑】再重新运行这个文件！
) ELSE (
    echo ✅ 检测到 Node.js 已安装，顺利过关！
)

echo.
echo ------------- [2/3] 自动获取 Qdrant 向量数据库软件 -------------
IF EXIST "14_qdrant\qdrant.exe" (
    echo ✅ qdrant.exe 已经为你准备好了，不需要再下载。
) ELSE (
    echo ❌ 在 14_qdrant 文件夹里没找到数据库引擎，正在自动为你去海外下载（可能有点慢）...
    if not exist "14_qdrant" mkdir 14_qdrant
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/qdrant/qdrant/releases/latest/download/qdrant-x86_64-pc-windows-msvc.zip' -OutFile '14_qdrant\qdrant.zip'"
    echo 正在解压刚才下载的文件...
    powershell -Command "Expand-Archive -Path '14_qdrant\qdrant.zip' -DestinationPath '14_qdrant' -Force"
    del 14_qdrant\qdrant.zip
    echo ✅ Qdrant 下载解压完成！
)

echo.
echo ------------- [3/3] 自动安装必须的代码依赖包 -------------
echo 正在为你装配网页和后台需要的小插件...
call npm install
echo ✅ 终于装完啦！

echo.
echo ------------- ⚠️ 最后一个你需要手动干的事 ⚠️ -------------
echo 电脑里的基础环境我已经帮你全装完了！
echo 但是！大语言模型相关的【LM Studio】文件太大了（好几个G），没法帮你自动下。
echo.
echo 👉 你现在只剩下两件事要做：
echo 1. 去官网下载 LM Studio 装上，并下载一个 embedding 模型（文档里有写）。
echo 2. 在后台填好你的大模型 API 密钥。
echo.
echo ==========================================================
echo 🎉 【恭喜，自动配置结束！】 
echo 一切准备就绪后，以后每次使用，只要双击【一键启动_局域网前后端.bat】就行了！
echo ==========================================================
pause

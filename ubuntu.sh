＃！/data/data/com.termux/files/usr/bin/bash
文件夹= ubuntu-fs
如果 [ -d  “ $ folder ” ] ;  然后
	首= 1
	回声 “跳过下载”
科幻
tarball = “ ubuntu.tar.gz ”
如果 [ “ $ first ” ！= 1] ; 然后
	如果 [ ！ -f  $ tarball ] ;  然后
		回声 “下载ubuntu图像”
		情况下 `的dpkg --print架构` 中
		aarch64）
			archurl = “ arm64 ” ;;
		臂）
			archurl = “ armhf ” ;;
		amd64）
			archurl = “ amd64 ” ;;
		我* 86）
			archurl = “ i386 ” ;;
		x86_64）
			archurl = “ amd64 ” ;;
		*）
			回声 “未知的建筑” ;  出口 1 ;;
		埃萨克
		wget “ https://partner-images.canonical.com/core/disco/current/ubuntu-disco-core-cloudimg- $ {archurl} -root.tar.gz ” -O $ tarball
	科幻
	CUR = ` PWD `
	mkdir -p “ $文件夹”
	cd  “ $文件夹”
	回声 “解压ubuntu图像”
	proot --link2symlink tar -xf $ {cur} / $ {tarball} --exclude = ' dev ' || ：
	回显 “修复名称服务器，否则无法连接到互联网”
	回声 “名称服务器1.1.1.1 ”  > etc / resolv.conf
	cd  “ $ cur ”
科幻
mkdir -p绑定
bin = start-ubuntu.sh
回显 “编写启动脚本”
猫>  $ bin  << - EOM
＃！/ bin / bash
cd \ $（目录名\ $ 0）
##在安装termux-exec的情况下取消LD_PRELOAD
未设置LD_PRELOAD
command =“ proot”
command + =“ --link2symlink”
command + =“ -0”
command + =“ -r $ folder”
如果[-n“ \ $（ls -A绑定）”]; 然后
    对于绑定中的f / *;
      。\ $ f
    做完了
科幻
command + =“ -b / dev”
command + =“ -b / proc”
##取消注释以下行可以访问termux的主目录
＃command + =“ -b /data/data/com.termux/files/home:/root”
##取消注释以下行以将/ sdcard直接安装到/ 
＃command + =“ -b / sdcard”
command + =“ -w / root”
命令+ =“ / usr / bin / env -i”
command + =“ HOME = / root”
command + =“ PATH = / usr / local / sbin：/ usr / local / bin：/ bin：/ usr / bin：/ sbin：/ usr / sbin：/ usr / games：/ usr / local / games”
command + =“ TERM = \ $ TERM”
command + =“ LANG = C.UTF-8”
command + =“ / bin / bash --login”
com =“ \ $ @”
如果[-z“ \ $ 1”];然后
    exec \ $ command
其他
    \ $ command -c“ \ $ com”
科幻
紧急行动

回声 “修复$ bin的 shebang ”
termux-fix-shebang $ bin
回声 “使$ bin可执行文件”
chmod + x $ bin
echo  “您现在可以使用./ $ {bin}脚本启动Ubuntu ”
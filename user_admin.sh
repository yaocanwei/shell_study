#!/bin/bash

function usage()
{
  echo 用法:
  echo 添加一个用户
  echo $0 -adduser 用户名 密码 
  echo
  echo 删除用户 
  echo $0 -deluser 用户名
  echo
  echo 为用户设置默认终端
  echo $0 -shell 终端 终端路径
  echo
  echo 禁用用户
  echo $0 -disable 用户名
  echo
  echo 激活用户
  echo $0 -enable 用户名
  echo
  echo 设置用户过期日期
  echo $0 -expiry 日期 
  echo
  echo 改变用户密码
  echo $0 -passwd 用户名
  echo
  echo 新建用户组
  echo $0 -newgroup 组名
  echo
  echo 删除用户组
  echo $0 -delgroup 组名
  echo
  echo 为组添加用户
  echo $0 -addgroup 用户名 组名
  echo
  echo 显示用户详情
  echo $0 -details 用户名
  echo
  echo 用法
  echo $0 -usage
  echo

  exit
}

if [ $UID -ne 0 ];
then
  echo 以超级管理员执行 $0 .
  exit 2
fi

case $1 in

  -adduser) [ $# -ne 3 ] && usage ; useradd $2 -p $3 -m ;; 
  -deluser) [ $# -ne 2 ] && usage ; deluser $2 --remove-all-files;;
  -shell)    [ $# -ne 3 ] && usage ; chsh $2 -s $3 ;;
  -disable) [ $# -ne 2 ] && usage ; usermod -L $2 ;; 
  -enable) [ $# -ne 2 ] && usage ; usermod -U $2  ;;
  -expiry) [ $# -ne 3 ] && usage ; chage $2 -E $3 ;;
  -passwd) [ $# -ne 2 ] && usage ; passwd $2 ;;
  -newgroup) [ $# -ne 2 ] && usage ; addgroup $2 ;;
  -delgroup) [ $# -ne 2 ] && usage ; delgroup $2 ;;
  -addgroup) [ $# -ne 3 ] && usage ; addgroup $2 $3 ;;
  -details) [ $# -ne 2 ] && usage ; finger $2 ; chage -l $2 ;;
  -usage) usage ;;
  *) usage ;;
esac
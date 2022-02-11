#!/bin/bash


PHPFPM="/usr/local/sbin/php-fpm"

PHPINI="/usr/local/etc/php/php.ini"

PHPFPM_CONFIG="/usr/local/etc/php-fpm.conf"



# 检查程序是否在运行
is_exist() {
  pid=$(ps -ef | grep "php-fpm: master" | grep -v grep | awk '{print $1}')
  #如果不存在返回1，存在返回0
  if [ -z "${pid}" ]; then
    return 1
  else
    return 0
  fi
}

# 启动方法
start() {
  is_exist
  if [ $? -eq 0 ]; then
    echo "警告: php-fpm is already running PID=${pid}"
  else
    nohup $PHPFPM -c $PHPINI -y $PHPFPM_CONFIG -D >> /dev/null 2>&1 &

    is_exist
     if [ $? -eq 0 ]; then
          echo "服务【php-fpm】启动成功 PID=${pid}"
     fi
  fi
}

# 停止方法
stop() {
  is_exist
  if [ $? -eq "0" ]; then
     kill -INT ${pid}

     #循环等待进程结束
     i=1
    while true; do
      is_exist
      if [ $? -eq "0" ]; then
        echo '正在停止【php-fpm】服务... ... ('$i's)'
        #等待1s
        sleep 1
        let i++
      else
        break
      fi
    done

    echo "服务【php-fpm】停止成功"
  else
    echo "服务【php-fpm】is not running"
  fi
}

# 输出运行状态
status() {
  is_exist
  if [ $? -eq "0" ]; then
    echo "服务【php-fpm】is running PID=${pid}"
  else
    echo "服务【php-fpm】is not running"
  fi
}

# 使用说明，用来提示输入参数
usage() {
  echo "Usage: xxx.sh [start|stop|restart|status]"
  exit 1
}

case "$1" in
"start")
  start
  ;;
"stop")
  stop
  ;;
"status")
  status
  ;;
"restart")
  stop
  echo ""
  echo "------------------------------------------------------------------------"
  echo ""
  sleep 1
  start
  ;;
*)
  usage
  ;;
esac
exit 0
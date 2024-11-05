#!/usr/bin/bash
#set -o errexit
#set -o nounset
#set -o pipefail

## 需要清理的目录
K8S_LOGS_DIR=${K8S_LOGS_DIR:-'/var/log/kubernetes/'}
APP_LOGS_DIR=${APP_LOGS_DIR:-'{{data_dir}}/app/'}


function common::log_info ()
{
if [ ! -d /home/log  ]
then
    mkdir -p /home/log
fi
DATE_N=`date "+%Y-%m-%d %H:%M:%S"`
USER_N=`whoami`
echo "${DATE_N} ${USER_N} execute $0 [INFO] $@" >>/home/log/k8s_clear.log #执行成功日志打印路径

}

function common::log_error ()
{
DATE_N=`date "+%Y-%m-%d %H:%M:%S"`
USER_N=`whoami`
echo -e "\033[41;37m ${DATE_N} ${USER_N} execute $0 [ERROR] $@ \033[0m"  >>/home/log/k8s_clear.log  #执行失败日志打印路径

}

function common::fn_log ()  {
if [  $? -eq 0  ]
then
    common::log_info "$@ sucessed."
else
    common::log_error "$@ failed."
#    exit 1
fi
}

#Delete the logs under k8s_logs directory 3 days ago
function k8s::del_k8s_logs(){
  k8s_logs_dir=${K8S_LOGS_DIR}
  if [ -d ${k8s_logs_dir} ];then
    files_list=`find $k8s_logs_dir -type f -mtime +2`
      for file in $files_list;do
        rm -f $file
        common::fn_log $? "开始删除:${file}日志文件."
      done
  fi
}

# prune images
function docker::clear_img() {
      echo y | docker system prune -a
}

#Delete the logs under app_logs directory 4 days ago
function app::clear_app_logs(){
  app_logs_dir=${APP_LOGS_DIR}
  if [ -d ${app_logs_dir} ];then
    files_list=`find $app_logs_dir -type f -mtime +3`
      for file in $files_list;do
#        rm -f $file
        echo > $file
        common::fn_log $? "开始删除:${file}日志文件."
      done
  fi
}

## 距今 1 天前
function app::del_app_coredump(){
  core_dir=${APP_LOGS_DIR}
  if [ -d ${core_dir} ];then
    files_list=`find $core_dir  -name "core*" -mtime 1`
      for file in $files_list;do
#        rm -rf $file
         rm -rf "$(printf '%q' "$file")"
        common::fn_log $? "开始删除:${file} coredump文件."
      done
  fi
}


#docker::clear_img

k8s::del_k8s_logs

app::clear_app_logs

app::del_app_coredump
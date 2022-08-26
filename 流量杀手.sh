#!/bin/bash
## 主要变量
### User-Agent
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/13.10586"
### 目标下载连接
DownloadLink=
### 间隔时间，单位秒
waitTime=1

## Generate split line / 生成分割线
function print_x_axis(){  
    local Line= Title= Bytes= Xlength=  
  
    Title="$*"  
    Line='-'  
  
    if [ -n "${Title}" ]; then  
        Bytes=$(echo "${Title}"|wc -c)  
    else  
        Bytes=1  
    fi  
  
    Xlength=$(( $(stty size|awk '{print $2}') - ${Bytes} ))  
    printf '%s ' "${Title}"  
    printf "%${Xlength}s\n" "${Line}"|sed "s/ /${Line}/g"  
}   

## 打印基本信息
print_x_axis
echo UA = ${UA}
echo Link = ${DownloadLink}
print_x_axis

## 循环下载
i=0
all_size_download=0

### 循环次数，需要的循环次数-1，例如需要循环1000次，即填999就行
while ((${i}<=999))
do
    let "i++"
    #curl --user-agent "${UA}" -o /dev/null ${DownloadLink}
    new_size_download=$(curl --user-agent "${UA}" -o /dev/null ${DownloadLink} --write-out @size_download)
    all_size_download=$((${all_size_download}+${new_size_download}))
    print_x_axis
    echo "已完成第 ${i} 次"
    echo "共计下载量：" $((${all_size_download}/1024/1024)) "MB"
    sleep ${waitTime}
    print_x_axis
done



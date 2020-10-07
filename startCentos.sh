########################################################################
#	> File Name:startCentos.sh
#	> Author: jarven
#	> Mail: whuaw@aliyun.com
#	> Created Time: Wed 07 Oct 2020 08:28:17 AM PDT
########################################################################

#!/bin/bash

##浮点数比较
#function compare_version()
#{
#	echo "p1:"$1
#	echo "p2:"$2
#	if [ `echo "$1 < $2"|bc` -eq 1 ] ; then 
#		 echo  "$1 < $2 " 
#	 else 
#		 echo "$1 > $2 " 
#	fi
#}

#1. Install devtool , for gcc version > 5.0
# Centos的版本是7或是8，默认的GCC版本是低于5的不支持C++11，
# 需要安装devtool来使用gcc5.0以上的版本.
install_devtool()
{
	sudo yum install centos-release-scl
	sudo yum install devtoolset-7
	scl enable devtoolset-7 bash
}

GCC_VERSION=`gcc -dumpversion | awk -F . '{print $1}'`
#compare_version $GCC_VERSION 7
if [ $GCC_VERSION -gt 5 ]
then
	echo "GCC version:"$GCC_VERSION
else
	echo "Current gcc version is too old("$GCC_VERSION"), enable the devtool"
	scl enable devtoolset-7 bash
	if [ $? -ne 0 ];then
		install_devtool
	fi
fi

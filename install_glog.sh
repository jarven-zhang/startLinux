########################################################################
#	> File Name:install_glog.sh
#	> Author: jarven
#	> Mail: whuaw@aliyun.com
#	> Created Time: Wed 07 Oct 2020 10:10:21 AM PDT
########################################################################

#!/bin/bash

SOFT_DIR=~/soft

#1. install cmake
install_cmake()
{
	sudo yum install openssl-devel.x86_64 -y
	
	cd $SOFT_DIR
	wget https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4.tar.gz
	cd cmake-3.18.4
	scl enable devtoolset-7 bash
	./bootstrap
	make -j4
	sudo make install
}

#2. install glog
install_glog()
{
	cd $SOFT_DIR
	git clone https://github.com/google/glog.git
	cd glog
	cmake -H. -Bbuild -G "Unix Makefiles"
	cmake --build build
	cmake --build build --target install
}


#已经安装cmake且版本低于3，重新安装
if ! type cmake >/dev/null 2>&1; then
    echo 'cmake未安装';
	install_cmake
else
    echo 'cmake已安装,version:'`cmake --version`;
fi

install_glog


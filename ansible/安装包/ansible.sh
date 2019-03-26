#!/bin/sh
#因离线安装，故将安装所需压缩包放在服务器/home/ansible文件夹下（请先创建ansible文件夹）
#（1）python2.7安装
cd /home/ansible
tar xvzf Python-2.7.8.tgz
cd Python-2.7.8
./configure --prefix=/usr/local
make
make install
# 将python头文件拷贝到标准目录，以避免编译ansible时，找不到所需的头文件
cd /usr/local/include/python2.7
cp -a ./* /usr/local/include/
# 备份旧版本的python，并符号链接新版本的python
cd /usr/bin
mv python python.old
ln -s /usr/local/bin/python2.7 /usr/local/bin/python
rm -f /usr/bin/python && cp /usr/local/bin/python2.7 /usr/bin/python
# 修改yum脚本，使其指向旧版本的python，已避免其无法运行
sed -i 's/\/usr\/bin\/python/\/usr\/bin\/python2.4/g' /usr/bin/yum
#（2）setuptools模块安装
cd /home/ansible
tar xvzf setuptools-7.0.tar.gz
cd setuptools-7.0
python setup.py install
#安装好setuptools后就可以利用easy_install这个工具安装下面的python模块了，但若电脑是虚拟机，配置太低，则基本无法安装，所以只好一个一个下载下来再安装。
#(3)、pycrypto模块安装
cd /home/ansible
tar xvzf pycrypto-2.6.1.tar.gz
cd pycrypto-2.6.1
python setup.py install
#(4)、PyYAML模块安装
cd /home/ansible
tar xvzf yaml-0.1.5.tar.gz
cd yaml-0.1.5
./configure --prefix=/usr/local
make --jobs=`grep processor /proc/cpuinfo | wc -l`
make install
#---------------------------
cd /home/ansible
tar xvzf PyYAML-3.11.tar.gz
cd PyYAML-3.11
python setup.py install
#(5)、Jinja2模块安装
cd /home/ansible
tar xvzf MarkupSafe-0.9.3.tar.gz
cd MarkupSafe-0.9.3
python setup.py install
#---------------------------
cd /home/ansible
tar xvzf Jinja2-2.7.3.tar.gz
cd Jinja2-2.7.3
python setup.py install
#(6)、paramiko模块安装
cd /home/ansible
tar xvzf ecdsa-0.11.tar.gz
cd ecdsa-0.11
python setup.py install
#---------------------------
cd /home/ansible
tar xvzf paramiko-1.15.1.tar.gz
cd paramiko-1.15.1
python setup.py install
#(7)、simplejson模块安装
cd /home/ansible
tar xvzf simplejson-3.6.5.tar.gz
cd simplejson-3.6.5
python setup.py install
#(8)、ansible安装
cd /home/ansible
tar xvzf ansible-1.7.2.tar.gz
cd ansible-1.7.2
python setup.py install

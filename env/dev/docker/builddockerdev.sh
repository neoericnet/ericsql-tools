#!/bin/bash
set -e
##define env
version=1.0
echo buidl version=$version

##define vars
#path
root_path=$HOME/dev
user_name=$(git config --get user.name)
git_user_email=$user_name@163.com
docker_path=$root_path/docker
dockerfile_path=$docker_path/dockerfile
shell_path=$(cd "$(dirname "$0")"; pwd)
tools_path=$(cd $shell_path/../../../; pwd)
source_path=$root_path/git/
build_path=$source_path/build/mysql
data_path=$root_path/data
#version
docker_image_version=centos:centos6-mysql-dev-$version
docker_container_name=mysql-dev

##prepare path
#clean
if [ -d "$docker_path" ]; then
  cd $docker_path
  rm -rf dockerfile builddockerdev.sh gitconfig.sh profileconfig.sh
fi
#mkdir
mkdir -p $docker_path
mkdir -p $source_path
mkdir -p $build_path
mkdir -p $data_path
mkdir -p $dockerfile_path/.ssh

##clean env
set +e
chmod 777 $source_path
chmod -R 777 $build_path
chmod -R 777 $data_path
chmod 755 $data_path/*.cnf
docker stop $docker_container_name
docker rm -v $docker_container_name
docker rmi $docker_image_version
set -e

##prepare for build
#git config file
>$dockerfile_path/gitconfig.sh
echo #!/bin/sh > $dockerfile_path/gitconfig.sh
echo git config --system core.autocrlf false >> $dockerfile_path/gitconfig.sh
echo git config --system core.safecrlf warn >> $dockerfile_path/gitconfig.sh
echo git config --system color.status auto >> $dockerfile_path/gitconfig.sh
echo git config --system color.diff auto >> $dockerfile_path/gitconfig.sh
echo git config --system color.branch auto >> $dockerfile_path/gitconfig.sh
echo git config --system color.interactive auto >> $dockerfile_path/gitconfig.sh
echo git config --system http.sslVerify false >> $dockerfile_path/gitconfig.sh
echo git config --system credential.helper cache >> $dockerfile_path/gitconfig.sh
echo git config --system user.name "$user_name" >> $dockerfile_path/gitconfig.sh
echo git config --system user.email "$git_user_email" >> $dockerfile_path/gitconfig.sh
echo git config --system core.excludesfile /etc/gitignore >> $dockerfile_path/gitconfig.sh
chmod 755 $dockerfile_path/gitconfig.sh
#profile config file
>$dockerfile_path/profileconfig.sh
echo #!/bin/sh > $dockerfile_path/profileconfig.sh
echo 'echo "#find .h file for gcc" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export C_INCLUDE_PATH=/usr/include:/usr/local/include/gtest:$C_INCLUDE_PATH:. >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo "#find .h file for g++" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export CPLUS_INCLUDE_PATH=/usr/include:/usr/local/include/gtest:$CPLUS_INCLUDE_PATH:. >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo "#search .so path when execute program" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LD_LIBRARY_PATH:. >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo "#find static lib .a path" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LIBRARY_PATH:. >>/etc/profile' >> $dockerfile_path/profileconfig.sh
chmod 755 $dockerfile_path/profileconfig.sh
#cp file
cp -rf $HOME/.ssh/* $dockerfile_path/.ssh
cp -rf $tools_path/env/dev/docker/dockerfile $docker_path
cp -rf $tools_path/3rd $dockerfile_path
cd $dockerfile_path
tar -xjf 3rd/gcc/gcc-4.8.5.tar.bz2
tar -xvf 3rd/cmake/cmake-3.11.4.tar.gz
tar -xvf 3rd/bison/bison-3.0.4.tar.gz
tar -xjf 3rd/boost/boost_1_59_0.tar.bz2
#build file
#git config file
#mysqldemo cnf file
if [ ! -f "$data_path/mysqldemo.cnf" ]; then
  cp -rf $tools_path/env/dev/docker/data/demo/mysqldemo.cnf $data_path/mysqldemo.cnf
fi
##build images
cd $dockerfile_path
docker build -t $docker_image_version .

##run container
docker run -itd --name $docker_container_name -v $source_path:/soft/mysql/source -v $data_path:/data/mysql $docker_image_version

##check
docker images
docker ps

##clean env
#clean
if [ -d "$docker_path" ]; then
  cd $docker_path
  rm -rf dockerfile builddockerdev.sh gitconfig.sh profileconfig.sh
fi

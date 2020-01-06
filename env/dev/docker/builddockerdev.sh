#!/bin/bash
set -e
##define env
version=1.0
docker_image_repo=registry.cn-hangzhou.aliyuncs.com/ericdemo/mysqlkernel
echo buidl version=$version

##define vars
#path
root_path=$HOME/dev
user_name=ericsql_ci
git_user_email=$user_name@hotmail.com
docker_path=$root_path/docker
dockerfile_path=$docker_path/dockerfiles/
shell_path=$(cd "$(dirname "$0")"; pwd)
tools_path=$(cd $shell_path/../../../; pwd)
source_path=$root_path/git/
build_path=$root_path/build/
data_path=$root_path/data
mysql_uid=$(id -u)
mysql_gid=$(id -g)
#version
docker_image_version=$docker_image_repo:centos6-mysql-dev-$version
docker_container_name=mysql-dev

##prepare path
#clean
if [ -d "$docker_path" ]; then
  cd $docker_path
  rm -rf dockerfiles builddockerdev.sh Dockerfile
fi
#mkdir
mkdir -p $docker_path
mkdir -p $source_path
mkdir -p $build_path
mkdir -p $data_path
mkdir -p $dockerfile_path/ssh
mkdir -p $dockerfile_path/3rd

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
echo 'echo "#find .h file for gcc" >>/etc/profile' \
  >> $dockerfile_path/profileconfig.sh
echo 'echo export C_INCLUDE_PATH=/usr/local/include:/usr/local/include/gtest:$C_INCLUDE_PATH:. >>/etc/profile' \
  >> $dockerfile_path/profileconfig.sh
echo 'echo  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo "#find .h file for g++" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export CPLUS_INCLUDE_PATH=/usr/local/include:/usr/local/include/gtest:$CPLUS_INCLUDE_PATH:. >>/etc/profile' \
  >> $dockerfile_path/profileconfig.sh
echo 'echo  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo "#search .so path when execute program" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LD_LIBRARY_PATH:. \
  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo "#find static lib .a path" >>/etc/profile' >> $dockerfile_path/profileconfig.sh
echo 'echo export LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LIBRARY_PATH:. \
  >>/etc/profile' >> $dockerfile_path/profileconfig.sh
chmod 755 $dockerfile_path/profileconfig.sh
#cp file
cp -rf $tools_path/env/dev/docker/dockerfile/* $docker_path/dockerfiles/
mv $dockerfile_path/Dockerfile $docker_path/
cp -rf $tools_path/ci/ssh/* $dockerfile_path/ssh
#copy 3rd
cp -rf $tools_path/3rd/gcc $dockerfile_path/3rd/
cp -rf $tools_path/3rd/cmake $dockerfile_path/3rd/
cp -rf $tools_path/3rd/bison $dockerfile_path/3rd/
cd $dockerfile_path/3rd/gcc/
tar -xjf gcc-4.8.5.tar.bz2
cd $dockerfile_path/3rd/cmake/
tar -xvf cmake-3.11.4.tar.gz
cd $dockerfile_path/3rd/bison/
tar -xvf bison-3.0.4.tar.gz
#build file
#git config file
#mysqldemo cnf file
if [ ! -f "$data_path/mysqldemo.cnf" ]; then
  cp -rf $tools_path/env/dev/docker/data/demo/mysqldemo.cnf $data_path/mysqldemo.cnf
fi
##build images
cd $docker_path
set -x
docker build --no-cache -t $docker_image_version .

##run container
docker run -itd \
  --name $docker_container_name \
  -v $build_path:/soft/mysql/dev/build \
  -v $source_path:/soft/mysql/dev/git \
  -v $data_path:/data/mysql \
  $docker_image_version $mysql_uid $mysql_gid

set +x

##check
docker images
docker ps

##clean env
#clean
if [ -d "$docker_path" ]; then
  cd $docker_path
  rm -rf dockerfiles builddockerdev.sh Dockerfile
fi

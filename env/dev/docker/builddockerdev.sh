#!/bin/bash
set -e
##define env
version=1.0
echo buidl version=$version

##define vars
#path
root_path=$HOME/dev
docker_path=$root_path/docker
dockerfile_path=$docker_path/dockerfile
git_path=$root_path/git/
data_path=$root_path/data
#version
docker_image_version=centos:centos6-mysql-dev-$version
docker_container_name=mysqlsql-dev

##prepare path
#clean
cd $docker_path
rm -rf dockerfile builddockerdev.sh
#mkdir
mkdir -p $docker_path
mkdir -p $git_path
mkdir -p $data_path

##clean env
docker stop $docker_container_name
docker rm -v $docker_container_name
docker rmi $docker_image_version

##clone mysql-tools
cd $git_path
if [ ! -d "$git_path/mysql-tools" ]; then
  git clone git@git.eric.com:mysqlkernel/ericsql-tools.git mysql-tools
else
  cd $git_path/mysql-tools && git pull
fi

##prepare for build
#cp file
cp -rf $HOME/.ssh $dockerfile_path/
cp -rf $git_path/mysql-tools/env/dev/docker/dockerfile $docker_path
cp -rf $git_path/mysql-tools/3rd $dockerfile_path
#build file
#git config file

##build images
cd $dockerfile_path
docker build -t $docker_image_version .

##run container
docker run -itd --name $docker_container_name -v $git_path:/soft/mysql/source -v $data_path:/data/mysql $docker_image_version

##check
docker images
docker ps

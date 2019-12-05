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
  rm -rf dockerfile builddockerdev.sh
fi
#mkdir
mkdir -p $docker_path
mkdir -p $source_path
mkdir -p $build_path
mkdir -p $data_path
mkdir -p $dockerfile_path/.ssh

##clean env
set +e
chmod -R 777 $source_path
chmod -R 777 $build_path
chmod -R 777 $data_path
docker stop $docker_container_name
docker rm -v $docker_container_name
docker rmi $docker_image_version
set -e

##prepare for build
#cp file
cp -rf $HOME/.ssh/* $dockerfile_path/.ssh
cp -rf $tools_path/env/dev/docker/dockerfile $docker_path
cp -rf $tools_path/3rd $dockerfile_path
cd $dockerfile_path
tar -xjf 3rd/boost/boost_1_59_0.tar.bz2
#build file
#git config file

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
  rm -rf dockerfile builddockerdev.sh
fi

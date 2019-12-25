# ERICSQL Tools Repository

## Link

* [ERICSQL repository](http://git.eric.com/mysqlkernel/ericsql)
* [Jenkins CI]()

## Introduction

ERICSQL if engine of ERIC's MySQL-compatible product.

This repository containers the scripts for the CI system that tests ERICSQL.

The mysql-test-run.pl script is used to run the tests.



## Directory planning

```
.
|-- 3rd
|   |-- bison
|   |-- boost
|   |-- cmake
|   `-- gcc
|-- ci
|   `-- ssh
|-- env
|   `-- dev
|-- LICENSE
`-- README.md

```

Node: you can use command to get the source tree:

```
cd $SOURCE_PATH/mysql-tools
tree -L 2
```



## Init develop env

Befor do it, you should install docker and git, and config git in your local machine.

If your local os is os-x, you need to install [docker-sync](https://docker-sync.readthedocs.io/en/latest/getting-started/installation.html#installation-osx).

Init .bash_profile file, the file content in [mysql-tools](http://git.eric.com/mysqlkernel/ericsql-tools/blob/master/env/dev/docker/dockerfile/bash_profile)

If your root work dir is $HOME/dev

```
mkdir -p $SOURCE_PATH
mkdir -p $DOCKER_TMP_PATH
```

If your machine is mac, we need to install docker-sync.In $HOME/dev/docker dir, add new file:docker-sync.yml

src is dir:$HOME/dev/docker

```
version: '2'

options:
  verbose: false
  
syncs:
  unison-sync:
    #mount path
    src:'/soft/mysql/dev/docker'
    #macos native_osx,Windows unison
    sync_strategy: native_osx
    # userid is 1000, same to your php-fpm's userid
    sync_userid: 1000
    #execlude files
    sync_excludes:[
      '.gitignore',
      '.git/',
      '.DS_Store'
    ]
```

git config(it is my config, you need modify the user.name and user.email):

```
git config --system core.autocrlf false
git config --system core.safecrlf warn
git config --system color.status auto
git config --system color.diff auto
git config --system color.branch auto
git config --system color.interactive auto
git config --system http.sslVerify false
git config --system credential.helper cache
git config --system user.name "neoericnet"
git config --system user.email neoericnet@163.com
git config --system core.excludesfile /etc/gitignore
```

General your ssh key and update pub key in git server:

```
ssh-keygen -t rsa -C "neoericnet@163.com"
```



Add some alias to $HOME/.bash_profile in local machine.

```
#dev docker build
export DEV_IMAGE_TAG=registry.cn-hangzhou.aliyuncs.com/ericdemo/mysqlkernel:centos6-mysql-dev-1.0
export DEV_CONTAINER_NAME=mysql-dev
alias builddi="sh $SOURCE_PATH/mysql-tools/env/dev/docker/builddockerdev.sh"
alias builddc="docker run -itd --name $DEV_CONTAINER_NAME -v $BUILD_PATH:/soft/mysql/dev/build -v $SOURCE_PATH:/soft/mysql/dev/git -v $DOCKER_DATA_PATH:/data/mysql $DEV_IMAGE_TAG $(id -u) $(id -g)"
alias logind="docker exec -it $DEV_CONTAINER_NAME /bin/bash"
alias startdd="docker start `docker ps -a |grep $DEV_CONTAINER_NAME |awk '{print $1}'`"
```

source ~/.bash_profile



Init git dir:

```
#in your work directory
mkdir -p $SOURCE_PATH
cd $SOURCE_PATH
git clone git@git.eric.com:mysqlkernel/ericsql-tools.git mysql-tools
cp -f mysql-tools/env/dev/docker/dockerfile/gitignore /etc/gitignore

```



## Build Docker Image

build docker image

```
builddi
```

push your image

```
docker images
#f283a336552b is ImageID
docker tag f283a336552b registry.cn-hangzhou.aliyuncs.com/ericdemo/mysqlkernel:centos6-mysql-dev-1.0
docker push registry.cn-hangzhou.aliyuncs.com/ericdemo/mysqlkernel:centos6-mysql-dev-1.0

```



## Run In Your Docker Container

Note: 

- The docker image and container use the ci acount by default, this account has read-only access only.

​		   If you need more privileges, please reconfigure your git account information.

- The user:mysql don't has  password, you need to set it.
- You need to config your local docker CPU to the appropriate number of cores.
- You need to modify the mysql user file:$HOME/bin/env's repository to your own repository.

​     

build your docker container

```
docker pull registry.cn-hangzhou.aliyuncs.com/ericdemo/mysqlkernel:centos6-mysql-dev-1.0
mkdir -p $DOCKER_DATA_PATH
mkdir -p $BUILD_PATH
cp $SOURCE_PATH/mysql-tools/env/dev/docker/data/demo/mysqldemo.cnf $DOCKER_DATA_PATH
builddc
```

login your container

```
logind
```

download mysql source code

```
su - mysql
getsource
```

build and install mysql

```
cmakemysql && makemysql && makeinstallmysql
```



init mysqldemo database

```
$BUILD_PATH/mysql/debug/bin/mysqld --defaults-file=$DATA_PATH/mysqldemo.cnf --initialize --user=mysql
```

start mysql demo

```
startbuildmysql
```

conn mysql demo(no password)

```
connmysql
```



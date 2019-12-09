# ERICSQL Tools Repository

## Link

* [ERICSQL repository](http://git.eric.com/mysqlkernel/ericsql)
* [Jenkins CI]()

## Introduction

ERICSQL if engine of ERIC's MySQL-compatible product.

This repository containers the scripts for the CI system that tests ERICSQL.

The mysql-test-run.pl script is used to run the tests.



## Init develop env

Befor do it, you should install docker and git, and config git in your local machine.

If your local os is os-x, you need to install docker-sync.

If your root work dir is $HOME/dev

```
mkdir -p $HOME/dev/git
mkdir -p $HOME/dev/docker
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



```
#in your work directory
mkdir -p $HOME/dev/git
cd $HOME/dev/git
git clone git@git.eric.com:mysqlkernel/ericsql-tools.git mysql-tools
sh mysql-tools/env/dev/docker/builddockerdev.sh
```

log cmd:

```
docker exec -it mysql-dev /bin/bash
su - mysql
```

download mysql source code

```
getsource
```

build and install mysql

```
cmakemysql && makemysql && makeinstallmysql
```



init mysqldemo database

```
/soft/mysql/source/build/mysql/debug/bin/mysqld --defaults-file=/data/mysql/mysqldemo.cnf --initialize --user=mysql
```

start mysql demo

```
startbuildmysql
```

conn mysql demo(no password)

```
connmysql
```


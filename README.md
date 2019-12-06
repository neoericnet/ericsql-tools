# ERICSQL Tools Repository

## Link

* [ERICSQL repository](http://git.eric.com/mysqlkernel/ericsql)
* [Jenkins CI]()

## Introduction

ERICSQL if engine of ERIC's MySQL-compatible product.

This repository containers the scripts for the CI system that tests ERICSQL.

The mysql-test-run.pl script is used to run the tests.



## Init develop env

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



TODO:

init mysqldemo database

```
initmysqldemo
```

start mysql demo

```
startbuildmysql
```

conn mysql demo(password:mysql123)

```
connmysql
```


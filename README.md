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
git clone git@git.eric.com:mysqlkernel/ericsql-tools.git mysql-tools
sh mysql-tools/env/dev/docker/builddockerdev.sh
```


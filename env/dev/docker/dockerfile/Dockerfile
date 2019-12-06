FROM centos:centos6
RUN yum install -y gcc gcc-c++ make python-devel bunzip2 bzip2-devel zlib-devel libicu libicu-devel libXp libXt libXtst glibc-common glibc-devel glibc glibc-headers compat-glibc-headers compat-glibc glibc-static glibc-utils bison perl ncurses-devel libaio-devel numactl numactl-devel cmake wget nc git openssl openssl-libs openssl-devel \
    && mkdir -p /soft/mysql && groupadd mysql && useradd -d /soft/mysql -r -g mysql -s /bin/bash mysql && chown -R mysql:mysql /soft/mysql
COPY boost_1_59_0 /root/soft/boost/boost_1_59_0
COPY gitignore /etc/
COPY --chown=mysql:mysql bin /soft/mysql/bin/
COPY --chown=mysql:mysql gitconfig.sh /soft/mysql/bin/
COPY --chown=mysql:mysql .bash_profile /soft/mysql/
COPY --chown=mysql:mysql .bashrc /soft/mysql/
COPY --chown=mysql:mysql .ssh /soft/mysql/.ssh/
RUN chmod -R 755 /soft/mysql/bin/ \
    && sh /soft/mysql/bin/gitconfig.sh \
    && chmod 600 /soft/mysql/.ssh/id_rsa \
    && cd /root/soft/boost/boost_1_59_0 \
    && ./bootstrap.sh \
    && ./b2 install \
    && chmod -R 755 /usr/local/include/boost \
    && chmod -R 755 /usr/local/lib

FROM centos:centos6
RUN yum install -y gcc gcc-c++ make python-devel bunzip2 bzip2-devel zlib-devel libicu libicu-devel libXp libXt libXtst glibc-common glibc-devel glibc glibc-headers compat-glibc-headers compat-glibc glibc-static glibc-utils bison perl ncurses-devel libaio-devel numactl numactl-devel cmake wget nc git openssl openssl-libs openssl-devel \
    && mkdir -p /soft/mysql && groupadd mysql && useradd -d /soft/mysql -r -g mysql -s /bin/bash mysql && chown -R mysql:mysql /soft/mysql \
    && git config --system core.autocrlf false \
    && git config --system core.safecrlf warn \
    && git config --system color.status auto \
    && git config --system color.diff auto \
    && git config --system color.branch auto \
    && git config --system color.interactive auto \
    && git config --system http.sslVerify false \
    && git config --system credential.helper cache \
    && git config --system user.name "yaodi03" \
    && git config --system user.email yaodi03@meituan.com \
    && git config --system core.excludesfile /etc/gitignore
COPY 3rd/boost/boost_1_59_0.tar.bz2 /root/soft/boost/
COPY gitignore /etc/
COPY --chown=mysql:mysql bin /soft/mysql/bin/
COPY --chown=mysql:mysql .bash_profile /soft/mysql/
COPY --chown=mysql:mysql .bashrc /soft/mysql/
COPY --chown=mysql:mysql .ssh /soft/mysql/.ssh/
RUN chmod -R 755 /soft/mysql/bin/ \
    && chmod 600 /soft/mysql/.ssh/id_rsa \
    && tar -xjf /root/soft/boost/boost_1_59_0.tar.bz2 \
    && sh /root/soft/boost/boost_1_59_0/bootstrap.sh \
    && sh /root/soft/boost/boost_1_59_0/b2 install \
    && chmod -R 755 /usr/local/include/boost \
    && chmod -R 755 /usr/local/lib

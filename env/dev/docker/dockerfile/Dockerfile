FROM centos:centos6
RUN yum install -y gcc gcc-c++ make python-devel bunzip2 bzip2-devel zlib-devel libicu libicu-devel libXp libXt libXtst glibc-common glibc-devel glibc glibc-headers compat-glibc-headers compat-glibc glibc-static glibc-utils perl ncurses-devel libaio-devel numactl numactl-devel wget nc git openssl openssl-libs openssl-devel man epel-release check boost-devel asio-devel readline-devel pam-devel perl-Env time rpmdevtools rpm-build libcurl-devel \
    && mkdir -p /soft/mysql && groupadd mysql && useradd -d /soft/mysql -r -g mysql -s /bin/bash mysql && chown -R mysql:mysql /soft/mysql
COPY gcc-4.8.5    /root/soft/gcc/gcc-4.8.5
COPY cmake-3.11.4 /root/soft/cmake/cmake-3.11.4
COPY bison-3.0.4  /root/soft/bison/bison-3.0.4
COPY boost_1_59_0 /root/soft/boost/boost_1_59_0
COPY gitignore /etc/
COPY --chown=mysql:mysql bin /soft/mysql/bin/
COPY --chown=mysql:mysql gitconfig.sh /soft/mysql/bin/
COPY --chown=mysql:mysql profileconfig.sh /soft/mysql/bin/
COPY --chown=mysql:mysql .bash_profile /soft/mysql/
COPY --chown=mysql:mysql .bashrc /soft/mysql/
COPY --chown=mysql:mysql .ssh /soft/mysql/.ssh/
RUN chmod -R 755 /soft/mysql/bin/ \
    && sh /soft/mysql/bin/gitconfig.sh \
    && chmod 600 /soft/mysql/.ssh/id_rsa \
    && cd /root/soft/gcc/gcc-4.8.5 \
    && ./contrib/download_prerequisites \
    && mkdir gcc-build \
    && cd gcc-build \
    && ../configure -enable-checking=release -enable-languages=c,c++ -disable-multilib \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && mv /usr/bin/cc /usr/bin/cc-4.4.7 \
    && mv /usr/bin/gcc /usr/bin/gcc-4.4.7 \
    && mv /usr/bin/x86_64-redhat-linux-gcc /usr/bin/x86_64-redhat-linux-gcc-4.4.7 \
    && ln -s /usr/local/bin/gcc /usr/local/bin/cc \
    && update-alternatives --install /usr/bin/gcc gcc /usr/local/bin/x86_64-unknown-linux-gnu-gcc 200 \
    && sh /soft/mysql/bin/profileconfig.sh \
    && cd /root/soft/cmake/cmake-3.11.4 \
    && ./bootstrap \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && cd /root/soft/boost/boost_1_59_0 \
    && ./bootstrap.sh \
    && ./b2 install \
    && chmod -R 755 /usr/local/include/boost \
    && chmod -R 755 /usr/local/lib \
    && cd /root/soft/bison/bison-3.0.4 \
    && ./configure --prefix="/usr/" \
    && make -j$(getconf _NPROCESSORS_ONLN) && make install


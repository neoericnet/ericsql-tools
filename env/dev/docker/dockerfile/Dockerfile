FROM centos:centos6
COPY dockerfile /root/dockerfiles/
RUN yum install -y gcc gcc-c++ make python-devel bunzip2 bzip2-devel zlib-devel libicu libicu-devel \
    libXp libXt libXtst glibc-common glibc-devel glibc glibc-headers compat-glibc-headers compat-glibc \
    glibc-static glibc-utils perl ncurses-devel libaio-devel numactl numactl-devel wget nc git openssl \
    openssl-libs openssl-devel man epel-release check boost-devel asio-devel readline-devel pam-devel \
    perl-Env time rpmdevtools rpm-build libcurl-devel dos2unix tree \
    && mkdir -p /root/soft/m4 \
    && cd /root/soft/m4 \
    && wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz \
    && tar xvf m4-1.4.18.tar.gz \
    && cd /root/soft/m4/m4-1.4.18 \
    && ./configure && make && make install \
    && mkdir -p /soft/mysql \
    && groupadd mysql \
    && useradd -d /soft/mysql -r -g mysql -s /bin/bash mysql \
    && cp -rf /root/dockerfile/gitignore /etc \
    && cp -rf /root/dockerfile/bin /soft/mysql/ \
    && cp -rf /root/dockerfile/gitconfig.sh /soft/mysql/bin/ \
    && cp -rf /root/dockerfile/profileconfig.sh /soft/mysql/bin/ \
    && cp -rf /root/dockerfile/bash_profile /soft/mysql/ \
    && cp -rf /root/dockerfile/bashrc /soft/mysql/ \
    && mkdir -p /soft/mysql/.ssh/ \
    && cp -rf /root/dockerfile/ssh/* /soft/mysql/.ssh/ \
    && chown -R mysql:mysql /soft/mysql \
    && chmod -R 755 /soft/mysql/bin/ \
    && sh /soft/mysql/bin/gitconfig.sh \
    && chmod 600 /soft/mysql/.ssh/id_rsa \
    && cd /root/dockerfile/3rd/bison/bison-3.0.4 \
    && ./configure --prefix="/usr/" \
    && make -j$(getconf _NPROCESSORS_ONLN) && make install \
    && cd /root/dockerfile/3rd/gcc/gcc-4.8.5 \
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
    && export C_INCLUDE_PATH=/usr/include:/usr/local/include/gtest:$C_INCLUDE_PATH:. \
    && export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LD_LIBRARY_PATH:. \
    && export LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LIBRARY_PATH:. \
    && export CPLUS_INCLUDE_PATH=/usr/include:/usr/local/include/gtest:$CPLUS_INCLUDE_PATH:. \
    && cd /root/dockerfile/3rd/cmake/cmake-3.11.4 \
    && ./bootstrap \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && rm -rf /root/soft/gcc \
    && yum clean packages

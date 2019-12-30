FROM centos:centos6
COPY dockerfiles /root/dockerfiles/
RUN yum install -y gcc gcc-c++ make python-devel bunzip2 bzip2-devel zlib-devel libicu libicu-devel \
    libXp libXt libXtst glibc-common glibc-devel glibc glibc-headers compat-glibc-headers compat-glibc \
    glibc-static glibc-utils perl ncurses-devel libaio-devel numactl numactl-devel wget nc git openssl \
    openssl-libs openssl-devel man epel-release check boost-devel asio-devel readline-devel pam-devel \
    perl-Env time rpmdevtools rpm-build libcurl-devel dos2unix tree sudo rsyslog cloc lcov \
    && chmod -R 777 /tmp \
    && echo "Defaults logfile=/var/log/sudo.log" >> /etc/sudoers \
    && echo "local2.debug /var/log/sudo.log" >> /etc/rsyslog.conf \
    && echo "mysql ALL=(ALL) ALL" >> /etc/sudoers \
    && cp -rf /root/dockerfiles/os/init/* /etc/init.d/ \
    && chmod 755 /etc/init.d/* \
    && mkdir -p /root/soft/m4 \
    && cd /root/soft/m4 \
    && wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz \
    && tar xvf m4-1.4.18.tar.gz \
    && cd /root/soft/m4/m4-1.4.18 \
    && ./configure && make && make install \
    && mkdir -p /soft/mysql \
    && groupadd mysql \
    && useradd -d /soft/mysql -r -g mysql -s /bin/bash mysql \
    && cp -rf /root/dockerfiles/gitignore /etc \
    && cp -rf /root/dockerfiles/bin /soft/mysql/ \
    && cp -rf /root/dockerfiles/gitconfig.sh /soft/mysql/bin/ \
    && cp -rf /root/dockerfiles/profileconfig.sh /soft/mysql/bin/ \
    && mv /root/dockerfiles/bash_profile /soft/mysql/.bash_profile \
    && mv /root/dockerfiles/bashrc /soft/mysql/.bashrc \
    && mkdir -p /soft/mysql/.ssh/ \
    && cp -rf /root/dockerfiles/ssh/* /soft/mysql/.ssh/ \
    && chown -R mysql:mysql /soft/mysql \
    && chmod -R 755 /soft/mysql/bin/ \
    && sh /soft/mysql/bin/gitconfig.sh \
    && chmod 600 /soft/mysql/.ssh/id_rsa \
    && cd /root/dockerfiles/3rd/bison/bison-3.0.4 \
    && ./configure --prefix="/usr/" \
    && make -j$(getconf _NPROCESSORS_ONLN) && make install \
    && cd /root/dockerfiles/3rd/gcc/gcc-4.8.5 \
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
    && cd /root/dockerfiles/3rd/cmake/cmake-3.11.4 \
    && ./bootstrap \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install \
    && rm -rf /root/dockerfiles/3rd/gcc \
    && yum clean packages
ENTRYPOINT ["/etc/init.d/init"]

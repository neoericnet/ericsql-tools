FROM centos:centos6
RUN yum install -y gcc gcc-c++ make python-devel bunzip2 bzip2-devel zlib-devel libicu libicu-devel \
    libXp libXt libXtst glibc-common glibc-devel glibc glibc-headers compat-glibc-headers compat-glibc \
    glibc-static glibc-utils perl ncurses-devel libaio-devel numactl numactl-devel wget nc git openssl \
    openssl-libs openssl-devel man epel-release check boost-devel asio-devel readline-devel pam-devel \
    perl-Env time rpmdevtools rpm-build libcurl-devel dos2unix tree ruby \
    && mkdir -p /root/soft/m4 \
    && wget http://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.gz
    && tar xvf m4-1.4.18.tar.gz \
    && cd /root/soft/m4/m4-1.4.18 \
    && ./configure && make && make install \
    && yum install ruby \
    && gem sources -a http://mirrors.aliyun.com/rubygems/ \
    && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
    && curl -sSL https://get.rvm.io | bash -s stable \
    && source /etc/profile.d/rvm.sh \
    && gem sources --remove https://rubygems.org/ \
    && rvm install 2.6 \
    && mkdir -p /soft/mysql \
    && groupadd mysql \
    && useradd -d /soft/mysql -r -g mysql -s /bin/bash mysql \
    && chown -R mysql:mysql /soft/mysql
COPY gcc-4.8.5    /root/soft/gcc/gcc-4.8.5
COPY cmake-3.11.4 /root/soft/cmake/cmake-3.11.4
COPY bison-3.0.4  /root/soft/bison/bison-3.0.4
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
    && cd /root/soft/bison/bison-3.0.4 \
    && ./configure --prefix="/usr/" \
    && make -j$(getconf _NPROCESSORS_ONLN) && make install \
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
    && sh /soft/mysql/bin/profileconfig.sh
ENV C_INCLUDE_PATH /usr/include:/usr/local/include/gtest:$C_INCLUDE_PATH:.
ENV LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LD_LIBRARY_PATH:.
ENV LIBRARY_PATH /usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LIBRARY_PATH:.
ENV CPLUS_INCLUDE_PATH /usr/include:/usr/local/include/gtest:$CPLUS_INCLUDE_PATH:.
RUN cd /root/soft/cmake/cmake-3.11.4 \
    && ./bootstrap \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install
FROM jenkins/jnlp-slave:latest
MAINTAINER wanminny@163.com

# 切换到 root 账户进行操作
USER root

# 安装 maven
COPY apache-maven-3.6.2-bin.tar.gz .
RUN tar -zxf apache-maven-3.6.2-bin.tar.gz && \
    mv apache-maven-3.6.2 /usr/local && \
    rm -f apache-maven-3.6.2-bin.tar.gz && \
    ln -s /usr/local/apache-maven-3.6.2/bin/mvn /usr/bin/mvn && \
    ln -s /usr/local/apache-maven-3.6.2 /usr/local/apache-maven && \
    mkdir -p /usr/local/apache-maven/repo

# 拷贝本地下载的 kubectl
COPY kubectl /usr/bin/kubectl
RUN chmod +x /usr/bin/kubectl

# 拷贝本地下载的 Docker 静态二进制文件
COPY docker/* /usr/local/bin/
RUN chmod +x /usr/local/bin/docker*

# 拷贝配置文件
COPY settings.xml /usr/local/apache-maven/conf/settings.xml

# 切换回 jenkins 用户
#USER jenkins
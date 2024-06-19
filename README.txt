# ansible-k8

### 0. 前置准备工作：
    #### 1. 给到两个 cidr   /16的专用网段 一个是pod ,一个是service 
    ### 设置 dns; 
### 1. 基础依赖
    ntp  (master-00)
    gpu  (驱动，容器运行时)
    操作系统优化的参数  【 limits.conf, sysctl.conf】
    sealos 镜像主要是两个 （kubernetes-docker, helm ）
    上传镜像 （helm-operation，监控 ，基础的依赖镜像）
    
    
### 2. harbor
    ##### 1. 只在master-00上面
    ##### 2. 上次镜像

### 3. rancher
    #### 1.master-00
    #### 2.上传镜像; （基础镜像和业务镜像)
    #### 3. 

### 4. 夜莺
    #### 1. master-00 上面

### 5. k8s
    #### 1. k8s
    #### 2. local sc 
    #### 3. nfs
    #### 4. ingress
    #### 5. gpu plugin
    #### 6. gpu 监控 dcgm
    #### 7. 测试 ingress,pod ，testnfs
    #### 7. 部署 metacontroller ,pod-per-service;
    #### 8. 夜莺的 监控 yaml;

### 6. Rancher的监控
    ##### 1.注意要现在cpu/mem

### 7. 算法管理仓库



### 8. 使用
1.  copy docker-20.10.10.tgz 放在 /home
2. 执行 ./install_docker.sh install 
3. copy ansible.v2.9.1.tar 包
4. #docker run -it --rm --name ansible  -v /home/zxw/share/ansible:/ansible 10.30.26.151:80/devopstools/ansible-playbook:v2.9.1 /bin/bash
5. 卸载docker ./install_docker.sh uninstall 

## 9. 使用离线包安装ansible 
1. copy install-ansible.tar
2. tar -xzvf install-ansible.tar
3. 安装成功了 ansible --version
4. 使用
5. k8s纳管到rancher和监控中导入面板和告警规则需要手动导入；

    
### 9. Ubuntu 22.04.3 LTS
0.  准备ansible 本身离线安装包; nfs, ntp 安装包;
    dpkg -i ansible.deb
    cd sshpass
    dpkg -i *.deb 【ansible依赖此】

1.  ANSIBLE_CONFIG=./ansible.cfg  ansible all -i demo.ubuntu -m ping
2. ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i demo.ubuntu  site.yaml

## 一  准备工作

1. 准备机器，每台机器都有 数据分区(/data  越大越好)和根分区(/   200g)
2. Gpu 机器安装好 gpu 驱动；NVIDIA-Linux-x86_64-470.57.02.run
3. 准备好2个 16掩码的cidr网段（虚拟的，专用，现在和后面都不能分配给其他业务）
4. 准备ntp ip地址
5. 准备存储  flink jar nfs server ip地址； 如果不提供的就在本地k8s集群中安装一个nfs;
6. 目前只支持root用户登录安装部署
7. 下面是不同的操作系统安装步骤流程；【支持centos/Ubuntu/Kylin/openEuler x86架构;部分已经适配了arm架构】


## 二  centos 安装部署


 1> 拷贝 ansible离线安装包  install-ansible.tar.gz

   ```   
   copy  ansible.tar.gz 到任何一个目录比如 /home
   
   tar -xzvf ansible.tar.gz
   解压后里面有 install-ansible.tar.gz 解压，执行
   
   rpm -ivh /home/mypackages/*.rpm --force

   
   ansible --version 确认安装成功；
   ```



 2>  ansible部署

   ```
   直接cp inventory.txt 文件 修改里面的内容；填写对应的地址；适配当地环境
   
   ```



 3>  执行

   ```

   1.  执行之前先测试一下环境是否正常 到你当时解压的目录下面
       ANSIBLE_CONFIG=./ansible.cfg  ansible all -i inventory.txt -m ping
   所有为通过才正常！
   
   2.
   如果正常在往下走：
   
   ansible-playbook -i inventory.txt  site.yaml 
   
   3. flink 还需要导入 自己的dashborad
   
   ```

## 三 Ubuntu 22.04.3 LTS 部署 
   1>  准备

> 
   > dpkg -i ansible.deb
> 
   > 解压sshpass.zip 文件 ；cd sshpass
> 
   > dpkg -i *.deb 【ansible依赖此】 （这两个包也会打包在一起发给现场）

   2> ANSIBLE_CONFIG=./ansible.cfg  ansible all -i demo.ubuntu -m ping

   3> ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i demo.ubuntu  site.yaml

   4> 其他同上centos 

   5>  监控地址是: master或者node ip:31000 

## 四 Kylin Linux Advanced Server release V10 (Lance) 部署
1>  准备 

> 解压 ansible_kylin.rpm.x86.tar.gz 或者 ansible_kylin.rpm.aarch64.tar.gz;
> 
> rpm -ivh ansible_rpm/*.rpm --force
> 


2> ANSIBLE_CONFIG=./ansible.cfg  ansible all -i demo.kylin -m ping

3> ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i demo.kylin   site.yaml

4> 其他同上centos 

5>  监控地址是: master或者node ip:31000

## 五 openEuler 20.03 (LTS-SP3) 部署
1>  准备
> rpm -ivh  tar-1.32-4.oe1.x86_64.rpm
> 
> 安装这个tar程序;
> 然后解压 ansible.openeuler.x86_64.tar.gz
>
> rpm -ivh ansible/*.rpm --force

2> ANSIBLE_CONFIG=./ansible.cfg  ansible all -i demo.openeuler -m ping

3> ANSIBLE_CONFIG=./ansible.cfg ansible-playbook -i demo.openeuler site.yaml

4> 其他同上centos 

5> 去掉 rancher模块， n9e模块，categraf模块；

6> 监控地址是: master或者node ip:31000
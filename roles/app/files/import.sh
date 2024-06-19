#!/usr/bin/bash
for image in $(ls -lh|grep -v sealos | grep -v helm| grep -v kubernetes-docker |grep -i tar | awk '{print $9}');do
    echo $image &&  docker load -i $image  && sleep 1
done

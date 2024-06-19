#!/bin/bash

###获取vpcenter,产生vpcenter.tar.gz 镜像文件
##获取image 列表;
#helm template vias-vpcenter/ | grep -i image: | awk -F 'image:' '{print $2}' | awk '{$1=$1;print}' | sed -e 's/^"//' -e 's/"$//' | sort -u

rep1="10.30.26.151" ## 原始仓库地址
repo=""  # 替换为您的目标镜像仓库地址

images=(
  "${rep1}/common/postgres:12.10-alpine"
  "${rep1}/common/redis:6.2.7-debian-10-r0"
  "${rep1}/vpcenter/common/vias-user:75c6941"
  "${rep1}/vpcenter/vpcenter-api:fb32864"
  "${rep1}/vpcenter/vpcenter-front:fb32864"
)

# 遍历镜像列表，拉取镜像、打上tag并保存为.tar.gz文件
for image in "${images[@]}"; do
  # 拉取镜像
  docker pull "$image"

#  tag=$(echo "$image" | awk -F: '{print $NF}')

  # 去掉前缀的IP地址部分
  image_name_without_ip=$(echo "$image" | sed 's/^[^/]*\///')
  # 生成新的tag

#  new_tag="$repo"/"$image_name_without_ip"
  if [ -z "$repo" ]; then
    new_tag="$image_name_without_ip"
  else
    new_tag="$repo"/"$image_name_without_ip"
  fi
  # 打上新的tag
  docker tag "$image" "$new_tag"

#  docker push  "$new_tag"

done

# 定义新的镜像列表
new_images=()
for image in "${images[@]}"; do
  if [ -z "$repo" ]; then
    new_image=${image/$rep1\//}
  else
    new_image=${image/$rep1/$repo}
  fi
  new_images+=("$new_image")
done
#printf '%s\n' "${new_images[@]}"

docker save -o vpcenter.tar.gz "${new_images[@]}"


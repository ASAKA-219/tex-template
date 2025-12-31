#!/bin/bash
container="gifted_dirac"
image_name="latex_img:asaka"
image_exists=$(docker images -q "${image_name}")
cont_exist=$(docker ps -a --filter name=$container --format "{{.ID}}")

#ビルドキャッシュを削除
removable=$(docker system df | grep 'Build Cache' | awk '{print $5}' | sed 's/[[:alpha:]]//g')
if [ -n "$removable > 5" ]; then
  echo "5Gを超えたのでキャッシュを消します"
  docker builder prune
fi

if [ -n "$image_exists" ]; then
  # イメージが存在する場合の処理
  echo "イメージ"${image_name}"を見つけたよ！"
  if [ -n "$cont_exist" ]; then
    echo "コンテナ'$container'があったので起動するね！ "
    docker restart $container
    docker attach $container
  else
    echo "コンテナ'$container'が無かったので別の方法で起動するね！ "
    docker run -it \
      --name $container \
      -v /Users/hokok/tex-templates/templates:/home/asakayusuke/tex-template/templates \
      $image_name /bin/bash
  fi
else
  # イメージが存在しない場合の処理
  echo "イメージ" ${image_name} "は見つからなかったよ！イメージを作成するね！"
  docker image build --tag $image_name .
  echo "コンテナ'$container'が無かったので別の方法で起動するね！"

  docker run -it \
    --name $container \
    -v /Users/hokok/tex-template/templates:/home/asakayusuke/tex-template/templates \
    $image_name /bin/bash
fi

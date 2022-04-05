user=salt
root=/home/$user/deploys/$version
container_name=salt-cost-prod-1
db_container_name=db-for-salt-cost

function set_env {
    name=$1
    while [ -z "${!name}" ]; do
        echo "> 请输入 $name:"
        read $name
        sed -i "1s/^/export $name=${!name}\n/" ~/.bashrc
        echo "${name} 已保存至 ~/.bashrc"
    done
}
function title {
    echo
    echo '############################################################'
    echo "## $1"
    echo '############################################################'
    echo
}

title '设置远程机器的环境变量'
set_env DB_HOST
set_env DB_PASSWORD
set_env RAILS_MASTER_KEY

title '创建数据库'
if [ "$(docker ps -aq -f name=^${DB_HOST}$)" ]; then
  echo '已存在数据库'
else
  docker run -d -p 5432:5432 \
           --name $DB_HOST \
           --network=network1 \
           -e POSTGRES_USER=salt \
           -e POSTGRES_DB=salt_cost_prod \
           -e POSTGRES_PASSWORD=$DB_PASSWORD \
           -e PGDATA=/var/lib/postgresql/data/pgdata \
           -v salt-cost-data:/var/lib/postgresql/data \
           postgres:14
  echo '数据库创建成功'
fi

title 'docer build'
docker build $root -t salt-cost:$version

if [ "$(docker ps -aq -f name=^${container_name}$)" ]; then
  echo 'docker rm ...'
  docker rm -f $container_name
fi

title 'docker run ...'
docker run -d -p 3000:3000 \
              --network=network1 \
              --name=$container_name \
              -e DB_HOST=$DB_HOST \
              -e DB_PASSWORD=$DB_PASSWORD \
              -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
              salt-cost:$version

echo
echo "是否要更新数据库？(y/N)"
read ans
case $ans in
    y|Y|1  )   echo "yes" title '更新数据库'; docker exec $container_name bin/rails db:create db:migrate ;;
    n|N|0  )   echo "no" ;;
    ""     )   echo "no" ;;
esac

title '全部执行完毕'

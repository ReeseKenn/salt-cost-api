# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


数据库创建命令： `docker run -d  -p 5432:5432  --name db-for-salt-cost     -e POSTGRES_USER=salt        -e POSTGRES_PASSWORD=123456      -e POSTGRES_DB=salt_cost_dev      -e PGDATA=/var/lib/postgresql/data/pgdata      -v salt-cost-data:/var/lib/postgresql/data      --network=network1       postgres:14`

1. 创建controller `bin/rails g controller Api::V1::Items`  
2. 数据库迁移 `bin/rails db:rollback`  
            `bin/rails db:migrate`  
3. 创建model `bin/rails g model item user_id:integer amount:integer notes:text tags_id:integer happen_at:datetime`

#### 部署
1. 部署到宿主机  
```
pack_for_host.sh 打包到外部
运行setup_host.sh 部署到宿主机
```
2. 部署到云服务器  
`bin/pack_for_remote.sh` 一键部署到云服务器  

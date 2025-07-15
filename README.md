### 常用命令

- 虚拟网桥（network）管理
    ```
    docker network ls                                       #查看所以存在的networks
  
    docker network create --driver bridge $network          #创建bridge类型的network
  
    docker network rm $networkID                            #删除network
  
    docker network inspect $networkID                       #查看network信息
    ```
  
- dockerfile构建镜像
  ```
  docker build -f $dockerfile -t $tagname .
  ```


- docker-compose构建容器
    ```
    docker-compose -f $docker-composer.yml up -d
    docker compose -f $docker-composer.yml up -d
    ```


- docker进入容器hash
    ```
    docker exec -it $containerID /bin/bash
    ```


- 镜像及容器相信信息查看
    ```
    docker inspect $imageID             #查看镜像信息
  
    docker inspect $containerID         #查看容器信息
    ```
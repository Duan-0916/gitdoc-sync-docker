# 基础镜像
FROM ubuntu:20.04
RUN apt-get update && apt-get install -y net-tools vim git curl wget iputils-ping

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
# 安装 JDK 17
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean

# 拷贝jar包
COPY target/sofa-doc-bootstrap-0.0.1-SNAPSHOT.jar /app/git-to-yuque.jar
# 容器工作目录
WORKDIR /app
# 设置容器启动命令并调用接口
CMD nohup java -jar git-to-yuque.jar  > /var/log/sofadoc.log ; curl --location 'http://localhost:8080/v1/rest/sync' \
          --header 'Content-Type: application/json' \
          --data '{
              "inputs": {
                  "yuqueNamespace": "$1",
                  "yuqueSite": "$2",
                  "yuqueToken":"$3"
              }
          }'

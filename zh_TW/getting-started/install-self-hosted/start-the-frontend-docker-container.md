# 單獨啟動前端 Docker 容器

當單獨開發後端時，可能只需要源碼啟動後端服務，而不需要本地構建前端代碼並啟動，因此可以直接通過拉取 docker 鏡像並啟動容器的方式來啟動前端服務，以下為具體步驟：

#### 直接使用 DockerHub 鏡像

```Bash
docker run -it -p 3000:3000 -e CONSOLE_API_URL=http://127.0.0.1:5001 -e APP_API_URL=http://127.0.0.1:5001 langgenius/dify-web:latest
```

#### 源碼構建 Docker 鏡像

1.  構建前端鏡像

    ```
    cd web && docker build . -t dify-web
    ```
2.  啟動前端鏡像

    ```
    docker run -it -p 3000:3000 -e CONSOLE_API_URL=http://127.0.0.1:5001 -e APP_API_URL=http://127.0.0.1:5001 dify-web
    ```
3. 當控制檯域名和 Web APP 域名不一致時，可單獨設置 `CONSOLE_URL` 和 `APP_URL`
4. 本地訪問 [http://127.0.0.1:3000](http://127.0.0.1:3000)

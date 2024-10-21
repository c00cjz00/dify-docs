# Docker Compose 部署

### 前提條件

> 安裝 Dify 之前, 請確保你的機器已滿足最低安裝要求：
> - CPU >= 2 Core
> - RAM >= 4 GiB

| 操作系統                       | 軟件                                                             | 描述                                                                                                                                                                                   |
| -------------------------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| macOS 10.14 or later       | Docker Desktop                                                 | 為 Docker 虛擬機（VM）至少分配 2 個虛擬 CPU(vCPU) 和 8GB 初始內存，否則安裝可能會失敗。有關更多信息，請參考 [《在 Mac 內安裝 Docker 桌面端》](https://docs.docker.com/desktop/install/mac-install/)。                                 |
| Linux platforms            | <p>Docker 19.03 or later<br>Docker Compose 1.28 or later</p> | 請參閱[安裝 Docker](https://docs.docker.com/engine/install/) 和[安裝 Docker Compose](https://docs.docker.com/compose/install/) 以獲取更多信息。                                                      |
| Windows with WSL 2 enabled | <p>Docker Desktop<br></p>                                      | 我們建議將源代碼和其他數據綁定到 Linux 容器中時，將其存儲在 Linux 文件系統中，而不是 Windows 文件系統中。有關更多信息，請參閱[使用 WSL 2 後端在 Windows 上安裝 Docker Desktop](https://docs.docker.com/desktop/windows/install/#wsl-2-backend)。 |

### 克隆 Dify 代碼倉庫

克隆 Dify 源代碼至本地環境。

```bash
git clone https://github.com/langgenius/dify.git
```

### 啟動 Dify

1. 進入 Dify 源代碼的 Docker 目錄

   ```bash
   cd dify/docker
   ```

2. 複製環境配置文件

    ```bash
   cp .env.example .env
   ```

3. 啟動 Docker 容器

    根據你係統上的 Docker Compose 版本，選擇合適的命令來啟動容器。你可以通過 `$ docker compose version` 命令檢查版本，詳細說明請參考 [Docker 官方文檔](https://docs.docker.com/compose/#compose-v2-and-the-new-docker-compose-command)：

    - 如果版本是 Docker Compose V2，使用以下命令：
  
    ```bash
    docker compose up -d
    ```

    - 如果版本是 Docker Compose V1，使用以下命令：

    ```bash
    docker-compose up -d
    ```

運行命令後，你應該會看到類似以下的輸出，顯示所有容器的狀態和端口映射：

```Shell
[+] Running 11/11
 ✔ Network docker_ssrf_proxy_network  Created                                                                 0.1s 
 ✔ Network docker_default             Created                                                                 0.0s 
 ✔ Container docker-redis-1           Started                                                                 2.4s 
 ✔ Container docker-ssrf_proxy-1      Started                                                                 2.8s 
 ✔ Container docker-sandbox-1         Started                                                                 2.7s 
 ✔ Container docker-web-1             Started                                                                 2.7s 
 ✔ Container docker-weaviate-1        Started                                                                 2.4s 
 ✔ Container docker-db-1              Started                                                                 2.7s 
 ✔ Container docker-api-1             Started                                                                 6.5s 
 ✔ Container docker-worker-1          Started                                                                 6.4s 
 ✔ Container docker-nginx-1           Started                                                                 7.1s
```

最後檢查是否所有容器都正常運行：

```bash
docker compose ps
```

在這個輸出中，你應該可以看到包括 3 個業務服務 `api / worker / web`，以及 6 個基礎組件 `weaviate / db / redis / nginx / ssrf_proxy / sandbox` 。

```bash
NAME                  IMAGE                              COMMAND                   SERVICE      CREATED              STATUS                        PORTS
docker-api-1          langgenius/dify-api:0.6.13         "/bin/bash /entrypoi…"   api          About a minute ago   Up About a minute             5001/tcp
docker-db-1           postgres:15-alpine                 "docker-entrypoint.s…"   db           About a minute ago   Up About a minute (healthy)   5432/tcp
docker-nginx-1        nginx:latest                       "sh -c 'cp /docker-e…"   nginx        About a minute ago   Up About a minute             0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp
docker-redis-1        redis:6-alpine                     "docker-entrypoint.s…"   redis        About a minute ago   Up About a minute (healthy)   6379/tcp
docker-sandbox-1      langgenius/dify-sandbox:0.2.1      "/main"                   sandbox      About a minute ago   Up About a minute             
docker-ssrf_proxy-1   ubuntu/squid:latest                "sh -c 'cp /docker-e…"   ssrf_proxy   About a minute ago   Up About a minute             3128/tcp
docker-weaviate-1     semitechnologies/weaviate:1.19.0   "/bin/weaviate --hos…"   weaviate     About a minute ago   Up About a minute             
docker-web-1          langgenius/dify-web:0.6.13         "/bin/sh ./entrypoin…"   web          About a minute ago   Up About a minute             3000/tcp
docker-worker-1       langgenius/dify-api:0.6.13         "/bin/bash /entrypoi…"   worker       About a minute ago   Up About a minute             5001/tcp
```

通過這些步驟，你應該可以成功在本地安裝 Dify。

### 更新 Dify

進入 dify 源代碼的 docker 目錄，按順序執行以下命令：

```bash
cd dify/docker
docker compose down
git pull origin main
docker compose pull
docker compose up -d
```

#### 同步環境變量配置 (重要！)

* 如果 `.env.example` 文件有更新，請務必同步修改您本地的 `.env` 文件。
* 檢查 `.env` 文件中的所有配置項，確保它們與您的實際運行環境相匹配。您可能需要將 `.env.example` 中的新變量添加到 `.env` 文件中，並更新已更改的任何值。

### 訪問 Dify

你可以先前往管理員初始化頁面設置設置管理員賬戶：

```bash
# 本地環境
http://localhost/install

# 服務器環境

http://your_server_ip/install
```

Dify 主頁面：

```bash
# 本地環境
http://localhost

# 服務器環境
http://your_server_ip
```

### 自定義配置

編輯 `.env` 文件中的環境變量值。然後重新啟動 Dify：

```bash
docker compose down
docker compose up -d
```

完整的環境變量集合可以在 `docker/.env.example` 中找到。

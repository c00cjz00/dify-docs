# 本地部署相關

### 1. 本地部署初始化後，密碼錯誤如何重置？

若使用 docker compose 方式部署，可執行以下命令進行重置

```
docker exec -it docker-api-1 flask reset-password
```

輸入賬戶 email 以及兩次新密碼即可。

### 2. 本地部署日誌中報 File not found 錯誤，如何解決？

```
ERROR:root:Unknown Error in completion
Traceback (most recent call last):
  File "/www/wwwroot/dify/dify/api/libs/rsa.py", line 45, in decrypt
    private_key = storage.load(filepath)
  File "/www/wwwroot/dify/dify/api/extensions/ext_storage.py", line 65, in load
    raise FileNotFoundError("File not found")
FileNotFoundError: File not found
```

該錯誤可能是由於更換了部署方式，或者 `api/storage/privkeys` 刪除導致，這個文件是用來加密大模型密鑰的，因此丟失後不可逆。可以使用如下命令進行重置加密公私鑰：

*   Docker compose 部署

    ```
    docker exec -it docker-api-1 flask reset-encrypt-key-pair
    ```
*   源代碼啟動

    進入 api 目錄

    ```
    flask reset-encrypt-key-pair
    ```

    按照提示進行重置。

### **3. 安裝時後無法登錄，登錄成功，但後續接口均提示 401？**

這可能是由於切換了域名/網址，導致前端和服務端跨域。跨域和身份會涉及到下方的配置：

1. CORS 跨域配置
   1.  `CONSOLE_CORS_ALLOW_ORIGINS`

       控制檯 CORS 跨域策略，默認為 `*`，即所有域名均可訪問。
   2.  `WEB_API_CORS_ALLOW_ORIGINS`

       WebAPP CORS 跨域策略，默認為 `*`，即所有域名均可訪問。

### **4. 啟動後頁面一直在 loading，查看請求提示 CORS 錯誤？**

這可能是由於切換了域名/網址，導致前端和服務端跨域，請將 `docker-compose.yml` 中所有的以下配置項改為新的域名：

`CONSOLE_API_URL:` 控制檯 API 的後端 URL。
`CONSOLE_WEB_URL:` 控制檯網頁的前端 URL。
`SERVICE_API_URL:` 服務 API 的 URL。
`APP_API_URL:` WebApp API 的後端 URL。
`APP_WEB_URL:` WebApp 的 URL。

更多信息，請查看：[環境變量](../../getting-started/install-self-hosted/environments.md)

### 5. 部署後如何升級版本？

如果你是通過鏡像啟動，請重新拉取最新鏡像完成升級。 如果你是通過源碼啟動，請拉取最新代碼，然後啟動，完成升級。

源碼部署更新時，需要進入 api 目錄下，執行以下命令將數據庫結構遷移至最新版本：

`flask db upgrade`

### 6. 使用 Notion 導入時如何配置環境變量？

[**Notion 的集成配置地址**](https://www.notion.so/my-integrations)\*\*。\*\*進行私有化部署時，請設置以下配置：

1. **`NOTION_INTEGRATION_TYPE`** ：該值應配置為（**public/internal**）。由於 Notion 的 Oauth 重定向地址僅支持 https，如果在本地部署，請使用 Notion 的內部集成。
2. **`NOTION_CLIENT_SECRET`** ： Notion OAuth 客戶端密鑰（用於公共集成類型）。
3. **`NOTION_CLIENT_ID`** ： OAuth 客戶端ID（用於公共集成類型）。
4. **`NOTION_INTERNAL_SECRET`** ： Notion 內部集成密鑰，如果 `NOTION_INTEGRATION_TYPE` 的值為 **internal**，則需要配置此變量。

### 7. 本地部署版，如何更改空間的名稱？

在數據庫 `tenants` 表裡修改。

### 8. 想修改訪問應用的域名，在哪裡修改？

在 `docker_compose.yaml` 裡面找到 APP\_WEB\_URL 配置域名。

### 9. 如果發生數據庫遷移，需要備份哪些東西？

需要備份數據庫、配置的存儲以及向量數據庫數據，若為 docker compose 方式部署，可直接備份 `dify/docker/volumes` 目錄下所有數據內容。

### 10. 為什麼 Docker 部署 Dify，本地啟動 OpenLLM 用 127.0.0.1 卻無法訪問本地的端口？

127.0.0.1 是容器內部地址， Dify 配置的服務器地址需要宿主機局域網 IP 地址。

### 11. 本地部署版如何解決數據集文檔上傳的大小限制和數量限制。

可參考官網[環境變量說明文檔](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/environments)去配置。

### 12. 本地部署版如何通過郵箱邀請成員？

本地部署版，邀請成員可通過郵箱邀請，輸入郵箱邀請後，頁面顯示邀請鏈接，複製邀請鏈接轉發給用戶，用戶打開鏈接通過郵箱登錄設置密碼即可登錄到你的空間內。

### 13. 本地部署版本遇到這個錯誤需要怎麼辦 Can't load tokenizer for 'gpt2'

```
Can't load tokenizer for 'gpt2'. If you were trying to load it from 'https://huggingface.co/models', make sure you don't have a local directory with the same name. Otherwise, make sure 'gpt2' is the correct path to a directory containing all relevant files for a GPT2TokenizerFast tokenizer.
```

可參考官網[環境變量說明文檔](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/environments)去配置。以及相關 [Issue](https://github.com/langgenius/dify/issues/1261)。

### 14. 本地部署 80 端口被佔用應該如何解決？

本地部署 80 端口被佔用，可通過停止佔用 80 端口的服務，或者修改 docker-compose.yaml 裡面的端口映射，將 80 端口映射到其他端口。通常 Apache 和 Nginx 會佔用這個端口，可通過停止這兩個服務來解決。

### 15. 文本轉語音遇到這個錯誤怎麼辦？

```
[openai] Error: ffmpeg is not installed
```

由於 OpenAI TTS 實現了音頻流分段，源碼部署時需要安裝 ffmpeg 才可正常使用，詳細步驟：

**Windows:**

1. 訪問 [FFmpeg 官方網站](https://ffmpeg.org/download.html)，下載已經編譯好的 Windows shared 庫。
2. 下載並解壓 FFmpeg 文件夾，它會生成一個類似於 "ffmpeg-20200715-51db0a4-win64-static" 的文件夾。
3. 將解壓後的文件夾移動到你想要的位置，例如 C:\Program Files\。
4. 將 FFmpeg 的 bin 目錄所在的絕對路徑添加到系統環境變量中。
5. 打開命令提示符，輸入"ffmpeg -version"，如果能看到 FFmpeg 的版本信息，那麼說明安裝成功。

**Ubuntu:**

1. 打開終端。
2. 輸入以下命令來安裝 FFmpeg：`sudo apt-get update`，然後輸入`sudo apt-get install ffmpeg`。
3. 輸入"ffmpeg -version" 來檢查是否安裝成功。

**CentOS:**

1. 首先，你需要啟用EPEL存儲庫。在終端中輸入：`sudo yum install epel-release`
2. 然後，輸入：`sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm`
3. 更新 yum 包，輸入：`sudo yum update`
4. 最後，安裝 FFmpeg，輸入：`sudo yum install ffmpeg ffmpeg-devel`
5. 輸入"ffmpeg -version" 來檢查是否安裝成功。

**Mac OS X:**

1. 打開終端。
2. 如果你還沒有安裝 Homebrew，你可以通過在終端中輸入以下命令來安裝：`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. 使用 Homebrew 安裝 FFmpeg，輸入：`brew install ffmpeg`
4. 輸入 "ffmpeg -version" 來檢查是否安裝成功。

### 16. 本地部署時，如果遇到 Nginx 配置文件掛載失敗，如何解決？

```
Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error mounting "/run/desktop/mnt/host/d/Documents/docker/nginx/nginx.conf" to rootfs at "/etc/nginx/nginx.conf": mount /run/desktop/mnt/host/d/Documents/docker/nginx/nginx.conf:/etc/nginx/nginx.conf (via /proc/self/fd/9), flags: 0x5000: not a directory: unknown: Are you trying to mount a directory onto a file (or vice-versa)? Check if the specified host path exists and is the expected type
```

請下載完整的項目，進入 docker 執行 `docker-compose up -d` 即可。

```
git clone https://github.com/langgenius/dify.git
cd dify/docker
docker compose up -d
```

### 17. Migrate Vector Database to Qdrant or Milvus

如果您想將向量數據庫從 Weaviate 遷移到 Qdrant 或 Milvus，您需要遷移向量數據庫中的數據。以下是遷移方法：

步驟：

1. 如果您從本地源代碼開始，請將 `.env` 文件中的環境變量修改為您要遷移到的向量數據庫。 例如：`VECTOR_STORE=qdrant`
2. 如果您從 docker-compose 開始，請將 `docker-compose.yaml` 文件中的環境變量修改為您要遷移到的向量數據庫，api 和 worker 都需要修改。 例如：

```
# The type of vector store to use. Supported values are `weaviate`, `qdrant`, `milvus`.
VECTOR_STORE: weaviate
```

3. 執行以下命令

```
flask vdb-migrate # or docker exec -it docker-api-1 flask vdb-migrate
```

### 18. 為什麼需要SSRF\_PROXY？

在社區版的`docker-compose.yaml`中你可能注意到了一些服務配置有`SSRF_PROXY`和`HTTP_PROXY`等環境變量，並且他們都指向了一個`ssrf_proxy`容器，這是因為為了避免SSRF攻擊，關於SSRF攻擊，你可以查看[這篇](https://portswigger.net/web-security/ssrf)文章。

為了避免不必要的風險，我們給所有可能造成SSRF攻擊的服務都配置了一個代理，並強制如Sandbox等服務只能通過代理訪問外部網絡，從而確保你的數據安全和服務安全，默認的，這個代理不會攔截任何本地的請求，但是你可以通過修改`squid`的配置文件來自定義代理的行為。

#### 如何自定義代理的行為？

在`docker/volumes/ssrf_proxy/squid.conf`中，你可以找到`squid`的配置文件，你可以在這裡自定義代理的行為，比如你可以添加一些ACL規則來限制代理的訪問，或者添加一些`http_access`規則來限制代理的訪問，例如，您的本地可以訪問`192.168.101.0/24`這個網段，但是其中的`192.168.101.19`這個IP具有敏感數據，你不希望使用你本地部署的dify的用戶訪問到這個IP，但是想要其他的IP可以訪問，你可以在`squid.conf`中添加如下規則：

```
acl restricted_ip dst 192.168.101.19
acl localnet src 192.168.101.0/24

http_access deny restricted_ip
http_access allow localnet
http_access deny all
```

當然，這只是一個簡單的例子，你可以根據你的需求來自定義代理的行為，如果您的業務更加複雜，比如說需要給代理配置上游代理，或者需要配置緩存等，你可以查看[squid的配置文檔](http://www.squid-cache.org/Doc/config/)來了解更多。

### 19. 如何將自己創建的應用設置為模板？

目前還不支持將你自己創建的應用設置為模板。現有的模板是由Dify官方為雲版本用戶參考提供的。如果你正在使用雲版本，你可以將應用添加到你的工作空間或者在修改後定製它們以創建你自己的應用。如果你正在使用社區版本並且需要為你的團隊創建更多的應用模板，你可以諮詢我們的商務團隊以獲得付費技術支持：[business@dify.ai](mailto:business@dify.ai)

### 20.502 Bad Gateway

這是因為Nginx將服務轉發到了錯誤的位置導致的，首先確保容器正在運行，然後以Root權限運行以下命令：

```
docker ps -q | xargs -n 1 docker inspect --format '{{ .Name }}: {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
```

在輸出內容中找到這兩行：

```
/docker-web-1: 172.19.0.5
/docker-api-1: 172.19.0.7
```

記住後面的IP地址。然後打開你存放dify源代碼的地方，打開`dify/docker/nginx/conf.d`,將`http://api:5001`替換為`http://172.19.0.7:5001`,將`http://web:3000`替換為`http://172.19.0.5:3000`，隨後重啟Nginx容器或者重載配置。\
這些IP地址是_**示例性**_ 的，你必須執行命令獲取你自己的IP地址，不要直接填入。\
你可能在重新啟動相關容器時需要再次根據IP進行配置。

### 21. 如何開啟內容安全策略？

在 `.env` 配置文件中找到 `CSP_WHITELIST` 參數，然後填寫能夠被允許放行的域名，例如和所有和產品使用相關的網址、API 請求地址
此舉將有助於減少潛在的 XSS 攻擊。如需瞭解更多關於 CSP 的建議，請參考[內容安全策略](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CSP)。

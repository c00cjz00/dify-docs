# 環境變量說明

### 公共變量

#### CONSOLE\_API\_URL

控制檯 API 後端 URL，用於拼接授權回調，傳空則為同域。範例：`https://api.console.dify.ai`。

#### CONSOLE\_WEB\_URL

控制檯 web **前端** URL，用於拼接部分前端地址，以及 CORS 配置使用，傳空則為同域。範例：`https://console.dify.ai`

#### SERVICE\_API\_URL

Service API URL，用於**給前端**展示 Service API Base URL，傳空則為同域。範例：`https://api.dify.ai`

#### APP\_API\_URL

WebApp API 後端 URL，用於聲明**前端** API 後端地址，傳空則為同域。範例：`https://app.dify.ai`

#### APP\_WEB\_URL

WebApp URL，用於預覽文件、**給前端**展示下載用的 URL，以及作為多模型輸入接口，傳空則為同域。範例：`https://udify.app/`

#### FILES\_URL

文件預覽或下載 URL 前綴，用於將文件預覽或下載 URL 給前端展示或作為多模態模型輸入； 為了防止他人偽造，圖片預覽 URL 是帶有簽名的，並且有 5 分鐘過期時間。

***

### 服務端

#### MODE

啟動模式，僅使用 docker 啟動時可用，源碼啟動無效。

*   api

    啟動 API Server。
*   worker

    啟動異步隊列 worker。

#### DEBUG

調試模式，默認 false，建議本地開發打開該配置，可防止 monkey patch 導致的一些問題出現。

#### FLASK\_DEBUG

Flask 調試模式，開啟可在接口輸出 trace 信息，方便調試。

#### SECRET\_KEY

一個用於安全地簽名會話 cookie 並在數據庫上加密敏感信息的密鑰。初次啟動需要設置改變量。可以運行`openssl rand -base64 42`生成一個強密鑰。

#### DEPLOY\_ENV

部署環境。

*   PRODUCTION（默認）

    生產環境。
*   TESTING

    測試環境，前端頁面會有明顯顏色標識，該環境為測試環境。

#### LOG\_LEVEL

日誌輸出等級，默認為 INFO。生產建議設置為 ERROR。

#### MIGRATION\_ENABLED

當設置為 true 時，會在容器啟動時自動執行數據庫遷移，僅使用 docker 啟動時可用，源碼啟動無效。源碼啟動需要在 api 目錄手動執行 `flask db upgrade`。

#### CHECK\_UPDATE\_URL

是否開啟檢查版本策略，若設置為 false，則不調用 `https://updates.dify.ai` 進行版本檢查。由於目前國內無法直接訪問基於 CloudFlare Worker 的版本接口，設置該變量為空，可以屏蔽該接口調用。

#### TEXT\_GENERATION\_TIMEOUT\_MS

默認 60000，單位為 ms，用於指定文本生成和工作流的超時時間，防止因某些進程運行超時而導致整體服務不可用。

#### CSP_WHITELIST

內容安全策略（CSP）白名單，默認不開啟。在此變量中填寫被放行的域名列表後即視為開啟，有助於減少潛在的 XSS 攻擊。開啟後，白名單將自動包含以下域名：

```url
*.sentry.io http://localhost:* http://127.0.0.1:* https://analytics.google.com https://googletagmanager.com https://api.github.com
```

#### 容器啟動相關配置

僅在使用 docker 鏡像或者 docker-compose 啟動時有效。

*   DIFY\_BIND\_ADDRESS

    API 服務綁定地址，默認：0.0.0.0，即所有地址均可訪問。
*   DIFY\_PORT

    API 服務綁定端口號，默認 5001。
*   SERVER\_WORKER\_AMOUNT

    API 服務 Server worker 數量，即 gevent worker 數量，公式：`cpu 核心數 x 2 + 1`可參考：https://docs.gunicorn.org/en/stable/design.html#how-many-workers
*   SERVER\_WORKER\_CLASS

    默認為 gevent，若為 windows，可以切換為 sync 或 solo。
*   GUNICORN\_TIMEOUT

    請求處理超時時間，默認 200，建議 360，以支持更長的 sse 連接時間。
*   CELERY\_WORKER\_CLASS

    和 `SERVER_WORKER_CLASS` 類似，默認 gevent，若為 windows，可以切換為 sync 或 solo。
*   CELERY\_WORKER\_AMOUNT

    Celery worker 數量，默認為 1，按需設置。
*   HTTP\_PROXY

    HTTP 代理地址，用於解決國內無法訪問 OpenAI、HuggingFace 的問題。注意，若代理部署在宿主機(例如`http://127.0.0.1:7890`)，此處代理地址應當和接入本地模型時一樣，使用docker容器內部的宿主機地址（例如`http://192.168.1.100:7890`或`http://172.17.0.1:7890`）。
*   HTTPS\_PROXY

    HTTPS 代理地址，用於解決國內無法訪問 OpenAI、HuggingFace 的問題。同上。

#### 數據庫配置

數據庫使用 PostgreSQL，請使用 public schema。

* DB\_USERNAME：用戶名
* DB\_PASSWORD：密碼
* DB\_HOST：數據庫 host
* DB\_PORT：數據庫端口號，默認 5432
* DB\_DATABASE：數據庫 database
* SQLALCHEMY\_POOL\_SIZE：數據庫連接池大小，默認 30 個連接數，可適當增加。
* SQLALCHEMY\_POOL\_RECYCLE：數據庫連接池回收時間，默認 3600 秒。
* SQLALCHEMY\_ECHO：是否打印 SQL，默認 false。

#### Redis 配置

該 Redis 配置用於緩存以及對話時的 pub/sub。

* REDIS\_HOST：Redis host
* REDIS\_PORT：Redis port，默認 6379
* REDIS\_DB：Redis Database，默認為 0，請和 Session Redis、Celery Broker 分開用不同 Database。
* REDIS\_USERNAME：Redis 用戶名，默認為空
* REDIS\_PASSWORD：Redis 密碼，默認為空，強烈建議設置密碼。
* REDIS\_USE\_SSL：是否使用 SSL 協議進行連接，默認 false
* REDIS\_USE\_SENTINEL：使用 Redis Sentinel 連接 Redis 服務器
* REDIS\_SENTINELS：哨兵節點，格式：`<sentinel1_ip>:<sentinel1_port>,<sentinel2_ip>:<sentinel2_port>,<sentinel3_ip>:<sentinel3_port>`
* REDIS\_SENTINEL\_SERVICE\_NAME：哨兵服務名，同 Master Name
* REDIS\_SENTINEL\_USERNAME：哨兵的用戶名
* REDIS\_SENTINEL\_PASSWORD：哨兵的密碼
* REDIS\_SENTINEL\_SOCKET\_TIMEOUT：哨兵超時時間，默認值：0.1，單位：秒

#### Celery 配置

*   CELERY\_BROKER\_URL

    格式如下（直連模式）

    <pre><code><strong>redis://&#x3C;redis_username>:&#x3C;redis_password>@&#x3C;redis_host>:&#x3C;redis_port>/&#x3C;redis_database>
    </strong><strong>  
    </strong></code></pre>

    範例：`redis://:difyai123456@redis:6379/1`

    哨兵模式

    <pre><code><strong>sentinel://&#x3C;sentinel_username>:&#x3C;sentinel_password>@&#x3C;sentinel_host>:&#x3C;sentinel_port>/&#x3C;redis_database>
    </strong><strong>  
    </strong></code></pre>

    範例：`sentinel://localhost:26379/1;sentinel://localhost:26380/1;sentinel://localhost:26381/1`
    
*   BROKER\_USE\_SSL

    若設置為 true，則使用 SSL 協議進行連接，默認 false

*   CELERY\_USE\_SENTINEL

    若設置為 true，則啟用哨兵模式，默認 false

*   CELERY_SENTINEL_MASTER_NAME

    哨兵的服務名，即 Master Name

*   CELERY_SENTINEL_SOCKET_TIMEOUT

    哨兵連接超時時間，默認值：0.1，單位：秒

#### CORS 配置

用於設置前端跨域訪問策略。

*   CONSOLE\_CORS\_ALLOW\_ORIGINS

    控制檯 CORS 跨域策略，默認為 `*`，即所有域名均可訪問。
*   WEB\_API\_CORS\_ALLOW\_ORIGINS

    WebAPP CORS 跨域策略，默認為 `*`，即所有域名均可訪問。

詳細配置可參考：[跨域/身份相關指南](https://docs.dify.ai/v/zh-hans/learn-more/faq/install-faq#id-3.-an-zhuang-shi-hou-wu-fa-deng-lu-deng-lu-cheng-gong-dan-hou-xu-jie-kou-jun-ti-shi-401)

#### 文件存儲配置

用於存儲數據集上傳的文件、團隊/租戶的加密密鑰等等文件。

*   STORAGE\_TYPE

    存儲設施類型

    *   local（默認）

        本地文件存儲，若選擇此項則需要設置下方 `STORAGE_LOCAL_PATH` 配置。
    *   s3

        S3 對象存儲，若選擇此項則需要設置下方 S3\_ 開頭的配置。
    *   azure-blob

        Azure Blob 存儲，若選擇此項則需要設置下方 AZURE\_BLOB\_ 開頭的配置。
    *   huawei-obs

        Huawei OBS 存儲，若選擇此項則需要設置下方 HUAWEI\_OBS\_ 開頭的配置。
    *   volcengine-tos

        Volcengine TOS 存儲，若選擇此項則需要設置下方 VOLCENGINE\_TOS\_ 開頭的配置。
*   STORAGE\_LOCAL\_PATH

    默認為 storage，即存儲在當前目錄的 storage 目錄下。若使用 docker 或 docker-compose 進行部署，請務必將兩個容器中 `/app/api/storage` 目錄掛載到同一個本機目錄，否則可能會出現文件找不到的報錯。
* S3\_ENDPOINT：S3 端點地址
* S3\_BUCKET\_NAME：S3 桶名稱
* S3\_ACCESS\_KEY：S3 Access Key
* S3\_SECRET\_KEY：S3 Secret Key
* S3\_REGION：S3 地域信息，如：us-east-1
* AZURE\_BLOB\_ACCOUNT\_NAME: your-account-name 如 'difyai'
* AZURE\_BLOB\_ACCOUNT\_KEY: your-account-key 如 'difyai'
* AZURE\_BLOB\_CONTAINER\_NAME: your-container-name 如 'difyai-container'
* AZURE\_BLOB\_ACCOUNT\_URL: 'https://\<your\_account\_name>.blob.core.windows.net'
* ALIYUN\_OSS\_BUCKET_NAME: your-bucket-name 如 'difyai'
* ALIYUN\_OSS\_ACCESS_KEY: your-access-key 如 'difyai'
* ALIYUN\_OSS\_SECRET_KEY: your-secret-key 如 'difyai'
* ALIYUN\_OSS\_ENDPOINT: https://oss-ap-southeast-1-internal.aliyuncs.com # 參考文檔: https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints
* ALIYUN\_OSS\_REGION: ap-southeast-1 # 參考文檔: https://help.aliyun.com/zh/oss/user-guide/regions-and-endpoints
* ALIYUN\_OSS\_AUTH_VERSION: v4
* ALIYUN\_OSS\_PATH: your-path # 路徑不要使用斜線 "/" 開頭，阿里雲 OSS 不支持。參考文檔: https://api.aliyun.com/troubleshoot?q=0016-00000005
* HUAWEI\_OBS\_BUCKET\_NAME: your-bucket-name 如 'difyai'
* HUAWEI\_OBS\_SECRET\_KEY: your-secret-key 如 'difyai'
* HUAWEI\_OBS\_ACCESS\_KEY: your-access-key 如 'difyai'
* HUAWEI\_OBS\_SERVER: your-server-url # 參考文檔: https://support.huaweicloud.com/sdk-python-devg-obs/obs_22_0500.html
* VOLCENGINE_TOS_BUCKET_NAME: your-bucket-name 如 'difyai'
* VOLCENGINE_TOS_SECRET_KEY: your-secret-key 如 'difyai'
* VOLCENGINE_TOS_ACCESS_KEY: your-access-key 如 'difyai'
* VOLCENGINE_TOS_REGION: your-region 如 'cn-guangzhou' # 參考文檔: https://www.volcengine.com/docs/6349/107356
* VOLCENGINE_TOS_ENDPOINT: your-endpoint 如 'tos-cn-guangzhou.volces.com' # 參考文檔: https://www.volcengine.com/docs/6349/107356

#### 向量數據庫配置

*   VECTOR\_STORE

    **可使用的枚舉類型包括：**

    * `weaviate`
    * `qdrant`
    * `milvus`
    * `zilliz` 與 `milvus` 一致
    * `myscale`
    * `pinecone` (暫未開放)
    * `tidb_vector`
    * `analyticdb`
*   WEAVIATE\_ENDPOINT

    Weaviate 端點地址，如：`http://weaviate:8080`。
*   WEAVIATE\_API\_KEY

    連接 Weaviate 使用的 api-key 憑據。
*   WEAVIATE\_BATCH\_SIZE

    Weaviate 批量創建索引 Object 的數量，默認 100。可參考此文檔：https://weaviate.io/developers/weaviate/manage-data/import#how-to-set-batch-parameters
*   WEAVIATE\_GRPC\_ENABLED

    是否使用 gRPC 方式與 Weaviate 進行交互，開啟後性能會大大增加，本地可能無法使用，默認為 true。
*   QDRANT\_URL

    Qdrant 端點地址，如：`https://your-qdrant-cluster-url.qdrant.tech/`
*   QDRANT\_API\_KEY

    連接 Qdrant 使用的 api-key 憑據。
*   PINECONE\_API\_KEY

    連接 Pinecone 使用的 api-key 憑據。
*   PINECONE\_ENVIRONMENT

    Pinecone 所在的額環境，如：`us-east4-gcp`
*   MILVUS\_URI

    Milvus的URI配置。例如：http://localhost:19530。對於Zilliz Cloud，請將URI和令牌調整為 [Public Endpoint and Api key](https://docs.zilliz.com/docs/on-zilliz-cloud-console#free-cluster-details) 。
*   MILVUS\_TOKEN

    Milvus token 配置, 默認為空。
*   MILVUS\_USER

    Milvus user 配置，默認為空。
*   MILVUS\_PASSWORD

    Milvus 密碼配置，默認為空。
*   MYSCALE\_HOST

    MyScale host 配置。
*   MYSCALE\_PORT

    MyScale port 配置。
*   MYSCALE\_USER

    MyScale 用戶名配置，默認為 `default`。
*   MYSCALE\_PASSWORD

    MyScale 密碼配置，默認為空。
*   MYSCALE\_DATABASE

    MyScale 數據庫配置，默認為 `default`。
*   MYSCALE\_FTS\_PARAMS

    MyScale 全文搜索配置, 如需多語言支持，請參考 [MyScale 文檔](https://myscale.com/docs/en/text-search/#understanding-fts-index-parameters)，默認為空（僅支持英語）。

* TIDB\_VECTOR\_HOST

  TiDB Vector host 配置，如：`xxx.eu-central-1.xxx.tidbcloud.com`
* TIDB\_VECTOR\_PORT

  TiDB Vector 端口號配置，如：`4000`
* TIDB\_VECTOR\_USER

  TiDB Vector 用戶配置，如：`xxxxxx.root`
* TIDB\_VECTOR\_PASSWORD

  TiDB Vector 密碼配置
* TIDB\_VECTOR\_DATABASE

  TiDB Vector 數據庫配置，如：`dify`

*   ANALYTICDB_KEY_ID

    用於阿里雲OpenAPI認證的訪問密鑰ID。請閱讀 [Analyticdb 文檔](https://help.aliyun.com/zh/analyticdb/analyticdb-for-postgresql/support/create-an-accesskey-pair) 來創建您的AccessKey。

*   ANALYTICDB_KEY_SECRET

    用於阿里雲OpenAPI認證的訪問密鑰祕密。

*   ANALYTICDB_INSTANCE_ID

    您的AnalyticDB實例的唯一標識符，例如 `gp-xxxxxx`。請閱讀 [Analyticdb 文檔](https://help.aliyun.com/zh/analyticdb/analyticdb-for-postgresql/getting-started/create-an-instance-1) 來創建您的實例。

*   ANALYTICDB_REGION_ID

    AnalyticDB實例所在區域的標識符，例如 `cn-hangzhou`。

*   ANALYTICDB_ACCOUNT

    用於連接AnalyticDB實例的賬戶名稱。請閱讀 [Analyticdb 文檔](https://help.aliyun.com/zh/analyticdb/analyticdb-for-postgresql/getting-started/createa-a-privileged-account) 來創建賬戶。

*   ANALYTICDB_PASSWORD

    用於連接AnalyticDB實例的賬戶密碼。

*   ANALYTICDB_NAMESPACE

    在AnalyticDB實例內要操作的命名空間(schema)，例如 `dify`。如果此命名空間不存在，將自動創建。

*   ANALYTICDB_NAMESPACE_PASSWORD

    命名空間(schema)的密碼。如果命名空間不存在，將使用此密碼進行創建。

#### 知識庫配置

*   UPLOAD\_FILE\_SIZE\_LIMIT

    上傳文件大小限制，默認 15M。
*   UPLOAD\_FILE\_BATCH\_LIMIT

    每次上傳文件數上限，默認 5 個。
*   ETL\_TYPE

    **可使用的枚舉類型包括：**

    *   dify

        Dify 自研文件 Extract 方案
    *   Unstructured

        Unstructured.io 文件 Extract 方案
*   UNSTRUCTURED\_API\_URL

    Unstructured API 路徑，當 ETL\_TYPE 為 Unstructured 需要配置。

    如：`http://unstructured:8000/general/v0/general`

#### 多模態模型配置

*   MULTIMODAL\_SEND\_IMAGE\_FORMAT

    多模態模型輸入時，發送圖片的格式，默認為 `base64`，可選 `url`。 `url` 模式下，調用的延遲會比 `base64` 模式下低，一般建議使用兼容更好的 `base64` 模式。 若配置為 `url`，則需要將 `FILES_URL` 配置為外部可訪問的地址，以便多模態模型可以訪問到圖片。
*   UPLOAD\_IMAGE\_FILE\_SIZE\_LIMIT

    上傳圖片文件大小限制，默認 10M。

#### Sentry 配置

用於應用監控和錯誤日誌跟蹤。

*   SENTRY\_DSN

    Sentry DSN 地址，默認為空，為空時則所有監控信息均不上報 Sentry。
*   SENTRY\_TRACES\_SAMPLE\_RATE

    Sentry events 的上報比例，若為 0.01，則為 1%。
*   SENTRY\_PROFILES\_SAMPLE\_RATE

    Sentry profiles 的上報比例，若為 0.01，則為 1%。

#### Notion 集成配置

Notion 集成配置，變量可通過申請 Notion integration 獲取：[https://www.notion.so/my-integrations](https://www.notion.so/my-integrations)

* NOTION\_CLIENT\_ID
* NOTION\_CLIENT\_SECRET

#### 郵件相關配置

* MAIL\_TYPE
  * resend
    * MAIL\_DEFAULT\_SEND\_FROM\
      發件人的電子郵件名稱，例如：no-reply [no-reply@dify.ai](mailto:no-reply@dify.ai)，非必需。
    * RESEND\_API\_KEY\
      用於 Resend 郵件提供程序的 API 密鑰，可以從 API 密鑰獲取。
  * smtp
    * SMTP\_SERVER\
      SMTP 服務器地址
    * SMTP\_PORT\
      SMTP 服務器端口號
    * SMTP\_USERNAME\
      SMTP 用戶名
    * SMTP\_PASSWORD\
      SMTP 密碼
    * SMTP\_USE\_TLS\
      是否使用 TLS，默認為 false
    * MAIL\_DEFAULT\_SEND\_FROM\
      發件人的電子郵件名稱，例如：no-reply [no-reply@dify.ai](mailto:no-reply@dify.ai)，非必需。

#### 模型供應商 & 工具 位置配置

用於指定應用中可以使用的模型供應商和工具。您可以自定義哪些工具和模型供應商可用，以及它們在應用界面中的順序和包含/排除情況。

詳見可用的[工具](https://github.com/langgenius/dify/blob/main/api/core/tools/provider/_position.yaml) 和 [模型供應商](https://github.com/langgenius/dify/blob/main/api/core/model_runtime/model_providers/_position.yaml)。

* POSITION_TOOL_PINS

    將列出的工具固定在列表頂部，確保它們在界面中置頂出現。（使用逗號分隔的值，**中間不留空格**。）

    示例: `POSITION_TOOL_PINS=bing,google`

* POSITION_TOOL_INCLUDES

    指定要在應用中包含的工具。只有此處列出的工具才可用。如果未設置，則除非在 POSITION_TOOL_EXCLUDES 中指定，否則所有工具都會包含在內。（使用逗號分隔的值，**中間不留空格**。）

    示例: `POSITION_TOOL_INCLUDES=bing,google`

* POSITION_TOOL_EXCLUDES

    排除在應用中顯示或使用的特定工具。此處列出的工具將從可用選項中省略，除非它們被固定。（使用逗號分隔的值，**中間不留空格**。）

    示例: `POSITION_TOOL_EXCLUDES=yahoo,wolframalpha`

* POSITION_PROVIDER_PINS

    將列出的模型供應商固定在列表頂部，確保它們在界面中置頂出現。（使用逗號分隔的值，**中間不留空格**。）

    示例: `POSITION_PROVIDER_PINS=openai,openllm`

* POSITION_PROVIDER_INCLUDES

    指定要在應用中包含的模型供應商。只有此處列出的供應商才可用。如果未設置，則除非在 POSITION_PROVIDER_EXCLUDES 中指定，否則所有供應商都會包含在內。（使用逗號分隔的值，**中間不留空格**。）

    示例: `POSITION_PROVIDER_INCLUDES=cohere,upstage`

* POSITION_PROVIDER_EXCLUDES

    排除在應用中顯示特定模型供應商。此處列出的供應商將從可用選項中移除，除非它們被置頂。（使用逗號分隔的值，**中間不留空格**。）

    示例: `POSITION_PROVIDER_EXCLUDES=openrouter,ollama`

#### 其他

* INVITE\_EXPIRY\_HOURS：成員邀請鏈接有效時間（小時），默認：72。
* HTTP\_REQUEST\_NODE_MAX\_TEXT\_SIZE：workflow 工作流中 HTTP 請求節點的最大文本大小，默認 1MB。
* HTTP\_REQUEST\_NODE\_MAX\_BINARY\_SIZE：workflow 工作流中 HTTP 請求節點的最大二進制大小，默認 10MB。

***

### Web 前端

#### SENTRY\_DSN

Sentry DSN 地址，默認為空，為空時則所有監控信息均不上報 Sentry。

## 已廢棄

#### CONSOLE\_URL

> ⚠️ 修改於 0.3.8，於 0.4.9 廢棄，替代為：`CONSOLE_API_URL` 和 `CONSOLE_WEB_URL`。

控制檯 URL，用於拼接授權回調、控制檯前端地址，以及 CORS 配置使用，傳空則為同域。範例：`https://console.dify.ai`。

#### API\_URL

> ⚠️ 修改於 0.3.8，於 0.4.9 廢棄，替代為 `SERVICE_API_URL`。

API Url，用於**給前端**展示 Service API Base Url，傳空則為同域。範例：`https://api.dify.ai`

#### APP\_URL

> ⚠️ 修改於 0.3.8，於 0.4.9 廢棄，替代為 `APP_API_URL` 和 `APP_WEB_URL`。

WebApp Url，用於顯示文件預覽或下載 URL 到前端作為多模型輸入，傳空則為同域。範例：`https://udify.app/`

#### Session 配置

> ⚠️ 該配置從 0.3.24 版本起廢棄。

僅 API 服務使用，用於驗證接口身份。

* SESSION\_TYPE： Session 組件類型
  *   redis（默認）

      選擇此項，則需要設置下方 SESSION\_REDIS\_ 開頭的環境變量。
  *   sqlalchemy

      選擇此項，則使用當前數據庫連接，並使用 sessions 表進行讀寫 session 記錄。
* SESSION\_REDIS\_HOST：Redis host
* SESSION\_REDIS\_PORT：Redis port，默認 6379
* SESSION\_REDIS\_DB：Redis Database，默認為 0，請和 Redis、Celery Broker 分開用不同 Database。
* SESSION\_REDIS\_USERNAME：Redis 用戶名，默認為空
* SESSION\_REDIS\_PASSWORD：Redis 密碼，默認為空，強烈建議設置密碼。
* SESSION\_REDIS\_USE\_SSL：是否使用 SSL 協議進行連接，默認 false

#### Cookie 策略配置

> ⚠️ 該配置從 0.3.24 版本起廢棄。

用於設置身份校驗的 Session Cookie 瀏覽器策略。

*   COOKIE\_HTTPONLY

    Cookie HttpOnly 配置，默認為 true。
*   COOKIE\_SAMESITE

    Cookie SameSite 配置，默認為 Lax。
*   COOKIE\_SECURE

    Cookie Secure 配置，默認為 false。

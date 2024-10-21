# 本地源碼啟動

### 前置條件

> 安裝 Dify 之前, 請確保你的機器已滿足最低安裝要求：
> - CPU >= 2 Core
> - RAM >= 4 GiB

| 操作系統                       | 軟件                                                             | 說明                                                                                                                                                                                   |
| -------------------------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| macOS 10.14 or later       | Docker Desktop                                                 | 將 Docker 虛擬機（VM）設置為使用至少 2 個虛擬 CPU（vCPU）和 8 GB 的初始內存。否則，安裝可能會失敗。有關更多信息，請參閱[在 Mac 上安裝 Docker Desktop](https://docs.docker.com/desktop/mac/install/)。                                   |
| Linux platforms            | <p>Docker 19.03 or later<br>Docker Compose 1.25.1 or later</p> | 請參閱[安裝 Docker](https://docs.docker.com/engine/install/) 和[安裝 Docker Compose](https://docs.docker.com/compose/install/) 以獲取更多信息。                                                      |
| Windows with WSL 2 enabled | Docker Desktop                                                 | 我們建議將源代碼和其他數據綁定到 Linux 容器中時，將其存儲在 Linux 文件系統中，而不是 Windows 文件系統中。有關更多信息，請參閱[使用 WSL 2 後端在 Windows 上安裝 Docker Desktop](https://docs.docker.com/desktop/windows/install/#wsl-2-backend)。 |

> 若需要使用 OpenAI TTS，需要在系統中安裝 FFmpeg 才可正常使用，詳情可參考：[Link](https://docs.dify.ai/v/zh-hans/learn-more/faq/install-faq#id-15.-wen-ben-zhuan-yu-yin-yu-dao-zhe-ge-cuo-wu-zen-me-ban)。

Clone Dify 代碼：

```Bash
git clone https://github.com/langgenius/dify.git
```

在啟用業務服務之前，我們需要先部署 PostgresSQL / Redis / Weaviate（如果本地沒有的話），可以通過以下命令啟動：

```Bash
cd docker
cp middleware.env.example middleware.env
docker compose -f docker-compose.middleware.yaml up -d
```

***

### 服務端部署

* API 接口服務
* Worker 異步隊列消費服務

#### 安裝基礎環境

服務器啟動需要 Python 3.10.x。建議使用 [pyenv](https://github.com/pyenv/pyenv) 快速安裝 Python 環境。

要安裝其他 Python 版本，請使用 `pyenv install`。

```Bash
pyenv install 3.10
```

要切換到 "3.10" Python 環境，請使用以下命令:


```Bash
pyenv global 3.10
```

#### 啟動步驟

1.  進入 api 目錄

    ```
    cd api
    ```
2.  複製環境變量配置文件

    ```
    cp .env.example .env
    ```
3.  生成隨機密鑰，並替換 `.env` 中 `SECRET_KEY` 的值

    ```
    awk -v key="$(openssl rand -base64 42)" '/^SECRET_KEY=/ {sub(/=.*/, "=" key)} 1' .env > temp_env && mv temp_env .env
    ```
4.  安裝依賴包

    Dify API 服務使用 [Poetry](https://python-poetry.org/docs/) 來管理依賴。您可以執行 `poetry shell` 來激活環境。

    ```
    poetry env use 3.10
    poetry install
    ```

5.  執行數據庫遷移

    將數據庫結構遷移至最新版本。

    ```
    poetry shell
    flask db upgrade
    ```
6.  啟動 API 服務

    ```
    flask run --host 0.0.0.0 --port=5001 --debug
    ```

    正確輸出：

    ```
    * Debug mode: on
    INFO:werkzeug:WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
     * Running on all addresses (0.0.0.0)
     * Running on http://127.0.0.1:5001
    INFO:werkzeug:Press CTRL+C to quit
    INFO:werkzeug: * Restarting with stat
    WARNING:werkzeug: * Debugger is active!
    INFO:werkzeug: * Debugger PIN: 695-801-919
    ```
7.  啟動 Worker 服務

    用於消費異步隊列任務，如數據集文件導入、更新數據集文檔等異步操作。 Linux / MacOS 啟動：

    ```
    celery -A app.celery worker -P gevent -c 1 -Q dataset,generation,mail,ops_trace --loglevel INFO
    ```

    如果使用 Windows 系統啟動，請替換為該命令：

    ```
    celery -A app.celery worker -P solo --without-gossip --without-mingle -Q dataset,generation,mail,ops_trace --loglevel INFO
    ```

    正確輸出：

    ```
     -------------- celery@TAKATOST.lan v5.2.7 (dawn-chorus)
    --- ***** ----- 
    -- ******* ---- macOS-10.16-x86_64-i386-64bit 2023-07-31 12:58:08
    - *** --- * --- 
    - ** ---------- [config]
    - ** ---------- .> app:         app:0x7fb568572a10
    - ** ---------- .> transport:   redis://:**@localhost:6379/1
    - ** ---------- .> results:     postgresql://postgres:**@localhost:5432/dify
    - *** --- * --- .> concurrency: 1 (gevent)
    -- ******* ---- .> task events: OFF (enable -E to monitor tasks in this worker)
    --- ***** ----- 
     -------------- [queues]
                    .> dataset          exchange=dataset(direct) key=dataset
                    .> generation       exchange=generation(direct) key=generation
                    .> mail             exchange=mail(direct) key=mail

    [tasks]
      . tasks.add_document_to_index_task.add_document_to_index_task
      . tasks.clean_dataset_task.clean_dataset_task
      . tasks.clean_document_task.clean_document_task
      . tasks.clean_notion_document_task.clean_notion_document_task
      . tasks.create_segment_to_index_task.create_segment_to_index_task
      . tasks.deal_dataset_vector_index_task.deal_dataset_vector_index_task
      . tasks.document_indexing_sync_task.document_indexing_sync_task
      . tasks.document_indexing_task.document_indexing_task
      . tasks.document_indexing_update_task.document_indexing_update_task
      . tasks.enable_segment_to_index_task.enable_segment_to_index_task
      . tasks.generate_conversation_summary_task.generate_conversation_summary_task
      . tasks.mail_invite_member_task.send_invite_member_mail_task
      . tasks.remove_document_from_index_task.remove_document_from_index_task
      . tasks.remove_segment_from_index_task.remove_segment_from_index_task
      . tasks.update_segment_index_task.update_segment_index_task
      . tasks.update_segment_keyword_index_task.update_segment_keyword_index_task

    [2023-07-31 12:58:08,831: INFO/MainProcess] Connected to redis://:**@localhost:6379/1
    [2023-07-31 12:58:08,840: INFO/MainProcess] mingle: searching for neighbors
    [2023-07-31 12:58:09,873: INFO/MainProcess] mingle: all alone
    [2023-07-31 12:58:09,886: INFO/MainProcess] pidbox: Connected to redis://:**@localhost:6379/1.
    [2023-07-31 12:58:09,890: INFO/MainProcess] celery@TAKATOST.lan ready.
    ```

***

### 前端頁面部署

Web 前端客戶端頁面服務

#### 安裝基礎環境

Web 前端服務啟動需要用到 [Node.js v18.x (LTS)](http://nodejs.org) 、[NPM 版本 8.x.x ](https://www.npmjs.com/)或 [Yarn](https://yarnpkg.com/)。

* 安裝 NodeJS + NPM

進入 https://nodejs.org/en/download，選擇對應操作系統的 v18.x 以上的安裝包下載並安裝，建議 stable 版本，已自帶 NPM。

#### 啟動步驟

1.  進入 web 目錄

    ```
    cd web
    ```
2.  安裝依賴包

    ```
    npm install
    ```
3.  配置環境變量。在當前目錄下創建文件 `.env.local`，並複製`.env.example`中的內容。根據需求修改這些環境變量的值:

    ```
    # For production release, change this to PRODUCTION
    NEXT_PUBLIC_DEPLOY_ENV=DEVELOPMENT
    # The deployment edition, SELF_HOSTED
    NEXT_PUBLIC_EDITION=SELF_HOSTED
    # The base URL of console application, refers to the Console base URL of WEB service if console domain is
    # different from api or web app domain.
    # example: http://cloud.dify.ai/console/api
    NEXT_PUBLIC_API_PREFIX=http://localhost:5001/console/api
    # The URL for Web APP, refers to the Web App base URL of WEB service if web app domain is different from
    # console or api domain.
    # example: http://udify.app/api
    NEXT_PUBLIC_PUBLIC_API_PREFIX=http://localhost:5001/api

    # SENTRY
    NEXT_PUBLIC_SENTRY_DSN=
    NEXT_PUBLIC_SENTRY_ORG=
    NEXT_PUBLIC_SENTRY_PROJECT=
    ```
4.  構建代碼

    ```
    npm run build
    ```
5.  啟動 web 服務

    ```
    npm run start
    # or
    yarn start
    # or
    pnpm start
    ```

正常啟動後，終端會輸出如下信息：

```
ready - started server on 0.0.0.0:3000, url: http://localhost:3000
warn  - You have enabled experimental feature (appDir) in next.config.js.
warn  - Experimental features are not covered by semver, and may cause unexpected or broken application behavior. Use at your own risk.
info  - Thank you for testing `appDir` please leave your feedback at https://nextjs.link/app-feedback
```

### 訪問 Dify

最後，訪問 http://127.0.0.1:3000 即可使用本地部署的 Dify。

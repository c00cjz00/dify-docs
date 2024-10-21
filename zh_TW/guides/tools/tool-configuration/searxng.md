# SearXNG

> 工具作者 @Junytang。

SearXNG 是一個免費的互聯網元搜索引擎，整合了各種搜索服務的檢索結果。用戶不會被跟蹤，搜索行為也不會被分析。現在你可以直接在 Dify 中使用此工具。

下文將介紹如何在[社區版](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/docker-compose)使用 Docker 將 SearXNG 集成到 Dify。

> 如果你想在 Dify 雲服務內使用 SearXNG，請參考[ SearXNG 安裝文檔](https://docs.searxng.org/admin/installation.html)自建服務，然後回到 Dify，在 "工具 > SearXNG > 去認證" 頁填寫服務的 Base URL。

## 1. 修改 Dify 配置文件

SearXNG 的配置文件位於 `dify/api/core/tools/provider/builtin/searxng/docker/settings.yml`， 配置文檔可參考[這裡](https://docs.searxng.org/admin/settings/index.html)。

你可以按需修改配置，也可直接使用默認配置。

## 2. 啟動服務

在 Dify 根目錄下啟動 Docker 容器。

```bash
cd dify
docker run --rm -d -p 8081:8080 -v "${PWD}/api/core/tools/provider/builtin/searxng/docker:/etc/searxng" searxng/searxng
```

## 3. 使用 SearXNG

在 `工具 > SearXNG > 去認證` 中填寫訪問地址，建立 Dify 服務與 SearXNG 服務的連接。SearXNG 的 Docker 內網地址一般是 `http://host.docker.internal:8081`。

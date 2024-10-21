# 工具

### 工具定義

工具可以擴展 LLM 的能力，比如聯網搜索、科學計算或繪製圖片，賦予並增強了 LLM 連接外部世界的能力。Dify 提供了兩種工具類型：**第一方工具**和**自定義工具**。

你可以直接使用 Dify 生態提供的第一方內置工具，或者輕鬆導入自定義的 API 工具（目前支持 OpenAPI / Swagger 和 OpenAI Plugin 規範）。

#### 工具的作用：

1. 工具使用戶可以在 Dify 上創建更強大的 AI 應用，如你可以為智能助理型應用（Agent）編排合適的工具，它可以通過任務推理、步驟拆解、調用工具完成複雜任務。
2. 方便將你的應用與其他系統或服務連接，與外部環境交互，如代碼執行、對專屬信息源的訪問等。

### 如何配置第一方工具

<figure><img src="../../.gitbook/assets/image (182).png" alt=""><figcaption><p>第一方工具列表</p></figcaption></figure>

Dify 目前已支持：

<table><thead><tr><th width="154">工具</th><th>工具描述</th></tr></thead><tbody><tr><td>谷歌搜索</td><td>用於執行 Google SERP 搜索並提取片段和網頁的工具。輸入應該是一個搜索查詢</td></tr><tr><td>維基百科</td><td>用於執行維基百科搜索並提取片段和網頁的工具。</td></tr><tr><td>DALL-E 繪畫</td><td>用於通過自然語言輸入生成高質量圖片</td></tr><tr><td>網頁抓取</td><td>用於爬取網頁數據的工具</td></tr><tr><td>WolframAlpha</td><td>一個強大的計算知識引擎，能根據問題直接給出標準化答案，同時具有強大的數學計算功能</td></tr><tr><td>圖表生成</td><td>用於生成可視化圖表的工具，你可以通過它來生成柱狀圖、折線圖、餅圖等各類圖表</td></tr><tr><td>當前時間</td><td>用於查詢當前時間的工具</td></tr><tr><td>雅虎財經</td><td>獲取並整理出最新的新聞、股票報價等一切你想要的財經信息。</td></tr><tr><td>Stable Diffusion</td><td>一個可以在本地部署的圖片生成的工具，您可以使用 stable-diffusion-webui 來部署它</td></tr><tr><td>Vectorizer</td><td>一個將 PNG 和 JPG 圖像快速輕鬆地轉換為 SVG 矢量圖的工具。</td></tr><tr><td>YouTube</td><td>一個用於獲取油管頻道視頻統計數據的工具</td></tr></tbody></table>

{% hint style="info" %}
歡迎您為 Dify 貢獻自己開發的工具，關於如何貢獻的具體方法請查看 [Dify 開發貢獻文檔](https://github.com/langgenius/dify/blob/main/CONTRIBUTING.md)，您的任何支持對我們都是極為寶貴的。
{% endhint %}

#### 第一方工具授權

若你需要直接使用 Dify 生態提供的第一方內置工具，你需要在使用前配置相應的憑據。

<figure><img src="../../.gitbook/assets/image (185).png" alt=""><figcaption><p>配置第一方工具憑據</p></figcaption></figure>

憑據校驗成功後工具會顯示“已授權”狀態。配置憑據後，工作區中的所有成員都可以在編排應用程序時使用此工具。

<figure><img src="../../.gitbook/assets/image (187).png" alt=""><figcaption><p>第一方工具已授權</p></figcaption></figure>

### 如何創建自定義工具

你可以在“工具-自定義工具”內導入自定義的 API 工具，目前支持 OpenAPI / Swagger 和 ChatGPT Plugin 規範。你可以將 OpenAPI schema 內容直接粘貼或從 URL 內導入。關於 OpenAPI / Swagger 規範您可以查看[官方文檔說明](https://swagger.io/specification/)。

工具目前支持兩種鑑權方式：無鑑權 和 API Key。

<figure><img src="../../.gitbook/assets/image (198).png" alt=""><figcaption><p>創建自定義工具</p></figcaption></figure>

在導入 Schema 內容後系統會主動解析文件內的參數，並可預覽工具具體的參數、 方法、路徑。您也可以在此對工具參數進行測試。

<figure><img src="../../.gitbook/assets/image (199).png" alt=""><figcaption><p>自定義工具參數測試</p></figcaption></figure>

完成自定義工具創建之後，工作區中的所有成員都可以在“工作室”內編排應用程序時使用此工具。

<figure><img src="../../.gitbook/assets/image (201).png" alt=""><figcaption><p>已添加自定義工具</p></figcaption></figure>

#### Cloudflare Workers

您也可以使用 [dify-tools-worker](https://github.com/crazywoola/dify-tools-worker) 來快速部署自定義工具。該工具提供了：

* 可以導入 Dify 的路由 `https://difytoolsworker.yourname.workers.dev/doc`, 提供了 OpenAPI 兼容的接口文檔
* API 的實現代碼，可以直接部署到 Cloudflare Workers

### 如何在應用內使用工具

目前，您可以在“工作室”中創建**智能助手型應用**時，將已配置好憑據的工具在其中使用。

<figure><img src="../../.gitbook/assets/image (190).png" alt=""><figcaption><p>創建智能助手型應用時添加工具</p></figcaption></figure>

以下圖為例，在財務分析應用內添加工具後，智能助手將在需要時自主調用工具，從工具中查詢財務報告數據，並將數據分析後完成與用戶之間的對話。

<figure><img src="../../.gitbook/assets/image (195).png" alt=""><figcaption><p>智能助手在對話中完成工具調用回覆問題</p></figcaption></figure>

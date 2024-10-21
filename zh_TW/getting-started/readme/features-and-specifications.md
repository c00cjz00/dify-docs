---
description: 對於已經熟悉 LLM 應用技術棧的技術人士來說，這份文檔將是您瞭解 Dify 獨特優勢的捷徑。讓您能夠明智地比較和選擇，甚至向同事和朋友推薦。
---

# 特性與技術規格

{% hint style="info" %}
在 Dify，我們採用透明化的產品特性和技術規格政策，確保您在全面瞭解我們產品的基礎上做出決策。這種透明度不僅有利於您的技術選型，也促進了社區成員對產品的深入理解和積極貢獻。
{% endhint %}

### 項目基礎信息

<table data-header-hidden data-full-width="false"><thead><tr><th width="156"></th><th></th></tr></thead><tbody><tr><td>項目設立</td><td>2023 年 3 月</td></tr><tr><td>開源協議</td><td><a href="../../policies/open-source.md">基於 Apache License 2.0 有限商業許可</a></td></tr><tr><td>官方研發團隊</td><td>超過 15 名全職員工</td></tr><tr><td>社區貢獻者</td><td><a href="https://ossinsight.io/analyze/langgenius/dify">超過 290 人</a> （截止 2024 Q2）</td></tr><tr><td>後端技術</td><td>Python/Flask/PostgreSQL</td></tr><tr><td>前端技術</td><td>Next.js</td></tr><tr><td>代碼行數</td><td>超過 13 萬行</td></tr><tr><td>發版週期</td><td>平均每週一次</td></tr></tbody></table>

### 技術特性

<table data-header-hidden><thead><tr><th width="258"></th><th></th></tr></thead><tbody><tr><td>LLM 推理引擎</td><td>Dify Runtime ( 自 v0.4 起移除了 LangChain)</td></tr><tr><td>商業模型支持</td><td><p><strong>10+ 家</strong>，包括 OpenAI 與 Anthropic</p><p>新的主流模型通常在 48 小時內完成接入</p></td></tr><tr><td>MaaS 供應商支持</td><td><strong>7 家</strong>，Hugging Face，Replicate，AWS Bedrock，NVIDIA，GroqCloud，together.ai，OpenRouter</td></tr><tr><td>本地模型推理 Runtime 支持</td><td>6 <strong>家</strong>，Xoribits（推薦），OpenLLM，LocalAI，ChatGLM，Ollama，NVIDIA TIS </td></tr><tr><td>OpenAI 接口標準模型接入支持</td><td><strong>∞ 家</strong></td></tr><tr><td>多模態技術</td><td><p>ASR 模型</p><p>GPT-4o 規格的富文本模型</p></td></tr><tr><td>預置應用類型</td><td><p>對話型應用</p><p>文本生成應用<br>Agent<br>工作流</p></td></tr><tr><td>Prompt 即服務編排</td><td><p>廣受好評的可視化的 Prompt 編排界面，在同一個界面中修改 Prompt 並預覽效果<br></p><p><strong>編排模式</strong></p><ul><li>簡易模式編排</li><li>Assistant 模式編排</li><li>Flow 模式編排</li></ul><p><strong>Prompt 變量類型</strong></p><ul><li>字符串</li><li>單選枚舉</li><li>外部 API</li><li>文件（Q3 即將推出）</li></ul></td></tr><tr><td>Agentic Workflow 特性</td><td><p>行業領先的可視化流程編排界面，所見即所得的節點調試，可插拔的 DSL，原生的代碼運行時，構建更復雜、可靠、穩定的 LLM 應用。</p><p></p><p><strong>支持節點</strong></p><ul><li>LLM</li><li>知識庫檢索</li><li>問題分類</li><li>條件分支</li><li>代碼執行</li><li>模板轉換</li><li>HTTP 請求</li><li>工具</li></ul></td></tr><tr><td>RAG 特性</td><td><p>首創的可視化的知識庫管理界面，支持分段預覽和召回效果測試。<br><br><strong>索引方式</strong></p><ul><li>關鍵詞</li><li>文本向量</li><li>由 LLM 輔助的問題-分段模式</li></ul><p><strong>檢索方式</strong></p><ul><li>關鍵詞</li><li>文本相似度匹配</li><li>混合檢索</li><li>N 選 1 模式（即將下線）</li><li>多路召回</li></ul><p><strong>召回優化技術</strong></p><ul><li>使用 ReRank 模型</li></ul></td></tr><tr><td>ETL 技術</td><td><p>支持對 TXT、Markdown、PDF、HTML、DOC、CSV 等格式文件進行自動清洗，內置的 Unstructured 服務開啟後可獲得最大化支持。</p><p>支持同步來自 Notion 的文檔為知識庫。<br>支持同步網頁為知識庫。</p></td></tr><tr><td>向量數據庫支持</td><td>Qdrant（推薦），Weaviate，Zilliz/Milvus，Pgvector，Pgvector-rs，Chroma，OpenSearch，TiDB，Tencent Vector，Oracle，Relyt，Analyticdb</td></tr><tr><td>Agent 技術</td><td><p>ReAct，Function Call<br></p><p><strong>工具支持</strong></p><ul><li>可調用 OpenAI Plugin 標準的工具</li><li>可直接加載 OpenAPI Specification 的 API 作為工具</li></ul><p><strong>內置工具</strong></p><ul><li>40+ 款（截止 2024 Q2）</li></ul></td></tr><tr><td>日誌</td><td>支持，可基於日誌進行標註</td></tr><tr><td>標註回覆</td><td>基於經人類標註的 Q&#x26;A 對，可用於相似度對比回覆<br>可導出為供模型微調環節使用的數據格式</td></tr><tr><td>內容審查機制</td><td>OpenAI Moderation 或外部 API</td></tr><tr><td>團隊協同</td><td>工作空間與多成員管理支持</td></tr><tr><td>API 規格</td><td>RESTful，已覆蓋大部分功能</td></tr><tr><td>部署方式</td><td>Docker，Helm</td></tr></tbody></table>


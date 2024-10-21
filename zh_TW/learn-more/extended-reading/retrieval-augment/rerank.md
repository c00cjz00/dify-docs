# 重排序

### 為什麼需要重排序？

混合檢索能夠結合不同檢索技術的優勢獲得更好的召回結果，但在不同檢索模式下的查詢結果需要進行合併和歸一化（將數據轉換為統一的標準範圍或分佈，以便更好地進行比較、分析和處理），然後再一起提供給大模型。這時候我們需要引入一個評分系統：重排序模型（Rerank Model）。

**重排序模型會計算候選文檔列表與用戶問題的語義匹配度，根據語義匹配度重新進行排序，從而改進語義排序的結果**。其原理是計算用戶問題與給定的每個候選文檔之間的相關性分數，並返回按相關性從高到低排序的文檔列表。常見的 Rerank 模型如：Cohere rerank、bge-reranker 等。

<figure><img src="../../../.gitbook/assets/image (179).png" alt=""><figcaption><p>混合檢索+重排序</p></figcaption></figure>

在大多數情況下，在重排序之前會有一次前置檢索，這是由於計算查詢與數百萬個文檔之間的相關性得分將會非常低效。所以，**重排序一般都放在搜索流程的最後階段，非常適合用於合併和排序來自不同檢索系統的結果**。

不過，重排序並不是只適用於不同檢索系統的結果合併，即使是在單一檢索模式下，引入重排序步驟也能有效幫助改進文檔的召回效果，比如我們可以在關鍵詞檢索之後加入語義重排序。

在具體實踐過程中，除了將多路查詢結果進行歸一化之外，在將相關的文本分段交給大模型之前，我們一般會限制傳遞給大模型的分段個數（即 TopK，可以在重排序模型參數中設置），這樣做的原因是大模型的輸入窗口存在大小限制（一般為 4K、8K、16K、128K 的 Token 數量），你需要根據選用的模型輸入窗口的大小限制，選擇合適的分段策略和 TopK 值。

需要注意的是，即使模型上下文窗口很足夠大，過多的召回分段會可能會引入相關度較低的內容，導致回答的質量降低，所以重排序的 TopK 參數並不是越大越好。

重排序並不是搜索技術的替代品，而是一種用於增強現有檢索系統的輔助工具。**它最大的優勢是不僅提供了一種簡單且低複雜度的方法來改善搜索結果，允許用戶將語義相關性納入現有的搜索系統中，而且無需進行重大的基礎設施修改。**

以 Cohere Rerank 為例，你只需要註冊賬戶和申請 API ，接入只需要兩行代碼。另外，他們也提供了多語言模型，也就是說你可以將不同語言的文本查詢結果進行一次性排序。\\

### 如何配置 Rerank 模型？

Dify 目前已支持 Cohere Rerank 模型，進入“模型供應商-> Cohere”頁面填入 Rerank 模型的 API 祕鑰：

<figure><img src="../../../.gitbook/assets/image (163).png" alt=""><figcaption><p>在模型供應商內配置 Cohere Rerank 模型</p></figcaption></figure>

###

### 如何獲取 Cohere Rerank 模型？

登錄：[https://cohere.com/rerank](https://cohere.com/rerank)，在頁內註冊並申請 Rerank 模型的使用資格，獲取 API 祕鑰。

###

### 數據集檢索模式中設置 Rerank 模型

進入“數據集->創建數據集->檢索設置”頁面並在添加 Rerank 設置。除了在創建數據集可以設置 Rerank ，你也可以在已創建的數據集設置內更改 Rerank 配置，在應用編排的數據集召回模式設置中更改 Rerank 配置。

<figure><img src="../../../.gitbook/assets/image (132).png" alt="" width="563"><figcaption><p>數據集檢索模式中設置 Rerank 模型</p></figcaption></figure>

**TopK：** 用於設置 Rerank 後返回相關文檔的數量。

**Score 閾值：** 用於設置 Rerank 後返回相關文檔的最低分值。設置 Rerank 模型後，TopK 和 Score 閾值設置僅在 Rerank 步驟生效。

### 數據集多路召回模式中設置 Rerank 模型

進入“提示詞編排->上下文->設置”頁面中設置為多路召回模式時需開啟 Rerank 模型。

查看更多關於多路召回模式的說明，[《多路召回》](https://docs.dify.ai/v/zh-hans/guides/knowledge-base/integrate-knowledge-within-application#duo-lu-zhao-hui-tui-jian)。

<figure><img src="../../../.gitbook/assets/image (133).png" alt=""><figcaption><p>數據集多路召回模式中設置 Rerank 模型</p></figcaption></figure>

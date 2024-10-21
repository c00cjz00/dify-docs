# 標註回覆

標註回覆功能通過人工編輯標註為應用提供了可定製的高質量問答回覆能力。

適用情景：

* **特定領域的定製化回答：** 在企業、政府等客服或知識庫問答情景時，對於某些特定問題，服務提供方希望確保系統以明確的結果來回答問題，因此需要對在特定問題上定製化輸出結果。比如定製某些問題的“標準答案”或某些問題“不可回答”。
* **POC 或 DEMO 產品快速調優：** 在快速搭建原型產品，通過標註回覆實現的定製化回答可以高效提升問答結果的生成預期，提升客戶滿意度。

標註回覆功能相當於提供了另一套檢索增強系統，可以跳過 LLM 的生成環節，規避 RAG 的生成幻覺問題。

### 使用流程

1. 在開啟標註回覆功能之後，你可以對 LLM 對話回覆內容進行標註，你可以將 LLM 回覆的高質量答案直接添加為一條標註，也可以根據自己的需求編輯一條高質量答案，這些編輯的標註內容會被持久化保存；
2. 當用戶再次提問相似的問題時，會將問題向量化並查詢中與之相似的標註問題；
3. 如果找到匹配項，則直接返回標註中與問題相對應的答案，不再傳遞至 LLM 或 RAG 過程進行回覆；
4. 如果沒有找到匹配項，則問題繼續常規流程（傳遞至 LLM 或 RAG）；
5. 關閉標註回覆功能後，系統將一直不再繼續從標註內匹配回覆。

<figure><img src="../../.gitbook/assets/image (181).png" alt="" width="563"><figcaption><p>標註回覆流程</p></figcaption></figure>

### 提示詞編排中開啟標註回覆

進入“應用構建->添加功能”開啟標註回覆開關：

<figure><img src="../../.gitbook/assets/image (124).png" alt=""><figcaption><p>提示詞編排中開啟標註回覆</p></figcaption></figure>

開啟時需要先設置標註回覆的參數，可設置參數包括：Score 閾值 和 Embedding 模型

**Score 閾值**：用於設置標註回覆的匹配相似度閾值，只有高於閾值分數的標註會被召回。

**Embedding 模型**：用於對標註文本進行向量化，切換模型時會重新生成嵌入。

點擊保存並啟用時，該設置會立即生效，系統將對所有已保存的標註利用 Embedding 模型生成嵌入保存。

<figure><img src="../../.gitbook/assets/image (126).png" alt=""><figcaption><p>標註回覆參數設置</p></figcaption></figure>

### 在會話調試頁添加標註

你可以在調試與預覽頁面直接在模型回覆信息上添加或編輯標註。

<figure><img src="../../.gitbook/assets/image (128).png" alt=""><figcaption><p>添加標註回覆</p></figcaption></figure>

編輯成你需要的高質量回復並保存。

<figure><img src="../../.gitbook/assets/image (129).png" alt=""><figcaption><p>編輯標註回覆</p></figcaption></figure>

再次輸入同樣的用戶問題，系統將使用已保存的標註直接回複用戶問題。

<figure><img src="../../.gitbook/assets/image (130).png" alt=""><figcaption><p>通過已保存的標註回覆用戶問題</p></figcaption></figure>

### 日誌與標註中開啟標註回覆

進入“應用構建->日誌與標註->標註”開啟標註回覆開關：

<figure><img src="../../.gitbook/assets/image (118).png" alt=""><figcaption><p>日誌與標註中開啟標註回覆</p></figcaption></figure>

### 在標註後臺設置標註回覆參數

標註回覆可設置的參數包括：Score 閾值 和 Embedding 模型

**Score 閾值**：用於設置標註回覆的匹配相似度閾值，只有高於閾值分數的標註會被召回。

**Embedding 模型**：用於對標註文本進行向量化，切換模型時會重新生成嵌入。

<figure><img src="../../.gitbook/assets/image (119).png" alt=""><figcaption><p>設置標註回覆參數</p></figcaption></figure>

### 批量導入標註問答對

在批量導入功能內，你可以下載標註導入模板，按模版格式編輯標註問答對，編輯好後在此批量導入。

<figure><img src="../../.gitbook/assets/image (120).png" alt=""><figcaption><p>批量導入標註問答對</p></figcaption></figure>

### 批量導出標註問答對

通過標註批量導出功能，你可以一次性導出系統內已保存的所有標註問答對。

<figure><img src="../../.gitbook/assets/image (121).png" alt=""><figcaption><p>批量導出標註問答對</p></figcaption></figure>

### 查看標註回覆命中歷史

在標註命中歷史功能內，你可以查看所有命中該條標註的編輯歷史、命中的用戶問題、回覆答案、命中來源、匹配相似分數、命中時間等信息，你可以根據這些系統信息持續改進你的標註內容。

<figure><img src="../../.gitbook/assets/image (123).png" alt=""><figcaption><p>查看標註回覆命中歷史</p></figcaption></figure>

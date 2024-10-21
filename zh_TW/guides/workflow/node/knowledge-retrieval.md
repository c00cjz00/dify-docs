# 知識檢索

### 定義

從知識庫中檢索與用戶問題相關的文本內容，可作為下游 LLM 節點的上下文來使用。



***

### 應用場景

常見情景：構建基於外部數據/知識的 AI 問答系統（RAG）。瞭解更多關於 RAG 的[基本概念](../../../learn-more/extended-reading/retrieval-augment/)。

下圖為一個最基礎的知識庫問答應用示例，該流程的執行邏輯為：知識庫檢索作為 LLM 節點的前置步驟，在用戶問題傳遞至 LLM 節點之前，先在知識檢索節點內將匹配用戶問題最相關的文本內容並召回，隨後在 LLM 節點內將用戶問題與檢索到的上下文一同作為輸入，讓 LLM 根據檢索內容來回復問題。

<figure><img src="../../../.gitbook/assets/image (244).png" alt=""><figcaption><p>知識庫問答應用示例</p></figcaption></figure>

***

### 配置指引

**配置流程：**

1. 選擇查詢變量。查詢變量通常代表用戶輸入的問題，該變量可以作為輸入項並檢索知識庫中的相關文本分段。在常見的對話類應用中一般將開始節點的 `sys.query` 作為查詢變量，知識庫所能接受的最大查詢內容為 200 字符；
2. 選擇需要查詢的知識庫，可選知識庫需要在 Dify 知識庫內預先[創建](../../knowledge-base/create-knowledge-and-upload-documents.md)；
3. 指定[召回模式](../../../learn-more/extended-reading/retrieval-augment/retrieval.md)。自 9 月 1 日後，知識庫的召回模式將自動切換為多路召回，不再建議使用 N 選 1 召回模式；
4. 連接並配置下游節點，一般為 LLM 節點；

<figure><img src="../../../.gitbook/assets/image (74).png" alt=""><figcaption><p>知識檢索配置</p></figcaption></figure>

**輸出變量**

<figure><img src="../../../.gitbook/assets/image (250).png" alt="" width="272"><figcaption><p>輸出變量</p></figcaption></figure>

知識檢索的輸出變量 `result` 為從知識庫中檢索到的相關文本分段。其變量數據結構中包含了分段內容、標題、鏈接、圖標、元數據信息。

**配置下游節點**

在常見的對話類應用中，知識庫檢索的下游節點一般為 LLM 節點，知識檢索的**輸出變量** `result` 需要配置在 LLM 節點中的 **上下文變量** 內關聯賦值。關聯後你可以在提示詞的合適位置插入 **上下文變量**。

{% hint style="info" %}
上下文變量是 LLM 節點內定義的特殊變量類型，用於在提示詞內插入外部檢索的文本內容。
{% endhint %}

當用戶提問時，若在知識檢索中召回了相關文本，文本內容會作為上下文變量中的值填入提示詞，提供 LLM 回覆問題；若未在知識庫檢索中召回相關的文本，上下文變量值為空，LLM 則會直接回複用戶問題。

<figure><img src="../../../.gitbook/assets/image (77).png" alt=""><figcaption><p>配置下游 LLM 節點</p></figcaption></figure>

該變量除了可以作為 LLM 回覆問題時的提示詞上下文作為外部知識參考引用，另外由於其數據結構中包含了分段引用信息，同時可以支持應用端的 [**引用與歸屬**](../../knowledge-base/retrieval-test-and-citation.md#id-2-yin-yong-yu-gui-shu) 功能。

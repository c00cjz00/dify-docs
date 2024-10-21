---
description: 作者： Allen。 Dify Technical Writer。
---

# 連接外部知識庫

> 為做出區別，獨立於 Dify 平臺之外的知識庫在本文內均被統稱為 **“外部知識庫”**。

## 功能簡介

對於內容檢索有著更高要求的進階開發者而言，Dify 平臺內置的知識庫功能和文本檢索和召回機制**存在限制，無法輕易變更文本召回結果。**

出於對文本檢索和召回的精確度有著更高追求，以及對內部資料的管理需求，部分團隊選擇自主研發 RAG 算法並獨立維護文本召回系統、或將內容統一託管至雲廠商的知識庫服務（例如 [AWS Bedrock](https://aws.amazon.com/bedrock/)）。

作為中立的 LLM 應用開發平臺，Dify 致力於給予開發者更多選擇權。

**連接外部知識庫**功能可以將 Dify 平臺與外部知識庫建立連接。通過 API 服務，AI 應用能夠獲取更多信息來源。這意味著：

* Dify 平臺能夠直接獲取託管在雲服務提供商知識庫內的文本內容，開發者無需將內容重複搬運至 Dify 中的知識庫；
* Dify 平臺能夠直接獲取自建知識庫內經算法處理後的文本內容，開發者僅需關注自建知識庫的信息檢索機制，並不斷優化與提升信息召回的準確度。

<figure><img src="../../.gitbook/assets/image (1) (1) (1).png" alt=""><figcaption><p>外部知識庫連接原理</p></figcaption></figure>

以下是連接外部知識的詳細步驟：

### 1. 建立符合要求的外部知識庫 API

為了確保你的外部知識庫與 Dify 連接成功，請在建立 API 服務前仔細閱讀由 Dify 編寫的[外部知識庫 API 規範。](external-knowledge-api-documentation.md)

### 2. 關聯外部知識庫

> 目前， Dify 連接外部知識庫時僅具備檢索權限，暫不支持對外部知識庫進行優化與修改，開發者需自行維護外部知識庫。

前往 **“知識庫”** 頁，點擊右上角的 **“外部知識庫 API”**，輕點 **“添加外部知識庫 API”**。

按照頁面提示，依次填寫以下內容：

* 知識庫的名稱，允許自定義名稱，用於區分所連接的不同外部知識 API；
* API 接口地址，外部知識庫的連接地址，示例 `api-endpoint/retrieval`；詳細說明請參考[外部知識庫 API](https://docs.dify.ai/zh-hans/guides/knowledge-base/external-knowledge-api-documentation)；
* API Key，外部知識庫連接密鑰，詳細說明請參考[外部知識庫 API](https://docs.dify.ai/zh-hans/guides/knowledge-base/external-knowledge-api-documentation)；

<figure><img src="../../.gitbook/assets/image (353).png" alt=""><figcaption></figcaption></figure>

### 3. 連接外部知識庫

前往 **“知識庫”** 頁，點擊添加知識庫卡片下方的 **“連接外部知識庫”** 跳轉至參數配置頁面。

<figure><img src="../../.gitbook/assets/image (354).png" alt=""><figcaption></figcaption></figure>

填寫以下參數：

* **知識庫名稱與描述**
* **外部知識庫 API** 選擇在第二步中關聯的外部知識庫 API；Dify 將通過 API 連接的方式，調用存儲在外部知識庫的文本內容；
* **外部知識庫 ID** 指定需要被關聯的特定的外部知識庫 ID，詳細說明請參考外部知識庫 API 定義。
*   **調整召回設置**

    **Top K：**用戶發起提問時，將請求外部知識 API 獲取相關性較高的內容分段。該參數用於篩選與用戶問題相似度較高的文本片段。默認值為 3，數值越高，召回存在相關性的文本分段也就越多。

    **Score 閾值：**文本片段篩選的相似度閾值，只召回超過設置分數的文本片段，默認值為 0.5。數值越高說明對於文本與問題要求的相似度越高，預期被召回的文本數量也越少，結果也會相對而言更加精準。

<figure><img src="../../.gitbook/assets/image (355).png" alt=""><figcaption></figcaption></figure>

### 4. 測試外部知識庫連接與召回

建立與外部知識庫的連接後，開發者可以在 **“召回測試”** 中模擬可能的問題關鍵詞，預覽從外部知識庫召回的文本分段。若對於召回結果不滿意，可以嘗試修改召回參數或自行調整外部知識庫的檢索設置。

<figure><img src="../../.gitbook/assets/image (356).png" alt=""><figcaption></figcaption></figure>

### 5. 在應用內集成外部知識庫

*   Chatbot / Agent 類型應用

    在 Chatbot / Agent 類型應用內的編排頁中的 **“上下文”** 內，選中帶有 `EXTERNAL` 標籤的外部知識庫。

    <figure><img src="../../.gitbook/assets/image (357).png" alt=""><figcaption></figcaption></figure>
*   Chatflow / Workflow 類型應用

    在 Chatflow / Workflow 類型應用內添加 **“知識檢索”** 節點，選中帶有 `EXTERNAL` 標籤的外部知識庫。

    <figure><img src="../../.gitbook/assets/image (358).png" alt=""><figcaption></figcaption></figure>

### 6. 管理外部知識庫

在 **“知識庫”** 頁，外部知識庫的卡片右上角會帶有 EXTERNAL 標籤。進入需要修改的知識庫，點擊 “設置” 修改以下內容：

* **知識庫名稱和描述**
* **可見範圍** 提供 「 只有我 」 、 「 所有團隊成員 」 和 「部分團隊成員」 三種權限範圍。不具有權限的人將無法訪問該知識庫。若選擇將知識庫公開至其它成員，則意味著其它成員同樣具備該知識庫的查看、編輯和刪除權限。
*   **召回設置**

    **Top K:** 用戶發起提問時，將請求外部知識 API 獲取相關性較高的內容分段。該參數用於篩選與用戶問題相似度較高的文本片段。默認值為 3，數值越高，召回存在相關性的文本分段也就越多。

    **Score 閾值：**文本片段篩選的相似度閾值，只召回超過設置分數的文本片段，默認值為 0.5。數值越高說明對於文本與問題要求的相似度越高，預期被召回的文本數量也越少，結果也會相對而言更加精準。

外部知識庫所關聯的 **“外部知識庫 API”** 和 **“外部知識 ID”** 不支持修改，如需修改請關聯新的 “外部知識庫 API” 並重新進行連接。

### 連接示例

[how-to-connect-aws-bedrock.md](../../learn-more/use-cases/how-to-connect-aws-bedrock.md "mention")

### 常見問題

**連接外部知識庫 API 時異常，出現報錯如何處理？**

以下是返回信息各個錯誤碼所對應的錯誤提示與解決辦法：

| 錯誤碼  | 錯誤提示                        | 解決辦法                           |
| ---- | --------------------------- | ------------------------------ |
| 1001 | 無效的 Authorization header 格式 | 請檢查請求的 Authorization header 格式 |
| 1002 | 驗證異常                        | 請檢查所填寫的 API Key 是否正確           |
| 2001 | 知識庫不存在                      | 請檢查外部知識庫                       |

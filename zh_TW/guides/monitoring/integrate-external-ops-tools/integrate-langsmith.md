# 集成 LangSmith

### 什麼是 LangSmith

LangSmith 是一個用於構建生產級 LLM 應用程序的平臺，它用於開發、協作、測試、部署和監控 LLM 應用程序。

{% hint style="info" %}
LangSmith 官網介紹：[https://www.langchain.com/langsmith](https://www.langchain.com/langsmith)
{% endhint %}

***

### 如何配置 LangSmith

本章節將指引你註冊 LangSmith 並將其集成至 Dify 平臺內。

#### 1. 註冊/登錄 [LangSmith](https://www.langchain.com/langsmith)

#### 2. 創建項目

在 LangSmith 內創建項目，登錄後在主頁點擊 **New Project** 創建一個自己的項目，**項目**將用於與 Dify 內的**應用**關聯進行數據監測。

<figure><img src="../../../.gitbook/assets/image (29).png" alt=""><figcaption><p>在 LangSmith 內創建項目</p></figcaption></figure>

創建完成之後在 Projects 內可以查看該項目。

<figure><img src="../../../.gitbook/assets/image (36).png" alt=""><figcaption><p>在 LangSmith 內查看已創建項目</p></figcaption></figure>

#### 3. 創建項目憑據

創建項目憑據，在左側邊欄內找到項目設置 **Settings**。

<figure><img src="../../../.gitbook/assets/image (37).png" alt=""><figcaption><p>項目設置</p></figcaption></figure>

點擊 **Create API Key**，創建一個項目憑據。

<figure><img src="../../../.gitbook/assets/image (32).png" alt=""><figcaption><p>創建一個項目 API Key</p></figcaption></figure>

選擇 **Personal Access Token** ，用於後續的 API 身份校驗。

<figure><img src="../../../.gitbook/assets/image (34).png" alt=""><figcaption><p>創建一個 API Key</p></figcaption></figure>

將創建的 API key 複製保存。

<figure><img src="../../../.gitbook/assets/image (38).png" alt=""><figcaption><p>複製 API Key</p></figcaption></figure>

#### 4. 將 LangSmith 集成至 Dify 平臺

在 Dify 應用內配置 LangSmith。打開需要監測的應用，在左側邊菜單內打開**監測**，點擊頁面內的**配置。**

<figure><img src="../../../.gitbook/assets/image (40).png" alt=""><figcaption><p>配置 LangSmith</p></figcaption></figure>

點擊配置後，將在 LangSmith 內創建的 **API Key** 和**項目名**粘貼到配置內並保存。

<figure><img src="../../../.gitbook/assets/image (41).png" alt=""><figcaption><p>配置 LangSmith</p></figcaption></figure>

{% hint style="info" %}
配置項目名需要與 LangSmith 內設置的項目一致，若項目名不一致，數據同步時 LangSmith 會自動創建一個新的項目。
{% endhint %}

成功保存後可以在當前頁面查看監測狀態。

<figure><img src="../../../.gitbook/assets/image (44).png" alt=""><figcaption><p>查看配置狀態</p></figcaption></figure>

### 在 LangSmith 內查看監測數據

配置完成後， Dify 內應用的調試或生產數據可以在 LangSmith 查看監測數據。

<figure><img src="../../../.gitbook/assets/image (46).png" alt=""><figcaption><p>在 Dify 內調試應用</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (28).png" alt=""><figcaption><p>在 LangSmith 內查看應用數據</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (47).png" alt=""><figcaption><p>在 LangSmith 內查看應用數據</p></figcaption></figure>

### 監測數據清單

#### Workflow /Chatflow Trace信息

**用於追蹤workflow以及chatflow**

| Workflow                                 | LangSmith Chain            |
| ---------------------------------------- | -------------------------- |
| workflow\_app\_log\_id/workflow\_run\_id | id                         |
| user\_session\_id                        | -放入metadata                |
| workflow\_{id}                           | name                       |
| start\_time                              | start\_time                |
| end\_time                                | end\_time                  |
| inputs                                   | inputs                     |
| outputs                                  | outputs                    |
| 模型token消耗相關                              | usage\_metadata            |
| metadata                                 | extra                      |
| error                                    | error                      |
| \[workflow]                              | tags                       |
| "conversation\_id/workflow時無"            | metadata中的conversation\_id |
| conversion\_id                           | parent\_run\_id            |

**Workflow Trace Info**

* workflow\_id - Workflow的唯一標識
* conversation\_id - 對話ID
* workflow\_run\_id - 此次運行的ID
* tenant\_id - 租戶ID
* elapsed\_time - 此次運行耗時
* status - 運行狀態
* version - Workflow版本
* total\_tokens - 此次運行使用的token總數
* file\_list - 處理的文件列表
* triggered\_from - 觸發此次運行的來源
* workflow\_run\_inputs - 此次運行的輸入數據
* workflow\_run\_outputs - 此次運行的輸出數據
* error - 此次運行中發生的錯誤
* query - 運行時使用的查詢
* workflow\_app\_log\_id - Workflow應用日誌ID
* message\_id - 關聯的消息ID
* start\_time - 運行開始時間
* end\_time - 運行結束時間
* workflow node executions - workflow節點運行信息
* Metadata
  * workflow\_id - Workflow的唯一標識
  * conversation\_id - 對話ID
  * workflow\_run\_id - 此次運行的ID
  * tenant\_id - 租戶ID
  * elapsed\_time - 此次運行耗時
  * status - 運行狀態
  * version - Workflow版本
  * total\_tokens - 此次運行使用的token總數
  * file\_list - 處理的文件列表
  * triggered\_from - 觸發來源

#### Message Trace信息

**用於追蹤llm對話相關**

| Chat                             | LangSmith LLM              |
| -------------------------------- | -------------------------- |
| message\_id                      | id                         |
| user\_session\_id                | -放入metadata                |
| “message\_{id}"                  | name                       |
| start\_time                      | start\_time                |
| end\_time                        | end\_time                  |
| inputs                           | inputs                     |
| outputs                          | outputs                    |
| 模型token消耗相關                      | usage\_metadata            |
| metadata                         | extra                      |
| error                            | error                      |
| \["message", conversation\_mode] | tags                       |
| conversation\_id                 | metadata中的conversation\_id |
| conversion\_id                   | parent\_run\_id            |

**Message Trace Info**

* message\_id - 消息ID
* message\_data - 消息數據
* user\_session\_id - 用戶的session\_id
* conversation\_model - 對話模式
* message\_tokens - 消息中的令牌數
* answer\_tokens - 回答中的令牌數
* total\_tokens - 消息和回答中的總令牌數
* error - 錯誤信息
* inputs - 輸入數據
* outputs - 輸出數據
* file\_list - 處理的文件列表
* start\_time - 開始時間
* end\_time - 結束時間
* message\_file\_data - 消息關聯的文件數據
* conversation\_mode - 對話模式
* Metadata
  * conversation\_id - 消息所屬對話的ID
  * ls\_provider - 模型提供者
  * ls\_model\_name - 模型ID
  * status - 消息狀態
  * from\_end\_user\_id - 發送用戶的ID
  * from\_account\_id - 發送賬戶的ID
  * agent\_based - 是否基於代理
  * workflow\_run\_id - 工作流運行ID
  * from\_source - 消息來源
  * message\_id - 消息ID

#### Moderation Trace信息

**用於追蹤對話審查**

| Moderation    | LangSmith Tool  |
| ------------- | --------------- |
| user\_id      | -放入metadata     |
| “moderation"  | name            |
| start\_time   | start\_time     |
| end\_time     | end\_time       |
| inputs        | inputs          |
| outputs       | outputs         |
| metadata      | extra           |
| \[moderation] | tags            |
| message\_id   | parent\_run\_id |

**Message Trace Info**

* message\_id - 消息ID
* user\_id: 用戶id
* workflow\_app\_log\_id workflow\_app\_log\_id
* inputs - 審查的輸入數據
* message\_data - 消息數據
* flagged - 是否被標記為需要注意的內容
* action - 執行的具體行動
* preset\_response - 預設響應
* start\_time - 審查開始時間
* end\_time - 審查結束時間
* Metadata
  * message\_id - 消息ID
  * action - 執行的具體行動
  * preset\_response - 預設響應

#### Suggested Question Trace信息

**用於追蹤建議問題**

| Suggested Question     | LangSmith LLM   |
| ---------------------- | --------------- |
| user\_id               | -放入metadata     |
| suggested\_question    | name            |
| start\_time            | start\_time     |
| end\_time              | end\_time       |
| inputs                 | inputs          |
| outputs                | outputs         |
| metadata               | extra           |
| \[suggested\_question] | tags            |
| message\_id            | parent\_run\_id |

**Message Trace Info**

* message\_id - 消息ID
* message\_data - 消息數據
* inputs - 輸入的內容
* outputs - 輸出的內容
* start\_time - 開始時間
* end\_time - 結束時間
* total\_tokens - 令牌數量
* status - 消息狀態
* error - 錯誤信息
* from\_account\_id - 發送賬戶的ID
* agent\_based - 是否基於代理
* from\_source - 消息來源
* model\_provider - 模型提供者
* model\_id - 模型ID
* suggested\_question - 建議的問題
* level - 狀態級別
* status\_message - 狀態信息
* Metadata
  * message\_id - 消息ID
  * ls\_provider - 模型提供者
  * ls\_model\_name - 模型ID
  * status - 消息狀態
  * from\_end\_user\_id - 發送用戶的ID
  * from\_account\_id - 發送賬戶的ID
  * workflow\_run\_id - 工作流運行ID
  * from\_source - 消息來源

#### Dataset Retrieval Trace信息

**用於追蹤知識庫檢索**

| Dataset Retrieval     | LangSmith Retriever |
| --------------------- | ------------------- |
| user\_id              | -放入metadata         |
| dataset\_retrieval    | name                |
| start\_time           | start\_time         |
| end\_time             | end\_time           |
| inputs                | inputs              |
| outputs               | outputs             |
| metadata              | extra               |
| \[dataset\_retrieval] | tags                |
| message\_id           | parent\_run\_id     |

**Dataset Retrieval Trace Info**

* message\_id - 消息ID
* inputs - 輸入內容
* documents - 文檔數據
* start\_time - 開始時間
* end\_time - 結束時間
* message\_data - 消息數據
* Metadata
  * message\_id消息ID
  * ls\_provider模型提供者
  * ls\_model\_name模型ID
  * status消息狀態
  * from\_end\_user\_id發送用戶的ID
  * from\_account\_id發送賬戶的ID
  * agent\_based是否基於代理
  * workflow\_run\_id工作流運行ID
  * from\_source消息來源

#### Tool Trace信息

**用於追蹤工具調用**

| Tool                  | LangSmith Tool  |
| --------------------- | --------------- |
| user\_id              | -放入metadata     |
| tool\_name            | name            |
| start\_time           | start\_time     |
| end\_time             | end\_time       |
| inputs                | inputs          |
| outputs               | outputs         |
| metadata              | extra           |
| \["tool", tool\_name] | tags            |
| message\_id           | parent\_run\_id |

**Tool Trace Info**

* message\_id消息ID
* tool\_name工具名稱
* start\_time開始時間
* end\_time結束時間
* tool\_inputs工具輸入
* tool\_outputs工具輸出
* message\_data消息數據
* error錯誤信息，如果存在
* inputs消息的輸入內容
* outputs消息的回答內容
* tool\_config工具配置
* time\_cost時間成本
* tool\_parameters工具參數
* file\_url關聯文件的URL
* Metadata
  * message\_id消息ID
  * tool\_name工具名稱
  * tool\_inputs工具輸入
  * tool\_outputs工具輸出
  * tool\_config工具配置
  * time\_cost時間成本
  * error錯誤信息
  * tool\_parameters工具參數
  * message\_file\_id消息文件ID
  * created\_by\_role創建者角色
  * created\_user\_id創建者用戶ID

#### Generate Name Trace信息

**用於追蹤會話標題生成**

| Generate Name     | LangSmith Tool |
| ----------------- | -------------- |
| user\_id          | -放入metadata    |
| generate\_name    | name           |
| start\_time       | start\_time    |
| end\_time         | end\_time      |
| inputs            | inputs         |
| outputs           | outputs        |
| metadata          | extra          |
| \[generate\_name] | tags           |

**Generate Name Trace Info**

* conversation\_id對話ID
* inputs輸入數據
* outputs生成的會話名稱
* start\_time開始時間
* end\_time結束時間
* tenant\_id租戶ID
* Metadata
  * conversation\_id對話ID
  * tenant\_id租戶ID

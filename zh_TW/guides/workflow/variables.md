---
description: 最近編輯：Allen, Dify Technical Writer
---

# 變量

Workflow 和 Chatflow 類型應用由獨立節點相構成。大部分節點設有輸入和輸出項，但每個節點的輸入信息不一致，各個節點所輸出的答覆也不盡相同。

如何用一種固定的符號**指代動態變化的內容？** 變量作為一種動態數據容器，能夠存儲和傳遞不固定的內容，在不同的節點內被相互引用，實現信息在節點間的靈活通信。

### **系統變量**

系統變量指的是在 Chatflow / Workflow 應用內預設的系統級參數，可以被其它節點全局讀取。系統級變量均以 `sys` 開頭。

#### Workflow

Workflow 類型應用提供以下系統變量：

<table><thead><tr><th width="193">變量名稱</th><th width="116">數據類型</th><th width="278">說明</th><th>備註</th></tr></thead><tbody><tr><td><p><code>sys.files</code></p><p><code>[LEGACY]</code></p></td><td>Array[File]</td><td>文件參數，存儲用戶初始使用應用時上傳的圖片</td><td>圖片上傳功能需在應用編排頁右上角的 “功能” 處開啟</td></tr><tr><td><code>sys.user_id</code></td><td>String</td><td>用戶 ID，每個用戶在使用工作流應用時，系統會自動向用戶分配唯一標識符，用以區分不同的對話用戶</td><td></td></tr><tr><td><code>sys.app_id</code></td><td>String</td><td> 應用 ID，系統會向每個 Workflow 應用分配一個唯一的標識符，用以區分不同的應用，並通過此參數記錄當前應用的基本信息</td><td>面向具備開發能力的用戶，通過此參數區分並定位不同的 Workflow 應用</td></tr><tr><td><code>sys.workflow_id</code></td><td>String</td><td>Workflow ID，用於記錄當前 Workflow 應用內所包含的所有節點信息</td><td>面向具備開發能力的用戶，可以通過此參數追蹤並記錄 Workflow 內的包含節點信息</td></tr><tr><td><code>sys.workflow_run_id</code></td><td>String</td><td>Workflow 應用運行 ID，用於記錄 Workflow 應用中的運行情況</td><td>面向具備開發能力的用戶，可以通過此參數追蹤應用的歷次運行情況</td></tr></tbody></table>



<figure><img src="../../.gitbook/assets/image (19).png" alt=""><figcaption><p>Workflow 類型應用系統變量</p></figcaption></figure>

#### Chatflow

Chatflow 類型應用提供以下系統變量：

<table><thead><tr><th>變量名稱</th><th width="127">數據類型</th><th width="283">說明</th><th>備註</th></tr></thead><tbody><tr><td><code>sys.query</code></td><td>String</td><td>用戶在對話框中初始輸入的內容</td><td></td></tr><tr><td><code>sys.files</code></td><td>Array[File]</td><td>用戶在對話框內上傳的圖片</td><td>圖片上傳功能需在應用編排頁右上角的 “功能” 處開啟</td></tr><tr><td><code>sys.dialogue_count</code></td><td>Number</td><td><p>用戶在與 Chatflow 類型應用交互時的對話輪數。每輪對話後自動計數增加 1，可以和 if-else 節點搭配出豐富的分支邏輯。</p><p>例如到第 X 輪對話時，回顧歷史對話並給出分析</p></td><td></td></tr><tr><td><code>sys.conversation_id</code></td><td>String</td><td>對話框交互會話的唯一標識符，將所有相關的消息分組到同一個對話中，確保 LLM 針對同一個主題和上下文持續對話</td><td></td></tr><tr><td><code>sys.user_id</code></td><td>String</td><td>分配給每個應用用戶的唯一標識符，用以區分不同的對話用戶</td><td></td></tr><tr><td><code>sys.app_id</code></td><td>String</td><td> 應用 ID，系統會向每個 Workflow 應用分配一個唯一的標識符，用以區分不同的應用，並通過此參數記錄當前應用的基本信息</td><td>面向具備開發能力的用戶，通過此參數區分並定位不同的 Workflow 應用</td></tr><tr><td><code>sys.workflow_id</code></td><td>String</td><td>Workflow ID，用於記錄當前 Workflow 應用內所包含的所有節點信息</td><td>面向具備開發能力的用戶，可以通過此參數追蹤並記錄 Workflow 內的包含節點信息</td></tr><tr><td><code>sys.workflow_run_id</code></td><td>String</td><td>Workflow 應用運行 ID，用於記錄 Workflow 應用中的運行情況</td><td>面向具備開發能力的用戶，可以通過此參數追蹤應用的歷次運行情況</td></tr></tbody></table>

<figure><img src="../../.gitbook/assets/image (6).png" alt=""><figcaption><p>Chatflow 類型應用系統變量</p></figcaption></figure>

### 環境變量

**環境變量用於保護工作流內所涉及的敏感信息**，例如運行工作流時所涉及的 API 密鑰、數據庫密碼等。它們被存儲在工作流程中，而不是代碼中，以便在不同環境中共享。

<figure><img src="../../.gitbook/assets/環境變量.jpeg" alt=""><figcaption><p>環境變量</p></figcaption></figure>

支持以下三種數據類型：

* String 字符串
* Number 數字
* Secret 密鑰

環境變量擁有以下特性：

* 環境變量可在大部分節點內全局引用；
* 環境變量命名不可重複；
* 環境變量為只讀變量，不可寫入；

### 會話變量

> 會話變量面向多輪對話場景，而 Workflow 類型應用的交互是線性而獨立的，不存在多次對話交互的情況，因此會話變量僅適用於 Chatflow 類型（聊天助手 → 工作流編排）應用。

**會話變量允許應用開發者在同一個 Chatflow 會話內，指定需要被臨時存儲的特定信息，並確保在當前工作流內的多輪對話內都能夠引用該信息**，如上下文、上傳至對話框的文件（即將上線）、 用戶在對話過程中所輸入的偏好信息等。好比為 LLM 提供一個可以被隨時查看的“備忘錄”，避免因 LLM 記憶出錯而導致的信息偏差。

例如你可以將用戶在首輪對話時輸入的語言偏好存儲至會話變量中，LLM 在回答時將參考會話變量中的信息，並在後續的對話中使用指定的語言回覆用戶。

<figure><img src="../../.gitbook/assets/會話變量.jpeg" alt=""><figcaption><p>會話變量</p></figcaption></figure>

**會話變量**支持以下六種數據類型：

* String 字符串
* Number 數值
* Object 對象
* Array\[string] 字符串數組
* Array\[number] 數值數組
* Array\[object] 對象數組

**會話變量**具有以下特性：

* 會話變量可在大部分節點內全局引用；
* 會話變量的寫入需要使用[變量賦值](node/variable-assignment.md)節點；
* 會話變量為可讀寫變量；

關於如何將會話變量與變量賦值節點配合使用，請參考[變量賦值](node/variable-assignment.md)節點說明。

### 注意事項

* 為避免變量名重複，節點命名不可重複
* 節點的輸出變量一般為固定變量，不可編輯






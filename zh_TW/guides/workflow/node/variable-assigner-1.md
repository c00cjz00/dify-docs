# 變量賦值

### 1 定義

變量賦值節點用於向可寫入變量進行變量賦值。目前已支持的可寫入變量為[會話變量](../key-concept.md#hui-hua-bian-liang)。

通過變量賦值節點可以將工作流內的變量賦值到會話變量中臨時存儲，並在後續對話中引用該變量值。

<figure><img src="../../../.gitbook/assets/image (8).png" alt="" width="375"><figcaption></figcaption></figure>

***

### 2 場景

將會話中的**上下文、上傳的文件、用戶偏好**等通過變量賦值寫入到會話變量中，並在後續對話中引用已存儲的信息導向不同的處理流程或者進行回覆。

**場景 1** &#x20;

**用戶偏好記錄**，在會話內記住用戶語言偏好並在後續對話中持續使用該語言類型進行回覆。

<figure><img src="../../../.gitbook/assets/image (265).png" alt=""><figcaption></figcaption></figure>

**配置流程：**

**設置會話變量**：首先設置一個會話變量 `language`，在會話流程開始時添加一個條件判斷節點，用來判斷 `language` 變量的值是否為空。

**變量寫入/賦值**：首輪對話開始時， `language` 變量值為空，則使用 LLM 節點來提取用戶輸入的語言，再通過變量賦值節點將該語言類型寫入到會話變量 `language` 中。

**變量讀取**：在後續的對話輪次內： `language` 變量已存儲用戶語言偏好，LLM 節點可以通過引用 language 變量，使用用戶的偏好語言類型進行回覆。

**場景 2**

**Checklist 打卡**，在會話內記住用戶的 checklist 輸入項並在後續對話中檢查未完成項。

<figure><img src="../../../.gitbook/assets/image (266).png" alt=""><figcaption></figcaption></figure>

會話開始時 LLM 會要求用戶檢查 Checklist 是否都已填寫。

<figure><img src="../../../.gitbook/assets/image (267).png" alt=""><figcaption></figcaption></figure>

會話過程中，根據用戶已填寫的信息，LLM 會每輪檢查未填寫的 Checklist，並提醒用戶繼續填寫。\


<figure><img src="../../../.gitbook/assets/image (268).png" alt=""><figcaption></figcaption></figure>

**配置流程：**

* **設置會話變量：**首先設置一個會話變量 `ai_checklist`,在 LLM 內引用該變量作為上下文進行檢查。
* **變量賦值/寫入**：每一輪對話時，在 LLM 節點內檢查 `ai_checklist` 內的值並比對用戶輸入，若用戶提供了新的信息，則更新 Checklist 並將輸出內容通過變量賦值節點寫入到 `ai_checklist` 內。
* **變量讀取：**每一輪對話讀取 `ai_cheklist` 內的值並比對用戶輸入直至所有 checklist 完成。

***

### 3 如何操作

<figure><img src="../../../.gitbook/assets/image (7).png" alt="" width="375"><figcaption></figcaption></figure>

**設置變量：**

Assigned Variable 指定變量：選擇被賦值變量

Set Variable 設置變量：選擇需要賦值的變量

以上圖為例，賦值邏輯：將 `Language Recognition/text`  變量的值賦值到 `language` 變量中。

**寫入模式：**

* Overwrite 寫入
* Append 追加，指定變量為 Array 類型時
* Clear 清除


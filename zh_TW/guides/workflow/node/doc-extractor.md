# 文檔提取器

### 定義

LLM 自身無法直接讀取或解釋文檔的內容。因此需要將用戶上傳的文檔，通過文檔提取器節點解析並讀取文檔文件中的信息，轉化文本之後再將內容傳給 LLM 以實現對於文件內容的處理。

### 應用場景

* 構建能夠與文件進行互動的 LLM 應用，例如 ChatPDF 或 ChatWord；
* 分析並檢查用戶上傳的文件內容；

### 節點功能

文檔提取器節點可以理解為一個信息處理中心，通過識別並讀取輸入變量中的文件，提取信息後並轉化為 string 類型輸出變量，供下游節點調用。

<figure><img src="../../../.gitbook/assets/image (12).png" alt=""><figcaption><p>文檔提取器節點</p></figcaption></figure>

文檔提取器節點結構分為輸入變量、輸出變量。

#### 輸入變量

文檔提取器僅接受以下數據結構的變量：

* `File`，單獨一個文件
* `Array[File]`，多個文件

文檔提取器僅能夠提取文檔類型文件中的信息，例如 TXT、Markdown、PDF、HTML、DOCX 格式文件的內容，無法處理圖片、音頻、視頻等格式文件。

#### 輸出變量

輸出變量固定命名為 text。輸出的變量類型取決於輸入變量：

* 輸入變量為 `File`，輸出變量為 `string`
* 輸入變量為 `Array[File]`，輸出變量為 `array[string]`

> Array 數組變量一般需配合列表操作節點使用，詳細說明請參考 [list-operator.md](list-operator.md "mention")。

### 配置示例

在一個典型的文件交互問答場景中，文檔提取器可以作為 LLM 節點的前置步驟，提取應用的文件信息並傳遞至下游的 LLM 節點，回答用戶關於文件的問題。

本章節將通過一個典型的 ChatPDF 示例工作流模板，介紹文檔提取器節點的使用方法。

<figure><img src="../../../.gitbook/assets/image (373).png" alt=""><figcaption><p>ChatPDF 工作流</p></figcaption></figure>

**配置流程：**

1. 為應用開啟文件上傳功能。在 [“開始”](start.md) 節點中添加**單文件變量**並命名為 `pdf`。
2. 添加文檔提取節點，並在輸入變量內選中 `pdf` 變量。
3. 添加 LLM 節點，在系統提示詞內選中文檔提取器節點的輸出變量。LLM 可以通過該輸出變量讀取文件中的內容。

<figure><img src="../../../.gitbook/assets/image (14).png" alt=""><figcaption><p>填寫文檔提取器的輸出變量</p></figcaption></figure>

&#x20;4\. 配置結束節點，在結束節點中選擇 LLM 節點的輸出變量。

配置完成後，應用將具備文件上傳功能，使用者可以上傳 PDF 文件並展開對話。

<figure><img src="../../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
如需瞭解如何在聊天對話中上傳文件並與 LLM 互動，請參考 [附加功能](../additional-features.md)。
{% endhint %}






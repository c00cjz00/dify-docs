---
description: 作者：Steven, Allen. Technical Writer
---

# 文件上傳

許多專業的內容存儲在文檔文件內，例如學術報告、法律合同。受限於 LLM 僅能夠文本或者圖片輸入源，難以獲取文件內更加豐富的上下文信息，許多用戶不得不手動複製粘貼大量信息與 LLM 對話，應用場景有限。

文件上傳功能允許將文件以 File variables 的形式在工作流應用中上傳、解析、引用、和下載。**開發者現可輕鬆構建能理解和處理圖片、音頻、視頻的複雜工作。**



### 應用場景

1. **文檔分析**: 上傳學術研究報告文件，LLM 可以快速總結要點，根據文件內容回答相關問題。
2. **代碼審查**: 開發者上傳代碼文件，獲得優化建議與 bug 檢測。
3. **學習輔導**: 學生上傳作業或學習資料，獲得個性化的解釋和指導。
4. **法律援助**: 上傳完整的合同文本，由 LLM 協助審查條款，指出潛在風險。

### 快速開始

Dify 支持在 [ChatFlow](key-concept.md#chatflow-he-workflow) 和 [WorkFlow](key-concept.md#chatflow-he-workflow) 類型應用中上傳文件，並通過[變量](variables.md)交由 LLM 處理。應用開發者可以參考以下兩種方法為應用開啟文件上傳功能：

* 在 [“附加功能”](additional-features.md) 中開啟文件上傳（僅 ChatFlow 支持）
* 在[“開始節點”](node/start.md)添加文件變量

在附加功能開啟後可以在 chatflow 的節點中引用 sys.file 來使用通過聊天窗上傳的文件。sys.file 的文件變量是臨時的，在多輪對話中會被最新上傳的文件覆蓋，開始節點的文件變量是永遠指向開始節點中對應的文件。

#### File Types

支持以下文件類型與格式：

<table data-header-hidden><thead><tr><th width="227"></th><th></th></tr></thead><tbody><tr><td>文件類型</td><td>支持格式</td></tr><tr><td>文檔</td><td>TXT, MARKDOWN, PDF, HTML, XLSX, XLS, DOCX, CSV, EML, MSG, PPTX, PPT, XML, EPUB.</td></tr><tr><td>圖片</td><td>JPG, JPEG, PNG, GIF, WEBP, SVG.</td></tr><tr><td>音頻</td><td>MP3, M4A, WAV, WEBM, AMR.</td></tr><tr><td>視頻</td><td>MP4, MOV, MPEG, MPGA.</td></tr><tr><td>其他</td><td>自定義後綴名支持</td></tr></tbody></table>

#### 方法一：在應用聊天框中開啟文件上傳（僅適用於 Chatflow）

1.  點擊 Chatflow 應用右上角的 **“功能”** 按鈕即可為應用添加更多功能。

    開啟此功能後，應用使用者可以在應用對話的過程中隨時上傳並更新文件。最多支持同時上傳 10 個文件，每個文件的大小上限為 15MB。

<figure><img src="../../.gitbook/assets/image (379).png" alt=""><figcaption><p>文件上傳功能</p></figcaption></figure>

開啟該功能並不意味著賦予 LLM 直接讀取文件的能力，還需要配備[**文檔提取器**](node/doc-extractor.md)將文檔解析為文本供 LLM 理解。音頻、視頻和其他文件類型暫無對應的提取器，需要應用開發者接入[外部工具](../tools/advanced-tool-integration.md)進行處理。

2. 添加[文檔提取器](node/doc-extractor.md)節點，在輸入變量中選中 `sys.files` 變量。
3. 添加 LLM 節點，在系統提示詞中選中文檔提取器節點的輸出變量。
4. 在末尾添加 “直接回復” 節點，填寫 LLM 節點的輸出變量。

<figure><img src="../../.gitbook/assets/image (380).png" alt=""><figcaption></figcaption></figure>

開啟後，用戶可以在對話框中上傳文件並進行對話。但通過此方式， LLM 應用並不具備記憶文件內容的能力，每次對話時需要上傳文件。

<figure><img src="../../.gitbook/assets/image (381).png" alt=""><figcaption></figcaption></figure>

若希望 LLM 能夠在對話中記憶文件內容，請參考方法二。

#### 方法二：通過添加文件變量開啟文件上傳功能

#### 1. 在“開始”節點添加文件變量

在應用的[“開始”](node/start.md)節點內添加輸入字段，選擇**“單文件”**或**“文件列表”** 字段類型的變量。

{% @arcade/embed flowId="TiLAgL3vgozVhuLBmob9" url="https://app.arcade.software/share/TiLAgL3vgozVhuLBmob9" %}

*   **單文件**

    僅允許應用使用者上傳單個文件。
*   **文件列表**

    允許應用使用者單詞批量上傳多個文件。

> 為了便於操作，將使用單文件變量作為示例。

#### 2. 添加文檔提取器節點

上傳文件後將存儲至單文件變量內，LLM 暫不支持直接讀取變量中的文件。因此需要先添加 [**“文檔提取器”**](node/doc-extractor.md)&#x20;

節點，從已上傳的文檔文件內提取內容併發送至 LLM 節點完成信息處理。

將“開始”節點內的文件變量作為**“文檔提取器”**節點的輸入變量。

<figure><img src="../../.gitbook/assets/截屏2024-10-12 15.45.45.png" alt=""><figcaption><p>添加輸入變量</p></figcaption></figure>

將“文檔提取器”節點的輸出變量填寫至 LLM 節點的系統提示詞內。

<figure><img src="../../.gitbook/assets/image (376).png" alt=""><figcaption><p>粘貼系統提示詞</p></figcaption></figure>

完成上述設置後，應用的使用者可以在 WebApp 內粘貼文件 URL 或上傳本地文件，然後就文檔內容與 LLM 展開互動。應用使用者可以在對話過程中隨時替換文件，LLM 將獲取最新的文件內容。

<figure><img src="../../.gitbook/assets/image (5).png" alt=""><figcaption><p>粘貼 URL 進行對話</p></figcaption></figure>

### 進階使用

若希望應用能夠支持上傳多種文件，例如允許用戶同時上傳文檔文件、圖片和音視頻文件，此時需要在 “開始節點” 中添加  “文件列表” 變量，並通過“列表操作”節點針對不同的文件類型進行處理。詳細說明請參考[列表操作](node/list-operator.md)節點。

<figure><img src="../../.gitbook/assets/image (378).png" alt=""><figcaption></figcaption></figure>

如需查看更多使用案例，請參考以下內容：

動手實驗室 - 使用文件上傳搭建文章理解助手（上線後替換鏈接）


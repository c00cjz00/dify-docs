# 附加功能

Workflow 和 Chatflow 應用均支持開啟附加功能以增強使用者的交互體驗。例如添加文件上傳入口、給 LLM 應用添加一段自我介紹或使用歡迎語，讓應用使用者獲得更加豐富的交互體驗。

點擊應用右上角的 **“功能”** 按鈕即可為應用添加更多功能。

{% @arcade/embed flowId="a0tbwuEIT5I3y5RdHsJp" url="https://app.arcade.software/share/a0tbwuEIT5I3y5RdHsJp" %}

### Workflow

Workflow 類型應用僅支持 **“圖片上傳”** 功能。開啟後，Workflow 應用的使用頁將出現圖片上傳入口。

{% @arcade/embed flowId="DqlK9RV79K25ElxMq1BJ" url="https://app.arcade.software/share/DqlK9RV79K25ElxMq1BJ" %}

**用法：**

**對於應用使用者而言：**已開啟圖片上傳功能的應用的使用頁將出現上傳按鈕，點擊按鈕或粘貼文件鏈接即可完成圖片上傳，你將會收到 LLM 對於圖片的回答。

**對於應用開發者而言：**開啟文件圖片上傳功能後，使用者所上傳的圖片文件將存儲在 `sys.files` 變量內。接下來添加 LLM 節點，選中具備視覺能力的大模型並在其中開啟 VISION 功能，選擇 `sys.files` 變量，使得 LLM 能夠讀取該圖片文件。

最後在 END 節點內選擇 LLM 節點的輸出變量即可完成設置。

<figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption><p>開啟視覺分析能力</p></figcaption></figure>

### Chatflow

Chatflow 類型應用支持以下功能：

*   **對話開場白**

    讓 AI 主動發送一段話，可以是歡迎語或 AI 的自我介紹，以拉近與使用者的距離。
*   **下一步問題建議**

    在對話完成後，自動添加下一步問題建議，以提升對話的話題深度與頻率。
*   **文字轉語音**

    在問答文字框中添加一個音頻播放按鈕，使用 TTS 服務（需在[模型供應商](../../getting-started/readme/model-providers.md)內置）並朗讀其中的文字。
*   **文件上傳**

    支持以下文件類型：文檔、圖片、音頻、視頻以及其它文件類型。開啟此功能後，應用使用者可以在應用對話的過程中隨時上傳並更新文件。最多支持同時上傳 10 個文件，每個文件的大小上限為 15MB。

    <figure><img src="../../.gitbook/assets/image (8).png" alt=""><figcaption><p>文件上傳功能</p></figcaption></figure>


*   **引用和歸屬**

    常用於配合[“知識檢索”](node/knowledge-retrieval.md)節點共同使用，顯示 LLM 給出答覆的參考源文檔及歸屬部分。
*   **內容審查**

    支持使用審查 API 維護敏感詞庫，確保 LLM 能夠迴應和輸出安全內容，詳細說明請參考[敏感內容審查](../application-orchestrate/app-toolkits/moderation-tool.md)。

**用法：**

除了**文件上傳**功能以外，Chatflow 應用內的其它功能用法較為簡單，開啟後可以在應用交互頁直觀使用。

本章節將主要介紹**文件上傳**功能的具體用法：

**對於應用使用者而言：**已開啟文件上傳功能的 Chatflow 應用將會在對話框右側出現 “回形針” 標識，點擊後即可上傳文件並與 LLM 交互。

<figure><img src="../../.gitbook/assets/image (9).png" alt=""><figcaption><p>使用文件上傳</p></figcaption></figure>

**對於應用開發者而言：**

開啟文件上傳功能後，使用者所上傳的文件將存儲在 `sys.files` 變量內。如果用戶在對話的過程中上傳了新文件，該變量中的文件將會被覆蓋。

根據上傳的文件差異，不同類型的文件對應不同的應用編排方式。

* **文檔文件**

LLM 並不具備直接讀取文檔文件的能力，因此需要使用 [文檔提取器](node/doc-extractor.md) 節點預處理 `sys.files` 變量內的文件。編排步驟如下：

1. 開啟 Features 功能，並在文件類型中僅勾選 “文檔”。
2. 在[文檔提取器](node/doc-extractor.md)節點的輸入變量中選中 `sys.files` 變量。
3. 添加 LLM 節點，在系統提示詞中選中文檔提取器節點的輸出變量。
4. 在末尾添加 “直接回復” 節點，填寫 LLM 節點的輸出變量。

使用此方法搭建出的 Chatflow 應用無法記憶已上傳的文件內容。應用使用者每次對話時都需要在聊天框中上傳文檔文件。如果你希望應用能夠記憶已上傳的文件，請參考 [《文件上傳：在開始節點添加變量》](file-upload.md#fang-fa-er-zai-tian-jia-wen-jian-bian-liang)。

<figure><img src="../../.gitbook/assets/image (372).png" alt=""><figcaption><p>文檔文件編排</p></figcaption></figure>

* **圖片文件**

部分 LLM 支持直接獲取圖片中的信息，因此無需添加額外節點處理圖片。

編排步驟如下：

1. 開啟 Features 功能，並在文件類型中僅勾選 “圖片”。
2. 添加 LLM 節點，啟 VISION 功能並選擇 `sys.files` 變量。
3. 在末尾添加 “直接回復” 節點，填寫 LLM 節點的輸出變量。

<figure><img src="../../.gitbook/assets/image (3).png" alt=""><figcaption><p>開啟視覺分析能力</p></figcaption></figure>

* **混合文件類型**

若希望應用具備同時處理文檔文件 + 圖片文件的能力，需要用到 [列表操作](node/list-operator.md) 節點預處理 `sys.files` 變量內的文件，提取更加精細的變量後發送至對應的處理節點。編排步驟如下：

1. 開啟 Features 功能，並在文件類型中勾選 “圖片” + “文檔文件” 類型。
2. 添加兩個列表操作節點，在 “過濾” 條件中提取圖片與文檔變量。
3. 提取文檔文件變量，傳遞至 “文檔提取器” 節點；提取圖片文件變量，傳遞至 “LLM” 節點。
4. 在末尾添加 “直接回復” 節點，填寫 LLM 節點的輸出變量。

應用使用者同時上傳文檔文件和圖片後，文檔文件自動分流至文檔提取器節點，圖片文件自動分流至 LLM 節點以實現對於文件的共同處理。

<figure><img src="../../.gitbook/assets/image (16).png" alt=""><figcaption><p>混合文件處理</p></figcaption></figure>

* **音視頻文件**

&#x20;LLM 尚未支持直接讀取音視頻文件，Dify 平臺也尚未內置相關文件處理工具。應用開發者可以參考 [外部數據工具](../extension/api-based-extension/external-data-tool.md) 接入工具自行處理文件信息。



### 常見問題

**在 Dify Cloud 中，應用使用者在聊天框中上傳的文件將保存多久？**

持久保存。




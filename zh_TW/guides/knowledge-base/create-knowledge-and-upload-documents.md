# 創建知識庫&上傳文檔

創建知識庫並上傳文檔大致分為以下步驟**：**

1. 在 Dify 團隊內創建知識庫，從本地選擇你需要上傳的文檔；
2. 選擇分段與清洗模式，預覽效果；
3. 配置索引方式和檢索設置；
4. 等待分段嵌入；
5. 完成上傳，在應用內關聯並使用 🎉

以下是各個步驟的詳細說明：

### 1 創建知識庫

在 Dify 主導航欄中點擊知識庫，在該頁面你可以看到團隊內的知識庫，點擊“**創建知識庫”** 進入創建嚮導。

* 拖拽或選中文件進行上傳，批量上傳的文件數量取決於[訂閱計劃](https://dify.ai/pricing);
* 如果還沒有準備好文檔，可以先創建一個空知識庫;
* 如果你在創建知識庫時選擇了使用外部數據源（Notion 或同步 Web 站點），該知識庫的類型不可更改；此舉是為了防止單一知識庫存在多數據源而造成的管理困難。如果你需要使用多個數據源，建議創建多個知識庫並使用 [多路召回](https://docs.dify.ai/v/zh-hans/guides/knowledge-base/integrate-knowledge-within-application#duo-lu-zhao-hui-tui-jian) 模式在同一個應用內引用多個知識庫。

**上傳文檔存在以下限制：**

* 單文檔的上傳大小限制為 15MB；
* SaaS 版本的不同[訂閱計劃](https://dify.ai/pricing)限定了**批量上傳個數、文檔上傳總數、向量存儲空間。**

<figure><img src="../../.gitbook/assets/image (371) (1).png" alt=""><figcaption><p>創建知識庫</p></figcaption></figure>

***

### 2 選擇分段與清洗策略

將內容上傳至知識庫後，需要先對內容進行分段與數據清洗，該階段可以被理解為是對內容預處理與結構化。

<details>

<summary>什麼是分段與清洗？</summary>

* **分段**

大語言模型存在有限的上下文窗口，無法將知識庫中的所有內容發送至 LLM。因此可以將整段長文本分段處理，再基於用戶問題，召回與關聯度最高的段落內容，即採用分段 TopK 召回模式。此外，將用戶問題與文本分段進行語義匹配時，合適的分段大小有助於找到知識庫內關聯性最高的文本內容，減少信息噪音。

* **清洗**

為了保證文本召回的效果，通常需要在將數據錄入知識庫之前便對其進行清理。例如，如果文本內容中存在無意義的字符或者空行，可能會影響問題回覆的質量。關於 Dify 內置的清洗策略，詳細說明請參考 [ETL](create-knowledge-and-upload-documents.md#etl)。

</details>

支持以下兩種策略：

* **自動分段與清洗**
* **自定義**

{% tabs %}
{% tab title="自動分段與清洗" %}
#### 自動分段與清洗

自動模式適合對分段規則與預處理規則尚不熟悉的初級用戶。在該模式下，Dify 將為你自動分段與清洗內容文件。

<figure><img src="../../.gitbook/assets/image (372) (1).png" alt=""><figcaption><p>自動分段與清洗</p></figcaption></figure>
{% endtab %}

{% tab title="自定義" %}
#### 自定義

自定義模式適合對於文本處理有明確需求的進階用戶。在自定義模式下，你可以根據不同的文檔格式和場景要求，手動配置文本的分段規則和清洗策略。

**分段規則：**

* **分段標識符**，指定標識符，系統將在文本中出現該標識符時分段。例如填寫 `\n`（[正則表達式](https://regexr.com/)中的換行符），文本換行時將自動分段；
* **分段最大長度**，根據分段的文本字符數最大上限來進行分段，超出該長度時將強制分段。一個分段的最大長度為 4000 Tokens；
* **分段重疊長度**，分段重疊指的是在對數據進行分段時，段與段之間存在一定的重疊部分。這種重疊可以幫助提高信息的保留和分析的準確性，提升召回效果。建議設置為分段長度 Tokens 數的 10-25%；

**文本預處理規則：**文本預處理規則可以幫助過濾知識庫內部分無意義的內容。

* 替換連續的空格、換行符和製表符；
* 刪除所有 URL 和電子郵件地址；

<figure><img src="../../.gitbook/assets/image (373) (1).png" alt=""><figcaption><p>Custom mode</p></figcaption></figure>
{% endtab %}
{% endtabs %}

### 3 索引方式

指定內容的預處理方法（分段與清洗）後，接下來需要指定對結構化內容的索引方式。索引方式將直接影響 LLM 對知識庫內容的檢索效率以及回答的準確性。

系統提供以下三種索引方式，你可以根據實際需求調整每種方式內的[檢索設置](create-knowledge-and-upload-documents.md#id-4-jian-suo-she-zhi)：

* 高質量
* 經濟
* Q\&A 模式\


{% tabs %}
{% tab title="高質量" %}
在高質量模式下，將首先調用 Embedding 嵌入模型（支持切換）將已分段的文本轉換為數字向量，幫助開發者更有效地實現大量文本信息的壓縮與存儲；同時還能夠在用戶與 LLM 對話時提供更高的準確度。

> 如需瞭解更多，請參考[《Embedding 技術與 Dify》](https://mp.weixin.qq.com/s/vmY\_CUmETo2IpEBf1nEGLQ)。

高質量索引方式提供向量檢索、全文檢索和混合檢索三種檢索設置。關於更多檢索設置的說明，請閱讀 [檢索設置](create-knowledge-and-upload-documents.md#id-4-jian-suo-she-zhi)。

<figure><img src="../../.gitbook/assets/image (374) (1).png" alt=""><figcaption><p>高質量模式</p></figcaption></figure>
{% endtab %}

{% tab title="經濟" %}
使用離線的向量引擎與關鍵詞索引方式，降低了準確度但無需額外花費 Token，產生費用。檢索方式僅提供倒排索引，詳細說明請閱讀[下文](create-knowledge-and-upload-documents.md#dao-pai-suo-yin)。

<figure><img src="broken-reference" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Q&A 模式（僅社區版支持）" %}
在知識庫上傳文檔時，系統將對文本進行分段，總結後為每分段生成 Q\&A 匹配對。與高質量與經濟模式中所採用的「Q to P」（用戶問題匹配文本段落）策略不同，QA 模式採用 「Q to Q」（問題匹配問題）策略。

這是因為問題文本**通常是是具有完整語法結構的自然語言**，Q to Q 的模式會令語意和匹配更加清晰，並同時滿足一些高頻和高相似度問題的提問場景。

當用戶提問時，系統會找出與之最相似的問題，然後返回對應的分段作為答案。這種方式更加精確，因為它直接針對用戶問題進行匹配，可以更準確地幫助用戶檢索真正需要的信息。

<figure><img src="broken-reference" alt=""><figcaption><p>Q&#x26;A 分段模式下被總結成多個 Q&#x26;A 對的文本</p></figcaption></figure>

<figure><img src="broken-reference" alt=""><figcaption><p>Q to P 與 Q to Q 的索引模式區別</p></figcaption></figure>


{% endtab %}
{% endtabs %}

***

### 4 檢索設置

在**高質量索引方式**下，Dify 提供以下 3 種檢索方案：

* #### **向量檢索**
* **全文檢索**
* **混合檢索**

{% tabs %}
{% tab title="向量檢索" %}
**定義：**向量化用戶輸入的問題並生成查詢向量，比較查詢向量與知識庫內對應的文本向量距離，尋找最近的分段內容。

<figure><img src="broken-reference" alt=""><figcaption><p>向量檢索</p></figcaption></figure>

**向量檢索設置：**

**Rerank 模型：**使用第三方 Rerank 模型對向量檢索召回後的分段再一次進行語義重排序，優化排序結果。在“模型供應商”頁面配置 Rerank 模型的 API 祕鑰之後，在檢索設置中打開“Rerank 模型”。

**TopK：**用於篩選與用戶問題相似度最高的文本片段。系統同時會根據選用模型上下文窗口大小動態調整片段數量。默認值為 3，數值越高，預期被召回的文本分段數量越多。

**Score 閾值：**用於設置文本片段篩選的相似度閾值，只召回超過設置分數的文本片段，默認值為 0.5。數值越高說明對於文本與問題要求的相似度越高，預期被召回的文本數量也越少。

> TopK 和 Score 設置僅在 Rerank 步驟生效，因此需要添加並開啟 Rerank 模型才能應用兩者中的設置。
{% endtab %}

{% tab title="全文檢索" %}
**定義：**關鍵詞檢索，即索引文檔中的所有詞彙。用戶輸入問題後，通過明文關鍵詞匹配知識庫內對應的文本片段，返回符合關鍵詞的文本片段；類似搜索引擎中的明文檢索。

<figure><img src="broken-reference" alt=""><figcaption><p>全文檢索</p></figcaption></figure>

**Rerank 模型：**使用第三方 Rerank 模型對全文檢索召回後的分段再一次進行語義重排序，優化排序結果。在“模型供應商”頁面配置 Rerank 模型的 API 祕鑰之後，在檢索設置中打開“Rerank 模型”。

**TopK：**用於篩選與用戶問題相似度最高的文本片段。系統同時會根據選用模型上下文窗口大小動態調整片段數量。系統默認值為 3 。數值越高，預期被召回的文本分段數量越多。

**Score 閾值：**用於設置文本片段篩選的相似度閾值，只召回超過設置分數的文本片段，默認值為 0.5。數值越高說明對於文本與問題要求的相似度越高，預期被召回的文本數量也越少。

> TopK 和 Score 設置僅在 Rerank 步驟生效，因此需要添加並開啟 Rerank 模型才能應用兩者中的設置。
{% endtab %}

{% tab title="混合檢索" %}
**定義：**同時執行全文檢索和向量檢索，並應用重排序步驟，從兩類查詢結果中選擇匹配用戶問題的最佳結果。在此模式下可以指定“權重設置”（無需配置 Rerank 模型 API）或選擇 Rerank 模型進行檢索。

<figure><img src="broken-reference" alt=""><figcaption><p>混合檢索</p></figcaption></figure>

在混合檢索設置內可以選擇啟用**“權重設置”**或**“Rerank 模型”**。

**權重設置：**允許用戶賦予語義優先和關鍵詞優先自定義的權重。關鍵詞檢索指的是在知識庫內進行全文檢索（Full Text Search），語義檢索指的是在知識庫內進行向量檢索（Vector Search）。

* **語義值為 1**

僅啟用語義檢索模式。藉助 Embedding 模型，即便知識庫中沒有出現查詢中的確切詞彙，也能通過計算向量距離的方式提高搜索的深度，返回正確內容。此外，當需要處理多語言內容時，語義檢索能夠捕捉不同語言之間的意義轉換，提供更加準確的跨語言搜索結果。

> 語義檢索指的是比對用戶問題與知識庫內容中的向量距離。距離越近，匹配的概率越大。參考閱讀：[《Dify：Embedding 技術與 Dify 數據集設計/規劃》](https://mp.weixin.qq.com/s/vmY\_CUmETo2IpEBf1nEGLQ)。

* **關鍵詞值為 1**

僅啟用關鍵詞檢索模式。通過用戶輸入的信息文本在知識庫全文匹配，適用於用戶知道確切的信息或術語的場景。該方法所消耗的計算資源較低，適合在大量文檔的知識庫內快速檢索。

* **自定義關鍵詞和語義權重**

除了僅啟用語義檢索或關鍵詞檢索模式，我們還提供了靈活的自定義權重設置。你可以通過不斷調試二者的權重，找到符合業務場景的最佳權重比例。

***

**Rerank 模型：**你可以在“模型供應商”頁面配置 Rerank 模型的 API 祕鑰之後，在檢索設置中打開“Rerank 模型”，系統會在混合檢索後對已召回的文檔結果再一次進行語義重排序，優化排序結果。

***

**“權重設置”**和**“Rerank 模型”**設置內支持啟用以下選項：

**TopK：**用於篩選與用戶問題相似度最高的文本片段。系統同時會根據選用模型上下文窗口大小動態調整片段數量。系統默認值為 3 。數值越高，預期被召回的文本分段數量越多。

**Score 閾值：**用於設置文本片段篩選的相似度閾值，即：只召回超過設置分數的文本片段。系統默認關閉該設置，即不會對召回的文本片段相似值過濾。打開後默認值為 0.5。數值越高，預期被召回的文本數量越少。
{% endtab %}
{% endtabs %}

***

在**經濟索引方式**下，Dify 僅提供 1 種檢索設置：

#### **倒排索引**

倒排索引是一種用於快速檢索文檔中關鍵詞的索引結構，它的基本原理是將文檔中的關鍵詞映射到包含這些關鍵詞的文檔列表，從而提高搜索效率。具體原理請參考[《倒排索引》](https://zh.wikipedia.org/wiki/%E5%80%92%E6%8E%92%E7%B4%A2%E5%BC%95)。

**TopK：**用於篩選與用戶問題相似度最高的文本片段。系統同時會根據選用模型上下文窗口大小動態調整片段數量。系統默認值為 3 。數值越高，預期被召回的文本分段數量越多。

<figure><img src="broken-reference" alt=""><figcaption><p>倒排索引</p></figcaption></figure>

指定檢索設置後，你可以參考 [retrieval-test-and-citation.md](retrieval-test-and-citation.md "mention") 查看關鍵詞與內容塊的匹配情況。

### 5 完成上傳

配置完上文所述的各項配置後，輕點“保存並處理”即可完成知識庫的創建。你可以參考 [在應用內集成知識庫](integrate-knowledge-within-application.md)，搭建出能夠基於知識庫進行問答的 LLM 應用。

***

### 參考閱讀

#### ETL

在 RAG 的生產級應用中，為了獲得更好的數據召回效果，需要對多源數據進行預處理和清洗，即 ETL （_extract, transform, load_）。為了增強非結構化/半結構化數據的預處理能力，Dify 支持了可選的 ETL 方案：**Dify ETL** 和[ ](https://docs.unstructured.io/welcome)[**Unstructured ETL** ](https://unstructured.io/)。Unstructured 能夠高效地提取並轉換您的數據為乾淨的數據用於後續的步驟。Dify 各版本的 ETL 方案選擇：

* SaaS 版不可選，默認使用 Unstructured ETL；
* 社區版可選，默認使用 Dify ETL ，可通過[環境變量](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/environments#zhi-shi-ku-pei-zhi)開啟 Unstructured ETL；

文件解析支持格式的差異：

| DIFY ETL                                       | Unstructured ETL                                                         |
| ---------------------------------------------- | ------------------------------------------------------------------------ |
| txt、markdown、md、pdf、html、htm、xlsx、xls、docx、csv | txt、markdown、md、pdf、html、htm、xlsx、xls、docx、csv、eml、msg、pptx、ppt、xml、epub |

不同的 ETL 方案在文件提取效果的方面也會存在差異，想了解更多關於 Unstructured ETL 的數據處理方式，請參考[官方文檔](https://docs.unstructured.io/open-source/core-functionality/partitioning)。

***

**Embedding 模型**

**Embedding 嵌入**是一種將離散型變量（如單詞、句子或者整個文檔）轉化為連續的向量表示的技術。它可以將高維數據（如單詞、短語或圖像）映射到低維空間，提供一種緊湊且有效的表示方式。這種表示不僅減少了數據的維度，還保留了重要的語義信息，使得後續的內容檢索更加高效。

**Embedding 模型**是一種專門用於將文本向量化的大語言模型，它擅長將文本轉換為密集的數值向量，有效捕捉語義信息。

> 如需瞭解更多，請參考：[《Dify：Embedding 技術與 Dify 數據集設計/規劃》](https://mp.weixin.qq.com/s/vmY\_CUmETo2IpEBf1nEGLQ)。

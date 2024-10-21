# 知識庫管理與文檔維護

## 知識庫管理

> 知識庫管理頁僅面向團隊所有者、團隊管理員、編輯權限角色開放。

在 Dify 團隊首頁中，點擊頂部的 “知識庫” tab 頁，選擇需要管理的知識庫，輕點左側導航中的**設置**進行調整。你可以調整知識庫名稱、描述、可見權限、索引模式、Embedding 模型和檢索設置。

<figure><img src="../../.gitbook/assets/image (8) (1).png" alt=""><figcaption><p>知識庫設置</p></figcaption></figure>

**知識庫名稱**，用於區分不同的知識庫。

**知識庫描述**，用於描述知識庫內文檔代表的信息。

**可見權限**，提供 **「 只有我 」** 、 **「 所有團隊成員 」** 和 **「部分團隊成員」** 三種權限範圍。不具有權限的人將無法訪問該知識庫。若選擇將知識庫公開至其它成員，則意味著其它成員同樣具備該知識庫的查看、編輯和刪除權限。

**索引模式**，詳細說明請[參考文檔](https://docs.dify.ai/v/zh-hans/guides/knowledge-base/create-knowledge-and-upload-documents#id-5-suo-yin-fang-shi)。

**Embedding 模型**， 修改知識庫的嵌入模型，修改 Embedding 模型將對知識庫內的所有文檔重新嵌入，原先的嵌入將會被刪除。

**檢索設置**，詳細說明請[參考文檔](https://docs.dify.ai/v/zh-hans/guides/knowledge-base/create-knowledge-and-upload-documents#id-6-jian-suo-she-zhi)。

***

### 使用 API 維護知識庫

Dify 知識庫提供整套標準 API ，開發者通過 API 調用對知識庫內的文檔、分段進行增刪改查等日常管理維護操作，請參考[知識庫 API 文檔](maintain-dataset-via-api.md)。

<figure><img src="../../.gitbook/assets/image (231).png" alt=""><figcaption><p>知識庫 API 管理</p></figcaption></figure>

## 維護知識庫中的文本

### 添加文檔

知識庫（Knowledge）是一些文檔（Documents）的集合。文檔可以由開發者或運營人員上傳，或由同步其它數據源（對應數據源中的一個文件單位，例如 Notion 庫內的一篇文檔或新的在線文檔網頁）。

點擊 「知識庫」 > 「文檔列表 ，然後輕點 「 添加文件 」，即可在已創建的知識庫內上傳新的文檔。

<figure><img src="../../.gitbook/assets/image (10) (1).png" alt=""><figcaption><p>在知識庫內上傳新文檔</p></figcaption></figure>

***

### 禁用或歸檔文檔

**禁用**：數據集支持將暫時不想被索引的文檔或分段進行禁用，在數據集文檔列表，點擊禁用按鈕，則文檔被禁用；也可以在文檔詳情，點擊禁用按鈕，禁用整個文檔或某個分段，禁用的文檔將不會被索引。禁用的文檔點擊啟用，可以取消禁用。

**歸檔**：一些不再使用的舊文檔數據，如果不想刪除可以將它進行歸檔，歸檔後的數據就只能查看或刪除，不可以進行編輯。在數據集文檔列表，點擊歸檔按鈕，則文檔被歸檔，也可以在文檔詳情，歸檔文檔。歸檔的文檔將不會被索引。歸檔的文檔也可以點擊撤銷歸檔。

***

### 查看文本分段

知識庫內已上傳的每個文檔都會以文本分段（Chunks）的形式進行存儲，你可以在分段列表內查看每一個分段的具體文本內容。

<figure><img src="../../.gitbook/assets/image (88).png" alt=""><figcaption><p>查看已上傳的文檔分段</p></figcaption></figure>

***

### 檢查分段質量

文檔分段對於知識庫應用的問答效果有明顯影響，在將知識庫與應用關聯之前，建議人工檢查分段質量。

通過字符長度、標識符或者 NLP 語義分段等機器自動化的分段方式雖然能夠顯著減少大規模文本分段的工作量，但分段質量與不同文檔格式的文本結構、前後文的語義聯繫都有關係，通過人工檢查和訂正可以有效彌補機器分段在語義識別方面的缺點。

檢查分段質量時，一般需要關注以下幾種情況：

* **過短的文本分段**，導致語義缺失；

<figure><img src="../../.gitbook/assets/image (234).png" alt="" width="373"><figcaption><p>過短的文本分段</p></figcaption></figure>

* **過長的文本分段**，導致語義噪音影響匹配準確性；

<figure><img src="../../.gitbook/assets/image (237).png" alt="" width="375"><figcaption><p>過長的文本分段</p></figcaption></figure>

* **明顯的語義截斷**，在使用最大分段長度限制時會出現強制性的語義截斷，導致召回時缺失內容；

<figure><img src="../../.gitbook/assets/image (236).png" alt="" width="357"><figcaption><p>明顯的語義截斷</p></figcaption></figure>

***

### 添加文本分段

在分段列表內點擊 「 添加分段 」 ，可以在文檔內自行添加一個或批量添加多個自定義分段。

<figure><img src="../../.gitbook/assets/image (90).png" alt=""><figcaption></figcaption></figure>

批量添加分段時，你需要先下載 CSV 格式的分段上傳模板，並按照模板格式在 Excel 內編輯所有的分段內容，再將 CSV 文件保存後上傳。

<figure><img src="../../.gitbook/assets/image (92).png" alt=""><figcaption><p>批量添加自定義分段</p></figcaption></figure>

***

### ![](<../../.gitbook/assets/image (7) (1).png>)編輯文本分段

在分段列表內，你可以對已添加的分段內容直接進行編輯修改。包括分段的文本內容和關鍵詞。

<figure><img src="../../.gitbook/assets/image (93).png" alt=""><figcaption><p>編輯文檔分段</p></figcaption></figure>

***

### 元數據管理

除了用於標記不同來源文檔的元數據信息，例如網頁數據的標題、網址、關鍵詞、描述等。元數據將被用於知識庫的分段召回過程中，作為結構化字段參與召回過濾或者顯示引用來源。

{% hint style="info" %}
元數據過濾及引用來源功能當前版本尚未支持。
{% endhint %}

<figure><img src="../../.gitbook/assets/image (230).png" alt=""><figcaption><p>元數據管理</p></figcaption></figure>

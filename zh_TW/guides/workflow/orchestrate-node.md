# 編排節點

Chatflow 和 Workflow 類型應用內的節點均可以通過可視化拖拉拽的形式進行編排，支持**串行**和**並行**兩種編排設計模式。

<figure><img src="../../.gitbook/assets/image (336).png" alt=""><figcaption><p>上圖為串行節點流、下圖為並行節點流</p></figcaption></figure>

## 串行設計

該結構要求節點按照預設順序依次執行，每個節點需等待前一個節點完成並輸出結果後才能開始工作，有助於**確保任務按照邏輯順序執行。**

例如，在一個採用串行結構設計的“小說生成” AI 應用內，用戶輸入小說風格、節奏和角色後，LLM 按照順序補全小說大綱、小說劇情和結尾；每個節點都基於前一個節點的輸出結果展開工作，確保小說的風格一致性。

### 設計串行結構

點擊兩個節點中間連線的 + 號即可在中間添加一個串行節點；按照順序將節點依次串線連接，最後將線收攏至\*\*“結束”節點\*\*（Workflow）/ **“直接回復”節點**（Chatflow）完成設計。

<figure><img src="../../.gitbook/assets/image (337).png" alt=""><figcaption><p>串行結構</p></figcaption></figure>

### 查看串行結構應用日誌

串行結構應用內的日誌將按照順序展示各個節點的運行情況。點擊對話框右上角的 「查看日誌-追蹤」，查看工作流完整運行過程各節點的輸入 / 輸出、Token 消耗、運行時長等。

<figure><img src="../../.gitbook/assets/image (339).png" alt=""><figcaption><p>串行結構應用日誌</p></figcaption></figure>

## 並行設計

該設計模式允許多個節點在同一時間內共同執行，前置節點可以同時觸發位於並行結構內的多個節點。並行結構內的節點不存在依賴關係，能夠同時執行任務，更好地提升**節點的任務執行效率。**

例如，在某個並行設計的翻譯工作流應用內，用戶輸入源文本觸發工作流後，位於並行結構內的節點將共同收到前置節點的流轉指令，同時開展多語言的翻譯任務，縮短任務的處理耗時。

<figure><img src="../../.gitbook/assets/image (335).png" alt=""><figcaption><p>並行設計</p></figcaption></figure>

### 新建並行結構

你可以參考以下四種方式，通過新建節點或拖拽的方式創建並行結構。

**方式 1**

將鼠標 Hover 至某個節點，顯示 `+` 按鈕，支持新建多個節點，創建後自動形成並行結構。

<figure><img src="../../.gitbook/assets/image (340).png" alt=""><figcaption><p>Type 01</p></figcaption></figure>

**方式 2**

拖拽節點末尾的 `+` 按鈕，拉出連線形成並行結構。

<figure><img src="../../.gitbook/assets/image (341).png" alt=""><figcaption><p>Type 02</p></figcaption></figure>

**方式 3**

如果畫布存在多個節點，通過可視化拖拽的方式組成並行結構。

<figure><img src="../../.gitbook/assets/image (342).png" alt=""><figcaption><p>Type 03</p></figcaption></figure>

**方式 4**

除了在畫布中通過直接添加並行節點或可視化拖拽方式組成並行結構，你也可以在節點右側清單的“下一步”中添加並行節點，自動生成並行結構。

<figure><img src="../../.gitbook/assets/image (343).png" alt=""><figcaption><p>Type 04</p></figcaption></figure>

**Tips：**

* 畫布上的“線”可以被刪除；
* 並行結構的下游節點可以是任意節點；
* 在 Workflow 類型應用內需確定唯一的 “end” 節點；
* Chatflow 類型應用支持添加多個 **“直接回復”** 節點，該類型應用內的所有並行結構在末尾處均需要配置 **“直接回復”** 節點才能正常輸出各個並行結構裡的內容；
* 所有的並行結構都會同時運行；並行結構內的節點處理完任務後即輸出結果，**輸出結果時不存在順序關係**。並行結構越簡單，輸出結果的速度越快。

<figure><img src="../../.gitbook/assets/image (344).png" alt=""><figcaption><p>Chatflow 應用中的並行結構</p></figcaption></figure>

### 設計並行結構應用

下文將展示四種常見的並行節點設計思路。

1. **普通並行**

普通並行指的是 `開始 | 並行結構 | 結束` 三層關係也是並行結構的最小單元。這種結構較為直觀，用戶輸入內容後，工作流能同時執行多條任務。

> 並行分支的上限數為 10 個。

<figure><img src="../../.gitbook/assets/image (345).png" alt=""><figcaption><p>普通並行</p></figcaption></figure>

2. **嵌套並行**

嵌套並行指的是 `開始 | 多個並行結構 | 結束`多層關係，它適用於內部較為複雜的工作流，例如需要在某個節點內請求外部 API，將返回的結果同時交給下游節點處理。

一個工作流內最多支持 3 層嵌套關係。

<figure><img src="../../.gitbook/assets/image (349).png" alt=""><figcaption><p>嵌套並行：2 層嵌套關係</p></figcaption></figure>

3. **條件分支 + 並行**

並行結構也可以和條件分支共同使用。

<figure><img src="../../.gitbook/assets/image (333).png" alt=""><figcaption><p><strong>條件分支 + 並行</strong></p></figcaption></figure>

4. **迭代分支 + 並行**

迭代分支內同樣支持編排並行結構，加速迭代內各節點的執行效率。

<figure><img src="../../.gitbook/assets/image (350).png" alt=""><figcaption><p>迭代分支+並行</p></figcaption></figure>

### 查看並行結構應用日誌

包含並行結構的應用的運行日誌支持以樹狀結構進行展示，你可以摺疊並行節點組以更好地查看各個節點的運行日誌。

<figure><img src="../../.gitbook/assets/image (351).png" alt="" width="315"><figcaption><p>並行結構</p></figcaption></figure>

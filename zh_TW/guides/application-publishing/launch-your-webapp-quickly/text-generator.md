# 文本生成型應用

文本生成類應用是一種根據用戶提供的提示，自動生成高質量文本的應用。它可以生成各種類型的文本，例如文章摘要、翻譯等。

文本生成型應用支持如下功能：

1. 運行一次。
2. 批量運行。
3. 保存運行結果。
4. 生成更多類似結果。

下面我們分別來介紹。

### 運行一次

輸入查詢內容，點擊運行按鈕，右側會生成結果，如下圖所示：

<figure><img src="../../../.gitbook/assets/image (58) (1).png" alt=""><figcaption></figcaption></figure>

在生成的結果部分，點 “複製” 按鈕可以將內容複製到剪貼板。點 “保存” 按鈕可以保存內容。可以在 “已保存” 選項卡中看到保存過的內容。也可以對生成的內容點 “贊” 和 “踩”。

### 批量運行

有時，我們需要運行一個應用很多次。比如：有個 Web 應用可以根據主題來生成文章。現在要生成 100 篇不同主題的文章。那麼這個任務要做 100 次，很麻煩。而且，必須等一個任務完成才能開始下一個任務。

上面的場景，用批量運行功能，操作便利(把主題錄入一個 `csv` 文件，只需執行一次)，也節約了生成的時間(多個任務同時運行)。使用方式如下：

#### 第 1 步 進入批量運行頁面

點擊 “批量運行” 選項卡，則會進入批量運行頁面。

<figure><img src="../../../.gitbook/assets/image (73) (1).png" alt=""><figcaption></figcaption></figure>

#### 第 2 步 下載模版並填寫內容

點擊下載模版按鈕，下載模版。編輯模版，填寫內容，並另存為 `.csv` 格式的文件。

<figure><img src="../../../.gitbook/assets/image (36) (1).png" alt=""><figcaption></figcaption></figure>

#### 第 3 步 上傳文件並運行

<figure><img src="../../../.gitbook/assets/image (70) (1).png" alt=""><figcaption></figcaption></figure>

如果需要導出生成的內容，可以點右上角的下載 “按鈕” 來導出為 `csv` 文件。

**注意:** 上傳的的 `csv` 文件的編碼必須是 `Unicode` 的編碼。否則會運行結果失敗。解決方案：用 Excel，WPS 等導出為 `csv` 文件時，編碼選擇 `Unicode`。

### 保存運行結果

點擊生成結果下面的 “保存” 按鈕，可以保存運行結果。在 “已保存” 選項卡中，可以看到所有已保存的內容。

<figure><img src="../../../.gitbook/assets/image (57) (1).png" alt=""><figcaption></figcaption></figure>

### 生成更多類似結果

如果在應用編排時開啟了 “更多類似” 的功能。在 Web 應用中可以點擊 “更多類似” 的按鈕來生成和當前結果相似的內容。如下圖所示：

<figure><img src="../../../.gitbook/assets/image (39) (1).png" alt=""><figcaption></figcaption></figure>

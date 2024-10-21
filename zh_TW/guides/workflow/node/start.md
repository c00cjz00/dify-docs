# 開始

### 定義

為啟動工作流設置初始參數。

在開始節點中，您可以自定義啟動工作流的輸入變量。每個工作流都需要一個開始節點。

<figure><img src="../../../.gitbook/assets/image (236) (1).png" alt="" width="375"><figcaption><p>工作流開始節點</p></figcaption></figure>

開始節點支持定義四種類型輸入變量：

* 文本
* 段落
* 下拉選項
* 數字
* 文件（即將推出）

<figure><img src="../../../.gitbook/assets/output (2) (1) (1).png" alt=""><figcaption><p>配置開始節點的變量</p></figcaption></figure>

配置完成後，工作流在執行時將提示您提供開始節點中定義的變量值。

<figure><img src="../../../.gitbook/assets/output (3) (1).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Tip: 在Chatflow中，開始節點提供了內置系統變量：`sys.query` 和 `sys.files`。

`sys.query` 用於對話應用中的用戶輸入問題。

`sys.files` 用於對話中的文件上傳，如上傳圖片，這需要與圖片理解模型配合使用。
{% endhint %}

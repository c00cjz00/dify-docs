# 直接回復

### 定義

定義一個 Chatflow 流程中的回覆內容。

你可以在文本編輯器中自由定義回覆格式，包括自定義一段固定的文本內容、使用前置步驟中的輸出變量作為回覆內容、或者將自定義文本與變量組合後回覆。

可隨時加入節點將內容流式輸出至對話回覆，支持所見即所得配置模式並支持圖文混排，如：

1. 輸出 LLM 節點回復內容
2. 輸出生成圖片
3. 輸出純文本

**示例1：**輸出純文本

<figure><img src="../../../.gitbook/assets/output (2) (2).png" alt=""><figcaption></figcaption></figure>

**示例2：**輸出圖片+LLM回覆

<figure><img src="../../../.gitbook/assets/image (95).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (96).png" alt="" width="275"><figcaption></figcaption></figure>

{% hint style="info" %}
直接回復節點可以不作為最終的輸出節點，作為流程過程節點時，可以在中間步驟流式輸出結果。
{% endhint %}

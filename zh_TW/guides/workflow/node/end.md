# 結束

### 定義

定義一個工作流程結束的最終輸出內容。每一個工作流在完整執行後都需要至少一個結束節點，用於輸出完整執行的最終結果。

結束節點為流程終止節點，後面無法再添加其他節點，工作流應用中只有運行到結束節點才會輸出執行結果。若流程中出現條件分叉，則需要定義多個結束節點。

結束節點需要聲明一個或多個輸出變量，聲明時可以引用任意上游節點的輸出變量。

{% hint style="info" %}
Chatflow 內不支持結束節點
{% endhint %}

***

### 場景

在以下[長故事生成工作流](iteration.md#shi-li-2-chang-wen-zhang-die-dai-sheng-cheng-qi-ling-yi-zhong-bian-pai-fang-shi)中，結束節點聲明的變量 `Output` 為上游代碼節點的輸出，即該工作流會在 Code3 節點執行完成之後結束，並輸出 Code3 的執行結果。

<figure><img src="../../../.gitbook/assets/image (284).png" alt=""><figcaption><p>結束節點-長故事生成示例</p></figcaption></figure>

**單路執行示例：**

<figure><img src="../../../.gitbook/assets/output (5).png" alt=""><figcaption></figcaption></figure>

**多路執行示例：**

<figure><img src="../../../.gitbook/assets/output (1) (3).png" alt=""><figcaption></figcaption></figure>

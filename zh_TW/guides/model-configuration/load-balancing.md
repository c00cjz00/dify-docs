# 負載均衡

模型速率限制（Rate limits）是模型廠商對用戶或客戶在指定時間內訪問 API 服務次數所添加的限制。它有助於防止 API 的濫用或誤用，有助於確保每個用戶都能公平地訪問 API，控制基礎設施的總體負載。

在企業級大規模調用模型 API 時，高併發請求會導致超過請求速率限制並影響用戶訪問。負載均衡可以通過在多個 API 端點之間分配 API 請求，確保所有用戶都能獲得最快的響應和最高的模型調用吞吐量，保障業務穩定運行。

你可以在 **模型供應商 -- 模型列表 -- 設置模型負載均衡** 打開該功能，並在同一個模型上添加多個憑據 (API key)。

<figure><img src="../../.gitbook/assets/image (60).png" alt="" width="563"><figcaption><p>模型負載均衡</p></figcaption></figure>

{% hint style="info" %}
模型負載均衡為付費特性，您可以通過[訂閱 SaaS 付費服務](../../getting-started/cloud.md#ding-yue-ji-hua)或者購買企業版來開啟該功能。
{% endhint %}

默認配置中的 API Key 為初次配置模型供應商時添加的憑據，您需要點擊 **增加配置** 添加同一模型的不同 API Key 來正常使用負載均衡功能。

<figure><img src="../../.gitbook/assets/image (61).png" alt="" width="563"><figcaption><p>配置負載均衡</p></figcaption></figure>

**需要額外添加至少 1 個模型憑據**即可保存並開啟負載均衡。

你也可以將已配置的憑據**臨時停用**或者**刪除**。

<figure><img src="../../.gitbook/assets/image (65).png" alt="" width="563"><figcaption></figcaption></figure>

配置完成後再模型列表內會顯示所有已開啟負載均衡的模型。

<figure><img src="../../.gitbook/assets/image (64).png" alt="" width="563"><figcaption><p>開啟負載均衡</p></figcaption></figure>

{% hint style="info" %}
默認情況下，負載均衡使用 Round-robin 策略。如果觸發速率限制，將應用 1 分鐘的冷卻時間。
{% endhint %}

你也可以從 **添加模型** 配置負載均衡，配置流程與上面一致。

<figure><img src="../../.gitbook/assets/image (57).png" alt="" width="563"><figcaption><p>從添加模型配置負載均衡</p></figcaption></figure>

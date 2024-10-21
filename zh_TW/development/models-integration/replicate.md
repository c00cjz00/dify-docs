# 接入 Replicate 上的開源模型

Dify 支持接入 Replicate 上的 [Language models](https://replicate.com/collections/language-models) 和 [Embedding models](https://replicate.com/collections/embedding-models)。Language models 對應 Dify 的推理模型，Embedding models 對應 Dify 的 Embedding 模型。

具體步驟如下：

1. 你需要有 Replicate 的賬號([註冊地址](https://replicate.com/signin?next=/docs))。
2. 獲取 API Key([獲取地址](https://replicate.com/account/api-tokens))。
3. 挑選模型。在 [Language models](https://replicate.com/collections/language-models) 和 [Embedding models](https://replicate.com/collections/embedding-models) 下挑選模型。
4. 在 Dify 的 `設置 > 模型供應商 > Replicate` 中添加模型。

<figure><img src="../../.gitbook/assets/image (4) (1) (1).png" alt=""><figcaption></figcaption></figure>

API key 為第 2 步中設置的 API Key。Model Name 和 Model Version 可以在模型詳情頁中找到：

<figure><img src="../../.gitbook/assets/image (5) (1) (1).png" alt=""><figcaption></figcaption></figure>

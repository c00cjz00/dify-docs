# 模型

Dify 是基於大語言模型的 AI 應用開發平臺，初次使用時你需要先在 Dify 的 **設置 -- 模型供應商** 頁面內添加並配置所需要的模型。

<figure><img src="../../.gitbook/assets/image (216).png" alt=""><figcaption><p>設置-模型供應商</p></figcaption></figure>

Dify 目前已支持主流的模型供應商，例如 OpenAI 的 GPT 系列、Anthropic 的 Claude 系列等。不同模型的能力表現、參數類型會不一樣，你可以根據不同情景的應用需求選擇你喜歡的模型供應商。**你在 Dify 應用以下模型能力前，應該前往不同的模型廠商官方網站獲得他們的 API key 。**

### 模型類型

在 Dify 中，我們按模型的使用場景將模型分為以下 4 類：

1.  **系統推理模型**。 在創建的應用中，用的是該類型的模型。智聊、對話名稱生成、下一步問題建議用的也是推理模型。

    > 已支持的系統推理模型供應商：[OpenAI](https://platform.openai.com/account/api-keys)、[Azure OpenAI Service](https://azure.microsoft.com/en-us/products/ai-services/openai-service/)、[Anthropic](https://console.anthropic.com/account/keys)、Hugging Face Hub、Replicate、Xinference、OpenLLM、[訊飛星火](https://www.xfyun.cn/solutions/xinghuoAPI)、[文心一言](https://console.bce.baidu.com/qianfan/ais/console/applicationConsole/application)、[通義千問](https://dashscope.console.aliyun.com/api-key\_management?spm=a2c4g.11186623.0.0.3bbc424dxZms9k)、[Minimax](https://api.minimax.chat/user-center/basic-information/interface-key)、ZHIPU(ChatGLM)
2.  **Embedding 模型**。在數據集中，將分段過的文檔做 Embedding 用的是該類型的模型。在使用了數據集的應用中，將用戶的提問做 Embedding 處理也是用的該類型的模型。

    > 已支持的 Embedding 模型供應商：OpenAI、ZHIPU(ChatGLM)、Jina AI([Jina Embeddings](https://jina.ai/embeddings/))
3.  [**Rerank 模型**](https://docs.dify.ai/v/zh-hans/advanced/retrieval-augment/rerank)。**Rerank 模型用於增強檢索能力，改善 LLM 的搜索結果。**

    > 已支持的 Rerank 模型供應商：Cohere、Jina AI([Jina Reranker](https://jina.ai/reranker))
4.  **語音轉文字模型**。將對話型應用中，將語音轉文字用的是該類型的模型。

    > 已支持的語音轉文字模型供應商：OpenAI

根據技術變化和用戶需求，我們將陸續支持更多 LLM 供應商。

### 託管模型試用服務

我們為 Dify 雲服務的用戶提供了不同模型的試用額度，請在該額度耗盡前設置你自己的模型供應商，否則將會影響應用的正常使用。

* **OpenAI 託管模型試用：** 我們提供 200 次調用次數供你試用體驗，可用於 GPT3.5-turbo、GPT3.5-turbo-16k、text-davinci-003 模型。

### 設置默認模型

Dify 在需要模型時，會根據使用場景來選擇設置過的默認模型。在 `設置 > 模型供應商` 中設置默認模型。

<figure><img src="../../.gitbook/assets/image (113).png" alt=""><figcaption></figcaption></figure>

系統默認推理模型(System Reasoning Model)：設置創建應用使用的默認推理模型,以及對話名稱生成、下一步問題建議等功能也會使用該默認推理模型。

### 接入模型設置

在 Dify 的 `設置 > 模型供應商` 中設置要接入的模型。

<figure><img src="../../.gitbook/assets/image-20231210143654461 (1).png" alt=""><figcaption></figcaption></figure>

模型供應商分為兩種：

1. 自有模型。該類型的模型供應商提供的是自己開發的模型。如 OpenAI，Anthropic 等。
2. 託管模型。該類型的模型供應商提供的是第三方模型。如 Hugging Face，Replicate 等。

在 Dify 中接入不同類型的模型供應商的方式稍有不同。

**接入自有模型的模型供應商**

接入自有模型的供應商後，Dify 會自動接入該供應商下的所有模型。

在 Dify 中設置對應模型供應商的 API key，即可接入該模型供應商。

{% hint style="info" %}
Dify 使用了 [PKCS1\_OAEP](https://pycryptodome.readthedocs.io/en/latest/src/cipher/oaep.html) 來加密存儲用戶託管的 API 密鑰，每個租戶均使用了獨立的密鑰對進行加密，確保你的 API 密鑰不被洩漏。
{% endhint %}

**接入托管模型的模型供應商**

託管類型的供應商上面有很多第三方模型。接入模型需要一個個的添加。具體接入方式如下：

* [Hugging Face](../../development/mo-xing-jie-ru/hugging-face.md)
* [Replicate](../../development/mo-xing-jie-ru/replicate.md)
* [Xinference](../../development/mo-xing-jie-ru/xinference.md)
* [OpenLLM](../../development/mo-xing-jie-ru/openllm.md)

### 使用模型

配置完模型後，就可以在應用中使用這些模型了：

<figure><img src="../../.gitbook/assets/image (217).png" alt=""><figcaption></figcaption></figure>

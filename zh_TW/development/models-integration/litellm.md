# 接入 LiteLLM 代理的模型



LiteLLM Proxy 是一個代理服務器，支持以下功能：

* 支持 OpenAI 格式調用 100 多種 LLMs ，包括 OpenAI、Azure、Vertex 和 Bedrock 等。
* 設置 API Key 、預算、速率限制並跟蹤使用情況。

Dify 支持集成 LiteLLM Proxy 上的 LLM 和 Text Embedding 模型。

## **快速集成**

### **步驟 1. 啟動 LiteLLM Proxy 服務器**

LiteLLM 需要一個包含所有定義模型的配置文件，命名為 `litellm_config.yaml`。

如何設置 LiteLLM 配置的詳細文檔 - [點擊這裡](https://example.com)

```yaml
model_list:
  - model_name: deepseek-chat #調用 LiteLLM 的模型名詞
    litellm_params:
      model: openai/deepseek-chat #`openai/` 前綴表示該模型與 openai 格式兼容
      api_key: 
      api_base: https://api.deepseek.com/
  - model_name: gpt-4
    litellm_params:
      model: azure/chatgpt-v-2
      api_base: https://openai-gpt-4-test-v-1.openai.azure.com/
      api_version: "2023-05-15"
      api_key: 
  - model_name: gpt-4
    litellm_params:
      model: azure/gpt-4
      api_key: 
      api_base: https://openai-gpt-4-test-v-2.openai.azure.com/
```

### **步驟 2. 啟動 LiteLLM 代理**

```bash
docker run \
    -v $(pwd)/litellm_config.yaml:/app/config.yaml \
    -p 4000:4000 \
    ghcr.io/berriai/litellm:main-latest \
    --config /app/config.yaml --detailed_debug
```

成功後，代理將在 `http://localhost:4000` 上運行。

### **步驟 3. 在 Dify 中集成 LiteLLM Proxy**

在`設置 > 模型供應商 > OpenAI-API-compatible` 中填寫：

<figure><img src="../../.gitbook/assets/截屏2024-10-11 16.07.39.png" alt=""><figcaption></figcaption></figure>

* **模型名稱**: gpt-4
* **API endpoint URL**: `http://localhost:4000`
  * 輸入 LiteLLM 服務可訪問的基礎 URL。
* **Completion mode**: 對話
* **模型上下文長度**: 4096
  * 模型的最大上下文長度。如果不確定，使用默認值 4096。
* **最大 Token 上限**: 4096
  * 模型返回的最大 Token 數量。如果沒有特定要求，可以與模型上下文長度一致。
* **支持視覺**:&#x20;
  * 如果模型支持圖像理解（多模態），如 gpt4-o，請勾選此選項。

點擊`保存`，在確認無誤後即可在應用程序中使用該模型。

嵌入模型的集成方法與 LLM 類似，只需將模型類型更改為文本嵌入。

**更多信息**

有關 LiteLLM 的更多信息，請參閱：

* [LiteLLM](https://example.com)
* [LiteLLM Proxy Server](https://example.com)

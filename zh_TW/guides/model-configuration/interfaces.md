# 接口方法

這裡介紹供應商和各模型類型需要實現的接口方法和參數說明。

## 供應商

繼承 `__base.model_provider.ModelProvider` 基類，實現以下接口：

```python
def validate_provider_credentials(self, credentials: dict) -> None:
    """
    Validate provider credentials
    You can choose any validate_credentials method of model type or implement validate method by yourself,
    such as: get model list api

    if validate failed, raise exception

    :param credentials: provider credentials, credentials form defined in `provider_credential_schema`.
    """
```

- `credentials` (object) 憑據信息

  憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 定義，傳入如：`api_key` 等。

驗證失敗請拋出 `errors.validate.CredentialsValidateFailedError` 錯誤。

**注：預定義模型需完整實現該接口，自定義模型供應商只需要如下簡單實現即可**

```python
class XinferenceProvider(Provider):
    def validate_provider_credentials(self, credentials: dict) -> None:
        pass
```

## 模型

模型分為 5 種不同的模型類型，不同模型類型繼承的基類不同，需要實現的方法也不同。

### 通用接口

所有模型均需要統一實現下面 2 個方法：

- 模型憑據校驗

  與供應商憑據校驗類似，這裡針對單個模型進行校驗。

  ```python
  def validate_credentials(self, model: str, credentials: dict) -> None:
      """
      Validate model credentials
  
      :param model: model name
      :param credentials: model credentials
      :return:
      """
  ```

  參數：

  - `model` (string) 模型名稱

  - `credentials` (object) 憑據信息

    憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

  驗證失敗請拋出 `errors.validate.CredentialsValidateFailedError` 錯誤。

- 調用異常錯誤映射表

  當模型調用異常時需要映射到 Runtime 指定的 `InvokeError` 類型，方便 Dify 針對不同錯誤做不同後續處理。

  Runtime Errors:

  - `InvokeConnectionError` 調用連接錯誤
  - `InvokeServerUnavailableError ` 調用服務方不可用
  - `InvokeRateLimitError ` 調用達到限額
  - `InvokeAuthorizationError`  調用鑑權失敗
  - `InvokeBadRequestError ` 調用傳參有誤

  ```python
  @property
  def _invoke_error_mapping(self) -> dict[type[InvokeError], list[type[Exception]]]:
      """
      Map model invoke error to unified error
      The key is the error type thrown to the caller
      The value is the error type thrown by the model,
      which needs to be converted into a unified error type for the caller.
  
      :return: Invoke error mapping
      """
  ```

  也可以直接拋出對應 Errors，並做如下定義，這樣在之後的調用中可以直接拋出`InvokeConnectionError`等異常。
  
    ```python
    @property
    def _invoke_error_mapping(self) -> dict[type[InvokeError], list[type[Exception]]]:
        return {
            InvokeConnectionError: [
              InvokeConnectionError
            ],
            InvokeServerUnavailableError: [
              InvokeServerUnavailableError
            ],
            InvokeRateLimitError: [
              InvokeRateLimitError
            ],
            InvokeAuthorizationError: [
              InvokeAuthorizationError
            ],
            InvokeBadRequestError: [
              InvokeBadRequestError
            ],
        }
    ```

​	可參考 OpenAI `_invoke_error_mapping`。  

### LLM

繼承 `__base.large_language_model.LargeLanguageModel` 基類，實現以下接口：

- LLM 調用

  實現 LLM 調用的核心方法，可同時支持流式和同步返回。

  ```python
  def _invoke(self, model: str, credentials: dict,
              prompt_messages: list[PromptMessage], model_parameters: dict,
              tools: Optional[list[PromptMessageTool]] = None, stop: Optional[list[str]] = None,
              stream: bool = True, user: Optional[str] = None) \
          -> Union[LLMResult, Generator]:
      """
      Invoke large language model
  
      :param model: model name
      :param credentials: model credentials
      :param prompt_messages: prompt messages
      :param model_parameters: model parameters
      :param tools: tools for tool calling
      :param stop: stop words
      :param stream: is stream response
      :param user: unique user id
      :return: full response or stream response chunk generator result
      """
  ```

  - 參數：

    - `model` (string) 模型名稱

    - `credentials` (object) 憑據信息
    
      憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

    - `prompt_messages` (array[[PromptMessage](#PromptMessage)]) Prompt 列表
    
      若模型為 `Completion` 類型，則列表只需要傳入一個 [UserPromptMessage](#UserPromptMessage) 元素即可；
    
      若模型為 `Chat` 類型，需要根據消息不同傳入 [SystemPromptMessage](#SystemPromptMessage), [UserPromptMessage](#UserPromptMessage), [AssistantPromptMessage](#AssistantPromptMessage), [ToolPromptMessage](#ToolPromptMessage) 元素列表

    - `model_parameters` (object) 模型參數
    
      模型參數由模型 YAML 配置的 `parameter_rules` 定義。

    - `tools` (array[[PromptMessageTool](#PromptMessageTool)]) [optional] 工具列表，等同於 `function calling` 中的 `function`。
    
      即傳入 tool calling 的工具列表。

    - `stop` (array[string]) [optional] 停止序列
    
      模型返回將在停止序列定義的字符串之前停止輸出。

    - `stream` (bool) 是否流式輸出，默認 True
    
      流式輸出返回 Generator[[LLMResultChunk](#LLMResultChunk)]，非流式輸出返回 [LLMResult](#LLMResult)。

    - `user` (string) [optional] 用戶的唯一標識符
    
      可以幫助供應商監控和檢測濫用行為。

  - 返回

    流式輸出返回 Generator[[LLMResultChunk](#LLMResultChunk)]，非流式輸出返回 [LLMResult](#LLMResult)。

- 預計算輸入 tokens

  若模型未提供預計算 tokens 接口，可直接返回 0。

  ```python
  def get_num_tokens(self, model: str, credentials: dict, prompt_messages: list[PromptMessage],
                     tools: Optional[list[PromptMessageTool]] = None) -> int:
      """
      Get number of tokens for given prompt messages

      :param model: model name
      :param credentials: model credentials
      :param prompt_messages: prompt messages
      :param tools: tools for tool calling
      :return:
      """
  ```

  參數說明見上述 `LLM 調用`。

  該接口需要根據對應`model`選擇合適的`tokenizer`進行計算，如果對應模型沒有提供`tokenizer`，可以使用`AIModel`基類中的`_get_num_tokens_by_gpt2(text: str)`方法進行計算。

- 獲取自定義模型規則 [可選]

  ```python
  def get_customizable_model_schema(self, model: str, credentials: dict) -> Optional[AIModelEntity]:
      """
      Get customizable model schema

      :param model: model name
      :param credentials: model credentials
      :return: model schema
      """
  ```

​當供應商支持增加自定義 LLM 時，可實現此方法讓自定義模型可獲取模型規則，默認返回 None。

對於`OpenAI`供應商下的大部分微調模型，可以通過其微調模型名稱獲取到其基類模型，如`gpt-3.5-turbo-1106`，然後返回基類模型的預定義參數規則，參考[openai](https://github.com/langgenius/dify-runtime/blob/main/lib/model_providers/anthropic/llm/llm.py)
的具體實現

### TextEmbedding

繼承 `__base.text_embedding_model.TextEmbeddingModel` 基類，實現以下接口：

- Embedding 調用

  ```python
  def _invoke(self, model: str, credentials: dict,
              texts: list[str], user: Optional[str] = None) \
          -> TextEmbeddingResult:
      """
      Invoke large language model
  
      :param model: model name
      :param credentials: model credentials
      :param texts: texts to embed
      :param user: unique user id
      :return: embeddings result
      """
  ```

  - 參數：

    - `model` (string) 模型名稱

    - `credentials` (object) 憑據信息

      憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

    - `texts` (array[string]) 文本列表，可批量處理

    - `user` (string) [optional] 用戶的唯一標識符

      可以幫助供應商監控和檢測濫用行為。

  - 返回：

    [TextEmbeddingResult](#TextEmbeddingResult) 實體。

- 預計算 tokens

  ```python
  def get_num_tokens(self, model: str, credentials: dict, texts: list[str]) -> int:
      """
      Get number of tokens for given prompt messages

      :param model: model name
      :param credentials: model credentials
      :param texts: texts to embed
      :return:
      """
  ```

  參數說明見上述 `Embedding 調用`。

  同上述`LargeLanguageModel`，該接口需要根據對應`model`選擇合適的`tokenizer`進行計算，如果對應模型沒有提供`tokenizer`，可以使用`AIModel`基類中的`_get_num_tokens_by_gpt2(text: str)`方法進行計算。

### Rerank

繼承 `__base.rerank_model.RerankModel` 基類，實現以下接口：

- rerank 調用

  ```python
  def _invoke(self, model: str, credentials: dict,
              query: str, docs: list[str], score_threshold: Optional[float] = None, top_n: Optional[int] = None,
              user: Optional[str] = None) \
          -> RerankResult:
      """
      Invoke rerank model
  
      :param model: model name
      :param credentials: model credentials
      :param query: search query
      :param docs: docs for reranking
      :param score_threshold: score threshold
      :param top_n: top n
      :param user: unique user id
      :return: rerank result
      """
  ```

  - 參數：

    - `model` (string) 模型名稱

    - `credentials` (object) 憑據信息

      憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

    - `query` (string) 查詢請求內容

    - `docs` (array[string]) 需要重排的分段列表

    - `score_threshold` (float) [optional] Score 閾值

    - `top_n` (int) [optional] 取前 n 個分段

    - `user` (string) [optional] 用戶的唯一標識符

      可以幫助供應商監控和檢測濫用行為。

  - 返回：

    [RerankResult](#RerankResult) 實體。

### Speech2text

繼承 `__base.speech2text_model.Speech2TextModel` 基類，實現以下接口：

- Invoke 調用

  ```python
  def _invoke(self, model: str, credentials: dict,
              file: IO[bytes], user: Optional[str] = None) \
          -> str:
      """
      Invoke large language model
  
      :param model: model name
      :param credentials: model credentials
      :param file: audio file
      :param user: unique user id
      :return: text for given audio file
      """	
  ```

  - 參數：

    - `model` (string) 模型名稱

    - `credentials` (object) 憑據信息

      憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

    - `file` (File) 文件流

    - `user` (string) [optional] 用戶的唯一標識符

      可以幫助供應商監控和檢測濫用行為。

  - 返回：

    語音轉換後的字符串。

### Text2speech

繼承 `__base.text2speech_model.Text2SpeechModel` 基類，實現以下接口：

- Invoke 調用

  ```python
  def _invoke(self, model: str, credentials: dict, content_text: str, streaming: bool, user: Optional[str] = None):
      """
      Invoke large language model
  
      :param model: model name
      :param credentials: model credentials
      :param content_text: text content to be translated
      :param streaming: output is streaming
      :param user: unique user id
      :return: translated audio file
      """	
  ```

  - 參數：

    - `model` (string) 模型名稱

    - `credentials` (object) 憑據信息

      憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

    - `content_text` (string) 需要轉換的文本內容

    - `streaming` (bool) 是否進行流式輸出

    - `user` (string) [optional] 用戶的唯一標識符

      可以幫助供應商監控和檢測濫用行為。

  - 返回：

    文本轉換後的語音流。

### Moderation

繼承 `__base.moderation_model.ModerationModel` 基類，實現以下接口：

- Invoke 調用

  ```python
  def _invoke(self, model: str, credentials: dict,
              text: str, user: Optional[str] = None) \
          -> bool:
      """
      Invoke large language model
  
      :param model: model name
      :param credentials: model credentials
      :param text: text to moderate
      :param user: unique user id
      :return: false if text is safe, true otherwise
      """
  ```

  - 參數：

    - `model` (string) 模型名稱

    - `credentials` (object) 憑據信息

      憑據信息的參數由供應商 YAML 配置文件的 `provider_credential_schema` 或 `model_credential_schema` 定義，傳入如：`api_key` 等。

    - `text` (string) 文本內容

    - `user` (string) [optional] 用戶的唯一標識符

      可以幫助供應商監控和檢測濫用行為。

  - 返回：

    False 代表傳入的文本安全，True 則反之。



## 實體

### PromptMessageRole 

消息角色

```python
class PromptMessageRole(Enum):
    """
    Enum class for prompt message.
    """
    SYSTEM = "system"
    USER = "user"
    ASSISTANT = "assistant"
    TOOL = "tool"
```

### PromptMessageContentType

消息內容類型，分為純文本和圖片。

```python
class PromptMessageContentType(Enum):
    """
    Enum class for prompt message content type.
    """
    TEXT = 'text'
    IMAGE = 'image'
```

### PromptMessageContent

消息內容基類，僅作為參數聲明用，不可初始化。

```python
class PromptMessageContent(BaseModel):
    """
    Model class for prompt message content.
    """
    type: PromptMessageContentType
    data: str  # 內容數據
```

當前支持文本和圖片兩種類型，可支持同時傳入文本和多圖。

需要分別初始化 `TextPromptMessageContent` 和 `ImagePromptMessageContent` 傳入。

### TextPromptMessageContent

```python
class TextPromptMessageContent(PromptMessageContent):
    """
    Model class for text prompt message content.
    """
    type: PromptMessageContentType = PromptMessageContentType.TEXT
```

若傳入圖文，其中文字需要構造此實體作為 `content` 列表中的一部分。

### ImagePromptMessageContent

```python
class ImagePromptMessageContent(PromptMessageContent):
    """
    Model class for image prompt message content.
    """
    class DETAIL(Enum):
        LOW = 'low'
        HIGH = 'high'

    type: PromptMessageContentType = PromptMessageContentType.IMAGE
    detail: DETAIL = DETAIL.LOW  # 分辨率
```

若傳入圖文，其中圖片需要構造此實體作為 `content` 列表中的一部分

`data` 可以為 `url` 或者圖片 `base64` 加密後的字符串。

### PromptMessage

所有 Role 消息體的基類，僅作為參數聲明用，不可初始化。

```python
class PromptMessage(ABC, BaseModel):
    """
    Model class for prompt message.
    """
    role: PromptMessageRole  # 消息角色
    content: Optional[str | list[PromptMessageContent]] = None  # 支持兩種類型，字符串和內容列表，內容列表是為了滿足多模態的需要，可詳見 PromptMessageContent 說明。
    name: Optional[str] = None  # 名稱，可選。
```

### UserPromptMessage

UserMessage 消息體，代表用戶消息。

```python
class UserPromptMessage(PromptMessage):
    """
    Model class for user prompt message.
    """
    role: PromptMessageRole = PromptMessageRole.USER
```

### AssistantPromptMessage

代表模型返回消息，通常用於 `few-shots` 或聊天曆史傳入。

```python
class AssistantPromptMessage(PromptMessage):
    """
    Model class for assistant prompt message.
    """
    class ToolCall(BaseModel):
        """
        Model class for assistant prompt message tool call.
        """
        class ToolCallFunction(BaseModel):
            """
            Model class for assistant prompt message tool call function.
            """
            name: str  # 工具名稱
            arguments: str  # 工具參數

        id: str  # 工具 ID，僅在 OpenAI tool call 生效，為工具調用的唯一 ID，同一個工具可以調用多次
        type: str  # 默認 function
        function: ToolCallFunction  # 工具調用信息

    role: PromptMessageRole = PromptMessageRole.ASSISTANT
    tool_calls: list[ToolCall] = []  # 模型回覆的工具調用結果（僅當傳入 tools，並且模型認為需要調用工具時返回）
```

其中 `tool_calls` 為調用模型傳入 `tools` 後，由模型返回的 `tool call` 列表。

### SystemPromptMessage

代表系統消息，通常用於設定給模型的系統指令。

```python
class SystemPromptMessage(PromptMessage):
    """
    Model class for system prompt message.
    """
    role: PromptMessageRole = PromptMessageRole.SYSTEM
```

### ToolPromptMessage

代表工具消息，用於工具執行後將結果交給模型進行下一步計劃。

```python
class ToolPromptMessage(PromptMessage):
    """
    Model class for tool prompt message.
    """
    role: PromptMessageRole = PromptMessageRole.TOOL
    tool_call_id: str  # 工具調用 ID，若不支持 OpenAI tool call，也可傳入工具名稱
```

基類的 `content` 傳入工具執行結果。

### PromptMessageTool

```python
class PromptMessageTool(BaseModel):
    """
    Model class for prompt message tool.
    """
    name: str  # 工具名稱
    description: str  # 工具描述
    parameters: dict  # 工具參數 dict
```

---

### LLMResult

```python
class LLMResult(BaseModel):
    """
    Model class for llm result.
    """
    model: str  # 實際使用模型
    prompt_messages: list[PromptMessage]  # prompt 消息列表
    message: AssistantPromptMessage  # 回覆消息
    usage: LLMUsage  # 使用的 tokens 及費用信息
    system_fingerprint: Optional[str] = None  # 請求指紋，可參考 OpenAI 該參數定義
```

### LLMResultChunkDelta

流式返回中每個迭代內部 `delta` 實體

```python
class LLMResultChunkDelta(BaseModel):
    """
    Model class for llm result chunk delta.
    """
    index: int  # 序號
    message: AssistantPromptMessage  # 回覆消息
    usage: Optional[LLMUsage] = None  # 使用的 tokens 及費用信息，僅最後一條返回
    finish_reason: Optional[str] = None  # 結束原因，僅最後一條返回
```

### LLMResultChunk

流式返回中每個迭代實體

```python
class LLMResultChunk(BaseModel):
    """
    Model class for llm result chunk.
    """
    model: str  # 實際使用模型
    prompt_messages: list[PromptMessage]  # prompt 消息列表
    system_fingerprint: Optional[str] = None  # 請求指紋，可參考 OpenAI 該參數定義
    delta: LLMResultChunkDelta  # 每個迭代存在變化的內容
```

### LLMUsage

```python
class LLMUsage(ModelUsage):
    """
    Model class for llm usage.
    """
    prompt_tokens: int  # prompt 使用 tokens
    prompt_unit_price: Decimal  # prompt 單價
    prompt_price_unit: Decimal  # prompt 價格單位，即單價基於多少 tokens 
    prompt_price: Decimal  # prompt 費用
    completion_tokens: int  # 回覆使用 tokens
    completion_unit_price: Decimal  # 回覆單價
    completion_price_unit: Decimal  # 回覆價格單位，即單價基於多少 tokens 
    completion_price: Decimal  # 回覆費用
    total_tokens: int  # 總使用 token 數
    total_price: Decimal  # 總費用
    currency: str  # 貨幣單位
    latency: float  # 請求耗時(s)
```

---

### TextEmbeddingResult

```python
class TextEmbeddingResult(BaseModel):
    """
    Model class for text embedding result.
    """
    model: str  # 實際使用模型
    embeddings: list[list[float]]  # embedding 向量列表，對應傳入的 texts 列表
    usage: EmbeddingUsage  # 使用信息
```

### EmbeddingUsage

```python
class EmbeddingUsage(ModelUsage):
    """
    Model class for embedding usage.
    """
    tokens: int  # 使用 token 數
    total_tokens: int  # 總使用 token 數
    unit_price: Decimal  # 單價
    price_unit: Decimal  # 價格單位，即單價基於多少 tokens
    total_price: Decimal  # 總費用
    currency: str  # 貨幣單位
    latency: float  # 請求耗時(s)
```

---

### RerankResult

```python
class RerankResult(BaseModel):
    """
    Model class for rerank result.
    """
    model: str  # 實際使用模型
    docs: list[RerankDocument]  # 重排後的分段列表	
```

### RerankDocument

```python
class RerankDocument(BaseModel):
    """
    Model class for rerank document.
    """
    index: int  # 原序號
    text: str  # 分段文本內容
    score: float  # 分數
```

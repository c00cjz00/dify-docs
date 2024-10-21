# 預定義模型接入

供應商集成完成後，接下來為供應商下模型的接入。

我們首先需要確定接入模型的類型，並在對應供應商的目錄下創建對應模型類型的 `module`。

當前支持模型類型如下：

* `llm` 文本生成模型
* `text_embedding` 文本 Embedding 模型
* `rerank` Rerank 模型
* `speech2text` 語音轉文字
* `tts` 文字轉語音
* `moderation` 審查

依舊以 `Anthropic` 為例，`Anthropic` 僅支持 LLM，因此在 `model_providers.anthropic` 創建一個 `llm` 為名稱的 `module`。

對於預定義的模型，我們首先需要在 `llm` `module` 下創建以模型名為文件名稱的 YAML 文件，如：`claude-2.1.yaml`。

#### 準備模型 YAML

```yaml
model: claude-2.1  # 模型標識
# 模型展示名稱，可設置 en_US 英文、zh_Hans 中文兩種語言，zh_Hans 不設置將默認使用 en_US。
# 也可不設置 label，則使用 model 標識內容。
label:
  en_US: claude-2.1
model_type: llm  # 模型類型，claude-2.1 為 LLM
features:  # 支持功能，agent-thought 為支持 Agent 推理，vision 為支持圖片理解
- agent-thought
model_properties:  # 模型屬性
  mode: chat  # LLM 模式，complete 文本補全模型，chat 對話模型
  context_size: 200000  # 支持最大上下文大小
parameter_rules:  # 模型調用參數規則，僅 LLM 需要提供
- name: temperature  # 調用參數變量名
  # 默認預置了 5 種變量內容配置模板，temperature/top_p/max_tokens/presence_penalty/frequency_penalty
  # 可在 use_template 中直接設置模板變量名，將會使用 entities.defaults.PARAMETER_RULE_TEMPLATE 中的默認配置
  # 若設置了額外的配置參數，將覆蓋默認配置
  use_template: temperature
- name: top_p
  use_template: top_p
- name: top_k
  label:  # 調用參數展示名稱
    zh_Hans: 取樣數量
    en_US: Top k
  type: int  # 參數類型，支持 float/int/string/boolean
  help:  # 幫助信息，描述參數作用
    zh_Hans: 僅從每個後續標記的前 K 個選項中採樣。
    en_US: Only sample from the top K options for each subsequent token.
  required: false  # 是否必填，可不設置
- name: max_tokens_to_sample
  use_template: max_tokens
  default: 4096  # 參數默認值
  min: 1  # 參數最小值，僅 float/int 可用
  max: 4096  # 參數最大值，僅 float/int 可用
pricing:  # 價格信息
  input: '8.00'  # 輸入單價，即 Prompt 單價
  output: '24.00'  # 輸出單價，即返回內容單價
  unit: '0.000001'  # 價格單位，即上述價格為每 100K 的單價
  currency: USD  # 價格貨幣
```

建議將所有模型配置都準備完畢後再開始模型代碼的實現。

同樣，也可以參考 `model_providers` 目錄下其他供應商對應模型類型目錄下的 YAML 配置信息，完整的 YAML 規則見：Schema[^1]。

#### 實現模型調用代碼

接下來需要在 `llm` `module` 下創建一個同名的 python 文件 `llm.py` 來編寫代碼實現。

在 `llm.py` 中創建一個 Anthropic LLM 類，我們取名為 `AnthropicLargeLanguageModel`（隨意），繼承 `__base.large_language_model.LargeLanguageModel` 基類，實現以下幾個方法：

*   LLM 調用

    實現 LLM 調用的核心方法，可同時支持流式和同步返回。

    ```python
    def _invoke(self, model: str, credentials: dict,
                prompt_messages: list[PromptMessage], model_parameters: dict,
                tools: Optional[list[PromptMessageTool]] = None, stop: Optional[List[str]] = None,
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

    在實現時，需要注意使用兩個函數來返回數據，分別用於處理同步返回和流式返回，因為Python會將函數中包含 `yield` 關鍵字的函數識別為生成器函數，返回的數據類型固定為 `Generator`，因此同步和流式返回需要分別實現，就像下面這樣（注意下面例子使用了簡化參數，實際實現時需要按照上面的參數列表進行實現）：

    ```python
    def _invoke(self, stream: bool, **kwargs) \
            -> Union[LLMResult, Generator]:
        if stream:
              return self._handle_stream_response(**kwargs)
        return self._handle_sync_response(**kwargs)

    def _handle_stream_response(self, **kwargs) -> Generator:
        for chunk in response:
              yield chunk
    def _handle_sync_response(self, **kwargs) -> LLMResult:
        return LLMResult(**response)
    ```
*   預計算輸入 tokens

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
*   模型憑據校驗

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
*   調用異常錯誤映射表

    當模型調用異常時需要映射到 Runtime 指定的 `InvokeError` 類型，方便 Dify 針對不同錯誤做不同後續處理。

    Runtime Errors:

    * `InvokeConnectionError` 調用連接錯誤
    * `InvokeServerUnavailableError` 調用服務方不可用
    * `InvokeRateLimitError` 調用達到限額
    * `InvokeAuthorizationError` 調用鑑權失敗
    * `InvokeBadRequestError` 調用傳參有誤

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

接口方法說明見：[Interfaces](https://github.com/langgenius/dify/blob/main/api/core/model\_runtime/docs/zh\_Hans/interfaces.md)，具體實現可參考：[llm.py](https://github.com/langgenius/dify-runtime/blob/main/lib/model_providers/anthropic/llm/llm.py)。

[^1]: #### Provider

    * `provider` (string) 供應商標識，如：`openai`
    * `label` (object) 供應商展示名稱，i18n，可設置 `en_US` 英文、`zh_Hans` 中文兩種語言
      * `zh_Hans` (string) \[optional] 中文標籤名，`zh_Hans` 不設置將默認使用 `en_US`。
      * `en_US` (string) 英文標籤名
    * `description` (object) \[optional] 供應商描述，i18n
      * `zh_Hans` (string) \[optional] 中文描述
      * `en_US` (string) 英文描述
    * `icon_small` (string) \[optional] 供應商小 ICON，存儲在對應供應商實現目錄下的 `_assets` 目錄，中英文策略同 `label`
      * `zh_Hans` (string) \[optional] 中文 ICON
      * `en_US` (string) 英文 ICON
    * `icon_large` (string) \[optional] 供應商大 ICON，存儲在對應供應商實現目錄下的 \_assets 目錄，中英文策略同 label
      * `zh_Hans` (string) \[optional] 中文 ICON
      * `en_US` (string) 英文 ICON
    * `background` (string) \[optional] 背景顏色色值，例：#FFFFFF，為空則展示前端默認色值。
    * `help` (object) \[optional] 幫助信息
      * `title` (object) 幫助標題，i18n
        * `zh_Hans` (string) \[optional] 中文標題
        * `en_US` (string) 英文標題
      * `url` (object) 幫助鏈接，i18n
        * `zh_Hans` (string) \[optional] 中文鏈接
        * `en_US` (string) 英文鏈接
    * `supported_model_types` (array\[ModelType]) 支持的模型類型
    * `configurate_methods` (array\[ConfigurateMethod]) 配置方式
    * `provider_credential_schema` (ProviderCredentialSchema) 供應商憑據規格
    * `model_credential_schema` (ModelCredentialSchema) 模型憑據規格

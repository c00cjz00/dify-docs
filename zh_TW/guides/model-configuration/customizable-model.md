# 自定義模型接入

### 介紹

供應商集成完成後，接下來為供應商下模型的接入，為了幫助理解整個接入過程，我們以`Xinference`為例，逐步完成一個完整的供應商接入。

需要注意的是，對於自定義模型，每一個模型的接入都需要填寫一個完整的供應商憑據。

而不同於預定義模型，自定義供應商接入時永遠會擁有如下兩個參數，不需要在供應商 yaml 中定義。

<figure><img src="../../.gitbook/assets/Feb 4,2.png" alt=""><figcaption></figcaption></figure>

在前文中，我們已經知道了供應商無需實現`validate_provider_credential`，Runtime會自行根據用戶在此選擇的模型類型和模型名稱調用對應的模型層的`validate_credentials`來進行驗證。

#### 編寫供應商 yaml

我們首先要確定，接入的這個供應商支持哪些類型的模型。

當前支持模型類型如下：

* `llm` 文本生成模型
* `text_embedding` 文本 Embedding 模型
* `rerank` Rerank 模型
* `speech2text` 語音轉文字
* `tts` 文字轉語音
* `moderation` 審查

`Xinference`支持`LLM`、`Text Embedding`和`Rerank`，那麼我們開始編寫`xinference.yaml`。

```yaml
provider: xinference #確定供應商標識
label: # 供應商展示名稱，可設置 en_US 英文、zh_Hans 中文兩種語言，zh_Hans 不設置將默認使用 en_US。
  en_US: Xorbits Inference
icon_small: # 小圖標，可以參考其他供應商的圖標，存儲在對應供應商實現目錄下的 _assets 目錄，中英文策略同 label
  en_US: icon_s_en.svg
icon_large: # 大圖標
  en_US: icon_l_en.svg
help: # 幫助
  title:
    en_US: How to deploy Xinference
    zh_Hans: 如何部署 Xinference
  url:
    en_US: https://github.com/xorbitsai/inference
supported_model_types: # 支持的模型類型，Xinference同時支持LLM/Text Embedding/Rerank
- llm
- text-embedding
- rerank
configurate_methods: # 因為Xinference為本地部署的供應商，並且沒有預定義模型，需要用什麼模型需要根據Xinference的文檔自己部署，所以這裡只支持自定義模型
- customizable-model
provider_credential_schema:
  credential_form_schemas:
```

隨後，我們需要思考在 Xinference 中定義一個模型需要哪些憑據

* 它支持三種不同的模型，因此，我們需要有`model_type`來指定這個模型的類型，它有三種類型，所以我們這麼編寫

```yaml
provider_credential_schema:
  credential_form_schemas:
  - variable: model_type
    type: select
    label:
      en_US: Model type
      zh_Hans: 模型類型
    required: true
    options:
    - value: text-generation
      label:
        en_US: Language Model
        zh_Hans: 語言模型
    - value: embeddings
      label:
        en_US: Text Embedding
    - value: reranking
      label:
        en_US: Rerank
```

* 每一個模型都有自己的名稱`model_name`，因此需要在這裡定義

```yaml
  - variable: model_name
    type: text-input
    label:
      en_US: Model name
      zh_Hans: 模型名稱
    required: true
    placeholder:
      zh_Hans: 填寫模型名稱
      en_US: Input model name
```

* 填寫 Xinference 本地部署的地址

```yaml
  - variable: server_url
    label:
      zh_Hans: 服務器URL
      en_US: Server url
    type: text-input
    required: true
    placeholder:
      zh_Hans: 在此輸入Xinference的服務器地址，如 https://example.com/xxx
      en_US: Enter the url of your Xinference, for example https://example.com/xxx
```

* 每個模型都有唯一的 model\_uid，因此需要在這裡定義

```yaml
  - variable: model_uid
    label:
      zh_Hans: 模型 UID
      en_US: Model uid
    type: text-input
    required: true
    placeholder:
      zh_Hans: 在此輸入您的 Model UID
      en_US: Enter the model uid
```

現在，我們就完成了供應商的基礎定義。

#### 編寫模型代碼

然後我們以`llm`類型為例，編寫`xinference.llm.llm.py`

在 `llm.py` 中創建一個 Xinference LLM 類，我們取名為 `XinferenceAILargeLanguageModel`（隨意），繼承 `__base.large_language_model.LargeLanguageModel` 基類，實現以下幾個方法：

*   LLM 調用

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

    有時候，也許你不需要直接返回0，所以你可以使用`self._get_num_tokens_by_gpt2(text: str)`來獲取預計算的tokens，這個方法位於`AIModel`基類中，它會使用GPT2的Tokenizer進行計算，但是隻能作為替代方法，並不完全準確。
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
*   模型參數 Schema

    與自定義類型不同，由於沒有在 yaml 文件中定義一個模型支持哪些參數，因此，我們需要動態時間模型參數的Schema。

    如Xinference支持`max_tokens` `temperature` `top_p` 這三個模型參數。

    但是有的供應商根據不同的模型支持不同的參數，如供應商`OpenLLM`支持`top_k`，但是並不是這個供應商提供的所有模型都支持`top_k`，我們這裡舉例 A 模型支持`top_k`，B模型不支持`top_k`，那麼我們需要在這裡動態生成模型參數的 Schema，如下所示：

    ```python
    def get_customizable_model_schema(self, model: str, credentials: dict) -> AIModelEntity | None:
        """
            used to define customizable model schema
        """
        rules = [
            ParameterRule(
                name='temperature', type=ParameterType.FLOAT,
                use_template='temperature',
                label=I18nObject(
                    zh_Hans='溫度', en_US='Temperature'
                )
            ),
            ParameterRule(
                name='top_p', type=ParameterType.FLOAT,
                use_template='top_p',
                label=I18nObject(
                    zh_Hans='Top P', en_US='Top P'
                )
            ),
            ParameterRule(
                name='max_tokens', type=ParameterType.INT,
                use_template='max_tokens',
                min=1,
                default=512,
                label=I18nObject(
                    zh_Hans='最大生成長度', en_US='Max Tokens'
                )
            )
        ]

        # if model is A, add top_k to rules
        if model == 'A':
            rules.append(
                ParameterRule(
                    name='top_k', type=ParameterType.INT,
                    use_template='top_k',
                    min=1,
                    default=50,
                    label=I18nObject(
                        zh_Hans='Top K', en_US='Top K'
                    )
                )
            )

        """
            some NOT IMPORTANT code here
        """

        entity = AIModelEntity(
            model=model,
            label=I18nObject(
                en_US=model
            ),
            fetch_from=FetchFrom.CUSTOMIZABLE_MODEL,
            model_type=model_type,
            model_properties={ 
                ModelPropertyKey.MODE:  ModelType.LLM,
            },
            parameter_rules=rules
        )

        return entity
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

# 增加新供應商

### 供應商配置方式

供應商支持三種模型配置方式：

**預定義模型（predefined-model）**

表示用戶只需要配置統一的供應商憑據即可使用供應商下的預定義模型。

**自定義模型（customizable-model）**

用戶需要新增每個模型的憑據配置，如 Xinference，它同時支持 LLM 和 Text Embedding，但是每個模型都有唯一的 **model\_uid**，如果想要將兩者同時接入，就需要為每個模型配置一個 **model\_uid**。

**從遠程獲取（fetch-from-remote）**

與 `predefined-model`配置方式一致，只需要配置統一的供應商憑據即可，模型通過憑據信息從供應商獲取。

如OpenAI，我們可以基於 gpt-turbo-3.5 來 Fine Tune 多個模型，而他們都位於同一個 **api\_key** 下，當配置為`fetch-from-remote`時，開發者只需要配置統一的 **api\_key** 即可讓 Dify Runtime 獲取到開發者所有的微調模型並接入 Dify。

這三種配置方式**支持共存**，即存在供應商支持`predefined-model` + `customizable-model` 或 `predefined-model` + `fetch-from-remote`等，也就是配置了供應商統一憑據可以使用預定義模型和從遠程獲取的模型，若新增了模型，則可以在此基礎上額外使用自定義的模型。

### 配置說明

**名詞解釋**

* `module`: 一個`module`即為一個 Python Package，或者通俗一點，稱為一個文件夾，裡面包含了一個`__init__.py`文件，以及其他的`.py`文件。

**步驟**

新增一個供應商主要分為幾步，這裡簡單列出，幫助大家有一個大概的認識，具體的步驟會在下面詳細介紹。

* 創建供應商 yaml 文件，根據 [Provider Schema](https://github.com/langgenius/dify/blob/main/api/core/model\_runtime/docs/zh\_Hans/schema.md) 編寫。
* 創建供應商代碼，實現一個`class`。
* 根據模型類型，在供應商`module`下創建對應的模型類型 `module`，如`llm`或`text_embedding`。
* 根據模型類型，在對應的模型`module`下創建同名的代碼文件，如`llm.py`，並實現一個`class`。
* 如果有預定義模型，根據模型名稱創建同名的yaml文件在模型`module`下，如`claude-2.1.yaml`，根據 [AI Model Entity](https://github.com/langgenius/dify/blob/main/api/core/model\_runtime/docs/zh\_Hans/schema.md#aimodelentity) 編寫。
* 編寫測試代碼，確保功能可用。

#### 開始吧

增加一個新的供應商需要先確定供應商的英文標識，如 `anthropic`，使用該標識在 `model_providers` 創建以此為名稱的 `module`。

在此 `module` 下，我們需要先準備供應商的 YAML 配置。

**準備供應商 YAML**

此處以 `Anthropic` 為例，預設了供應商基礎信息、支持的模型類型、配置方式、憑據規則。

```YAML
provider: anthropic  # 供應商標識
label:  # 供應商展示名稱，可設置 en_US 英文、zh_Hans 中文兩種語言，zh_Hans 不設置將默認使用 en_US。
  en_US: Anthropic
icon_small:  # 供應商小圖標，存儲在對應供應商實現目錄下的 _assets 目錄，中英文策略同 label
  en_US: icon_s_en.png
icon_large:  # 供應商大圖標，存儲在對應供應商實現目錄下的 _assets 目錄，中英文策略同 label
  en_US: icon_l_en.png
supported_model_types:  # 支持的模型類型，Anthropic 僅支持 LLM
- llm
configurate_methods:  # 支持的配置方式，Anthropic 僅支持預定義模型
- predefined-model
provider_credential_schema:  # 供應商憑據規則，由於 Anthropic 僅支持預定義模型，則需要定義統一供應商憑據規則
  credential_form_schemas:  # 憑據表單項列表
  - variable: anthropic_api_key  # 憑據參數變量名
    label:  # 展示名稱
      en_US: API Key
    type: secret-input  # 表單類型，此處 secret-input 代表加密信息輸入框，編輯時只展示屏蔽後的信息。
    required: true  # 是否必填
    placeholder:  # PlaceHolder 信息
      zh_Hans: 在此輸入您的 API Key
      en_US: Enter your API Key
  - variable: anthropic_api_url
    label:
      en_US: API URL
    type: text-input  # 表單類型，此處 text-input 代表文本輸入框
    required: false
    placeholder:
      zh_Hans: 在此輸入您的 API URL
      en_US: Enter your API URL
```

如果接入的供應商提供自定義模型，比如`OpenAI`提供微調模型，那麼我們就需要添加[`model_credential_schema`](https://github.com/langgenius/dify/blob/main/api/core/model\_runtime/docs/zh\_Hans/schema.md)，以`OpenAI`為例：

```yaml
model_credential_schema:
  model: # 微調模型名稱
    label:
      en_US: Model Name
      zh_Hans: 模型名稱
    placeholder:
      en_US: Enter your model name
      zh_Hans: 輸入模型名稱
  credential_form_schemas:
  - variable: openai_api_key
    label:
      en_US: API Key
    type: secret-input
    required: true
    placeholder:
      zh_Hans: 在此輸入您的 API Key
      en_US: Enter your API Key
  - variable: openai_organization
    label:
        zh_Hans: 組織 ID
        en_US: Organization
    type: text-input
    required: false
    placeholder:
      zh_Hans: 在此輸入您的組織 ID
      en_US: Enter your Organization ID
  - variable: openai_api_base
    label:
      zh_Hans: API Base
      en_US: API Base
    type: text-input
    required: false
    placeholder:
      zh_Hans: 在此輸入您的 API Base
      en_US: Enter your API Base
```

也可以參考`model_providers`目錄下其他供應商目錄下的 [YAML 配置信息](https://github.com/langgenius/dify/blob/main/api/core/model\_runtime/docs/zh\_Hans/schema.md)。

**實現供應商代碼**

我們需要在`model_providers`下創建一個同名的python文件，如`anthropic.py`，並實現一個`class`，繼承`__base.provider.Provider`基類，如`AnthropicProvider`。

**自定義模型供應商**

當供應商為 Xinference 等自定義模型供應商時，可跳過該步驟，僅創建一個空的`XinferenceProvider`類即可，並實現一個空的`validate_provider_credentials`方法，該方法並不會被實際使用，僅用作避免抽象類無法實例化。

```python
class XinferenceProvider(Provider):
    def validate_provider_credentials(self, credentials: dict) -> None:
        pass
```

**預定義模型供應商**

供應商需要繼承 `__base.model_provider.ModelProvider` 基類，實現 `validate_provider_credentials` 供應商統一憑據校驗方法即可，可參考 [AnthropicProvider](https://github.com/langgenius/dify/blob/main/api/core/model\_runtime/model\_providers/anthropic/anthropic.py)。

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

當然也可以先預留 `validate_provider_credentials` 實現，在模型憑據校驗方法實現後直接複用。

**增加模型**

[**增加預定義模型** ](https://docs.dify.ai/v/zh-hans/guides/model-configuration/predefined-model)**👈🏻**

對於預定義模型，我們可以通過簡單定義一個 yaml，並通過實現調用代碼來接入。

[**增加自定義模型**](https://docs.dify.ai/v/zh-hans/guides/model-configuration/customizable-model) **👈🏻**

對於自定義模型，我們只需要實現調用代碼即可接入，但是它需要處理的參數可能會更加複雜。

***

#### 測試

為了保證接入供應商/模型的可用性，編寫後的每個方法均需要在 `tests` 目錄中編寫對應的集成測試代碼。

依舊以 `Anthropic` 為例。

在編寫測試代碼前，需要先在 `.env.example` 新增測試供應商所需要的憑據環境變量，如：`ANTHROPIC_API_KEY`。

在執行前需要將 `.env.example` 複製為 `.env` 再執行。

**編寫測試代碼**

在 `tests` 目錄下創建供應商同名的 `module`: `anthropic`，繼續在此模塊中創建 `test_provider.py` 以及對應模型類型的 test py 文件，如下所示：

```shell
.
├── __init__.py
├── anthropic
│   ├── __init__.py
│   ├── test_llm.py       # LLM 測試
│   └── test_provider.py  # 供應商測試
```

針對上面實現的代碼的各種情況進行測試代碼編寫，並測試通過後提交代碼。

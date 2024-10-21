# 配置規則

- 供應商規則基於 [Provider](#Provider) 實體。

- 模型規則基於 [AIModelEntity](#AIModelEntity) 實體。

> 以下所有實體均基於 `Pydantic BaseModel`，可在 `entities` 模塊中找到對應實體。

### Provider

- `provider` (string) 供應商標識，如：`openai`
- `label` (object) 供應商展示名稱，i18n，可設置 `en_US` 英文、`zh_Hans` 中文兩種語言
  - `zh_Hans ` (string) [optional] 中文標籤名，`zh_Hans` 不設置將默認使用 `en_US`。
  - `en_US` (string) 英文標籤名
- `description` (object) [optional] 供應商描述，i18n
  - `zh_Hans` (string) [optional] 中文描述
  - `en_US` (string) 英文描述
- `icon_small` (string) [optional] 供應商小 ICON，存儲在對應供應商實現目錄下的 `_assets` 目錄，中英文策略同 `label`
  - `zh_Hans` (string)  [optional] 中文 ICON
  - `en_US` (string) 英文 ICON
- `icon_large` (string) [optional] 供應商大 ICON，存儲在對應供應商實現目錄下的 _assets 目錄，中英文策略同 label
  - `zh_Hans `(string) [optional] 中文 ICON
  - `en_US` (string) 英文 ICON
- `background` (string) [optional] 背景顏色色值，例：#FFFFFF，為空則展示前端默認色值。
- `help` (object) [optional] 幫助信息
  - `title` (object) 幫助標題，i18n
    - `zh_Hans` (string) [optional] 中文標題
    - `en_US` (string) 英文標題
  - `url` (object) 幫助鏈接，i18n
    - `zh_Hans` (string) [optional] 中文鏈接
    - `en_US` (string) 英文鏈接
- `supported_model_types` (array[[ModelType](#ModelType)]) 支持的模型類型
- `configurate_methods` (array[[ConfigurateMethod](#ConfigurateMethod)]) 配置方式
- `provider_credential_schema` ([ProviderCredentialSchema](#ProviderCredentialSchema)) 供應商憑據規格
- `model_credential_schema` ([ModelCredentialSchema](#ModelCredentialSchema)) 模型憑據規格

### AIModelEntity

- `model` (string) 模型標識，如：`gpt-3.5-turbo`
- `label` (object) [optional] 模型展示名稱，i18n，可設置 `en_US` 英文、`zh_Hans` 中文兩種語言
  - `zh_Hans `(string) [optional] 中文標籤名
  - `en_US` (string) 英文標籤名
- `model_type` ([ModelType](#ModelType)) 模型類型
- `features` (array[[ModelFeature](#ModelFeature)]) [optional] 支持功能列表
- `model_properties` (object) 模型屬性
  - `mode` ([LLMMode](#LLMMode)) 模式 (模型類型 `llm` 可用)
  - `context_size` (int) 上下文大小 (模型類型 `llm` `text-embedding` 可用)
  - `max_chunks` (int) 最大分塊數量 (模型類型 `text-embedding ` `moderation` 可用)
  - `file_upload_limit` (int) 文件最大上傳限制，單位：MB。（模型類型 `speech2text` 可用）
  - `supported_file_extensions` (string)  支持文件擴展格式，如：mp3,mp4（模型類型 `speech2text` 可用）
  - `default_voice` (string)  缺省音色，必選：alloy,echo,fable,onyx,nova,shimmer（模型類型 `tts` 可用）
  - `voices` (list)  可選音色列表。
    - `mode` (string)  音色模型。（模型類型 `tts` 可用）
    - `name` (string)  音色模型顯示名稱。（模型類型 `tts` 可用）
    - `language` (string)  音色模型支持語言。（模型類型 `tts` 可用）
  - `word_limit` (int)  單次轉換字數限制，默認按段落分段（模型類型 `tts` 可用）
  - `audio_type` (string)  支持音頻文件擴展格式，如：mp3,wav（模型類型 `tts` 可用）
  - `max_workers` (int)  支持文字音頻轉換併發任務數（模型類型 `tts` 可用）
  - `max_characters_per_chunk` (int) 每塊最大字符數 (模型類型  `moderation` 可用)
- `parameter_rules` (array[[ParameterRule](#ParameterRule)]) [optional] 模型調用參數規則
- `pricing` ([PriceConfig](#PriceConfig)) [optional] 價格信息
- `deprecated` (bool) 是否廢棄。若廢棄，模型列表將不再展示，但已經配置的可以繼續使用，默認 False。

### ModelType

- `llm` 文本生成模型
- `text-embedding` 文本 Embedding 模型
- `rerank` Rerank 模型
- `speech2text` 語音轉文字
- `tts` 文字轉語音
- `moderation` 審查

### ConfigurateMethod

- `predefined-model  ` 預定義模型

  表示用戶只需要配置統一的供應商憑據即可使用供應商下的預定義模型。
- `customizable-model` 自定義模型

  用戶需要新增每個模型的憑據配置。

- `fetch-from-remote` 從遠程獲取

  與 `predefined-model` 配置方式一致，只需要配置統一的供應商憑據即可，模型通過憑據信息從供應商獲取。

### ModelFeature

- `agent-thought` Agent 推理，一般超過 70B 有思維鏈能力。
- `vision` 視覺，即：圖像理解。
- `tool-call` 工具調用
- `multi-tool-call` 多工具調用
- `stream-tool-call` 流式工具調用

### FetchFrom

- `predefined-model` 預定義模型
- `fetch-from-remote` 遠程模型

### LLMMode

- `completion` 文本補全
- `chat` 對話

### ParameterRule

- `name` (string) 調用模型實際參數名

- `use_template` (string) [optional] 使用模板
  
  默認預置了 5 種變量內容配置模板：

  - `temperature`
  - `top_p`
  - `frequency_penalty`
  - `presence_penalty`
  - `max_tokens`
  
  可在 use_template 中直接設置模板變量名，將會使用 entities.defaults.PARAMETER_RULE_TEMPLATE 中的默認配置
  不用設置除 `name` 和 `use_template` 之外的所有參數，若設置了額外的配置參數，將覆蓋默認配置。
  可參考 `openai/llm/gpt-3.5-turbo.yaml`。

- `label` (object) [optional] 標籤，i18n

  - `zh_Hans`(string) [optional] 中文標籤名
  - `en_US` (string) 英文標籤名

- `type`(string) [optional] 參數類型

  - `int` 整數
  - `float` 浮點數
  - `string` 字符串
  - `boolean` 布爾型

- `help` (string) [optional] 幫助信息

  - `zh_Hans` (string) [optional] 中文幫助信息
  - `en_US` (string) 英文幫助信息

- `required` (bool) 是否必填，默認 False。

- `default`(int/float/string/bool) [optional] 默認值

- `min`(int/float) [optional] 最小值，僅數字類型適用

- `max`(int/float) [optional] 最大值，僅數字類型適用

- `precision`(int) [optional] 精度，保留小數位數，僅數字類型適用

- `options` (array[string]) [optional] 下拉選項值，僅當 `type` 為 `string` 時適用，若不設置或為 null 則不限制選項值

### PriceConfig

- `input` (float) 輸入單價，即 Prompt 單價
- `output` (float) 輸出單價，即返回內容單價
- `unit` (float) 價格單位，如以 1M tokens 計價，則單價對應的單位 token 數為 `0.000001`
- `currency` (string) 貨幣單位

### ProviderCredentialSchema

- `credential_form_schemas` (array[[CredentialFormSchema](#CredentialFormSchema)]) 憑據表單規範

### ModelCredentialSchema

- `model` (object) 模型標識，變量名默認 `model`
  - `label` (object) 模型表單項展示名稱
    - `en_US` (string) 英文
    - `zh_Hans`(string) [optional] 中文
  - `placeholder` (object) 模型提示內容
    - `en_US`(string) 英文
    - `zh_Hans`(string) [optional] 中文
- `credential_form_schemas` (array[[CredentialFormSchema](#CredentialFormSchema)]) 憑據表單規範

### CredentialFormSchema

- `variable` (string) 表單項變量名
- `label` (object) 表單項標籤名
  - `en_US`(string) 英文
  - `zh_Hans` (string) [optional] 中文
- `type` ([FormType](#FormType)) 表單項類型
- `required` (bool) 是否必填
- `default`(string) 默認值
- `options` (array[[FormOption](#FormOption)]) 表單項為 `select` 或 `radio` 專有屬性，定義下拉內容
- `placeholder`(object) 表單項為 `text-input `專有屬性，表單項 PlaceHolder
  - `en_US`(string) 英文
  - `zh_Hans` (string) [optional] 中文
- `max_length` (int) 表單項為`text-input`專有屬性，定義輸入最大長度，0 為不限制。
- `show_on` (array[[FormShowOnObject](#FormShowOnObject)]) 當其他表單項值符合條件時顯示，為空則始終顯示。

### FormType

- `text-input` 文本輸入組件
- `secret-input` 密碼輸入組件
- `select` 單選下拉
- `radio` Radio 組件
- `switch` 開關組件，僅支持 `true` 和 `false`

### FormOption

- `label` (object) 標籤
  - `en_US`(string) 英文
  - `zh_Hans`(string) [optional] 中文
- `value` (string) 下拉選項值
- `show_on` (array[[FormShowOnObject](#FormShowOnObject)]) 當其他表單項值符合條件時顯示，為空則始終顯示。

### FormShowOnObject

- `variable` (string) 其他表單項變量名
- `value` (string) 其他表單項變量值

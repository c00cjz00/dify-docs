# 快速接入工具

這裡我們以 GoogleSearch 為例，介紹如何快速接入一個工具。

### 1. 準備工具供應商 yaml

#### 介紹

這個 yaml 將包含工具供應商的信息，包括供應商名稱、圖標、作者等詳細信息，以幫助前端靈活展示。

#### 示例

我們需要在 `core/tools/provider/builtin`下創建一個`google`模塊（文件夾），並創建`google.yaml`，名稱必須與模塊名稱一致。

後續，我們關於這個工具的所有操作都將在這個模塊下進行。

```yaml
identity: # 工具供應商的基本信息
  author: Dify # 作者
  name: google # 名稱，唯一，不允許和其他供應商重名
  label: # 標籤，用於前端展示
    en_US: Google # 英文標籤
    zh_Hans: Google # 中文標籤
  description: # 描述，用於前端展示
    en_US: Google # 英文描述
    zh_Hans: Google # 中文描述
  icon: icon.svg # 圖標，需要放置在當前模塊的_assets文件夾下

```

* `identity` 字段是必須的，它包含了工具供應商的基本信息，包括作者、名稱、標籤、描述、圖標等
  *   圖標需要放置在當前模塊的`_assets`文件夾下，可以參考這裡：api/core/tools/provider/builtin/google/\_assets/icon.svg

      ```xml
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="25" viewBox="0 0 24 25" fill="none">
        <path d="M22.501 12.7332C22.501 11.8699 22.4296 11.2399 22.2748 10.5865H12.2153V14.4832H18.12C18.001 15.4515 17.3582 16.9099 15.9296 17.8898L15.9096 18.0203L19.0902 20.435L19.3106 20.4565C21.3343 18.6249 22.501 15.9298 22.501 12.7332Z" fill="#4285F4"/>
        <path d="M12.214 23C15.1068 23 17.5353 22.0666 19.3092 20.4567L15.9282 17.8899C15.0235 18.5083 13.8092 18.9399 12.214 18.9399C9.38069 18.9399 6.97596 17.1083 6.11874 14.5766L5.99309 14.5871L2.68583 17.0954L2.64258 17.2132C4.40446 20.6433 8.0235 23 12.214 23Z" fill="#34A853"/>
        <path d="M6.12046 14.5766C5.89428 13.9233 5.76337 13.2233 5.76337 12.5C5.76337 11.7766 5.89428 11.0766 6.10856 10.4233L6.10257 10.2841L2.75386 7.7355L2.64429 7.78658C1.91814 9.20993 1.50146 10.8083 1.50146 12.5C1.50146 14.1916 1.91814 15.7899 2.64429 17.2132L6.12046 14.5766Z" fill="#FBBC05"/>
        <path d="M12.2141 6.05997C14.2259 6.05997 15.583 6.91163 16.3569 7.62335L19.3807 4.73C17.5236 3.03834 15.1069 2 12.2141 2C8.02353 2 4.40447 4.35665 2.64258 7.78662L6.10686 10.4233C6.97598 7.89166 9.38073 6.05997 12.2141 6.05997Z" fill="#EB4335"/>
      </svg>
      ```

### 2. 準備供應商憑據

Google 作為一個第三方工具，使用了 SerpApi 提供的 API，而 SerpApi 需要一個 API Key 才能使用，那麼就意味著這個工具需要一個憑據才可以使用，而像`wikipedia`這樣的工具，就不需要填寫憑據字段，可以參考這裡：api/core/tools/provider/builtin/wikipedia/wikipedia.yaml

```yaml
identity:
  author: Dify
  name: wikipedia
  label:
    en_US: Wikipedia
    zh_Hans: 維基百科
    pt_BR: Wikipedia
  description:
    en_US: Wikipedia is a free online encyclopedia, created and edited by volunteers around the world.
    zh_Hans: 維基百科是一個由全世界的志願者創建和編輯的免費在線百科全書。
    pt_BR: Wikipedia is a free online encyclopedia, created and edited by volunteers around the world.
  icon: icon.svg
credentials_for_provider:
```

配置好憑據字段後效果如下：

```yaml
identity:
  author: Dify
  name: google
  label:
    en_US: Google
    zh_Hans: Google
  description:
    en_US: Google
    zh_Hans: Google
  icon: icon.svg
credentials_for_provider: # 憑據字段
  serpapi_api_key: # 憑據字段名稱
    type: secret-input # 憑據字段類型
    required: true # 是否必填
    label: # 憑據字段標籤
      en_US: SerpApi API key # 英文標籤
      zh_Hans: SerpApi API key # 中文標籤
    placeholder: # 憑據字段佔位符
      en_US: Please input your SerpApi API key # 英文佔位符
      zh_Hans: 請輸入你的 SerpApi API key # 中文佔位符
    help: # 憑據字段幫助文本
      en_US: Get your SerpApi API key from SerpApi # 英文幫助文本
      zh_Hans: 從 SerpApi 獲取您的 SerpApi API key # 中文幫助文本
    url: https://serpapi.com/manage-api-key # 憑據字段幫助鏈接

```

* `type`：憑據字段類型，目前支持`secret-input`、`text-input`、`select` 三種類型，分別對應密碼輸入框、文本輸入框、下拉框，如果為`secret-input`，則會在前端隱藏輸入內容，並且後端會對輸入內容進行加密。

### 3. 準備工具 yaml

一個供應商底下可以有多個工具，每個工具都需要一個 yaml 文件來描述，這個文件包含了工具的基本信息、參數、輸出等。

仍然以 GoogleSearch 為例，我們需要在`google`模塊下創建一個`tools`模塊，並創建`tools/google_search.yaml`，內容如下。

```yaml
identity: # 工具的基本信息
  name: google_search # 工具名稱，唯一，不允許和其他工具重名
  author: Dify # 作者
  label: # 標籤，用於前端展示
    en_US: GoogleSearch # 英文標籤
    zh_Hans: 谷歌搜索 # 中文標籤
description: # 描述，用於前端展示
  human: # 用於前端展示的介紹，支持多語言
    en_US: A tool for performing a Google SERP search and extracting snippets and webpages.Input should be a search query.
    zh_Hans: 一個用於執行 Google SERP 搜索並提取片段和網頁的工具。輸入應該是一個搜索查詢。
  llm: A tool for performing a Google SERP search and extracting snippets and webpages.Input should be a search query. # 傳遞給 LLM 的介紹，為了使得LLM更好理解這個工具，我們建議在這裡寫上關於這個工具儘可能詳細的信息，讓 LLM 能夠理解並使用這個工具
parameters: # 參數列表
  - name: query # 參數名稱
    type: string # 參數類型
    required: true # 是否必填
    label: # 參數標籤
      en_US: Query string # 英文標籤
      zh_Hans: 查詢語句 # 中文標籤
    human_description: # 用於前端展示的介紹，支持多語言
      en_US: used for searching
      zh_Hans: 用於搜索網頁內容
    llm_description: key words for searching # 傳遞給LLM的介紹，同上，為了使得LLM更好理解這個參數，我們建議在這裡寫上關於這個參數儘可能詳細的信息，讓LLM能夠理解這個參數
    form: llm # 表單類型，llm表示這個參數需要由Agent自行推理出來，前端將不會展示這個參數
  - name: result_type
    type: select # 參數類型
    required: true
    options: # 下拉框選項
      - value: text
        label:
          en_US: text
          zh_Hans: 文本
      - value: link
        label:
          en_US: link
          zh_Hans: 鏈接
    default: link
    label:
      en_US: Result type
      zh_Hans: 結果類型
    human_description:
      en_US: used for selecting the result type, text or link
      zh_Hans: 用於選擇結果類型，使用文本還是鏈接進行展示
    form: form # 表單類型，form表示這個參數需要由用戶在對話開始前在前端填寫

```

* `identity` 字段是必須的，它包含了工具的基本信息，包括名稱、作者、標籤、描述等
* `parameters` 參數列表
  * `name` 參數名稱，唯一，不允許和其他參數重名
  * `type` 參數類型，目前支持`string`、`number`、`boolean`、`select` 四種類型，分別對應字符串、數字、布爾值、下拉框
  * `required` 是否必填
    * 在`llm`模式下，如果參數為必填，則會要求 Agent 必須要推理出這個參數
    * 在`form`模式下，如果參數為必填，則會要求用戶在對話開始前在前端填寫這個參數
  * `options` 參數選項
    * 在`llm`模式下，Dify 會將所有選項傳遞給 LLM，LLM 可以根據這些選項進行推理
    * 在`form`模式下，`type`為`select`時，前端會展示這些選項
  * `default` 默認值
  * `label` 參數標籤，用於前端展示
  * `human_description` 用於前端展示的介紹，支持多語言
  * `llm_description` 傳遞給 LLM 的介紹，為了使得 LLM 更好理解這個參數，我們建議在這裡寫上關於這個參數儘可能詳細的信息，讓 LLM 能夠理解這個參數
  * `form` 表單類型，目前支持`llm`、`form`兩種類型，分別對應 Agent 自行推理和前端填寫

### 4. 準備工具代碼

當完成工具的配置以後，我們就可以開始編寫工具代碼了，主要用於實現工具的邏輯。

在`google/tools`模塊下創建`google_search.py`，內容如下。

```python
from core.tools.tool.builtin_tool import BuiltinTool
from core.tools.entities.tool_entities import ToolInvokeMessage

from typing import Any, Dict, List, Union

class GoogleSearchTool(BuiltinTool):
    def _invoke(self, 
                user_id: str,
               tool_Parameters: Dict[str, Any], 
        ) -> Union[ToolInvokeMessage, List[ToolInvokeMessage]]:
        """
            invoke tools
        """
        query = tool_Parameters['query']
        result_type = tool_Parameters['result_type']
        api_key = self.runtime.credentials['serpapi_api_key']
        # TODO: search with serpapi
        result = SerpAPI(api_key).run(query, result_type=result_type)

        if result_type == 'text':
            return self.create_text_message(text=result)
        return self.create_link_message(link=result)
```

#### 參數

工具的整體邏輯都在`_invoke`方法中，這個方法接收兩個參數：`user_id`和`tool_Parameters`，分別表示用戶 ID 和工具參數

#### 返回數據

在工具返回時，你可以選擇返回一個消息或者多個消息，這裡我們返回一個消息，使用`create_text_message`和`create_link_message`可以創建一個文本消息或者一個鏈接消息。

### 5. 準備供應商代碼

最後，我們需要在供應商模塊下創建一個供應商類，用於實現供應商的憑據驗證邏輯，如果憑據驗證失敗，將會拋出`ToolProviderCredentialValidationError`異常。

在`google`模塊下創建`google.py`，內容如下。

```python
from core.tools.entities.tool_entities import ToolInvokeMessage, ToolProviderType
from core.tools.tool.tool import Tool
from core.tools.provider.builtin_tool_provider import BuiltinToolProviderController
from core.tools.errors import ToolProviderCredentialValidationError

from core.tools.provider.builtin.google.tools.google_search import GoogleSearchTool

from typing import Any, Dict

class GoogleProvider(BuiltinToolProviderController):
    def _validate_credentials(self, credentials: Dict[str, Any]) -> None:
        try:
            # 1. 此處需要使用 GoogleSearchTool()實例化一個 GoogleSearchTool，它會自動加載 GoogleSearchTool 的 yaml 配置，但是此時它內部沒有憑據信息
            # 2. 隨後需要使用 fork_tool_runtime 方法，將當前的憑據信息傳遞給 GoogleSearchTool
            # 3. 最後 invoke 即可，參數需要根據 GoogleSearchTool 的 yaml 中配置的參數規則進行傳遞
            GoogleSearchTool().fork_tool_runtime(
                meta={
                    "credentials": credentials,
                }
            ).invoke(
                user_id='',
                tool_Parameters={
                    "query": "test",
                    "result_type": "link"
                },
            )
        except Exception as e:
            raise ToolProviderCredentialValidationError(str(e))
```

### 完成

當上述步驟完成以後，我們就可以在前端看到這個工具了，並且可以在 Agent 中使用這個工具。

當然，因為 google\_search 需要一個憑據，在使用之前，還需要在前端配置它的憑據。

<figure><img src="../../.gitbook/assets/Feb 4, 2024.png" alt=""><figcaption></figcaption></figure>

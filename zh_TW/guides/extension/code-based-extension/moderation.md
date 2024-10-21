# 敏感內容審查

除了系統內置的內容審查類型，Dify 也支持用戶擴展自定義的內容審查規則，該方法適用於私有部署的開發者定製開發。比如企業內部客服，規定用戶在查詢的時候以及客服回覆的時候，除了不可以輸入暴力，性和非法行為等相關詞語，也不能出現企業自己規定的禁詞或違反內部制定的審查邏輯，那麼開發者可以在私有部署的 Dify 代碼層擴展自定義內容審查規則。

## 快速開始

這裡以一個 `Cloud Service` 內容審查擴展為例，步驟如下：

1. 初始化目錄
2. 添加前端組件定義文件
3. 添加實現類
4. 預覽前端界面
5. 調試擴展

### 1. 初始化目錄

新增自定義類型 `Cloud Service`，需要在 `api/core/moderation` 目錄下新建相關的目錄和文件。

```Plain
.
└── api
    └── core
        └── moderation
            └── cloud_service
                ├── __init__.py
                ├── cloud_service.py
                └── schema.json
```

### 2.添加前端組件規範

* `schema.json`，這裡定義了前端組件規範，詳細見 [Broken link](broken-reference "mention") 。

```json
{
    "label": {
        "en-US": "Cloud Service",
        "zh-Hans": "雲服務"
    },
    "form_schema": [
        {
            "type": "select",
            "label": {
                "en-US": "Cloud Provider",
                "zh-Hans": "雲廠商"
            },
            "variable": "cloud_provider",
            "required": true,
            "options": [
                {
                    "label": {
                        "en-US": "AWS",
                        "zh-Hans": "亞馬遜"
                    },
                    "value": "AWS"
                },
                {
                    "label": {
                        "en-US": "Google Cloud",
                        "zh-Hans": "谷歌雲"
                    },
                    "value": "GoogleCloud"
                },
                {
                    "label": {
                        "en-US": "Azure Cloud",
                        "zh-Hans": "微軟雲"
                    },
                    "value": "Azure"
                }
            ],
            "default": "GoogleCloud",
            "placeholder": ""
        },
        {
            "type": "text-input",
            "label": {
                "en-US": "API Endpoint",
                "zh-Hans": "API Endpoint"
            },
            "variable": "api_endpoint",
            "required": true,
            "max_length": 100,
            "default": "",
            "placeholder": "https://api.example.com"
        },
        {
            "type": "paragraph",
            "label": {
                "en-US": "API Key",
                "zh-Hans": "API Key"
            },
            "variable": "api_keys",
            "required": true,
            "default": "",
            "placeholder": "Paste your API key here"
        }
    ]
}
```

### 3. 添加實現類

`cloud_service.py` 代碼模版，你可以在這裡實現具體的業務邏輯。

{% hint style="warning" %}
注意：類變量 name 為自定義類型名稱，需要跟目錄和文件名保持一致，而且唯一。
{% endhint %}

```python
from core.moderation.base import Moderation, ModerationAction, ModerationInputsResult, ModerationOutputsResult

class CloudServiceModeration(Moderation):
    """
    The name of custom type must be unique, keep the same with directory and file name.
    """
    name: str = "cloud_service"

    @classmethod
    def validate_config(cls, tenant_id: str, config: dict) -> None:
        """
        schema.json validation. It will be called when user save the config.

        Example:
            .. code-block:: python
                config = {
                    "cloud_provider": "GoogleCloud",
                    "api_endpoint": "https://api.example.com",
                    "api_keys": "123456",
                    "inputs_config": {
                        "enabled": True,
                        "preset_response": "Your content violates our usage policy. Please revise and try again."
                    },
                    "outputs_config": {
                        "enabled": True,
                        "preset_response": "Your content violates our usage policy. Please revise and try again."
                    }
                }

        :param tenant_id: the id of workspace
        :param config: the variables of form config
        :return:
        """

        cls._validate_inputs_and_outputs_config(config, True)

        if not config.get("cloud_provider"):
            raise ValueError("cloud_provider is required")

        if not config.get("api_endpoint"):
            raise ValueError("api_endpoint is required")

        if not config.get("api_keys"):
            raise ValueError("api_keys is required")

    def moderation_for_inputs(self, inputs: dict, query: str = "") -> ModerationInputsResult:
        """
        Moderation for inputs.

        :param inputs: user inputs
        :param query: the query of chat app, there is empty if is completion app
        :return: the moderation result
        """
        flagged = False
        preset_response = ""

        if self.config['inputs_config']['enabled']:
            preset_response = self.config['inputs_config']['preset_response']

            if query:
                inputs['query__'] = query
            flagged = self._is_violated(inputs)

        # return ModerationInputsResult(flagged=flagged, action=ModerationAction.overridden, inputs=inputs, query=query)
        return ModerationInputsResult(flagged=flagged, action=ModerationAction.DIRECT_OUTPUT, preset_response=preset_response)

    def moderation_for_outputs(self, text: str) -> ModerationOutputsResult:
        """
        Moderation for outputs.

        :param text: the text of LLM response
        :return: the moderation result
        """
        flagged = False
        preset_response = ""

        if self.config['outputs_config']['enabled']:
            preset_response = self.config['outputs_config']['preset_response']

            flagged = self._is_violated({'text': text})

        # return ModerationOutputsResult(flagged=flagged, action=ModerationAction.overridden, text=text)
        return ModerationOutputsResult(flagged=flagged, action=ModerationAction.DIRECT_OUTPUT, preset_response=preset_response)

    def _is_violated(self, inputs: dict):
        """
        The main logic of moderation.

        :param inputs:
        :return: the moderation result
        """
        return False
```

### 4. 調試擴展

至此，即可在 Dify 應用編排界面選擇自定義的 `Cloud Service` 內容審查擴展類型進行調試。\\

## 實現類模版

```python
from core.moderation.base import Moderation, ModerationAction, ModerationInputsResult, ModerationOutputsResult

class CloudServiceModeration(Moderation):
    """
    The name of custom type must be unique, keep the same with directory and file name.
    """
    name: str = "cloud_service"

    @classmethod
    def validate_config(cls, tenant_id: str, config: dict) -> None:
        """
        schema.json validation. It will be called when user save the config.
        
        :param tenant_id: the id of workspace
        :param config: the variables of form config
        :return:
        """
        cls._validate_inputs_and_outputs_config(config, True)
        
        # implement your own logic here

    def moderation_for_inputs(self, inputs: dict, query: str = "") -> ModerationInputsResult:
        """
        Moderation for inputs.

        :param inputs: user inputs
        :param query: the query of chat app, there is empty if is completion app
        :return: the moderation result
        """
        flagged = False
        preset_response = ""
        
        # implement your own logic here
        
        # return ModerationInputsResult(flagged=flagged, action=ModerationAction.overridden, inputs=inputs, query=query)
        return ModerationInputsResult(flagged=flagged, action=ModerationAction.DIRECT_OUTPUT, preset_response=preset_response)

    def moderation_for_outputs(self, text: str) -> ModerationOutputsResult:
        """
        Moderation for outputs.

        :param text: the text of LLM response
        :return: the moderation result
        """
        flagged = False
        preset_response = ""
        
        # implement your own logic here

        # return ModerationOutputsResult(flagged=flagged, action=ModerationAction.overridden, text=text)
        return ModerationOutputsResult(flagged=flagged, action=ModerationAction.DIRECT_OUTPUT, preset_response=preset_response)
```

## 實現類開發詳細介紹

### def validate\_config

`schema.json` 表單校驗方法，當用戶點擊「發佈」保存配置時調用

* `config` 表單參數
  * `{{variable}}` 表單自定義變量
  * `inputs_config` 輸入審查預設回覆
    * `enabled` 是否開啟
    * `preset_response` 輸入預設回覆
  * `outputs_config`輸出審查預設回覆
    * `enabled` 是否開啟
    * `preset_response` 輸出預設回覆

### def moderation\_for\_inputs

輸入校驗函數

* `inputs` ：終端用戶傳入變量值
* `query` ：終端用戶當前對話輸入內容，對話型應用固定參數。
* `ModerationInputsResult`
  * `flagged` 是否違反校驗規則
  * `action` 執行動作
    * `direct_output` 直接輸出預設回覆
    * `overridden` 覆寫傳入變量值
  * `preset_response` 預設回覆（僅當 action=direct\_output 返回）
  * `inputs` 終端用戶傳入變量值，key 為變量名，value 為變量值（僅當 action=overridden 返回）
  * `query` 覆寫的終端用戶當前對話輸入內容，對話型應用固定參數。（僅當 action=overridden 返回）

### def moderation\_for\_outputs

輸出校驗函數

* `text` ：模型輸出內容
* `moderation_for_outputs` ：輸出校驗函數
  * `text` ：LLM 回答內容。當 LLM 輸出為流式時，此處為 100 字為一個分段的內容。
  * `ModerationOutputsResult`
    * `flagged` 是否違反校驗規則
    * `action` 執行動作
      * `direct_output`直接輸出預設回覆
      * `overridden`覆寫傳入變量值
    * `preset_response` 預設回覆（僅當 action=direct\_output 返回）
    * `text` 覆寫的 LLM 回答內容（僅當 action=overridden 返回）。

\\

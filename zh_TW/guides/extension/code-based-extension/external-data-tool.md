# 外部數據工具

外部數據工具用於在終端用戶提交數據後，利用外部工具獲取額外數據組裝至提示詞中作為 LLM 額外上下文信息。Dify 默認提供了外部 API 調用的工具，具體參見 [api-based-extension](../api-based-extension/ "mention")。

而對於本地部署 Dify 的開發者，為了滿足更加定製化的需求，或者不希望額外開發一個 API Server，可以直接在 Dify 服務的基礎上，以插件的形式插入定製的外部數據工具實現邏輯。擴展自定義工具後，將會在工具類型的下拉列表中增加您的自定義工具選項，團隊成員即可使用自定義的工具來獲取外部數據。

## 快速開始

這裡以一個 `天氣查詢` 外部數據工具擴展為例，步驟如下：

1. 初始化目錄
2. 添加前端表單規範
3. 添加實現類
4. 預覽前端界面
5. 調試擴展

### 1. **初始化目錄**

新增自定義類型 `Weather Search` ，需要在 `api/core/external_data_tool` 目錄下新建相關的目錄和文件。

```python
.
└── api
    └── core
        └── external_data_tool
            └── weather_search
                ├── __init__.py
                ├── weather_search.py
                └── schema.json
```

### 2. **添加前端組件規範**

* `schema.json`，這裡定義了前端組件規範，詳細見 [Broken link](broken-reference "mention")

```json
{
    "label": {
        "en-US": "Weather Search",
        "zh-Hans": "天氣查詢"
    },
    "form_schema": [
        {
            "type": "select",
            "label": {
                "en-US": "Temperature Unit",
                "zh-Hans": "溫度單位"
            },
            "variable": "temperature_unit",
            "required": true,
            "options": [
                {
                    "label": {
                        "en-US": "Fahrenheit",
                        "zh-Hans": "華氏度"
                    },
                    "value": "fahrenheit"
                },
                {
                    "label": {
                        "en-US": "Centigrade",
                        "zh-Hans": "攝氏度"
                    },
                    "value": "centigrade"
                }
            ],
            "default": "centigrade",
            "placeholder": "Please select temperature unit"
        }
    ]
}
```

### 3. 添加實現類

`weather_search.py` 代碼模版，你可以在這裡實現具體的業務邏輯。

{% hint style="warning" %}
注意：類變量 name 為自定義類型名稱，需要跟目錄和文件名保持一致，而且唯一。
{% endhint %}

```python
from typing import Optional

from core.external_data_tool.base import ExternalDataTool


class WeatherSearch(ExternalDataTool):
    """
    The name of custom type must be unique, keep the same with directory and file name.
    """
    name: str = "weather_search"

    @classmethod
    def validate_config(cls, tenant_id: str, config: dict) -> None:
        """
        schema.json validation. It will be called when user save the config.

        Example:
            .. code-block:: python
                config = {
                    "temperature_unit": "centigrade"
                }

        :param tenant_id: the id of workspace
        :param config: the variables of form config
        :return:
        """

        if not config.get('temperature_unit'):
            raise ValueError('temperature unit is required')

    def query(self, inputs: dict, query: Optional[str] = None) -> str:
        """
        Query the external data tool.

        :param inputs: user inputs
        :param query: the query of chat app
        :return: the tool query result
        """
        city = inputs.get('city')
        temperature_unit = self.config.get('temperature_unit')

        if temperature_unit == 'fahrenheit':
            return f'Weather in {city} is 32°F'
        else:
            return f'Weather in {city} is 0°C'
```

### 4. **調試擴展**

至此，即可在 Dify 應用編排界面選擇自定義的 `Weather Search` 外部數據工具擴展類型進行調試。

## 實現類模版

```python
from typing import Optional

from core.external_data_tool.base import ExternalDataTool


class WeatherSearch(ExternalDataTool):
    """
    The name of custom type must be unique, keep the same with directory and file name.
    """
    name: str = "weather_search"

    @classmethod
    def validate_config(cls, tenant_id: str, config: dict) -> None:
        """
        schema.json validation. It will be called when user save the config.

        :param tenant_id: the id of workspace
        :param config: the variables of form config
        :return:
        """

        # implement your own logic here

    def query(self, inputs: dict, query: Optional[str] = None) -> str:
        """
        Query the external data tool.

        :param inputs: user inputs
        :param query: the query of chat app
        :return: the tool query result
        """
       
        # implement your own logic here
        return "your own data."
```

### 實現類開發詳細介紹

### def validate\_config

`schema.json` 表單校驗方法，當用戶點擊「發佈」保存配置時調用

* `config` 表單參數
  * `{{variable}}` 表單自定義變量

### def query

用戶自定義數據查詢實現，返回的結果將會被替換到指定的變量。

* `inputs` ：終端用戶傳入變量值
* `query` ：終端用戶當前對話輸入內容，對話型應用固定參數。

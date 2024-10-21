# 代碼擴展

對於在本地部署 Dify 的開發人員來說，代碼擴展可以在不重寫 API 服務的情況下實現功能的擴展。您可以在不破壞 Dify 原始代碼邏輯的情況下，以代碼形式擴展或增強程序的功能（即插件功能）。它遵循一定的接口或規範，以實現與主程序的兼容性和即插即用功能。目前，Dify 提供兩種代碼擴展：

* [外部數據工具](external-data-tool.md "mention")
* [敏感內容審核](moderation.md "mention")

基於上述功能，您可以按照代碼級接口規範實現橫向擴展。如果您願意為我們貢獻您的擴展功能，我們非常歡迎您為 Dify 提交 PR。

## 前端組件規範定義

代碼擴展的前端樣式通過 `schema.json` 進行定義：

* label: 自定義類型名稱，支持系統語言切換
* form_schema: 表單內容列表
  * type: 組件類型
    * select: 下拉選項
    * text-input: 文本
    * paragraph: 段落
  * label: 組件名稱，支持系統語言切換
  * variable: 變量名
  * required: 是否為必填
  * default：默認值
  * placeholder: 組件提示內容
  * options: 組件的專屬屬性，定義下拉內容
    * label：下拉菜單名稱，支持系統語言切換
    * value：下拉選項值
  * max_length：專屬屬性

### 模板示例

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
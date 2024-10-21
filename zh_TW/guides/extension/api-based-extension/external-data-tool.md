# 外部數據工具

在創建 AI 應用時，開發者可以通過 API 擴展的方式實現使用外部工具獲取額外數據組裝至 Prompt 中作為 LLM 額外信息。具體的實操過程可以參考 [API 擴展](../api-based-extension/ "mention")。

### 前置條件

請先閱讀 [.](./ "mention") 完成 API 服務基礎能力的開發和接入。

### 擴展點

`app.external_data_tool.query` 應用外部數據工具查詢擴展點。

該擴展點將終端用戶傳入的應用變量內容和對話輸入內容（對話型應用固定參數）作為參數，傳給 API。

開發者需要實現對應工具的查詢邏輯，並返回字符串類型的查詢結果。

#### Request Body <a href="#user-content-request-body" id="user-content-request-body"></a>

```
{
    "point": "app.external_data_tool.query", // 擴展點類型，此處固定為 app.external_data_tool.query
    "params": {
        "app_id": string,  // 應用 ID
        "tool_variable": string,  // 外部數據工具變量名稱，表示對應變量工具調用來源
        "inputs": {  // 終端用戶傳入變量值，key 為變量名，value 為變量值
            "var_1": "value_1",
            "var_2": "value_2",
            ...
        },
        "query": string | null  // 終端用戶當前對話輸入內容，對話型應用固定參數。
    }
}
```

* Example
  * ```
    {
        "point": "app.external_data_tool.query",
        "params": {
            "app_id": "61248ab4-1125-45be-ae32-0ce91334d021",
            "tool_variable": "weather_retrieve",
            "inputs": {
                "location": "London"
            },
            "query": "How's the weather today?"
        }
    }
    ```

#### API 返回 <a href="#usercontentapi-fan-hui" id="usercontentapi-fan-hui"></a>

```
{
    "result": string
}
```

* Example
  * ```
    {
        "result": "City: London\nTemperature: 10°C\nRealFeel®: 8°C\nAir Quality: Poor\nWind Direction: ENE\nWind Speed: 8 km/h\nWind Gusts: 14 km/h\nPrecipitation: Light rain"
    }
    ```

\\

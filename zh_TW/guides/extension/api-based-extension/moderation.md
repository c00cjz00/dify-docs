# 敏感內容審查

該模塊用於審查應用中終端用戶輸入的內容和 LLM 輸出的內容，分為兩個擴展點類型。

### 擴展點 <a href="#usercontent-kuo-zhan-dian" id="usercontent-kuo-zhan-dian"></a>

* `app.moderation.input` 終端用戶輸入的內容審查擴展點
  * 用於審查終端用戶傳入的變量內容以及對話型應用中對話的輸入內容。
* `app.moderation.output`LLM 輸出的內容審查擴展點
  * 用於審查 LLM 輸出的內容，
  * 當 LLM 輸出為流式時，輸出的內容將分 100 字為一個分段進行請求 API，儘可能避免輸出內容較長時，審查不及時的問題。

### app.moderation.input 擴展點 <a href="#usercontentappmoderationinput-kuo-zhan-dian" id="usercontentappmoderationinput-kuo-zhan-dian"></a>

#### Request Body <a href="#user-content-request-body" id="user-content-request-body"></a>

```
{
    "point": "app.moderation.input", // 擴展點類型，此處固定為 app.moderation.input
    "params": {
        "app_id": string,  // 應用 ID
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
        "point": "app.moderation.input",
        "params": {
            "app_id": "61248ab4-1125-45be-ae32-0ce91334d021",
            "inputs": {
                "var_1": "I will kill you.",
                "var_2": "I will fuck you."
            },
            "query": "Happy everydays."
        }
    }
    ```

#### API 返回 <a href="#usercontentapi-fan-hui" id="usercontentapi-fan-hui"></a>

```
{
    "flagged": bool,  // 是否違反校驗規則
    "action": string, // 動作，direct_output 直接輸出預設回答; overridden 覆寫傳入變量值
    "preset_response": string,  // 預設回答（僅當 action=direct_output 返回）
    "inputs": {  // 終端用戶傳入變量值，key 為變量名，value 為變量值（僅當 action=overridden 返回）
        "var_1": "value_1",
        "var_2": "value_2",
        ...
    },
    "query": string | null  // 覆寫的終端用戶當前對話輸入內容，對話型應用固定參數。（僅當 action=overridden 返回）
}
```

* Example
  * `action=``direct_output`
    * ```
      {
          "flagged": true,
          "action": "direct_output",
          "preset_response": "Your content violates our usage policy."
      }
      ```
  * `action=overridden`
    * ```
      {
          "flagged": true,
          "action": "overridden",
          "inputs": {
              "var_1": "I will *** you.",
              "var_2": "I will *** you."
          },
          "query": "Happy everydays."
      }
      ```

### app.moderation.output 擴展點 <a href="#usercontentappmoderationoutput-kuo-zhan-dian" id="usercontentappmoderationoutput-kuo-zhan-dian"></a>

#### Request Body <a href="#user-content-request-body-1" id="user-content-request-body-1"></a>

```
{
    "point": "app.moderation.output", // 擴展點類型，此處固定為 app.moderation.output
    "params": {
        "app_id": string,  // 應用 ID
        "text": string  // LLM 回答內容。當 LLM 輸出為流式時，此處為 100 字為一個分段的內容。
    }
}
```

* Example
  * ```
    {
        "point": "app.moderation.output",
        "params": {
            "app_id": "61248ab4-1125-45be-ae32-0ce91334d021",
            "text": "I will kill you."
        }
    }
    ```

#### API 返回 <a href="#usercontentapi-fan-hui-1" id="usercontentapi-fan-hui-1"></a>

```
{
    "flagged": bool,  // 是否違反校驗規則
    "action": string, // 動作，direct_output 直接輸出預設回答; overridden 覆寫傳入變量值
    "preset_response": string,  // 預設回答（僅當 action=direct_output 返回）
    "text": string  // 覆寫的 LLM 回答內容。（僅當 action=overridden 返回）
}
```

* Example
  * `action=direct_output`
    * ```
      {
          "flagged": true,
          "action": "direct_output",
          "preset_response": "Your content violates our usage policy."
      }
      ```
  * `action=overridden`
    * ```
      {
          "flagged": true,
          "action": "overridden",
          "text": "I will *** you."
      }
      ```

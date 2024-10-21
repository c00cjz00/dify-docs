# 基於 APIs 開發

Dify 基於“**後端即服務**”理念為所有應用提供了 API，為 AI 應用開發者帶來了諸多便利。通過這一理念，開發者可以直接在前端應用中獲取大型語言模型的強大能力，而無需關注複雜的後端架構和部署過程。

#### 使用 Dify API 的好處

* 讓前端應用直接安全地調用 LLM 能力，省去後端服務的開發過程
* 在可視化的界面中設計應用，並在所有客戶端中實時生效
* 對 LLM 供應商的基礎能力進行了良好封裝
* 隨時切換 LLM 供應商，並對 LLM 的密鑰進行集中管理
* 在可視化的界面中運營你的應用，例如分析日誌、標註及觀察用戶活躍
* 持續為應用提供更多工具能力、插件能力和數據集

#### 如何使用

選擇一個應用，在應用（Apps）左側導航中可以找到**訪問 API（API Access）**。在該頁面中你可以查看 Dify 提供的 API 文檔，並管理可訪問 API 的憑據。

<figure><img src="../../.gitbook/assets/api-access.png" alt=""><figcaption><p>訪問 API</p></figcaption></figure>

例如你是一個諮詢公司的開發部分，你可以基於公司的私有數據庫提供 AI 能力給終端用戶或開發者，但開發者無法掌握你的數據和 AI 邏輯設計，從而使得服務可以安全、可持續的交付並滿足商業目的。

{% hint style="warning" %}
在最佳實踐中，API 密鑰應通過後端調用，而不是直接以明文暴露在前端代碼或請求中，這樣可以防止你的應用被濫用或攻擊。
{% endhint %}

你可以為一個應用**創建多個訪問憑據**，以實現交付給不同的用戶或開發者。這意味著 API 的使用者雖然使用了應用開發者提供的 AI 能力，但背後的 Promp 工程、數據集和工具能力是經封裝的。

#### 文本生成型應用

可用於生成高質量文本的應用，例如生成文章、摘要、翻譯等，通過調用 completion-messages 接口，發送用戶輸入得到生成文本結果。用於生成文本的模型參數和提示詞模版取決於開發者在 Dify 提示詞編排頁的設置。

你可以在**應用 -> 訪問 API** 中找到該應用的 API 文檔與範例請求。

例如，創建文本補全信息的 API 的調用示例：

{% tabs %}
{% tab title="cURL" %}
```
curl --location --request POST 'https://api.dify.ai/v1/completion-messages' \
--header 'Authorization: Bearer ENTER-YOUR-SECRET-KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "inputs": {},
    "response_mode": "streaming",
    "user": "abc-123"
}'
```
{% endtab %}

{% tab title="Python" %}
```python
import requests
import json

url = "https://api.dify.ai/v1/completion-messages"

headers = {
    'Authorization': 'Bearer ENTER-YOUR-SECRET-KEY',
    'Content-Type': 'application/json',
}

data = {
    "inputs": {"text": 'Hello, how are you?'},
    "response_mode": "streaming",
    "user": "abc-123"
}

response = requests.post(url, headers=headers, data=json.dumps(data))

print(response.text)
```
{% endtab %}
{% endtabs %}

#### 對話型應用

可用於大部分場景的對話型應用，採用一問一答模式與用戶持續對話。要開始一個對話請調用 `chat-messages` 接口，每次對話開始都會產生出新的 `conversation\_id`，通過該`conversation\_id` 傳回接口就可繼續保持該會話。

#### `conversation_id` 的注意事項：

- **生成 `conversation_id`：**開始新對話時，請將 `conversation_id` 字段留空。系統將生成並返回一個新的 `conversation_id`，未來的交互中會使用該 `conversation_id` 繼續對話。
- **處理現有會話中的 `conversation_id`：**生成 `conversation_id` 後，對 API 的未來調用應包含此 `conversation_id`，以確保與 Dify 機器人的對話連續性。傳遞上一個 `conversation_id` 時，將忽略任何新的 `inputs`，僅處理正在進行的對話的 `query`。
- **管理動態變量：**如果在會話期間需要修改邏輯或變量，您可以使用會話變量（特定於會話的變量）來調整bot的行為或迴應。

你可以在**應用 -> 訪問 API** 中找到該應用的 API 文檔與範例請求。

例如，發送對話信息的 `chat-messages` API的調用示例：

{% tabs %}
{% tab title="cURL" %}
```
curl --location --request POST 'https://api.dify.ai/v1/chat-messages' \
--header 'Authorization: Bearer ENTER-YOUR-SECRET-KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "inputs": {},
    "query": "eh",
    "response_mode": "streaming",
    "conversation_id": "1c7e55fb-1ba2-4e10-81b5-30addcea2276",
    "user": "abc-123"
}'

```
{% endtab %}

{% tab title="Python" %}
```python
import requests
import json

url = 'https://api.dify.ai/v1/chat-messages'
headers = {
    'Authorization': 'Bearer ENTER-YOUR-SECRET-KEY',
    'Content-Type': 'application/json',
}
data = {
    "inputs": {},
    "query": "eh",
    "response_mode": "streaming",
    "conversation_id": "1c7e55fb-1ba2-4e10-81b5-30addcea2276",
    "user": "abc-123"
}

response = requests.post(url, headers=headers, data=json.dumps(data))

print(response.json())
```
{% endtab %}
{% endtabs %}

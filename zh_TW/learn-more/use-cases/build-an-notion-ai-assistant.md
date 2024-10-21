# 構建一個 Notion AI 助手

_作者：阿喬. Dify 用戶_

### 概述

Notion 是一個強大的知識管理工具。它的靈活性和可擴展性使其成為一個出色的個人知識庫和共享工作空間。許多人使用它來存儲他們的知識，並與他人協作，促進思想交流和新知識的創造。

然而，這些知識仍然是靜態的，因為用戶必須搜索他們需要的信息並閱讀其中的內容才能找到他們尋求的答案。這個過程既不特別高效，也不智能。 你是否曾經夢想過擁有一個基於你的 Notion 庫的 AI 助手？這個助手不僅可以幫助你審查知識庫，還可以像一位經驗豐富的管家一樣參與交流，甚至回答其他人的問題，就好像你是自己的個人 Notion 庫的主人一樣。

### 如何實現自己的 Notion AI 助手?

現在，你可以通過 Dify 來實現這個夢想。Dify 是一個開源的 LLMOps（大型語言模型運維）平臺。 ChatGPT 和 Claude 等大型語言模型已經利用其強大的能力改變了世界。它們的強大學習能力主要歸功於豐富的訓練數據。幸運的是，它們已經發展到足夠智能的程度，可以從你提供的內容中進行學習，從而使從個人 Notion 庫中生成創意成為現實。 在沒有 Dify 的情況下，你可能需要熟悉 langchain，這是一個簡化組裝這些要素過程的抽象概念。

### 如何使用Dify創建自己的AI助手?

訓練Notion AI助手的過程非常簡單。您只需要按照如下步驟操作:

1.登錄 Dify。

2.創建一個數據集。

3.將 Notion 和數據集連接起來。

4.開始訓練。

5.創建自己的AI應用程序。

#### 1. 登錄 Dify[​](https://wsyfin.com/notion-dify#1-login-to-dify) <a href="#id-1-login-to-dify" id="id-1-login-to-dify"></a>

點擊這裡登錄到 Dify。你可以使用你的 GitHub 或 Google 賬戶方便地登錄。

> 如果你使用 GitHub 賬戶登錄，不妨給這個[項目](https://github.com/langgenius/dify)點個星星吧？這真的對我們有很大的支持！

![login-1](https://pan.wsyfin.com/f/ERGcp/login-1.png)

#### 2.創建新的數據集 <a href="#id-2-create-a-new-datasets" id="id-2-create-a-new-datasets"></a>

點擊頂部側邊欄的 "Knowledge" 按鈕，然後點擊 "Create Knowledge" 按鈕。

![login-2](https://pan.wsyfin.com/f/G6ziA/login-2.png)

#### 3. 與 Notion 和您的數據集進行連接 <a href="#id-3-connect-with-notion-and-datasets" id="id-3-connect-with-notion-and-datasets"></a>

選擇 "Sync from Notion"，然後點擊 "Connect" 按鈕。

![connect-with-notion-1](https://pan.wsyfin.com/f/J6WsK/connect-with-notion-1.png)

然後，您將被重定向到 Notion 登錄頁面。使用您的 Notion 帳戶登錄。使用您的 Notion 帳戶登錄。

![connect-with-notion-2](https://pan.wsyfin.com/f/KrEi4/connect-with-notion-2.png)

檢查 Dify 所需的權限，然後單擊“選擇頁面”按鈕。

![connect-with-notion-3](https://pan.wsyfin.com/f/L91iQ/connect-with-notion-3.png)

選擇你要和 Dify 同步的頁面，然後點擊“允許訪問”按鈕。

![connect-with-notion-4](https://pan.wsyfin.com/f/M8Xtz/connect-with-notion-4.png)

#### 4. 開始訓練 <a href="#id-4-start-training" id="id-4-start-training"></a>

指定需要讓 AI 學習的頁面，使其能夠理解 Notion 中這個部分的內容。然後點擊 "下一步" 按鈕。

![train-1](https://pan.wsyfin.com/f/Nkjuj/train-1.png)

我們建議選擇 "自動" 和 "高質量" 的選項來訓練你的 AI 助手。然後點擊 "保存並處理" 按鈕。

![train-2](https://pan.wsyfin.com/f/OYoCv/train-2.png)

等待幾秒鐘，embedding 處理進程完成。

![train-3](https://pan.wsyfin.com/f/PN9F3/train-3.png)

#### 5. 創建你自己的 AI 應用程序[​](https://wsyfin.com/notion-dify#5-create-your-own-ai-application) <a href="#id-5-create-your-own-ai-application" id="id-5-create-your-own-ai-application"></a>

你需要創建一個AI應用，然後連接剛剛創建的數據集。返回到儀表板，然後點擊“創建新應用”按鈕。建議直接使用聊天應用。

![create-app-1](https://pan.wsyfin.com/f/QWRHo/create-app-1.png)

選擇“Prompt Eng.”並在“context”中添加你的 Notion 數據集。

![create-app-2](https://pan.wsyfin.com/f/R6DT5/create-app-2.png)

我建議在你的 AI 應用程序中添加一個「預設提示」。就像咒語對於哈利·波特來說是必不可少的一樣，某些工具或功能可以極大地增強 AI 應用程序的能力。

例如，如果你的 Notion 筆記主要關注軟件開發中的問題解決，可以在其中一個提示中寫道：

> 我希望你能在我的 Notion 工作區中扮演一個 IT 專家的角色，利用你對計算機科學、網絡基礎設施、Notion 筆記和 IT 安全的知識來解決問題。

<figure><img src="../../.gitbook/assets/image (34) (1).png" alt=""><figcaption></figcaption></figure>

建議初始時啟用 AI 主動提供用戶一個起始句子，給出可以詢問的線索。此外，激活「語音轉文字」功能可以讓用戶通過語音與你的 AI 助手進行互動。

<figure><img src="../../.gitbook/assets/image (42) (1).png" alt=""><figcaption></figcaption></figure>

現在您可以在“概覽”中單擊公共 URL 聊天與您自己的 AI 助手！

<figure><img src="../../.gitbook/assets/image (27) (1).png" alt=""><figcaption></figcaption></figure>

### 通過API集成到您的項目中​

通過 Dify 打造的每個 AI 應用程序都可以通過其 API 進行訪問。這種方法允許開發人員直接利用前端應用程序中強大的大型語言模型（LLM）的特性，提供真正的“後端即服務”（BaaS）體驗。

通過無縫的 API 集成，您可以方便地調用您的 Notion AI 應用程序，無需複雜的配置。

在概覽頁面上點擊「API 參考」按鈕。您可以將其作為您應用程序的 API 文檔參考。

![using-api-1](https://pan.wsyfin.com/f/wp0Cy/using-api-1.png)

#### 1. 生成 API 密鑰 <a href="#id-1-generate-api-secret-key" id="id-1-generate-api-secret-key"></a>

為了安全起見，建議生成 API 密鑰以訪問您的 AI 應用。

![using-api-2](https://pan.wsyfin.com/f/xk2Fx/using-api-2.png)

#### 2.檢索會話ID <a href="#id-2-retrieve-conversation-id" id="id-2-retrieve-conversation-id"></a>

與 AI 應用程序聊天后，您可以從“Logs & Ann.”頁面檢索會話 ID。

![using-api-3](https://pan.wsyfin.com/f/yPXHL/using-api-3.png)

#### 3. 調用API <a href="#id-3-invoke-api" id="id-3-invoke-api"></a>

您可以在API文檔上運行示例請求代碼來調用終端中的AI應用程序。

記住替換代碼中的SECRET KEY和conversation\_id。

您可以在第一次輸入空的conversation\_id，在收到包含conversation\_id的響應後將其替換。

```
curl --location --request POST 'https://api.dify.ai/v1/chat-messages' \
--header 'Authorization: Bearer ENTER-YOUR-SECRET-KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
    "inputs": {},
    "query": "eh",
    "response_mode": "streaming",
    "conversation_id": "",
    "user": "abc-123"
}'
```

在終端中發送請求，您將獲得成功的響應。

![using-api-4](https://pan.wsyfin.com/f/zpnI4/using-api-4.png)

如果您想繼續此聊天，請將請求代碼的`conversation_id`替換為您從響應中獲得的`conversation_id`。

你可以在`"Logs & Ann "`頁面查看所有的對話記錄。

![using-api-5](https://pan.wsyfin.com/f/ADQSE/using-api-5.png)

### 週期性地與 Notion 同步

如果你的 Notion 頁面更新了，你可以定期與 Dify 同步，讓你的人工智能助手保持最新狀態。你的人工智能助手將從新內容中學習並回答新問題。

![create-app-5](https://pan.wsyfin.com/f/XDBfO/create-app-5.png)

### 總結

在本教程中，我們不僅學會了如何將您的 Notion 數據導入到 Dify 中，還學會了如何使用 API 將其與您的項目集成。

Dify 是一個用戶友好的 LLMOps 平臺，旨在賦予更多人創建可持續的 AI 原生應用程序的能力。通過為各種應用類型設計的可視化編排，Dify 提供了可供使用的應用程序，可以幫助您利用數據打造獨特的 AI 助手。如果您有任何疑問，請隨時與我們聯繫。

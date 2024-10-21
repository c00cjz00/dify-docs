# 基於 WebApp 模板

如果開發人員從零開始開發新產品，或者處於產品原型設計階段，你可以使用Dify快速啟動人工智能網站。同時，Dify希望開發者能夠完全自由地創造出不同形式的前端應用。為此，我們提供:

* **SDK** 用於快速訪問各種語言的dify API
* **WebApp Template** 用於為每種類型的應用程序搭建WebApp開發腳手架

根據麻省理工學院的許可，WebApp模板是開源的。您可以自由地修改和部署它們以實現dify的所有功能，或者作為實現您自己的應用程序的參考代碼.

您可以在GitHub上找到這些模板:

* [Conversational app](https://github.com/langgenius/webapp-conversation)
* [Text generation app](https://github.com/langgenius/webapp-text-generator)

使用WebApp模板的最快捷方式是通過github點擊 "**Use this template**" , 這相當於派生一個新的存儲庫. 然後您需要配置dify應用ID和API密鑰, 比如:

```javascript
export const APP_ID = ''
export const API_KEY = ''
```

More config in `config/index.ts`:

```
export const APP_INFO: AppInfo = {
  "title": 'Chat APP',
  "description": '',
  "copyright": '',
  "privacy_policy": '',
  "default_language": 'zh-Hans'
}

export const isShowPrompt = true
export const promptTemplate = ''
```

每個WebApp模板都提供了一個包含部署說明的自述文件。通常，WebApp模板包含一個輕量級的後端服務，以確保開發者的API密鑰不會直接暴露給用戶.

這些WebApp模板可以幫助你快速構建AI應用的原型，並使用dify的所有功能。如果您在此基礎上開發自己的應用程序或新模板，請隨時與我們分享.

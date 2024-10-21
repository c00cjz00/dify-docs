# 基於前端模版再開發

如果開發者是從頭開發新產品或者在產品原型設計階段，你可以使用 Dify 快速發佈 AI 站點。與此同時，Dify 希望開發者能夠充分自由的創造不同形式的前端應用，為此我們提供了：

* **SDK**，用於在各種語言中快速接入 Dify API
* **WebApp Template**，每種類型應用的 WebApp 開發腳手架

WebApp Template 是基於 MIT 協議開源的，你可以充分自由的修改並部署他們，以實現 Dify 的所有能力。或者作為你實現自己 App 的一份參考代碼。

你可以在 GitHub 中找到這些 Template：

* [對話型應用](https://github.com/langgenius/webapp-conversation)
* [文本生成型應用](https://github.com/langgenius/webapp-text-generator)

使用 WebApp 模版最快的方法就是在 GitHub 中點擊「使用這個模版」，它相當於 Fork 了一個新的倉庫。隨後你需要配置 Dify 的 App ID 和 API Key，類似這樣：

````javascript
export const APP_ID = ''
export const API_KEY = ''
```

More config in `config/index.ts`:
```js
export const APP_INFO: AppInfo = {
  "title": 'Chat APP',
  "description": '',
  "copyright": '',
  "privacy_policy": '',
  "default_language": 'zh-Hans'
}

export const isShowPrompt = true
export const promptTemplate = ''
````

> App ID 可以在 App 的 URL 內獲取，其中的長串英文字符為唯一的 App ID。

每一種 WebApp 模版都提供了 README 文件，內含部署方式的說明。通常，WebApp 模版都包含了一個輕後端服務，這是為了確保開發者的 API KEY 不會直接暴露給用戶。

這些 WebApp 模版能夠幫助你快速搭建起 AI 應用原型，並使用 Dify 的所有能力。如果你基於它們開發了自己的應用或新的模版，歡迎你與我們分享。

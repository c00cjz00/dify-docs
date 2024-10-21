# 嵌入網站

Dify 支持將你的 AI 應用嵌入到業務網站中，你可以使用該能力在幾分鐘內製作具有業務數據的官網 AI 客服、業務知識問答等應用。點擊 WebApp 卡片上的嵌入按鈕，複製嵌入代碼，粘貼到你網站的目標位置。

當你在網站中使用 Dify 聊天機器人氣泡按鈕時，你可以自定義按鈕的樣式、位置和其他設置。

*   **iframe 標籤方式**

    將 iframe 代碼複製到你網站用於顯示 AI 應用的標籤中，如 `<div>`、`<section>` 等標籤。
*   **script 標籤方式**

    將 script 代碼複製到你網站 `<head>` 或 `<body>` 標籤中。

    <figure><img src="../../.gitbook/assets/image (69) (1).png" alt=""><figcaption></figcaption></figure>

    如果將 script 代碼粘貼到官網的 `<body>` 處，你將得到一個官網 AI 機器人：

    <figure><img src="../../.gitbook/assets/image (40) (1).png" alt=""><figcaption></figcaption></figure>

## 自定義 Dify 聊天機器人氣泡按鈕

Dify 聊天機器人氣泡按鈕可以通過以下配置選項進行自定義：

```javascript
window.difyChatbotConfig = {
    // 必填項，由 Dify 自動生成
    token: 'YOUR_TOKEN',
    // 可選項，默認為 false
    isDev: false,
    // 可選項，當 isDev 為 true 時，默認為 '[https://dev.udify.app](https://dev.udify.app)'，否則默認為 '[https://udify.app](https://udify.app)'
    baseUrl: 'YOUR_BASE_URL',
    // 可選項，可以接受除 `id` 以外的任何有效的 HTMLElement 屬性，例如 `style`、`className` 等
    containerProps: {},
    // 可選項，是否允許拖動按鈕，默認為 `false`
    draggable: false,
    // 可選項，允許拖動按鈕的軸，默認為 `both`，可以是 `x`、`y`、`both`
    dragAxis: 'both',
    // 可選項，在 dify 聊天機器人中設置的輸入對象
    inputs: {
        // 鍵是變量名
        // 例如：
        // name: "NAME"
    }

};
```

## 覆蓋默認按鈕樣式

你可以使用 CSS 變量或 `containerProps` 選項來覆蓋默認按鈕樣式。根據 CSS 優先級使用這些方法實現自定義樣式。

### 1.修改 CSS 變量

支持以下 CSS 變量進行自定義：

```css
/* 按鈕距離底部的距離，默認為 `1rem` */
--dify-chatbot-bubble-button-bottom

/* 按鈕距離右側的距離，默認為 `1rem` */
--dify-chatbot-bubble-button-right

/* 按鈕距離左側的距離，默認為 `unset` */
--dify-chatbot-bubble-button-left

/* 按鈕距離頂部的距離，默認為 `unset` */
--dify-chatbot-bubble-button-top

/* 按鈕背景顏色，默認為 `#155EEF` */
--dify-chatbot-bubble-button-bg-color

/* 按鈕寬度，默認為 `50px` */
--dify-chatbot-bubble-button-width

/* 按鈕高度，默認為 `50px` */
--dify-chatbot-bubble-button-height

/* 按鈕邊框半徑，默認為 `25px` */
--dify-chatbot-bubble-button-border-radius

/* 按鈕盒陰影，默認為 `rgba(0, 0, 0, 0.2) 0px 4px 8px 0px)` */
--dify-chatbot-bubble-button-box-shadow

/* 按鈕懸停變換，默認為 `scale(1.1)` */
--dify-chatbot-bubble-button-hover-transform
```

例如，要將按鈕背景顏色更改為 #ABCDEF，請添加以下 CSS：

```css
#dify-chatbot-bubble-button {
    --dify-chatbot-bubble-button-bg-color: #ABCDEF;
}
```

### 2.使用 `containerProps` 選項

使用 `style` 屬性設置內聯樣式：

```javascript
window.difyChatbotConfig = {
    // ... 其他配置
    containerProps: {
        style: {
            backgroundColor: '#ABCDEF',
            width: '60px',
            height: '60px',
            borderRadius: '30px',
        },
        // 對於較小的樣式覆蓋，也可以使用字符串作為 `style` 屬性的值：
        // style: 'background-color: #ABCDEF; width: 60px;',
    },
}
```

使用 `className` 屬性應用 CSS 類：

```javascript
window.difyChatbotConfig = {
    // ... 其他配置
    containerProps: {
        className: 'dify-chatbot-bubble-button-custom my-custom-class',
    },
};
```

### 3. 傳遞 `inputs`

支持四種類型的輸入：

1. **`text-input`**：接受任何值。如果輸入字符串的長度超過允許的最大長度，將被截斷。
2. **`paragraph`**：類似於 `text-input`，接受任何值並在字符串長度超過最大長度時截斷。
3. **`number`**：接受數字或數字字符串。如果提供的是字符串，將使用 `Number` 函數將其轉換為數字。
4. **`options`**：接受任何值，前提是它匹配預先配置的選項之一。

示例配置：

```javascript
window.difyChatbotConfig = {
    // ... 其他配置
    inputs: {
        name: 'apple',
    },
}
```

注意：使用 embed.js 腳本創建 iframe 時，每個輸入值將被處理——使用 GZIP 壓縮並以 base64 編碼——然後附加到 URL 上。

例如，處理後的輸入值 URL 將如下所示： `http://localhost/chatbot/{token}?name=H4sIAKUlmWYA%2FwWAIQ0AAACDsl7gLuiv2PQEUNAuqQUAAAA%3D`

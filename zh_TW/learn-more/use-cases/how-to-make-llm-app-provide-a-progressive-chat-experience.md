# 如何讓 LLM 應用提供循序漸進的聊天體驗？

讓 LLM 應用提供循序漸進的聊天體驗的關鍵在於，LLM 自身能夠感知到與用戶所處的對話輪數。例如在第五輪對話時深入擴展某項話題，或者在第 X 輪對話自動回顧歷史對話並給出覆盤分析。

本文將為你介紹如何使用 Chatflow 類型應用預置的 `sys.dialogue_count` 系統變量，利用其會隨著對話輪數自動新增 +1 的特性，編排出能夠感知對話輪數，並能夠向用戶提供循序漸進聊天體驗的 AI 應用。

### 場景 1：為用戶提供循序漸進的對話深度

**應用場景：AI 編程教師**

新手剛開始學習編程知識時，初始階段大量晦澀的專業名詞將造成困擾。一個理想的學習場景是老師能夠根據學生自身對知識的掌握情況，以及對話的聊天次數，循序漸進介紹更多教學內容並佈置合理的學習任務。

#### 設計思路

| 對話輪數    | 教學策略       | 內容重點                    |
| ------- | ---------- | ----------------------- |
| 1-5 輪   | 使用簡單、易懂的語言 | 介紹編程的基本概念（變量、數據類型、控制流等） |
| 6-10 輪  | 逐步引入基礎編程術語 | 深入探討基礎概念，提供更多示例         |
| 11-15 輪 | 使用更多專業術語   | 探討特定編程主題（如面向對象編程、數據結構）  |
| 15 輪以後  | 高級編程對話     | 討論高級概念、最佳實踐、項目開發        |

#### 實現方法

1. 設立第一個 LLM 節點，收集並分析用戶的初始編程水平能力
2. 新增數個條件分支，判斷該用戶與第一個 LLM 節點的對話次數
3. 將用戶分流至不同階段編程學習 LLM 節點。

在第一個 LLM 節點後新增數個條件分支，判斷 `sys.dialogue_count` 值的所處區間，然後分流至不同編程階段的 LLM 節點。

<figure><img src="https://langgenius.feishu.cn/space/api/box/stream/download/asynccode/?code=MzNlZjFlY2M5OTNmMmJlNmNhZmIwOWU0Y2VjZTRiZjJfZ0xsRm9BZHdRODJJa1VkblR1VWhnbm5KOE9ZdXFNcHNfVG9rZW46U25yVmJnT3Iyb0VPYVZ4RWF1d2NWQThUbk5mXzE3MjQ4MjU3ODc6MTcyNDgyOTM4N19WNA" alt=""><figcaption><p>AI 編程教師</p></figcaption></figure>

### 場景 2：定期回顧對話歷史

**應用場景：語言能力測試 AI 助手**

在學習新語言時，定期複習和鞏固知識點對於長期記憶至關重要。AI 語言學習助手可以通過跟蹤對話輪數，在適當的時機提供回顧和測試。

#### 設計思路

| 對話輪數   | 學習策略 | 活動類型                           | 目的        |
| ------ | ---- | ------------------------------ | --------- |
| 每 10 輪 | 知識回顧 | 簡短複習測驗                         | 鞏固近期學習的內容 |
| 每 20 輪 | 綜合測試 | 全面的語言能力測試，然後給出能力評估報告以及接下來的學習建議 | 評估整體學習進度  |

#### 實現方法

1. 設立第一個 LLM 對話應用，收集並分析用戶的初始語言能力，並給出訓練習題
2. 新增條件分支，在第 10 輪對話時制訂小型測驗，並給出學習回顧；在第 20 輪對話時給出更加全面的測驗和學習報告。其餘對話輪數則正常給出單個訓練習題。

通過在特定輪數回顧學生過往的學習分析報告，LLM 能夠更加像一個專業老師一樣重新審視並調整用戶的學習計劃。

<figure><img src="https://langgenius.feishu.cn/space/api/box/stream/download/asynccode/?code=ZjdjMjNmZmE4YzUzOWUwNDk5NjRkNzBkNjcxMzZiY2NfSENEZVZ1RFVnTkpGNTBESUVrVEtQVXZVUEdpMEcyOEZfVG9rZW46UlNMQmJSeG5Sb0pHVGF4U3FBQmNzSUlybjZkXzE3MjQ4MjU3ODc6MTcyNDgyOTM4N19WNA" alt=""><figcaption></figcaption></figure>

> 如果還想要了解更多關於工作流的編排技巧，請參考[《工作流》](https://docs.dify.ai/v/zh-hans/guides/workflow)。

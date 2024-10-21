# AlphaVantage 股票分析

> 工具作者 [@zhuhao](https://github.com/hwzhuhao)。

AlphaVantage 一個在線平臺，它提供金融市場數據和API，便於個人投資者和開發者獲取股票報價、技術指標和股票分析。本

## 1. 申請 AlphaVantage API Key

請在 [AlphaVantage](https://www.alphavantage.co/support/#api-key)申請 API Key。

## 2. 在 Dify 內填寫配置

在 Dify 導航頁內輕點 `工具 > AlphaVantage > 去授權` 填寫 API Key。

## 3. 使用工具

- **Chatflow / Workflow 應用**

Chatflow 和 Workflow 應用均支持添加 `AlphaVantage` 工具節點。添加後，需要在節點內的 “輸入變量 → 股票代碼” 通過[變量](https://docs.dify.ai/v/zh-hans/guides/workflow/variables)引用用戶輸入的查詢內容。最後在 “結束” 節點內使用變量引用 `AlphaVantage` 節點輸出的內容。

- **Agent 應用**

在 Agent 應用內添加 `AlphaVantage` 工具，然後在對話框內發送股票代碼或大致描述，調用工具得到準確的金融數據。

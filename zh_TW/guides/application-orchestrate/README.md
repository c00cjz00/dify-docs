# 構建

在 Dify 中，一個“應用”是指基於 GPT 等大語言模型構建的實際場景應用。通過創建應用，您可以將智能 AI 技術應用於特定的需求。它既包含了開發 AI 應用的工程範式，也包含了具體的交付物。

簡而言之，一個應用為開發者交付了：

* 封裝友好的 API，可由後端或前端應用直接調用，通過 Token 鑑權
* 開箱即用、美觀且託管的 WebApp，你可以 WebApp 的模版進行二次開發
* 一套包含提示詞工程、上下文管理、日誌分析和標註的易用界面

你可以任選**其中之一**或**全部**，來支撐你的 AI 應用開發。

### 應用類型 <a href="#application_type" id="application_type"></a>

Dify 中提供了四種應用類型：

* **聊天助手**：基於 LLM 構建對話式交互的助手
* **文本生成**：構建面向文本生成類任務的助手，例如撰寫故事、文本分類、翻譯等
* **Agent**：能夠分解任務、推理思考、調用工具的對話式智能助手
* **工作流**：基於流程編排的方式定義更加靈活的 LLM 工作流

文本生成與聊天助手的區別見下表：

<table><thead><tr><th width="180.33333333333331"></th><th>文本生成</th><th>聊天助手</th></tr></thead><tbody><tr><td>WebApp 界面</td><td>表單+結果式</td><td>聊天式</td></tr><tr><td>WebAPI 端點</td><td><code>completion-messages</code></td><td><code>chat-messages</code></td></tr><tr><td>交互方式</td><td>一問一答</td><td>多輪對話</td></tr><tr><td>流式結果返回</td><td>支持</td><td>支持</td></tr><tr><td>上下文保存</td><td>當次</td><td>持續</td></tr><tr><td>用戶輸入表單</td><td>支持</td><td>支持</td></tr><tr><td>數據集與插件</td><td>支持</td><td>支持</td></tr><tr><td>AI 開場白</td><td>不支持</td><td>支持</td></tr><tr><td>情景舉例</td><td>翻譯、判斷、索引</td><td>聊天</td></tr></tbody></table>

###

# Agent

### 定義

智能助手（Agent Assistant），利用大語言模型的推理能力，能夠自主對複雜的人類任務進行目標規劃、任務拆解、工具調用、過程迭代，並在沒有人類干預的情況下完成任務。

### 如何使用智能助手

為了方便快速上手使用，您可以在“探索”中找到智能助手的應用模板，添加到自己的工作區，或者在此基礎上進行自定義。在全新的 Dify 工作室中，你也可以從零編排一個專屬於你自己的智能助手，幫助你完成財務報表分析、撰寫報告、Logo 設計、旅程規劃等任務。

<figure><img src="../../.gitbook/assets/image (98).png" alt=""><figcaption><p>探索-智能助手應用模板</p></figcaption></figure>

選擇智能助手的推理模型，智能助手的任務完成能力取決於模型推理能力，我們建議在使用智能助手時選擇推理能力更強的模型系列如 gpt-4 以獲得更穩定的任務完成效果。

<figure><img src="../../.gitbook/assets/image (102).png" alt=""><figcaption><p>選擇智能助手的推理模型</p></figcaption></figure>

你可以在“提示詞”中編寫智能助手的指令，為了能夠達到更優的預期效果，你可以在指令中明確它的任務目標、工作流程、資源和限制等。

<figure><img src="../../.gitbook/assets/image (99).png" alt=""><figcaption><p>編排智能助手的指令提示詞</p></figcaption></figure>

### 添加助手需要的工具

在“上下文”中，你可以添加智能助手可以用於查詢的知識庫工具，這將幫助它獲取外部背景知識。

在“工具”中，你可以添加需要使用的工具。工具可以擴展 LLM 的能力，比如聯網搜索、科學計算或繪製圖片，賦予並增強了 LLM 連接外部世界的能力。Dify 提供了兩種工具類型：**第一方工具**和**自定義工具**。

你可以直接使用 Dify 生態提供的第一方內置工具，或者輕鬆導入自定義的 API 工具（目前支持 OpenAPI / Swagger 和 OpenAI Plugin 規範）。

<figure><img src="../../.gitbook/assets/image (100).png" alt=""><figcaption><p>添加助手需要的工具</p></figcaption></figure>

“工具”功能允許用戶藉助外部能力，在 Dify 上創建出更加強大的 AI 應用。例如你可以為智能助理型應用（Agent）編排合適的工具，它可以通過任務推理、步驟拆解、調用工具完成複雜任務。

另外工具也可以方便將你的應用與其他系統或服務連接，與外部環境交互。例如代碼執行、對專屬信息源的訪問等。你只需要在對話框中談及需要調用的某個工具的名字，即可自動調用該工具。

![](../../.gitbook/assets/zh-agent-dalle3.png)

### 配置 Agent

在 Dify 上為智能助手提供了 Function calling（函數調用）和 ReAct 兩種推理模式。已支持 Function Call 的模型系列如 gpt-3.5/gpt-4 擁有效果更佳、更穩定的表現，尚未支持 Function calling 的模型系列，我們支持了 ReAct 推理框架實現類似的效果。

在 Agent 配置中，你可以修改助手的迭代次數限制。

<figure><img src="../../.gitbook/assets/image (108).png" alt=""><figcaption><p>Function Calling 模式</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (110).png" alt=""><figcaption><p>ReAct 模式</p></figcaption></figure>

### 配置對話開場白

您可以為智能助手配置一套會話開場白和開場問題，配置的對話開場白將在每次用戶初次對話中展示助手可以完成什麼樣的任務，以及可以提出的問題示例。

<figure><img src="../../.gitbook/assets/image (101).png" alt=""><figcaption><p>配置會話開場白和開場問題</p></figcaption></figure>

### 調試與預覽

編排完智能助手之後，你可以在發佈成應用之前進行調試與預覽，查看助手的任務完成效果。

<figure><img src="../../.gitbook/assets/image (104).png" alt=""><figcaption><p>調試與預覽</p></figcaption></figure>

### 應用發佈

<figure><img src="../../.gitbook/assets/image (105).png" alt=""><figcaption><p>應用發佈為 Webapp</p></figcaption></figure>

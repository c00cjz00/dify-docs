# SiliconFlow (支持 Flux 繪圖)

> 工具作者 @hjlarry

SiliconCloud 基於優秀的開源基礎模型，提供高性價比的 GenAI 服務。你可以通過 **SiliconFlow** 在 Dify 內調用 Flux 、Stable Diffusion 繪圖模型，搭建你的專屬 AI 繪圖應用。以下是在 Dify 中配置 SiliconFlow 工具的步驟。

### 1. 申請 SiliconCloud API Key

請在 [SiliconCloud API 管理頁面](https://cloud.siliconflow.cn/account/ak) 新建 API Key 並保證有足夠餘額。

### 2. 在 Dify 內填寫配置

在 Dify 的工具頁中點擊 `SiliconCloud > 去授權` 填寫 API Key。

<figure><img src="../../../.gitbook/assets/截屏2024-09-26 23.12.01.png" alt=""><figcaption></figcaption></figure>

### 3. 使用工具

* **Chatflow / Workflow 應用**

Chatflow 和 Workflow 應用均支持添加 `SiliconFlow` 工具節點。

將用戶輸入的內容通過[變量](../../workflow/variables.md)傳遞至 Siliconflow 工具的 Flux 或 Stable Diffusion 節點內的“提示詞”“負面提示詞”框中，按照需求調整內置參數，最後在“結束”節點的回覆框中選中 Siliconflow 工具節點的輸出內容（文本、圖片等）。

<figure><img src="../../../.gitbook/assets/截屏2024-09-27 10.09.34.png" alt=""><figcaption></figcaption></figure>

* **Agent 應用**

在 Agent 應用內添加 `Stable Diffusion` 或 `Flux` 工具，然後在對話框內發送圖片描述，調用工具生成 AI 圖像。

<figure><img src="../../../.gitbook/assets/截屏2024-09-27 10.18.54.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/截屏2024-09-27 10.23.52.png" alt=""><figcaption></figcaption></figure>

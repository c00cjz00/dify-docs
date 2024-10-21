# 接入 OpenLLM 部署的本地模型

使用 [OpenLLM](https://github.com/bentoml/OpenLLM), 您可以針對任何開源大型語言模型進行推理,部署到雲端或本地,並構建強大的 AI 應用程序。
Dify 支持以本地部署的方式接入 OpenLLM 部署的大型語言模型的推理能力。

## 部署 OpenLLM 模型
### 開始部署

您可以通過以下方式部署：

```bash
docker run --rm -it -p 3333:3000 ghcr.io/bentoml/openllm start facebook/opt-1.3b --backend pt
```
> 注意：此處使用 facebook/opt-1.3b 模型僅作為示例，效果可能不佳，請根據實際情況選擇合適的模型，更多模型請參考：[支持的模型列表](https://github.com/bentoml/OpenLLM#-supported-models)。


模型部署完畢，在 Dify 中使用接入模型

   在 `設置 > 模型供應商 > OpenLLM` 中填入：

   - 模型名稱：`facebook/opt-1.3b`
   - 服務器 URL：`http://<Machine_IP>:3333` 替換成您的機器 IP 地址
   "保存" 後即可在應用中使用該模型。

本說明僅作為快速接入的示例，如需使用 OpenLLM 更多特性和信息，請參考：[OpenLLM](https://github.com/bentoml/OpenLLM)
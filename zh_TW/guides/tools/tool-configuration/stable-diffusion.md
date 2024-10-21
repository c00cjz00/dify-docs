# Stable Diffusion

> 工具作者 @Dify。

StableDiffusion 是一種基於文本提示生成圖像的工具，Dify 已經實現了訪問 Stable Diffusion WebUI API 的接口，因此你可以直接在 Dify 中使用它。以下是在 Dify 中集成 Stable Diffusion 的步驟。

## 1. 初始化本地環境

推薦使用裝有較強 GPU 的機器來安裝和驅動 Stable Diffusion，但這並不是必須的，你也可以使用 CPU 來生成圖像，但速度可能會很慢。

## 2. 安裝並啟動 Stable Diffusion WebUI

1. 從[官方倉庫](https://github.com/AUTOMATIC1111/stable-diffusion-webui)克隆 Stable Diffusion WebUI 倉庫
    
```bash
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui
```

2. 運行命令啟動 Stable Diffusion WebUI。

克隆倉庫後，切換到倉庫目錄。根據系統的不同，可能需要使用不同的命令來啟動 WebUI。

#### Windows

```bash
cd stable-diffusion-webui
./webui.bat --api --listen
```

#### Linux
```bash
cd stable-diffusion-webui
./webui.sh --api --listen
```

3. 準備模型

現在你可以根據終端中顯示的地址在瀏覽器中訪問 Stable Diffusion WebUI，但模型還不可用。你需要從 HuggingFace 或其他來源下載模型，並將其放在 Stable Diffusion WebUI 的 `models` 目錄中。

例如，我們使用 [pastel-mix](https://huggingface.co/JamesFlare/pastel-mix) 作為模型，使用 `git lfs` 下載模型並將其放在 `stable-diffusion-webui` 的 `models` 目錄中。

```bash
git clone https://huggingface.co/JamesFlare/pastel-mix
```

4. 獲取模型名稱

現在你可以在模型列表中看到 `pastel-mix`，但我們仍然需要獲取模型名稱，訪問 `http://your_id:port/sdapi/v1/sd-models`，你將看到如下的模型名稱。

```json
[
    {
        "title": "pastel-mix/pastelmix-better-vae-fp32.ckpt [943a810f75]",
        "model_name": "pastel-mix_pastelmix-better-vae-fp32",
        "hash": "943a810f75",
        "sha256": "943a810f7538b32f9d81dc5adea3792c07219964c8a8734565931fcec90d762d",
        "filename": "/home/takatost/stable-diffusion-webui/models/Stable-diffusion/pastel-mix/pastelmix-better-vae-fp32.ckpt",
        "config": null
    },
]
```

`model_name` 就是我們需要的，這個例子中是 `pastel-mix_pastelmix-better-vae-fp32`。

## 3. 在 Dify 集成 Stable Diffusion

在 `工具 > StableDiffusion > 去認證` 中填寫你在之前步驟中獲取的認證信息和模型配置。

## 4. 完成

- **Chatflow / Workflow 應用**

Chatflow 和 Workflow 應用均支持添加 `Stable Diffusion` 工具節點。添加後，需要在節點內的 “輸入變量 → 提示詞” 內填寫[變量](https://docs.dify.ai/v/zh-hans/guides/workflow/variables)引用用戶輸入的提示詞，或者是上一節點生成的內容。最後在 “結束” 節點內使用變量引用 `Stable Diffusion` 輸出的圖像。

- **Agent 應用**

在 Agent 應用內添加 `Stable Diffusion` 工具，然後在對話框內發送圖片描述，調用工具生成 AI 圖像。

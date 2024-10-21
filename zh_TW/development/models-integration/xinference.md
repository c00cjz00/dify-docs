# 接入 Xinference 部署的本地模型

[Xorbits inference](https://github.com/xorbitsai/inference) 是一個強大且通用的分佈式推理框架，旨在為大型語言模型、語音識別模型和多模態模型提供服務，甚至可以在筆記本電腦上使用。它支持多種與GGML兼容的模型,如 chatglm, baichuan, whisper, vicuna, orca 等。 Dify 支持以本地部署的方式接入 Xinference 部署的大型語言模型推理和 embedding 能力。

## 部署 Xinference

### 開始部署

部署 Xinference 有兩種方式，分別為[本地部署](https://github.com/xorbitsai/inference/blob/main/README\_zh\_CN.md#%E6%9C%AC%E5%9C%B0%E9%83%A8%E7%BD%B2)和[分佈式部署](https://github.com/xorbitsai/inference/blob/main/README\_zh\_CN.md#%E5%88%86%E5%B8%83%E5%BC%8F%E9%83%A8%E7%BD%B2)，以下以本地部署為例。

1.  首先通過 PyPI 安裝 Xinference：

    ```bash
    $ pip install "xinference[all]"
    ```
2.  本地部署方式啟動 Xinference：

    ```bash
    $ xinference-local
    2023-08-20 19:21:05,265 xinference   10148 INFO     Xinference successfully started. Endpoint: http://127.0.0.1:9997
    2023-08-20 19:21:05,266 xinference.core.supervisor 10148 INFO     Worker 127.0.0.1:37822 has been added successfully
    2023-08-20 19:21:05,267 xinference.deploy.worker 10148 INFO     Xinference worker successfully started.
    ```

    Xinference 默認會在本地啟動一個 worker，端點為：`http://127.0.0.1:9997`，端口默認為 `9997`。 默認只可本機訪問，可配置 `-H 0.0.0.0`，非本地客戶端可任意訪問。 如需進一步修改 host 或 port，可查看 xinference 的幫助信息：`xinference-local --help`。

    > 使用 Dify Docker 部署方式的需要注意網絡配置，確保 Dify 容器可以訪問到 Xinference 的端點，Dify 容器內部無法訪問到 localhost，需要使用宿主機 IP 地址。
3.  創建並部署模型

    進入 `http://127.0.0.1:9997` 選擇需要部署的模型和規格進行部署，如下圖所示：

    <figure><img src="../../.gitbook/assets/image (131).png" alt=""><figcaption></figcaption></figure>

    由於不同模型在不同硬件平臺兼容性不同，請查看 [Xinference 內置模型](https://inference.readthedocs.io/en/latest/models/builtin/index.html) 確定創建的模型是否支持當前硬件平臺。
4.  獲取模型 UID

    從上圖所在頁面獲取對應模型的 ID，如：`2c886330-8849-11ee-9518-43b0b8f40bea`
5.  模型部署完畢，在 Dify 中使用接入模型

    在 `設置 > 模型供應商 > Xinference` 中填入：

    * 模型名稱：`vicuna-v1.3`
    * 服務器 URL：`http://<Machine_IP>:9997` **替換成您的機器 IP 地址**
    * 模型 UID：`2c886330-8849-11ee-9518-43b0b8f40bea`

    "保存" 後即可在應用中使用該模型。

Dify 同時支持將 [Xinference embed 模型](https://github.com/xorbitsai/inference/blob/main/README\_zh\_CN.md#%E5%86%85%E7%BD%AE%E6%A8%A1%E5%9E%8B) 作為 Embedding 模型使用，只需在配置框中選擇 `Embeddings` 類型即可。

如需獲取 Xinference 更多信息，請參考：[Xorbits Inference](https://github.com/xorbitsai/inference/blob/main/README\_zh\_CN.md)

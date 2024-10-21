# 接入 Hugging Face 上的開源模型

Dify 支持 Text-Generation 和 Embeddings，以下是與之對應的 Hugging Face 模型類型：

* Text-Generation：[text-generation](https://huggingface.co/models?pipeline\_tag=text-generation\&sort=trending)，[text2text-generation](https://huggingface.co/models?pipeline\_tag=text2text-generation\&sort=trending)
* Embeddings：[feature-extraction](https://huggingface.co/models?pipeline\_tag=feature-extraction\&sort=trending)

具體步驟如下：

1. 你需要有 Hugging Face 賬號([註冊地址](https://huggingface.co/join))。
2. 設置 Hugging Face 的 API key([獲取地址](https://huggingface.co/settings/tokens))。
3. 進入 [Hugging Face 模型列表頁](https://huggingface.co/models)，選擇對應的模型類型。

<figure><img src="../../.gitbook/assets/image (14) (1) (1).png" alt=""><figcaption></figcaption></figure>

Dify 支持用兩種方式接入 Hugging Face 上的模型：

1. Hosted Inference API。這種方式是用的 Hugging Face 官方部署的模型。不需要付費。但缺點是，只有少量模型支持這種方式。
2. Inference Endpoint。這種方式是用 Hugging Face 接入的 AWS 等資源來部署模型，需要付費。

### 接入 Hosted Inference API 的模型

#### 1 選擇模型

模型詳情頁右側有包含 Hosted inference API 的 區域才支持 Hosted inference API 。如下圖所：

<figure><img src="../../.gitbook/assets/image (7) (1) (1).png" alt=""><figcaption></figcaption></figure>

在模型詳情頁，可以獲得模型的名稱。

<figure><img src="../../.gitbook/assets/image (8) (1) (1).png" alt=""><figcaption></figcaption></figure>

#### 2 在 Dify 中使用接入模型

在 `設置 > 模型供應商 > Hugging Face > 模型類型` 的 Endpoint Type 選擇 Hosted Inference API。如下圖所示：

<figure><img src="../../.gitbook/assets/image (160).png" alt=""><figcaption></figcaption></figure>

API Token 為文章開頭設置的 API Key。模型名字為上一步獲得的模型名字。

### 方式 2: Inference Endpoint

#### 1 選擇要部署模型

模型詳情頁右側的 `Deploy` 按鈕下有 Inference Endpoints 選項的模型才支持 Inference Endpoint。如下圖所示：

<figure><img src="../../.gitbook/assets/image (10) (1) (1).png" alt=""><figcaption></figcaption></figure>

#### 2 部署模型

點擊模型的部署按鈕，選擇 Inference Endpoint 選項。如果之前沒綁過銀行卡的，會需要綁卡。按流程走即可。綁過卡後，會出現下面的界面：按需求修改配置，點擊左下角的 Create Endpoint 來創建 Inference Endpoint。

<figure><img src="../../.gitbook/assets/image (11) (1) (1).png" alt=""><figcaption></figcaption></figure>

模型部署好後，就可以看到 Endpoint URL。

<figure><img src="../../.gitbook/assets/image (13) (1) (1).png" alt=""><figcaption></figcaption></figure>

#### 3 在 Dify 中使用接入模型

在 `設置 > 模型供應商 > Hugging Face > 模型類型` 的 Endpoint Type 選擇 Inference Endpoints。如下圖所示：

<figure><img src="../../.gitbook/assets/image (161).png" alt=""><figcaption></figcaption></figure>

API Token 為文章開頭設置的 API Key。`Text-Generation 模型名字隨便起，Embeddings 模型名字需要跟 Hugging Face 的保持一致。`Endpoint URL 為 上一步部署模型成功後獲得的 Endpoint URL。

<figure><img src="../../.gitbook/assets/image (158).png" alt=""><figcaption></figcaption></figure>

> 注意：Embeddings 的「用戶名 / 組織名稱」，需要根據你在 Hugging Face 的 [Inference Endpoints](https://huggingface.co/docs/inference-endpoints/guides/access) 部署方式，來填寫「[用戶名](https://huggingface.co/settings/account)」或者「[組織名稱](https://ui.endpoints.huggingface.co/)」。

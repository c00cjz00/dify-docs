# 如何連接 AWS Bedrock 知識庫？

本文將簡要介紹如何通過外部知識庫 API 將 Dify 平臺與 AWS Bedrock 知識庫相連接，使得 Dify 平臺內的 AI 應用能夠直接獲取存儲在 AWS Bedrock 知識庫中的內容，擴展新的信息來源渠道。

### 前置準備

* AWS Bedrock Knowledge Base
* Dify SaaS 服務 / Dify 社區版
* 後端 API 開發基礎知識

### 1. 註冊並創建 AWS Bedrock Knowledge Base

訪問 [AWS Bedrock](https://aws.amazon.com/bedrock/)，創建 Knowledge Base 服務。

<figure><img src="../../.gitbook/assets/image (360).png" alt=""><figcaption><p>創建 AWS Bedrock Knowledge Base</p></figcaption></figure>

### 2. 構建後端 API 服務

Dify 平臺尚不能直接連接 AWS Bedrock Knowledge Base，需要開發團隊參考 Dify 關於外部知識庫連接的 [API 定義](../../guides/knowledge-base/external-knowledge-api-documentation.md)，手動創建後端 API 服務，建立與 AWS Bedrock 的連接。具體架構示意圖請參考：

<figure><img src="../../.gitbook/assets/image (1) (1).png" alt=""><figcaption><p>構建後端 API 服務</p></figcaption></figure>

你可以參考以下 2 個代碼文件，構建後端服務 API。

`knowledge.py`

```python
from flask import request
from flask_restful import Resource, reqparse

from bedrock.knowledge_service import ExternalDatasetService


class BedrockRetrievalApi(Resource):
    # url : <your-endpoint>/retrieval
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument("retrieval_setting", nullable=False, required=True, type=dict, location="json")
        parser.add_argument("query", nullable=False, required=True, type=str,)
        parser.add_argument("knowledge_id", nullable=False, required=True, type=str)
        args = parser.parse_args()

        # Authorization check
        auth_header = request.headers.get("Authorization")
        if " " not in auth_header:
            return {
                "error_code": 1001,
                "error_msg": "Invalid Authorization header format. Expected 'Bearer <api-key>' format."
            }, 403
        auth_scheme, auth_token = auth_header.split(None, 1)
        auth_scheme = auth_scheme.lower()
        if auth_scheme != "bearer":
            return {
                "error_code": 1001,
                "error_msg": "Invalid Authorization header format. Expected 'Bearer <api-key>' format."
            }, 403
        if auth_token:
            # process your authorization logic here
            pass

        # Call the knowledge retrieval service
        result = ExternalDatasetService.knowledge_retrieval(
            args["retrieval_setting"], args["query"], args["knowledge_id"]
        )
        return result, 200
```

`knowledge_service.py`

```python
import boto3


class ExternalDatasetService:
    @staticmethod
    def knowledge_retrieval(retrieval_setting: dict, query: str, knowledge_id: str):
        # get bedrock client
        client = boto3.client(
            "bedrock-agent-runtime",
            aws_secret_access_key="AWS_SECRET_ACCESS_KEY",
            aws_access_key_id="AWS_ACCESS_KEY_ID",
            # example: us-east-1
            region_name="AWS_REGION_NAME",
        )
        # fetch external knowledge retrieval
        response = client.retrieve(
            knowledgeBaseId=knowledge_id,
            retrievalConfiguration={
                "vectorSearchConfiguration": {"numberOfResults": retrieval_setting.get("top_k"), "overrideSearchType": "HYBRID"}
            },
            retrievalQuery={"text": query},
        )
        # parse response
        results = []
        if response.get("ResponseMetadata") and response.get("ResponseMetadata").get("HTTPStatusCode") == 200:
            if response.get("retrievalResults"):
                retrieval_results = response.get("retrievalResults")
                for retrieval_result in retrieval_results:
                    # filter out results with score less than threshold
                    if retrieval_result.get("score") < retrieval_setting.get("score_threshold", .0):
                        continue
                    result = {
                        "metadata": retrieval_result.get("metadata"),
                        "score": retrieval_result.get("score"),
                        "title": retrieval_result.get("metadata").get("x-amz-bedrock-kb-source-uri"),
                        "content": retrieval_result.get("content").get("text"),
                    }
                    results.append(result)
        return {
            "records": results
        }
```

在此過程中，你可以構建 API 接口地址以及用於鑑權的 API Key 並用於後續的連接。

### 3. 獲取 AWS Bedrock Knowledge Base ID

登錄 AWS Bedrock Knowledge 後臺，獲取已創建 Knowledge Base 的 ID。此參數將會在[後續步驟](how-to-connect-aws-bderock.md#id-5.-lian-jie-wai-bu-zhi-shi-ku)用於與 Dify 平臺的連接。

<figure><img src="../../.gitbook/assets/image (359).png" alt=""><figcaption><p>獲取 AWS Bedrock Knowledge Base ID</p></figcaption></figure>

### 4. 關聯外部知識 API

前往 Dify 平臺中的 **“知識庫”** 頁，點擊右上角的 **“外部知識庫 API”**，輕點 **“添加外部知識庫 API”**。

按照頁面提示，依次填寫以下內容：

* 知識庫的名稱，允許自定義名稱，用於區分 Dify 平臺內所連接的不同外部知識 API；
* API 接口地址，外部知識庫的連接地址，可在[第二步](how-to-connect-aws-bderock.md#id-2.-gou-jian-hou-duan-api-fu-wu)中自定義。示例 `api-endpoint/retrieval`；
* API Key，外部知識庫連接密鑰，可在[第二步](how-to-connect-aws-bderock.md#id-2.-gou-jian-hou-duan-api-fu-wu)中自定義。

<figure><img src="../../.gitbook/assets/image (362).png" alt=""><figcaption></figcaption></figure>

### 5. 連接外部知識庫

前往 **“知識庫”** 頁，點擊添加知識庫卡片下方的 **“連接外部知識庫”** 跳轉至參數配置頁面。

<figure><img src="../../.gitbook/assets/image (363).png" alt=""><figcaption></figcaption></figure>

填寫以下參數：

* **知識庫名稱與描述**
*   **外部知識庫 API**

    選擇在[第四步](how-to-connect-aws-bderock.md#id-4.-guan-lian-wai-bu-zhi-shi-api)中關聯的外部知識庫 API
*   **外部知識庫 ID**

    填寫在[第三步](how-to-connect-aws-bderock.md#id-3.-huo-qu-aws-bedrock-knowledge-base-id)中獲取的 AWS Bedrock knowledge base ID
*   **調整召回設置**

    \*\*Top K：\*\*用戶發起提問時，將請求外部知識 API 獲取相關性較高的內容分段。該參數用於篩選與用戶問題相似度較高的文本片段。默認值為 3，數值越高，召回存在相關性的文本分段也就越多。

    \*\*Score 閾值：\*\*文本片段篩選的相似度閾值，只召回超過設置分數的文本片段，默認值為 0.5。數值越高說明對於文本與問題要求的相似度越高，預期被召回的文本數量也越少，結果也會相對而言更加精準。

<figure><img src="../../.gitbook/assets/image (364).png" alt=""><figcaption></figcaption></figure>

設置完成後即可建立與外部知識庫 API 的連接。

### 6. 測試外部知識庫連接與召回

建立與外部知識庫的連接後，開發者可以在 **“召回測試”** 中模擬可能的問題關鍵詞，預覽從 AWS Bedrock Knowledge Base 召回的文本分段。

<figure><img src="../../.gitbook/assets/image (366).png" alt=""><figcaption><p>測試外部知識庫的連接與召回</p></figcaption></figure>

若對於召回結果不滿意，可以嘗試修改召回參數或自行調整 AWS Bedrock Knowledge Base 的檢索設置。

<figure><img src="../../.gitbook/assets/image (367).png" alt=""><figcaption><p>調整 AWS Bedrock Knowledge Base 文本處理參數</p></figcaption></figure>

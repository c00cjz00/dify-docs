---
description: 作者： Allen。 Dify Technical Writer。
---

# 外部知識庫 API

## 端點

```
POST <your-endpoint>/retrieval
```

## 請求頭

該 API 用於連接團隊內獨立維護的知識庫，如需瞭解更多操作指引，請參考閱讀 [連接外部知識庫](https://docs.dify.ai/zh-hans/guides/knowledge-base/connect-external-knowledge-base)。你可以在 HTTP 請求頭的 `Authorization` 字段中使用 `API-Key` 來驗證權限。身份驗證邏輯由您在檢索 API 中定義，如下所示：

```
Authorization: Bearer {API_KEY}
```

## 請求體元素

請求接受以下 JSON 格式的數據。

| 屬性 | 是否必需 | 類型 | 描述 | 示例值 |
|------|----------|------|------|--------|
| knowledge_id | 是 | 字符串 | 知識庫唯一 ID | AAA-BBB-CCC |
| query | 是 | 字符串 | 用戶的查詢 | Dify 是什麼？ |
| retrieval_setting | 是 | 對象 | 知識檢索參數 | 見下文 |

`retrieval_setting` 屬性是一個包含以下鍵的對象：

| 屬性 | 是否必需 | 類型 | 描述 | 示例值 |
|------|----------|------|------|--------|
| top_k | 是 | 整數 | 檢索結果的最大數量 | 5 |
| score_threshold | 是 | 浮點數 | 結果與查詢相關性的分數限制，範圍：0~1 | 0.5 |

## 請求語法

```json
POST <your-endpoint>/retrieval HTTP/1.1
-- 請求頭
Content-Type: application/json
Authorization: Bearer your-api-key
-- 數據
{
    "knowledge_id": "your-knowledge-id",
    "query": "你的問題",
    "retrieval_setting":{
        "top_k": 2,
        "score_threshold": 0.5
    }
}
```

## 響應元素

如果操作成功，服務將返回 HTTP 200 響應。服務以 JSON 格式返回以下數據。

| 屬性 | 是否必需 | 類型 | 描述 | 示例值 |
|------|----------|------|------|--------|
| records | 是 | 對象列表 | 從知識庫查詢的記錄列表 | 見下文 |

`records` 屬性是一個包含以下鍵的對象列表：

| 屬性 | 是否必需 | 類型 | 描述 | 示例值 |
|------|----------|------|------|--------|
| content | 是 | 字符串 | 包含知識庫中數據源的文本塊 | Dify：GenAI 應用程序的創新引擎 |
| score | 是 | 浮點數 | 結果與查詢的相關性分數，範圍：0~1 | 0.5 |
| title | 是 | 字符串 | 文檔標題 | Dify 簡介 |
| metadata | 否 | json | 包含數據源中文檔的元數據屬性及其值 | 見示例 |

## 響應語法

```json
HTTP/1.1 200
Content-type: application/json
{
    "records": [{
                    "metadata": {
                            "path": "s3://dify/knowledge.txt",
                            "description": "dify 知識文檔"
                    },
                    "score": 0.98,
                    "title": "knowledge.txt",
                    "content": "這是外部知識的文檔。"
            },
            {
                    "metadata": {
                            "path": "s3://dify/introduce.txt",
                            "description": "dify 介紹"
                    },
                    "score": 0.66,
                    "title": "introduce.txt",
                    "content": "GenAI 應用程序的創新引擎"
            }
    ]
}
```

## 錯誤

如果操作失敗，服務將返回以下錯誤信息（JSON 格式）：

| 屬性 | 是否必需 | 類型 | 描述 | 示例值 |
|------|----------|------|------|--------|
| error_code | 是 | 整數 | 錯誤代碼 | 1001 |
| error_msg | 是 | 字符串 | API 異常描述 | 無效的 Authorization 頭格式。預期格式為 'Bearer <api-key>'。 |

`error_code` 屬性有以下類型：

| 代碼 | 描述 |
|------|------|
| 1001 | 無效的 Authorization 頭格式 |
| 1002 | 授權失敗 |
| 2001 | 知識庫不存在 |

### HTTP 狀態碼

**AccessDeniedException**
由於缺少訪問權限，請求被拒絕。請檢查您的權限並重試。
HTTP 狀態碼：403

**InternalServerException**
發生內部服務器錯誤。請重試您的請求。
HTTP 狀態碼：500
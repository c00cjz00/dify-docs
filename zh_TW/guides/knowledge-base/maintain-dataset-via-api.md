# 通過 API 維護知識庫

> 鑑權、調用方式與應用 Service API 保持一致，不同之處在於，所生成的單個知識庫 API token 具備操作當前賬號下所有可見知識庫的權限，請注意數據安全。

### 使用知識庫 API 的優勢

通過 API 維護知識庫可大幅提升數據處理效率，你可以通過命令行輕鬆同步數據，實現自動化操作，而無需在用戶界面進行繁瑣操作。

主要優勢包括:

* 自動同步: 將數據系統與 Dify 知識庫無縫對接，構建高效工作流程；
* 全面管理: 提供知識庫列表，文檔列表及詳情查詢等功能，方便你自建數據管理界面；
* 靈活上傳: 支持純文本和文件上傳方式,可針對分段（Chunks）內容的批量新增和修改操作；
* 提高效率: 減少手動處理時間，提升 Dify 平臺使用體驗。

### 如何使用

進入知識庫頁面，在左側的導航中切換至 **API** 頁面。在該頁面中你可以查看 Dify 提供的知識庫 API 文檔，並可以在 **API 密鑰** 中管理可訪問知識庫 API 的憑據。

<figure><img src="../../.gitbook/assets/dataset-api-token.png" alt=""><figcaption><p>Knowledge API Document</p></figcaption></figure>

### API 調用示例

#### 通過文本創建文檔

輸入示例：

```json
curl --location --request POST 'https://api.dify.ai/v1/datasets/{dataset_id}/document/create_by_text' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json' \
--data-raw '{"name": "text","text": "text","indexing_technique": "high_quality","process_rule": {"mode": "automatic"}}'
```

輸出示例：

```json
{
  "document": {
    "id": "",
    "position": 1,
    "data_source_type": "upload_file",
    "data_source_info": {
        "upload_file_id": ""
    },
    "dataset_process_rule_id": "",
    "name": "text.txt",
    "created_from": "api",
    "created_by": "",
    "created_at": 1695690280,
    "tokens": 0,
    "indexing_status": "waiting",
    "error": null,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "archived": false,
    "display_status": "queuing",
    "word_count": 0,
    "hit_count": 0,
    "doc_form": "text_model"
  },
  "batch": ""
}
```

#### 通過文件創建文檔

輸入示例：

```json
curl --location --request POST 'https://api.dify.ai/v1/datasets/{dataset_id}/document/create_by_file' \
--header 'Authorization: Bearer {api_key}' \
--form 'data="{"indexing_technique":"high_quality","process_rule":{"rules":{"pre_processing_rules":[{"id":"remove_extra_spaces","enabled":true},{"id":"remove_urls_emails","enabled":true}],"segmentation":{"separator":"###","max_tokens":500}},"mode":"custom"}}";type=text/plain' \
--form 'file=@"/path/to/file"'
```

輸出示例：

```json
{
  "document": {
    "id": "",
    "position": 1,
    "data_source_type": "upload_file",
    "data_source_info": {
      "upload_file_id": ""
    },
    "dataset_process_rule_id": "",
    "name": "Dify.txt",
    "created_from": "api",
    "created_by": "",
    "created_at": 1695308667,
    "tokens": 0,
    "indexing_status": "waiting",
    "error": null,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "archived": false,
    "display_status": "queuing",
    "word_count": 0,
    "hit_count": 0,
    "doc_form": "text_model"
  },
  "batch": ""
}

```

#### **創建空知識庫**

{% hint style="warning" %}
僅用來創建空知識庫
{% endhint %}

輸入示例：

```bash
curl --location --request POST 'https://api.dify.ai/v1/datasets' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json' \
--data-raw '{"name": "name", "permission": "only_me"}'
```

輸出示例：

```json
{
  "id": "",
  "name": "name",
  "description": null,
  "provider": "vendor",
  "permission": "only_me",
  "data_source_type": null,
  "indexing_technique": null,
  "app_count": 0,
  "document_count": 0,
  "word_count": 0,
  "created_by": "",
  "created_at": 1695636173,
  "updated_by": "",
  "updated_at": 1695636173,
  "embedding_model": null,
  "embedding_model_provider": null,
  "embedding_available": null
}
```

#### **知識庫列表**

輸入示例：

```bash
curl --location --request GET 'https://api.dify.ai/v1/datasets?page=1&limit=20' \
--header 'Authorization: Bearer {api_key}'
```

輸出示例：

```json
{
  "data": [
    {
      "id": "",
      "name": "知識庫名稱",
      "description": "描述信息",
      "permission": "only_me",
      "data_source_type": "upload_file",
      "indexing_technique": "",
      "app_count": 2,
      "document_count": 10,
      "word_count": 1200,
      "created_by": "",
      "created_at": "",
      "updated_by": "",
      "updated_at": ""
    },
    ...
  ],
  "has_more": true,
  "limit": 20,
  "total": 50,
  "page": 1
}
```

#### 刪除知識庫

輸入示例：

```json
curl --location --request DELETE 'https://api.dify.ai/v1/datasets/{dataset_id}' \
--header 'Authorization: Bearer {api_key}'
```

輸出示例：

```json
204 No Content
```

#### 通過文本更新文檔

此接口基於已存在知識庫，在此知識庫的基礎上通過文本更新文檔

輸入示例：

```bash
curl --location --request POST 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}/update_by_text' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json' \
--data-raw '{"name": "name","text": "text"}'
```

輸出示例：

```json
{
  "document": {
    "id": "",
    "position": 1,
    "data_source_type": "upload_file",
    "data_source_info": {
      "upload_file_id": ""
    },
    "dataset_process_rule_id": "",
    "name": "name.txt",
    "created_from": "api",
    "created_by": "",
    "created_at": 1695308667,
    "tokens": 0,
    "indexing_status": "waiting",
    "error": null,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "archived": false,
    "display_status": "queuing",
    "word_count": 0,
    "hit_count": 0,
    "doc_form": "text_model"
  },
  "batch": ""
}
```

#### 通過文件更新文檔

此接口基於已存在知識庫，在此知識庫的基礎上通過文件更新文檔的操作。

輸入示例：

```bash
curl --location --request POST 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}/update_by_file' \
--header 'Authorization: Bearer {api_key}' \
--form 'data="{"name":"Dify","indexing_technique":"high_quality","process_rule":{"rules":{"pre_processing_rules":[{"id":"remove_extra_spaces","enabled":true},{"id":"remove_urls_emails","enabled":true}],"segmentation":{"separator":"###","max_tokens":500}},"mode":"custom"}}";type=text/plain' \
--form 'file=@"/path/to/file"'
```

輸出示例：

```json
{
  "document": {
    "id": "",
    "position": 1,
    "data_source_type": "upload_file",
    "data_source_info": {
      "upload_file_id": ""
    },
    "dataset_process_rule_id": "",
    "name": "Dify.txt",
    "created_from": "api",
    "created_by": "",
    "created_at": 1695308667,
    "tokens": 0,
    "indexing_status": "waiting",
    "error": null,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "archived": false,
    "display_status": "queuing",
    "word_count": 0,
    "hit_count": 0,
    "doc_form": "text_model"
  },
  "batch": "20230921150427533684"
}
```


#### **獲取文檔嵌入狀態（進度）**

輸入示例：

```bash
curl --location --request GET 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{batch}/indexing-status' \
--header 'Authorization: Bearer {api_key}'
```

輸出示例：

```json
{
  "data":[{
    "id": "",
    "indexing_status": "indexing",
    "processing_started_at": 1681623462.0,
    "parsing_completed_at": 1681623462.0,
    "cleaning_completed_at": 1681623462.0,
    "splitting_completed_at": 1681623462.0,
    "completed_at": null,
    "paused_at": null,
    "error": null,
    "stopped_at": null,
    "completed_segments": 24,
    "total_segments": 100
  }]
}
```

#### **刪除文檔**

輸入示例：

```bash
curl --location --request DELETE 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}' \
--header 'Authorization: Bearer {api_key}'
```

輸出示例：

```bash
{
  "result": "success"
}
```

#### **知識庫文檔列表**

輸入示例：

```bash
curl --location --request GET 'https://api.dify.ai/v1/datasets/{dataset_id}/documents' \
--header 'Authorization: Bearer {api_key}'
```

輸出示例：

```json
{
  "data": [
    {
      "id": "",
      "position": 1,
      "data_source_type": "file_upload",
      "data_source_info": null,
      "dataset_process_rule_id": null,
      "name": "dify",
      "created_from": "",
      "created_by": "",
      "created_at": 1681623639,
      "tokens": 0,
      "indexing_status": "waiting",
      "error": null,
      "enabled": true,
      "disabled_at": null,
      "disabled_by": null,
      "archived": false
    },
  ],
  "has_more": false,
  "limit": 20,
  "total": 9,
  "page": 1
}
```

#### **新增分段**

輸入示例：

```bash
curl --location --request POST 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}/segments' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json' \
--data-raw '{"segments": [{"content": "1","answer": "1","keywords": ["a"]}]}'
```

輸出示例：

```json
{
  "data": [{
    "id": "",
    "position": 1,
    "document_id": "",
    "content": "1",
    "answer": "1",
    "word_count": 25,
    "tokens": 0,
    "keywords": [
        "a"
    ],
    "index_node_id": "",
    "index_node_hash": "",
    "hit_count": 0,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "status": "completed",
    "created_by": "",
    "created_at": 1695312007,
    "indexing_at": 1695312007,
    "completed_at": 1695312007,
    "error": null,
    "stopped_at": null
  }],
  "doc_form": "text_model"
}

```

### 查詢文檔分段

輸入示例：

```bash
curl --location --request GET 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}/segments' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json'
```

輸出示例：

```bash
{
  "data": [{
    "id": "",
    "position": 1,
    "document_id": "",
    "content": "1",
    "answer": "1",
    "word_count": 25,
    "tokens": 0,
    "keywords": [
        "a"
    ],
    "index_node_id": "",
    "index_node_hash": "",
    "hit_count": 0,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "status": "completed",
    "created_by": "",
    "created_at": 1695312007,
    "indexing_at": 1695312007,
    "completed_at": 1695312007,
    "error": null,
    "stopped_at": null
  }],
  "doc_form": "text_model"
}
```

### 刪除文檔分段

輸入示例：

```bash
curl --location --request DELETE 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}/segments/{segment_id}' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json'
```

輸出示例：

```bash
{
  "result": "success"
}
```

### 更新文檔分段

輸入示例：

```bash
curl --location --request POST 'https://api.dify.ai/v1/datasets/{dataset_id}/documents/{document_id}/segments/{segment_id}' \
--header 'Authorization: Bearer {api_key}' \
--header 'Content-Type: application/json'\
--data-raw '{"segment": {"content": "1","answer": "1", "keywords": ["a"], "enabled": false}}'
```

輸出示例：

```bash
{
  "data": [{
    "id": "",
    "position": 1,
    "document_id": "",
    "content": "1",
    "answer": "1",
    "word_count": 25,
    "tokens": 0,
    "keywords": [
        "a"
    ],
    "index_node_id": "",
    "index_node_hash": "",
    "hit_count": 0,
    "enabled": true,
    "disabled_at": null,
    "disabled_by": null,
    "status": "completed",
    "created_by": "",
    "created_at": 1695312007,
    "indexing_at": 1695312007,
    "completed_at": 1695312007,
    "error": null,
    "stopped_at": null
  }],
  "doc_form": "text_model"
}
```


### 錯誤信息

| 錯誤信息 | 錯誤碼 | 原因描述 |
|------|--------|---------|
| no_file_uploaded | 400 | 請上傳你的文件  |
| too_many_files | 400 | 只允許上傳一個文件  |
| file_too_large | 413 | 文件大小超出限制  |
| unsupported_file_type | 415 | 不支持的文件類型。目前只支持以下內容格式：`txt`, `markdown`, `md`, `pdf`, `html`, `html`, `xlsx`, `docx`, `csv` |
| high_quality_dataset_only | 400 | 當前操作僅支持"高質量"知識庫  |
| dataset_not_initialized | 400 | 知識庫仍在初始化或索引中。請稍候  |
| archived_document_immutable | 403 | 歸檔文檔不可編輯  |
| dataset_name_duplicate | 409 | 知識庫名稱已存在，請修改你的知識庫名稱  |
| invalid_action | 400 | 無效操作  |
| document_already_finished | 400 | 文檔已處理完成。請刷新頁面或查看文檔詳情  |
| document_indexing | 400 | 文檔正在處理中，無法編輯  |
| invalid_metadata | 400 | 元數據內容不正確。請檢查並驗證  |

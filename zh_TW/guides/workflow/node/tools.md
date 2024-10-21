# 工具

“工具”節點可以為工作流提供強大的第三方能力支持，分為以下三種類型：

* **內置工具**，Dify 第一方提供的工具，使用該工具前可能需要先給工具進行 **授權**。
* **自定義工具**，通過 [OpenAPI/Swagger 標準格式](https://swagger.io/specification/)導入或配置的工具。如果內置工具無法滿足使用需求，你可以在 **Dify 菜單導航 --工具** 內創建自定義工具。
* **工作流**，你可以編排一個更復雜的工作流，並將其發佈為工具。詳細說明請參考[工具配置說明](https://docs.dify.ai/v/zh-hans/guides/tools)。

### 添加工具節點

添加節點時，選擇右側的 “工具” tab 頁。配置工具節點一般分為兩個步驟：

1. 對工具授權/創建自定義工具/將工作流發佈為工具
2. 配置工具輸入和參數

<figure><img src="../../../.gitbook/assets/image (282).png" alt="" width="258"><figcaption><p>工具選擇</p></figcaption></figure>

工具節點可以連接其它節點，通過[變量](https://docs.dify.ai/v/zh-hans/guides/workflow/variables)處理和傳遞數據。

<figure><img src="../../../.gitbook/assets/image (283).png" alt=""><figcaption><p>配置 Google 搜索工具檢索外部知識</p></figcaption></figure>

### 將工作流應用發佈為工具

工作流應用可以被髮布為工具，並被其它工作流內的節點所應用。關於如何創建自定義工具和配置工具，請參考[工具配置說明](https://docs.dify.ai/v/zh-hans/guides/tools)。

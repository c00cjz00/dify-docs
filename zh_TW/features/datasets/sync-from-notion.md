# 概念同步

Dify的概念支持從概念導入並設置 **同步** 以便在概念更新後自動同步數據以進行更新.

### 鑑權

1. 當創建知識庫時, 選擇數據源, 點擊 **從概念同步--轉到連接**, 並根據提示完成授權驗證.
2. 你也可以: 點擊 **設置--數據源--添加數據源**, 點擊概念來源 **連接** 以完成鑑權.

<figure><img src="../../.gitbook/assets/notion-connect.png" alt=""><figcaption><p>概念鏈接</p></figcaption></figure>

### 導入數據

完成鑑權操作後, 前往構建知識庫頁面, 點擊 **概念同步**, 選擇要導入的所需授權頁面.

### 分段清洗

接下來, 選擇你的 **分段設置** 和 **索引方法**, **保存並處理**. 等待dify數據處理, 通常此步驟需要在LLM提供程序中使用令牌. 不僅支持導入普通頁面類型，還可以彙總保存數據庫類型下的頁面屬性.

_**便箋:當前不支持導入圖像和文件。表數據將轉換為文本.**_

### 同步概念數據

如果您的概念內容已被修改，您可以直接在dify知識文檔列表頁面上單擊[同步]按鈕，一鍵同步數據(請注意，每次單擊都會同步當前內容)。此步驟需要使用令牌.

<figure><img src="../../.gitbook/assets/sync-notion-data.png" alt=""><figcaption><p>同步概念數據</p></figcaption></figure>

### (社區版) 概念集成配置指南

集成分為兩種方式: **內部集成** 和 **公共集成** . 它可以按需在dify中配置.

有關這兩種集成方法的具體區別，請參閱 [概念正式說明](https://developers.notion.com/docs/authorization).

#### 1. **使用內部集成**

創建您的集成頁面 [集成設置](https://www.notion.so/my-integrations) . 默認狀態下, 所有集成都從內部集成開始; 內部集成將與您選擇的工作空間相關聯, 因此，您需要是工作區所有者才能創建集成.

**具體操作步驟:**

點擊 " **New integration** " 按鈕, 即默認為內部(不能修改), 選擇關聯的空間, 輸入名稱並上傳logo, 點擊"**提交**" 成功創建集成.

<figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

一旦創建了集成, 您可以根據需要更新其設置。 **性能** 此選項卡，然後再單擊 "**顯示**" 按鈕後 **密鑰** 複製您的密鑰.

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

將其複製並返回到dify源代碼 , 在 **.env** 文件與配置相關的環境變量中，環境變量如下:

**NOTION\_INTEGRATION\_TYPE** = 內部 或 **NOTION\_INTEGRATION\_TYPE** = 公用

**NOTION\_INTERNAL\_SECRET**= 你的內部密鑰

#### 2. **使用公共集成**

**您需要將內部集成升級為公共集成** , 導航到集成分發頁面，並切換開關以顯示集成.

要將開關切換到公共設置，您需要 **在組織信息中填寫其他信息**, 包括您的公司名稱, 網址, 和重定向目標路徑, 然後點擊 "提交" 按鈕.

<figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt=""><figcaption></figcaption></figure>

在您公共集成成功後， 在您的[集成設置頁面](https://www.notion.so/my-integrations), 您將能夠在[密鑰]選項卡中訪問集成的密鑰.

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>

返回到dify源代碼,在 **.env** 與文件配置相關的環境變量中, 環境變量如下:

**NOTION\_INTEGRATION\_TYPE**=公共

**NOTION\_CLIENT\_SECRET**=你的客戶端密鑰

**NOTION\_CLIENT\_ID**=你的客戶端id

配置完成後，您將能夠使用知識部分中的概念數據導入和同步功能.

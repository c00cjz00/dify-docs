# 團隊成員管理

本文將介紹如何在 Dify 團隊內管理成員。以下是各個 Dify 版本的團隊成員上限。

| Sandbox / Free | Professional | Team | 社區版 | 企業版 |
| -------------- | ------------ | ---- | --- | --- |
| 1              | 3            | 不限制  | 不限制 | 不限制 |

### 添加成員

{% hint style="info" %}
僅團隊所有者具備邀請團隊成員的權限。
{% endhint %}

團隊所有者點擊右上角頭像，然後輕點 **“成員”** → **“添加”**，輸入郵箱，分配成員權限完成添加。

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1).png" alt=""><figcaption><p>為團隊成員分配權限</p></figcaption></figure>

被邀請成員可以通過 URL 或郵箱進行註冊。

> 社區版團隊需在[環境變量](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/environments)中添加並啟用郵件服務，被邀成員才能收到邀請郵件。

### 成員權限

團隊成員分為所有者、管理員、編輯、成員。

* **所有者**
  * 角色描述：團隊中的首位成員，擁有最高權限，負責整個團隊的運營和管理工作。
  * 權限概覽：擁有管理團隊成員、調整成員權限、設置模型供應商、創建和刪除應用、創建知識庫、設置工具庫等權限。
* **管理員**
  * 角色描述：團隊中的管理員，負責管理團隊成員和模型供應商。
  * 權限概覽：無法調整成員權限；具備添加或移除團隊成員、設置模型供應商、創建、編輯和刪除應用、創建知識庫、設置工具庫等權限。
* **編輯**
  * 角色描述：團隊中的普通成員，負責協作創建和編輯應用。
  * 權限概覽：無法管理團隊成員、無法設置模型供應商、無法設置工具庫；具備創建、編輯和刪除應用、創建知識庫的權限。
* **成員**
  * 角色描述：團隊中的普通成員，僅允許查看和使用團隊內已創建的應用。
  * 權限概覽：僅具備使用團隊內應用、使用工具的權限。

### 移除成員

{% hint style="info" %}
僅團隊所有者具備移除團隊成員的權限。
{% endhint %}

點擊 Dify 團隊首頁右上角頭像，前往 **“設置”** → **“成員”** ，選擇需要被移除的成員的角色，輕點\*\*“移除團隊”\*\*。

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt=""><figcaption><p>移除成員</p></figcaption></figure>

### 常見問題

#### 1. 如何轉移團隊所有者？

團隊所有者具備最高權限，為了保持團隊結構的穩定性，團隊所有者一經創立無法手動轉移。

#### 2. 如何刪除團隊？

出於團隊數據安全考慮，團隊所有者無法自助刪除名下的團隊。

#### 3. 如何刪除團隊成員賬號？

團隊所有者 / 管理員均無法刪除團隊成員的賬號，刪除賬號需要賬號所有人主動申請，無法被其他人刪除。相較於刪除賬號，將成員移出團隊同樣可以關閉該用戶對團隊的訪問權限。
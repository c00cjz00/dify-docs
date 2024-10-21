# 問題分類

### **定義**

通過定義分類描述，問題分類器能夠根據用戶輸入，使用 LLM 推理與之相匹配的分類並輸出分類結果，向下遊節點提供更加精確的信息。

***

### **場景**

常見的使用情景包括**客服對話意圖分類、產品評價分類、郵件批量分類**等。

在一個典型的產品客服問答場景中，問題分類器可以作為知識庫檢索的前置步驟，對用戶輸入問題意圖進行分類處理，分類後導向下游不同的知識庫查詢相關的內容，以精確回覆用戶的問題。

下圖為產品客服場景的示例工作流模板：

<figure><img src="../../../.gitbook/assets/image (80).png" alt=""><figcaption></figcaption></figure>

在該場景中我們設置了 3 個分類標籤/描述：

* 分類 1 ：**與售後相關的問題**
* 分類 2：**與產品操作使用相關的問題**
* 分類 3 ：**其他問題**

當用戶輸入不同的問題時，問題分類器會根據已設置的分類標籤 / 描述自動完成分類：

* “**iPhone 14 如何設置通訊錄聯繫人？**” —> “**與產品操作使用相關的問題**”
* “**保修期限是多久？**” —> “**與售後相關的問題**”
* “**今天天氣怎麼樣？**” —> “**其他問題**”

***

### 如何配置

<figure><img src="../../../.gitbook/assets/image (81).png" alt=""><figcaption></figcaption></figure>

**配置步驟：**

1. **選擇輸入變量**，指用於分類的輸入內容，支持輸入[文件變量](../file-upload.md)。客服問答場景下一般為用戶輸入的問題 `sys.query`;
2. **選擇推理模型**，問題分類器基於大語言模型的自然語言分類和推理能力，選擇合適的模型將有助於提升分類效果；
3. **編寫分類標籤/描述**，你可以手動添加多個分類，通過編寫分類的關鍵詞或者描述語句，讓大語言模型更好的理解分類依據。
4. **選擇分類對應的下游節點，**問題分類節點完成分類之後，可以根據分類與下游節點的關係選擇後續的流程路徑。

#### **高級設置：**

**指令：**你可以在 **高級設置-指令** 裡補充附加指令，比如更豐富的分類依據，以增強問題分類器的分類能力。

**記憶：**開啟記憶後問題分類器的每次輸入將包含對話中的聊天曆史，以幫助 LLM 理解上文，提高對話交互中的問題理解能力。

**圖片分析：**僅適用於具備圖片識別能力的 LLM，允許輸入圖片變量。

**記憶窗口：**記憶窗口關閉時，系統會根據模型上下文窗口動態過濾聊天曆史的傳遞數量；打開時用戶可以精確控制聊天曆史的傳遞數量（對數）。

**輸出變量：**

`class_name`

即分類之後輸出的分類名。你可以在下游節點需要時使用分類結果變量。
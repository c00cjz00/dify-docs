# LLM 配置與使用

### 1. 如何在國內環境中使用 OpenAI 代理服務器進行訪問？

Dify 支持 OpenAI 的自定義 API 域名能力，支持任何兼容 OpenAI 的大模型 API 服務器。社區版中，通過 **設置 --> 模型供應商 --> OpenAI --> 編輯 API** 入口處填寫目標服務器地址即可。

### **2. 如何選擇基礎模型？**

* gpt-3.5-turbo gpt-3.5-turbo 是 gpt-3 模型系列的升級版，它比 gpt-3 更強大，可以處理更復雜的任務。 它在理解長文本和跨文檔推理方面有重大提高。 gpt-3.5 turbo 可以產生更連貫和更具說服力的文本。它在摘要、翻譯和創意寫作方面也有很大提高。 擅長：**長文本理解、跨文檔推理、摘要、翻譯、創意寫作。**
* gpt-4 gpt-4 是最新最強大的 Transformer 語言模型。它擁有預訓練的參數量增至約 200 億，這使其在所有語言任務上都達到了最高水平，特別是在需要深入理解和生成長、複雜響應的任務上。gpt-4 可以處理人類語言的所有方面，包括理解抽象概念和跨頁面的推理。gpt-4 是第一個真正的通用語言理解系統，它可以勝任人工智能領域內的任何自然語言處理任務。擅長： **所有 NLP 任務，語言理解，長文本生成，跨文檔推理，抽象概念理解**具體可參考[文檔](https://platform.openai.com/docs/models/overview)。

### **3. 為什麼建議 max\_tokens 設置小一點？**

因為在自然語言處理中，較長的文本輸出通常需要更長的計算時間和更多的計算資源。因此，限制輸出文本的長度可以在一定程度上降低計算成本和計算時間。例如設置：max\_tokens=500 ，表示最多隻考慮輸出文本的前 500 個 token，而超過這個長度的部分將會被丟棄。這樣做的目的是保證輸出文本的長度不會超過 LLM 的接受範圍，同時還可以充分利用計算資源，提高模型的運行效率。另一方面，更多的情況是，限制 max\_tokens 能夠增加 prompt 的長度，如 gpt-3.5-turbo 的限制為 4097 tokens，如果設置 max\_tokens=4000，那麼 prompt 就只剩下 97 tokens 可用，如果超過就會報錯。

### **4. 數據集長文本如何切分比較合理？**

在一些自然語言處理應用中，通常會將文本按照段落或者句子進行切分，以便更好地處理和理解文本中的語義和結構信息。最小切分單位取決於具體的任務和技術實現。例如：

* 對於文本分類任務，通常將文本按照句子或者段落進行切分
* 對於機器翻譯任務，則需要將整個句子或者段落作為切分單位。

最後，還需要進行實驗和評估來確定最合適的 embedding 技術和切分單位。可以在測試集上 / 命中測試比較不同技術和切分單位的性能表現，並選擇最優的方案。

### 5. 我們在獲取數據集分段時用的什麼距離函數？

我們使用[餘弦相似度](https://en.wikipedia.org/wiki/Cosine\_similarity)。距離函數的選擇通常無關緊要。OpenAI 嵌入被歸一化為長度 1，這意味著：

僅使用點積可以稍微更快地計算餘弦相似度

餘弦相似度和歐幾里德距離將導致相同的排名

* > 如果將歸一化後的嵌入向量用於計算餘弦相似度或歐幾里德距離，並基於這些相似性度量對向量進行排序，得到的排序結果將是相同的。也就是說，無論是使用餘弦相似度還是歐幾里德距離來衡量向量之間的相似性，排序後的結果將是一致的。這是因為在歸一化後，向量的長度不再影響它們之間的相對關係，只有方向信息被保留下來。因此，使用歸一化的向量進行相似性度量時，不同的度量方法將得到相同的排序結果。在向量歸一化後，將所有向量的長度縮放到 1，這意味著它們都處於單位長度上。單位向量只描述了方向而沒有大小，因為它們的長度恆為 1。_具體原理可問 ChatGPT._

當嵌入向量被歸一化為長度 1 後，計算兩個向量之間的餘弦相似度可以簡化為它們的點積。因為歸一化後的向量長度都為 1，點積的結果就等同於餘弦相似度的結果。由於點積運算相對於其他相似度度量（如歐幾里德距離）的計算速度更快，因此使用歸一化的向量進行點積計算可以稍微提高計算效率。

### 6. 填寫 OpenAI key，校驗失敗報錯提示：“**校驗失敗： You exceeded your current quota， please check your plan and billing details。**”是什麼原因？

說明你的 OpenAI key 的賬號沒費用了，請前往 OpenAI 充值。

### 7. 使用 OpenAI 的 key 在應用裡對話，有如下報錯提示，是什麼原因？

報錯一：

```JSON
The server encountered an internal error and was unable to complete your request。Either the server is overloaded or there is an error in the application
```

報錯二：

```JSON
Rate limit reached for default-gpt-3.5-turboin organization org-wDrZCxxxxxxxxxissoZb on requestsper min。 Limit: 3 / min. Please try again in 20s. Contact us through our help center   at help.openai.com   if you continue to haveissues. Please add a payment method toyour account to increase your rate limit.Visit https://platform.openai.com/account/billingto add a payment method.
```

請檢查是否達到了官方接口調用速率限制。具體請參考 [OpenAI 官方文檔說明](https://platform.openai.com/docs/guides/rate-limits)。

### 8. 用戶自部署後，智聊不可使用，報錯如下：**Unrecognized request argument supplied:functions**，該怎麼解決？

首先請檢查前後端版本是否是最新版且前後端版本保持一致；其次，該錯誤有可能是因為您使用了 Azure OpenAI 的 key，但沒有成功部署模型，請檢查您使用的 Azure OpenAI 裡是否部署了模型；其中 gpt-3.5-turbo 模型版本必須是 0613 以上版本。（因為 0613 之前的版本不支持 智聊 所使用的 function call 能力，所以無法使用）

### 9. 設置 OpenAI Key 時，報錯如下，是什麼原因？

```JSON
Error communicating with OpenAl: HTTPSConnectionPool(host='api.openai.com', port=443): Max retriesexceeded with url: /v1/chat/completions (Caused byNewConnectionError( <urllib3.connection.HTTPSConnection object at 0x7f0462ed7af0>; Failed toestablish a new connection: [Errno -3] Temporary failure in name resolution'))
```

通常情況下是由於您的環境設置了代理，請檢查是否設置代理。

### 10. 應用裡切換模型使用時遇到如下報錯，該怎麼解決？

```JSON
Anthropic: Error code: 400 - f'error': f'type': "invalid request error, 'message': 'temperature: range: -1 or 0..1)
```

由於每個模型的參數取值不同，需要按照當前模型的該參數值範圍設置。

### 11. 遇到如下報錯提示，該如何解決？

```JSON
Query or prefix prompt is too long, you can reduce the preix prompt, or shrink the max token, or switch to a llm with a larger token limit size
```

在編排頁參數設置裡，調小“最大 token”的值即可。

### 12. Dify 裡面默認的模型是什麼，可否使用開源的模型？

默認的模型可以在 **設置 - 模型供應商** 處配置，目前支持 OpenAI / Azure OpenAl / Anthropic 等模型廠商的文本生成型模型，同時支持 Hugging Face/ Replicate / xinference 上託管的開源模型的接入。

### 13. 在社區版中，數據集開啟 **Q\&A 分段模式**一直顯示排隊中，是什麼原因？

請檢查您所使用的 Embedding 模型 api-key 是否達到了速率限制。

### 14. 用戶在使用應用時遇到報錯“Invalid token”，該怎麼解決？

如果遇到報錯為 “Invalid token”，你可嘗試如下兩種解決辦法：

* 瀏覽器清除緩存（Cookies、Session Storage 和 Local Storage），如果是手機裡使用則清除對應 APP 的緩存，重新訪問；
* 二是重新生成一個 App 網址，重新網址進入即可。

### 15. 數據集文檔上傳的大小限制有哪些？

目前數據集文檔上傳單個文檔最大是 15MB，總文檔數量限制 100 個。如您本地部署版本需要調整修改該限制，請參考[文檔](https://docs.dify.ai/v/zh-hans/getting-started/faq/install-faq#11.-ben-di-bu-shu-ban-ru-he-jie-jue-shu-ju-ji-wen-dang-shang-chuan-de-da-xiao-xian-zhi-he-shu-liang)。

### 16. 為什麼選擇了 Claude 模型，還是會消耗 OpenAI 的費用？

因為 Claude 不支持 Embedding 模型，因此 Embedding 過程以及其他對話生成，下一個問題建議等默認都是用的 OpenAI 的 key，因此還是會消耗 OpenAI 的額度。也可以在**設置-模型供應商**裡設置其他默認推理模型和 Embedding 模型。

### 17. 有什麼方式能控制更多地使用上下文數據而不是模型自身生成能力嗎？

是否使用數據集，會和數據集的描述有關係，儘可能把數據集描述寫清楚，具體可參考[此文檔編寫技巧](https://docs.dify.ai/v/zh-hans/advanced/datasets)。

### 18. 上傳數據集文檔是 Excel，該如何更好地分段？

首行設置表頭，後面每行顯示內容，不要有其他多餘的表頭設置，不要設置複雜格式的表格內容。

如下方表格示例，僅需保留第二行的表頭，首行（表格1）為多餘表頭，需刪掉。

<figure><img src="../../.gitbook/assets/image (135).png" alt=""><figcaption></figcaption></figure>

### 19. 買了 ChatGPT plus，為什麼在 dify 裡還不能使用 GPT4？

OpenAI 的 GPT4 模型 API 和 ChatGPT Plus 是兩個產品。模型的 API 有自己的定價，具體參考 [OpenAI 定價文檔](https://openai.com/pricing) 。付費申請要先綁卡，綁了卡會有 GPT3.5 的權限，但沒有 GPT4 的權限，GPT4 的權限得有一次支付的賬單，具體參考 [OpenAI 官方文檔](https://platform.openai.com/account/billing/overview)。

### 20. 如何增加其他的 Embedding Model？

Dify 支持以下作為 Embedding 模型使用，只需在配置框中選擇 `Embeddings` 類型即可。

* Azure
* LocalAI
* MiniMax
* OpenAI
* Replicate
* XInference

### 21. 如何把自己創建的應用設置成應用模板？

該功能為 Dify 官方提供的應用模板供雲端版用戶參考使用，暫未支持將自己創建的應用設置成應用模板。如您使用雲端版，可 **添加到工作區** 或 **自定義** 修改後成為你自己的應用。如您使用社區版，需要為團隊內創建更多的應用模板，您可諮詢我們商業化團隊獲得付費的技術支持：`business@dify.ai`

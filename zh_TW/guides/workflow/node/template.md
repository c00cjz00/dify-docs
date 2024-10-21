# 模板轉換

### 定義

允許藉助 Jinja2 的 Python 模板語言靈活地進行數據轉換、文本處理等。

### 什麼是 Jinja？

> Jinja is a fast, expressive, extensible templating engine.
>
> Jinja 是一個快速、表達力強、可擴展的模板引擎。

—— [https://jinja.palletsprojects.com/en/3.1.x/](https://jinja.palletsprojects.com/en/3.1.x/)

### 場景

模板節點允許你藉助 Jinja2 這一強大的 Python 模板語言，在工作流內實現輕量、靈活的數據轉換，適用於文本處理、JSON 轉換等情景。例如靈活地格式化併合並來自前面步驟的變量，創建出單一的文本輸出。這非常適合於將多個數據源的信息彙總成一個特定格式，滿足後續步驟的需求。

**示例1：**將多個輸入（文章標題、介紹、內容）拼接為完整文本

<figure><img src="../../../.gitbook/assets/image (209).png" alt="" width="375"><figcaption><p>拼接文本</p></figcaption></figure>

**示例2：**將知識檢索節點獲取的信息及其相關的元數據，整理成一個結構化的 Markdown 格式

{% code fullWidth="false" %}
```Plain
{% raw %}
{% for item in chunks %}
### Chunk {{ loop.index }}. 
### Similarity: {{ item.metadata.score | default('N/A') }}

#### {{ item.title }}

##### Content
{{ item.content | replace('\n', '\n\n') }}

---
{% endfor %}
{% endraw %}
```
{% endcode %}

<figure><img src="../../../.gitbook/assets/image (210).png" alt=""><figcaption><p>知識檢索節點輸出轉換為 Markdown</p></figcaption></figure>

你可以參考 Jinja 的[官方文檔](https://jinja.palletsprojects.com/en/3.1.x/templates/)，創建更為複雜的模板來執行各種任務。

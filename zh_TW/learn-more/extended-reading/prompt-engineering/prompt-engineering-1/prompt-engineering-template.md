# 提示詞初始模版參考

為了實現對 LLM 更加定製化的要求來滿足開發人員的需要，Dify 在**專家模式**下將內置的完整提示詞完全開放，並在編排界面提供了初始模版。以下是四種初始模版參考：

### 1. 使用聊天模型構建對話型應用模版

* **SYSTEM**

```
Use the following context as your learned knowledge, inside <context></context> XML tags.

<context>
{{#context#}}
</context>

When answer to user:
- If you don't know, just say that you don't know.
- If you don't know when you are not sure, ask for clarification.
Avoid mentioning that you obtained the information from the context.
And answer according to the language of the user's question.
{{pre_prompt}}
```

* **USER**

```
{{Query}} //這裡輸入查詢的變量
```

* **ASSISTANT**

```Python
"" 
```

#### **模板結構（Prompt Structure）：**

* 上下文（`Context`）
* 預編排提示詞（`Pre-prompt`）
* 查詢變量（`Query`）

### 2. 使用聊天模型構建文本生成型應用模版

* **SYSTEM**

```
Use the following context as your learned knowledge, inside <context></context> XML tags.

<context>
{{#context#}}
</context>

When answer to user:
- If you don't know, just say that you don't know.
- If you don't know when you are not sure, ask for clarification.
Avoid mentioning that you obtained the information from the context.
And answer according to the language of the user's question.
{{pre_prompt}}
```

* **USER**

```
{{Query}} //這裡輸入查詢的變量，常用的是輸入段落形式的變量
```

* **ASSISTANT**

```Python
"" 
```

#### **模板結構（Prompt Structure）：**

* 上下文（`Context`）
* 預編排提示詞（`Pre-prompt`）
* 查詢變量（`Query`）

### 3. 使用文本補全模型構建對話型應用模版

```Python
Use the following context as your learned knowledge, inside <context></context> XML tags.

<context>
{{#context#}}
</context>

When answer to user:
- If you don't know, just say that you don't know.
- If you don't know when you are not sure, ask for clarification.
Avoid mentioning that you obtained the information from the context.
And answer according to the language of the user's question.

{{pre_prompt}}

Here is the chat histories between human and assistant, inside <histories></histories> XML tags.

<histories>
{{#histories#}}
</histories>


Human: {{#query#}}

Assistant: 
```

**模板結構（Prompt Structure）：**

* 上下文（`Context`）
* 預編排提示詞（`Pre-prompt`）
* 會話歷史（`History`）
* 查詢變量（`Query`）

### 4. 使用文本補全模型構建文本生成型應用模版

```Python
Use the following context as your learned knowledge, inside <context></context> XML tags.

<context>
{{#context#}}
</context>

When answer to user:
- If you don't know, just say that you don't know.
- If you don't know when you are not sure, ask for clarification.
Avoid mentioning that you obtained the information from the context.
And answer according to the language of the user's question.

{{pre_prompt}}
{{query}}
```

**模板結構（Prompt Structure）：**

* 上下文（`Context`）
* 預編排提示詞（`Pre-prompt`）
* 查詢變量（`Query`）

{% hint style="warning" %}
Dify 與部分模型廠商針對系統提示詞做了聯合深度優化，部分模型下的初始模版可能與以上示例不同。
{% endhint %}

### 參數釋義

* 上下文（`Context`）：用於將數據集中的相關文本作為提示詞上下文插入至完整的提示詞中。
* 對話前提示詞（`Pre-prompt`）：在**簡易模式**下編排的對話前提示詞將插入至完整提示詞中。
* 會話歷史（`History`）：使用文本生成模型構建聊天應用時，系統會將用戶會話歷史作為上下文插入至完整提示詞中。由於部分模型對角色前綴的響應有所差異，你也可以在對話歷史的設置中修改對話歷史中的角色前綴名，例如：將 “`Assistant`” 改為 “`AI`”。
* 查詢內容（`Query`）：查詢內容為變量值，用於插入用戶在聊天中輸入的問題。

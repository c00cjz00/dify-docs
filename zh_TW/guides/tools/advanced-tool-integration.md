# 高級接入工具

在開始高級接入之前，請確保你已經閱讀過[快速接入](https://docs.dify.ai/v/zh-hans/guides/tools/quick-tool-integration)，並對Dify的工具接入流程有了基本的瞭解。

### 工具接口

我們在`Tool`類中定義了一系列快捷方法，用於幫助開發者快速構較為複雜的工具。

#### 消息返回

Dify支持`文本` `鏈接` `圖片` `文件BLOB` 等多種消息類型，你可以通過以下幾個接口返回不同類型的消息給 LLM 和用戶。

注意，在下面的接口中的部分參數將在後面的章節中介紹。

**圖片URL**

只需要傳遞圖片的URL即可，Dify會自動下載圖片並返回給用戶。

```python
    def create_image_message(self, image: str, save_as: str = '') -> ToolInvokeMessage:
        """
            create an image message

            :param image: the url of the image
            :return: the image message
        """
```

**鏈接**

如果你需要返回一個鏈接，可以使用以下接口。

```python
    def create_link_message(self, link: str, save_as: str = '') -> ToolInvokeMessage:
        """
            create a link message

            :param link: the url of the link
            :return: the link message
        """
```

**文本**

如果你需要返回一個文本消息，可以使用以下接口。

```python
    def create_text_message(self, text: str, save_as: str = '') -> ToolInvokeMessage:
        """
            create a text message

            :param text: the text of the message
            :return: the text message
        """
```

**文件 BLOB**

如果你需要返回文件的原始數據，如圖片、音頻、視頻、PPT、Word、Excel 等，可以使用以下接口。

* `blob` 文件的原始數據，bytes 類型
* `meta` 文件的元數據，如果你知道該文件的類型，最好傳遞一個`mime_type`，否則Dify將使用`octet/stream`作為默認類型

```python
    def create_blob_message(self, blob: bytes, meta: dict = None, save_as: str = '') -> ToolInvokeMessage:
        """
            create a blob message

            :param blob: the blob
            :return: the blob message
        """
```

#### 快捷工具

在大模型應用中，我們有兩種常見的需求：

* 先將很長的文本進行提前總結，然後再將總結內容傳遞給 LLM，以防止原文本過長導致 LLM 無法處理
* 工具獲取到的內容是一個鏈接，需要爬取網頁信息後再返回給 LLM

為了幫助開發者快速實現這兩種需求，我們提供了以下兩個快捷工具。

**文本總結工具**

該工具需要傳入 user\_id 和需要進行總結的文本，返回一個總結後的文本，Dify 會使用當前工作空間的默認模型對長文本進行總結。

```python
    def summary(self, user_id: str, content: str) -> str:
        """
            summary the content

            :param user_id: the user id
            :param content: the content
            :return: the summary
        """
```

**網頁爬取工具**

該工具需要傳入需要爬取的網頁鏈接和一個 user\_agent（可為空），返回一個包含該網頁信息的字符串，其中`user_agent`是可選參數，可以用來識別工具，如果不傳遞，Dify將使用默認的`user_agent`。

```python
    def get_url(self, url: str, user_agent: str = None) -> str:
        """
            get url
        """ the crawled result
```

#### 變量池

我們在`Tool`中引入了一個變量池，用於存儲工具運行過程中產生的變量、文件等，這些變量可以在工具運行過程中被其他工具使用。

下面，我們以`DallE3`和`Vectorizer.AI`為例，介紹如何使用變量池。

* `DallE3`是一個圖片生成工具，它可以根據文本生成圖片，在這裡，我們將讓`DallE3`生成一個咖啡廳的 Logo。
* `Vectorizer.AI`是一個矢量圖轉換工具，它可以將圖片轉換為矢量圖，使得圖片可以無限放大而不失真，在這裡，我們將`DallE3`生成的PNG圖標轉換為矢量圖，從而可以真正被設計師使用。

**DallE3**

首先我們使用 DallE3，在創建完圖片以後，我們將圖片保存到變量池中，代碼如下

```python
from typing import Any, Dict, List, Union
from core.tools.entities.tool_entities import ToolInvokeMessage
from core.tools.tool.builtin_tool import BuiltinTool

from base64 import b64decode

from openai import OpenAI

class DallE3Tool(BuiltinTool):
    def _invoke(self, 
                user_id: str, 
               tool_Parameters: Dict[str, Any], 
        ) -> Union[ToolInvokeMessage, List[ToolInvokeMessage]]:
        """
            invoke tools
        """
        client = OpenAI(
            api_key=self.runtime.credentials['openai_api_key'],
        )

        # prompt
        prompt = tool_Parameters.get('prompt', '')
        if not prompt:
            return self.create_text_message('Please input prompt')

        # call openapi dalle3
        response = client.images.generate(
            prompt=prompt, model='dall-e-3',
            size='1024x1024', n=1, style='vivid', quality='standard',
            response_format='b64_json'
        )

        result = []
        for image in response.data:
            # 將所有圖片通過 save_as 參數保存到變量池中，變量名為 self.VARIABLE_KEY.IMAGE.value，如果如果後續有新的圖片生成，那麼將會覆蓋之前的圖片
            result.append(self.create_blob_message(blob=b64decode(image.b64_json), 
                                                   meta={ 'mime_type': 'image/png' },
                                                    save_as=self.VARIABLE_KEY.IMAGE.value))

        return result
```

我們可以注意到這裡我們使用了`self.VARIABLE_KEY.IMAGE.value`作為圖片的變量名，為了便於開發者們的工具能夠互相配合，我們定義了這個`KEY`，大家可以自由使用，也可以不使用這個`KEY`，傳遞一個自定義的KEY也是可以的。

**Vectorizer.AI**

接下來我們使用 Vectorizer.AI，將 DallE3 生成的PNG圖標轉換為矢量圖，我們先來過一遍我們在這裡定義的函數，代碼如下

```python
from core.tools.tool.builtin_tool import BuiltinTool
from core.tools.entities.tool_entities import ToolInvokeMessage, ToolParameter
from core.tools.errors import ToolProviderCredentialValidationError

from typing import Any, Dict, List, Union
from httpx import post
from base64 import b64decode

class VectorizerTool(BuiltinTool):
    def _invoke(self, user_id: str, tool_Parameters: Dict[str, Any]) \
        -> Union[ToolInvokeMessage, List[ToolInvokeMessage]]:
        """
        工具調用，圖片變量名需要從這裡傳遞進來，從而我們就可以從變量池中獲取到圖片
        """
        
    
    def get_runtime_parameters(self) -> List[ToolParameter]:
        """
        重寫工具參數列表，我們可以根據當前變量池裡的實際情況來動態生成參數列表，從而 LLM 可以根據參數列表來生成表單
        """
        
    
    def is_tool_available(self) -> bool:
        """
        當前工具是否可用，如果當前變量池中沒有圖片，那麼我們就不需要展示這個工具，這裡返回 False 即可
        """     
```

接下來我們來實現這三個函數

```python
from core.tools.tool.builtin_tool import BuiltinTool
from core.tools.entities.tool_entities import ToolInvokeMessage, ToolParameter
from core.tools.errors import ToolProviderCredentialValidationError

from typing import Any, Dict, List, Union
from httpx import post
from base64 import b64decode

class VectorizerTool(BuiltinTool):
    def _invoke(self, user_id: str, tool_Parameters: Dict[str, Any]) \
        -> Union[ToolInvokeMessage, List[ToolInvokeMessage]]:
        """
            invoke tools
        """
        api_key_name = self.runtime.credentials.get('api_key_name', None)
        api_key_value = self.runtime.credentials.get('api_key_value', None)

        if not api_key_name or not api_key_value:
            raise ToolProviderCredentialValidationError('Please input api key name and value')

        # 獲取 image_id，image_id 的定義可以在 get_runtime_parameters 中找到
        image_id = tool_Parameters.get('image_id', '')
        if not image_id:
            return self.create_text_message('Please input image id')

        # 從變量池中獲取到之前 DallE 生成的圖片
        image_binary = self.get_variable_file(self.VARIABLE_KEY.IMAGE)
        if not image_binary:
            return self.create_text_message('Image not found, please request user to generate image firstly.')

        # 生成矢量圖
        response = post(
            'https://vectorizer.ai/api/v1/vectorize',
            files={ 'image': image_binary },
            data={ 'mode': 'test' },
            auth=(api_key_name, api_key_value), 
            timeout=30
        )

        if response.status_code != 200:
            raise Exception(response.text)
        
        return [
            self.create_text_message('the vectorized svg is saved as an image.'),
            self.create_blob_message(blob=response.content,
                                    meta={'mime_type': 'image/svg+xml'})
        ]
    
    def get_runtime_parameters(self) -> List[ToolParameter]:
        """
        override the runtime parameters
        """
        # 這裡，我們重寫了工具參數列表，定義了 image_id，並設置了它的選項列表為當前變量池中的所有圖片，這裡的配置與 yaml 中的配置是一致的
        return [
            ToolParameter.get_simple_instance(
                name='image_id',
                llm_description=f'the image id that you want to vectorize, \
                    and the image id should be specified in \
                        {[i.name for i in self.list_default_image_variables()]}',
                type=ToolParameter.ToolParameterType.SELECT,
                required=True,
                options=[i.name for i in self.list_default_image_variables()]
            )
        ]
    
    def is_tool_available(self) -> bool:
        # 只有當變量池中有圖片時，LLM 才需要使用這個工具
        return len(self.list_default_image_variables()) > 0
```

可以注意到的是，我們這裡其實並沒有使用到`image_id`，我們已經假設了調用這個工具的時候一定有一張圖片在默認的變量池中，所以直接使用了`image_binary = self.get_variable_file(self.VARIABLE_KEY.IMAGE)`來獲取圖片，在模型能力較弱的情況下，我們建議開發者們也這樣做，可以有效提升容錯率，避免模型傳遞錯誤的參數。

# 成為貢獻者

所以你想為 Dify 做貢獻 - 這太棒了，我們迫不及待地想看到你的貢獻。作為一家人員和資金有限的初創公司，我們有著雄心勃勃的目標，希望設計出最直觀的工作流程來構建和管理 LLM 應用程序。社區的任何幫助都是寶貴的。

考慮到我們的現狀，我們需要靈活快速地交付，但我們也希望確保像你這樣的貢獻者在貢獻過程中獲得儘可能順暢的體驗。我們為此編寫了這份貢獻指南，旨在讓你熟悉代碼庫和我們與貢獻者的合作方式，以便你能快速進入有趣的部分。

這份指南，就像 Dify 本身一樣，是一個不斷改進的工作。如果有時它落後於實際項目，我們非常感謝你的理解，並歡迎任何反饋以供我們改進。

在許可方面，請花一分鐘閱讀我們簡短的 [許可證和貢獻者協議](https://github.com/langgenius/dify/blob/main/LICENSE)。社區還遵守 [行為準則](https://github.com/langgenius/.github/blob/main/CODE_OF_CONDUCT.md)。

## 在開始之前

[查找](https://github.com/langgenius/dify/issues?q=is:issue+is:closed) 現有問題，或 [創建](https://github.com/langgenius/dify/issues/new/choose) 一個新問題。我們將問題分為兩類：

### 功能請求：

* 如果您要提出新的功能請求，請解釋所提議的功能的目標，並儘可能提供詳細的上下文。[@perzeusss](https://github.com/perzeuss) 製作了一個很好的 [功能請求助手](https://udify.app/chat/MK2kVSnw1gakVwMX)，可以幫助您起草需求。隨時嘗試一下。

* 如果您想從現有問題中選擇一個，請在其下方留下評論表示您的意願。

相關方向的團隊成員將參與其中。如果一切順利，他們將批准您開始編碼。在此之前，請不要開始工作，以免我們提出更改導致您的工作付諸東流。

根據所提議的功能所屬的領域不同，您可能需要與不同的團隊成員交流。以下是我們團隊成員目前正在從事的各個領域的概述：

  | Member                                                       | Scope                                                |
  | ------------------------------------------------------------ | ---------------------------------------------------- |
  | [@yeuoly](https://github.com/Yeuoly)                         | Architecting Agents                                  |
  | [@jyong](https://github.com/JohnJyong)                       | RAG pipeline design                                  |
  | [@GarfieldDai](https://github.com/GarfieldDai)               | Building workflow orchestrations                     |
  | [@iamjoel](https://github.com/iamjoel) & [@zxhlyh](https://github.com/zxhlyh) | Making our frontend a breeze to use                  |
  | [@guchenhe](https://github.com/guchenhe) & [@crazywoola](https://github.com/crazywoola) | Developer experience, points of contact for anything |
  | [@takatost](https://github.com/takatost)                     | Overall product direction and architecture           |

  優先級的評判標準:

| Feature Type                                                 | Priority        |
| ------------------------------------------------------------ | --------------- |
| High-Priority Features as being labeled by a team member     | High Priority   |
| Popular feature requests from our [community feedback board](https://github.com/langgenius/dify/discussions/categories/ideas) | Medium Priority |
| Non-core features and minor enhancements                     | Low Priority    |
| Valuable but not immediate                                   | Future-Feature  |

### 其他任何事情（例如 bug 報告、性能優化、拼寫錯誤更正）：
* 立即開始編碼。

  優先級的評判標準:

  | Issue Type                                                   | Priority        |
  | ------------------------------------------------------------ | --------------- |
  | Bugs in core functions (cannot login, applications not working, security loopholes) | Critical        |
  | Non-critical bugs, performance boosts                        | Medium Priority |
  | Minor fixes (typos, confusing but working UI)                | Low Priority    |


## 安裝

以下是設置 Dify 進行開發的步驟：

### 1. Fork 該倉庫

### 2. 克隆倉庫

從終端克隆 fork 的倉庫：

```
git clone git@github.com:<github_username>/dify.git
```

### 3. 驗證依賴項

Dify 依賴以下工具和庫：

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Node.js v18.x (LTS)](http://nodejs.org)
- [npm](https://www.npmjs.com/) version 8.x.x or [Yarn](https://yarnpkg.com/)
- [Python](https://www.python.org/) version 3.10.x

### 4. 安裝

Dify 由後端和前端組成。通過 `cd api/` 導航到後端目錄，然後按照 [後端 README](https://github.com/langgenius/dify/blob/main/api/README.md) 進行安裝。在另一個終端中，通過 `cd web/` 導航到前端目錄，然後按照 [前端 README](https://github.com/langgenius/dify/blob/main/web/README.md) 進行安裝。

查看 [安裝常見問題解答](https://docs.dify.ai/v/zh-hans/learn-more/faq/install-faq) 以獲取常見問題列表和故障排除步驟。

### 5. 在瀏覽器中訪問 Dify

為了驗證您的設置，打開瀏覽器並訪問 [http://localhost:3000](http://localhost:3000)（默認或您自定義的 URL 和端口）。現在您應該看到 Dify 正在運行。

## 開發

如果您要添加模型提供程序，請參考 [此指南](https://github.com/langgenius/dify/blob/main/api/core/model_runtime/README.md)。

如果您要向 Agent 或 Workflow 添加工具提供程序，請參考 [此指南](https://github.com/langgenius/dify/blob/main/api/core/tools/README_CN.md)。

> **注意**：如果你想要貢獻新的工具，請確保已在工具的 `YAML` 文件內留下了你的聯繫方式，並且在 [Dify-docs](https://github.com/langgenius/dify-docs/tree/main/en/guides/tools/tool-configuration) 幫助文檔代碼倉庫中提交了對應的文檔 PR。

為了幫助您快速瞭解您的貢獻在哪個部分，以下是 Dify 後端和前端的簡要註釋大綱：

### 後端

Dify 的後端使用 Python 編寫，使用 [Flask](https://flask.palletsprojects.com/en/3.0.x/) 框架。它使用 [SQLAlchemy](https://www.sqlalchemy.org/) 作為 ORM，使用 [Celery](https://docs.celeryq.dev/en/stable/getting-started/introduction.html) 作為任務隊列。授權邏輯通過 Flask-login 進行處理。

```
[api/]
├── constants             // Constant settings used throughout code base.
├── controllers           // API route definitions and request handling logic.           
├── core                  // Core application orchestration, model integrations, and tools.
├── docker                // Docker & containerization related configurations.
├── events                // Event handling and processing
├── extensions            // Extensions with 3rd party frameworks/platforms.
├── fields                //field definitions for serialization/marshalling.
├── libs                  // Reusable libraries and helpers.
├── migrations            // Scripts for database migration.
├── models                // Database models & schema definitions.
├── services              // Specifies business logic.
├── storage               // Private key storage.      
├── tasks                 // Handling of async tasks and background jobs.
└── tests
```

### 前端

該網站使用基於 Typescript 的 [Next.js](https://nextjs.org/) 模板進行引導，並使用 [Tailwind CSS](https://tailwindcss.com/) 進行樣式設計。[React-i18next](https://react.i18next.com/) 用於國際化。

```
[web/]
├── app                   //layouts, pages, and components
│   ├── (commonLayout)    //common layout used throughout the app
│   ├── (shareLayout)     //layouts specifically shared across token-specific sessions 
│   ├── activate          //activate page
│   ├── components        //shared by pages and layouts
│   ├── install           //install page
│   ├── signin            //signin page
│   └── styles            //globally shared styles
├── assets                // Static assets
├── bin                   //scripts ran at build step
├── config                //adjustable settings and options 
├── context               //shared contexts used by different portions of the app
├── dictionaries          // Language-specific translate files 
├── docker                //container configurations
├── hooks                 // Reusable hooks
├── i18n                  // Internationalization configuration
├── models                //describes data models & shapes of API responses
├── public                //meta assets like favicon
├── service               //specifies shapes of API actions
├── test                  
├── types                 //descriptions of function params and return values
└── utils                 // Shared utility functions
```

## 提交你的 PR

最後，是時候向我們的倉庫提交一個拉取請求（PR）了。對於重要的功能，我們首先將它們合併到 `deploy/dev` 分支進行測試，然後再合併到 `main` 分支。如果你遇到合併衝突或者不知道如何提交拉取請求的問題，請查看 [GitHub 的拉取請求教程](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests)。

就是這樣！一旦你的 PR 被合併，你將成為我們 [README](https://github.com/langgenius/dify/blob/main/README_CN.md) 中的貢獻者。

## 獲取幫助

如果你在貢獻過程中遇到困難或者有任何問題，可以通過相關的 GitHub 問題提出你的疑問，或者加入我們的 [Discord](https://discord.gg/AhzKf7dNgk) 進行快速交流。
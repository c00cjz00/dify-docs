# DifySandbox

### 介紹
`DifySandbox`是一個輕量、快速、安全的代碼運行環境，支持多種編程語言，包括`Python`、`Nodejs`等，用戶在`Dify Workflow`中使用到的如`Code`節點、`Template Transform`節點、`LLM`節點的Jinja2語法、`Tool`節點的`Code Interpreter`等都基於DifySandbox運行，它確保了`Dify`可以運行用戶代碼的前提下整個系統的安全性。

### 特性
- **多語言支持**：`DifySandbox`基於`Seccomp`，這是一個系統層級的解決方案，從而確保了可以支持多種編程語言，目前支持了`Python`與`Nodejs`。
- **系統安全**：使用白名單策略，只允許運行特定的系統調用，從而確保不會出現意外的繞過。
- **文件系統隔離**：用戶代碼將運行在一個獨立的隔離的文件系統中。
- **網絡隔離**:
    - **DockerCompose**：獨立網絡Sandbox網絡，並使用代理容器進行網絡訪問，確保內網系統的安全，同時提供了靈活的代理配置方案。
    - **K8s**：直接使用`Exgress`配置網絡隔離策略即可。

### 項目地址
你可以直接訪問[DifySandbox](https://github.com/langgenius/dify-sandbox)獲取項目源碼，並遵循項目文檔進行部署和使用。

### 貢獻
你可以參考[貢獻指南](contribution.md)來參與到`DifySandbox`的開發中。

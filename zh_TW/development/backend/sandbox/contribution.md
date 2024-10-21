# 貢獻

### 代碼結構
參考如下代碼文件結構可以幫助你更好地理解代碼的組織方式。
```
[cmd/]
├── server                // Enterpoint for starting the server.
├── lib                   // Enterpoint for Shared libraries.
└── test                  // Common test scripts.
[build/]                  // build scripts for different architectures and platforms.
[internal/]               // Internal packages.
├── controller            // HTTP request handlers.
├── middleware            // Middleware for request processing.
├── server                // Server setup and configuration.
├── service               // Provides service for controller.
├── static                // Configuration files.
│   ├── nodejs_syscall    // Whitelist for nodejs syscall.
│   └── python_syscall    // Whitelist for python syscall.
├── types                 // Entities
├── core                  // Core logic for isolation and execution.
│   ├── lib               // Shared libraries.
│   ├── runner            // Code execution.
│   │   ├── nodejs        // Nodejs runner.
|   |   └── python        // Python runner.
└── tests                 // Tests for CI/CD.
```

### 原理
目前來說，核心邏輯的入口部分有兩個，一個是`DifySandbox`的`HTTP`服務入口，另一個是`動態鏈接庫`的入口，在Sandbox嘗試運行代碼時，它會首先生產一個臨時代碼文件，在這個文件的最開始，會調用`動態鏈接庫`來初始化運行環境，也就是`Sandbox`，隨後才是用戶代碼的執行，最終執行代碼時並不會直接執行用戶提交的代碼，而是執行這個臨時文件，從而確保不會被用戶提交的代碼破壞系統。

其中，動態鏈接庫中就是使用了`Seccomp`來限制系統調用，其中運行的系統調用位於`static`目錄下的`nodejs_syscall`和`python_syscall`文件中，並分別提供了`ARM64`和`AMD64`兩種架構的系統調用白名單，一共四份文件，在沒有特殊需求的情況下，請不要隨意修改這些文件。

### 如何貢獻
首先，對於`Typo`、`Bug`等問題，歡迎直接提交`PR`，如果是較大的改動或`Feature`級別的提交，請先提交`Issue`，以便我們更好地討論。

#### 待辦事項
這裡是一些我們目前正在考慮的待辦事項，如果你有興趣，可以選擇其中一個來貢獻。
- [ ] 新編程語言的支持：
    - 我們目前支持`Python`和`Nodejs`，如果你有興趣，可以嘗試添加新的編程語言支持。
    - 請注意，每新增一個語言，都要同時考慮`ARM64`和`AMD64`兩種架構，並提供`CI`測試，以便我們能確保新增語言的安全性。
- [ ] Nodejs的依賴問題：
    - 目前我們僅完成了`Python`的依賴支持，可以在`Sandbox`初始化時自動安裝`Python`依賴，但對於`Nodejs`，由於其`node_modules`的複雜性，我們目前還沒有找到一個很好的解決方案，如果你有興趣，可以嘗試解決這個問題。
- [ ] 圖片處理:
    - 在未來、多模態是一個必然的趨勢，因此在`Sandbox`支持處理圖片也是一個很有意義的事情。
    - 你可以嘗試添加對圖片處理的支持，比如`Pillow`等庫的支持，並支持在`Dify`中傳入圖片到`Sandbox`中進行處理。
- [ ] 完善的`CI`測試：
    - 目前我們的`CI`測試還不夠完善，只有一些簡單的用例。
- [ ] 生成多模態數據:
    - 嘗試使用`Sandbox`生成多模態數據，比如文本和圖片的組合數據。
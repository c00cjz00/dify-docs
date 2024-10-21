# 常見問題

### 1. 長時間未收到密碼重置郵件應如何處理？

你需要在 `.env` 文件內配置 `Mail` 參數項，詳細說明請參考 [《環境變量說明：郵件相關配置》](https://docs.dify.ai/v/zh-hans/getting-started/install-self-hosted/environments#you-jian-xiang-guan-pei-zhi)。

修改配置後，運行以下命令重啟服務。

```bash
docker compose down
docker compose up -d
```

如果依然沒能收到郵件，請檢查郵件服務是否正常，以及郵件是否進入了垃圾郵件列表。

### 2. 如果 workflow 太複雜超出節點上限如何處理？

在社區版您可以在`web/app/components/workflow/constants.ts` 手動調整MAX\_TREE\_DEPTH 單條分支深度的上限，我們的默認值是 50，在這裡要提醒自部署的情況下過深的分支可能會影響性能。

# Dify Premium

Dify Premium 是一款 [AWS AMI](https://docs.aws.amazon.com/zh\_cn/AWSEC2/latest/UserGuide/ec2-instances-and-amis.html) 產品，允許自定義品牌，並可作為 EC2 一鍵部署到你的 AWS VPC 上。前往 [AWS Marketplace](https://aws.amazon.com/marketplace/pp/prodview-t22mebxzwjhu6) 進行訂閱並使用，它適合以下場景：

* 在中小型企業內，需在服務器上創建一個或多應用程序，並且關心數據私有化。
* 你對 [Dify Cloud ](https://docs.dify.ai/v/zh-hans/getting-started/cloud)訂閱計劃感興趣，但所需的用例資源超出了[計劃](https://dify.ai/pricing)內所提供的資源。
* 你希望在組織內採用 Dify Enterprise 之前進行 POC 驗證。

### 設置

如果這是您第一次訪問 Dify，請輸入管理員初始化密碼（設置為你的 EC2 實例 ID）以開始設置過程。

部署 AMI 後，通過 EC2 控制檯中找到的實例公有 IP 訪問 Dify（默認使用 HTTP 端口 80）。

### 升級

在 EC2 實例中，運行以下命令：

```bash
git clone https://github.com/langgenius/dify.git /tmp/dify
mv -f /tmp/dify/docker/* /dify/
rm -rf /tmp/dify
docker-compose down
docker-compose pull
docker-compose -f docker-compose.yaml -f docker-compose.override.yaml up -d
```

### 定製化

就像自託管部署一樣，你可以根據需要修改 EC2 實例中 `.env` 下的環境變量。然後使用以下命令重新啟動 Dify：

```
docker-compose down
ocker-compose -f docker-compose.yaml -f docker-compose.override.yaml up -d
```

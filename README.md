# 分散キャッシュ構築手順

## ビルドコマンド

```
docker build -t honto/kyototycoon:latest .
```

## コンテナ起動

```
docker run -p 1978:1978 \
           -p 11401:11401 \
           -d --name ap-cache \
           -v /var/log/kyototycoon:/var/ktserver/ \
           honto/kyototycoon
```


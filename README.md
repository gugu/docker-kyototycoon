# KyotoTycoon構築手順

## ビルドコマンド

```
docker build -t honto/kyototycoon:latest .
```


## コンテナ起動

### docker

```
docker run -p 1978:1978 \
           -p 11401:11401 \
           -d --name ap-cache \
           -v /var/log/kyototycoon:/var/ktserver/ \
           honto/kyototycoon
```

### docker-compose

```
docker-compose up -d
```


### ポート説明

| ポート | 用途 |
|--------|--------|
| 1978 | KyotoTycoon用 |
| 11401 | Memcache用 |


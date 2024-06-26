# 1/bin/bash

# 200번 반복하면서 재고 확인 및 감소
## 리눅스에서 실행해야함!! >> 파일로 생성하여 제작 필요
for i in {1..200}; do
    quantity=$(redis-cli -h localhost -p 6379 get apple:1:quantity)
    if [ "$quantity" -lt 1 ]; then
        echo "재고가 부족합니다. 현재 재고: $quantity"
        break;
    fi
    # 재고 감소 코드
    redis-cli -h localhost -p 6379 decr apple:1:quantity
    echo "현재 재고: $quantity"
done
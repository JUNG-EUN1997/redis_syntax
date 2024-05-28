# redis 설치
sudo apt-get install redis-Server

# redis version 확인
redis-server --version

# redis 접속 
# cli : CommandLine Interface
redis-cli

# redis는 0~15번까지의 database로 구성
# 데이터베이스 선택 및 접속 -> default는 0번
select 번호

# 모든 키 조회하기 ⭐⭐⭐⭐⭐
keys *

# 특정 키 값 조회하기 ⭐⭐⭐⭐⭐
get 키 
get test_key1

# 자료구조 세팅하기! -> key와 value 구조로 세팅하기 필요
# 일반 string 자료구조

set 키 값
set test_key1 test_value1
set user:email:1 hongildong@naver.com
set user:num 1

# key값 중복 시 자동으로 덮어쓰기 된다.
# 맵저장소에서 key값은 유일하게 관리가 되므로
# nx : not exist -> 해당 키 값이 ⭐없을 때 만⭐ set 할 수 있다.
set user:email:1 hongildong@naver.com nx

# ex(만료시간 - 초단위) - ttl(time to live)
set user:email:2 hong2@naver.com ex 20

# 특정 key 삭제
del user:email:1
# 현 database 모든 key값 삭제
flushdb


# 증가 및 감소
# 추후, 명령어를 직접 관리할 일이 없기 때문에 알고만 있기
incr 키 # 1씩 증가
desc 키 # 1씩 감소


# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 #특정 key값의 value를 1만큼 증가
decr likes:posting:1 #특정 key값의 value를 1만큼 감소

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;
# 위 데이터 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
# redis json 규칙 : 
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}"

# list
# redis의 list는 javadml deque와 같은 구조
# 즉, double-ended queue구조

# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key value
# 데이터 오른쪽부터 꺼내기
RPOP key value

# 어떤 목적으로 사용될 수 있을까?
## 최근 본 상품목록, 최근 방문한 페이지, 

#꺼내서 없애는게 아니라 꺼내서 보기
lrange 키 0 0
lrange 키 -1 -1

# 데이터 개수 조회
llne key
# list 요소 조회 시 범위 지정
lrange 키 스타트지점 끝지점
# TTL 적용
expire 키 20 # 20초 뒤 삭제
# TTL 조회
ttl 키

# pop과 push를 동시에
RPOPLPUSH a리스트 b리스트

# 최근방문한페이지
# 5개 정보 데이터 push
# 최근 방문한 페이지 3개 정도만
rpush mypage www.google.com
rpush mypage www.naver.com
rpush mypage www.daum.com
rpush mypage www.kakao.com
rpush mypage www.naver.com

lrange mypage 2 -1 # 최대 개수가 몇 개인지 미리 알아야한다는 단점 존재, 추후 length를 구한 후 진행해야함

# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 무엇인지 출력
# 앞으로가기 누르면 앞으로 간 페이지가 무엇인지 출력
rpush forwards www.google.com
rpush forwards www.naver.com
rpush forwards www.daum.com
rpush forwards www.kakao.com
rpush forwards www.naver.com

lrange forwards -1 -1 #뒤로가기 페이지를 누르면 뒤로가기 페이지가 무엇인지 출력
rpoplpush forwards -2 -2

# set 자료구조
# set 자료구조에 멤버추가
sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers 키
smembers members

# set에서 멤버 삭제
srem members member2

# set 개수세기
scard members

# 특정 멤버 set 내부 존재여부 체크
sismember members member1

# 매일 방문자 수 계산
sadd visit:2024-05-27 hong1@naver.com
sadd visit:2024-05-27 hong2@naver.com
sadd visit:2024-05-27 hong1@naver.com
smembers visit:2024-05-27


# -----------------------------------------------------------------------------

# zset (sorted set)
zadd zmembers 3 member1
zadd zmembers 1 member2
zadd zmembers 4 member3
zadd zmembers 2 member4

# score기준 오름차순 정렬
zrange zmembers 0 -1
# score기준 내림차순 정렬
zrevrange zmembers 0 -1

# zrank는 해당 멤버가 index 몇 번째인지 출력
zrank zmembers member3

# 최근 본 상품목록 => sorted set (zset) 을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192420 apple
zadd recent:products 192420 apple

zrevrange zmembers 0 2


# -----------------------------------------------------------------------------


# hashes

# product 1에, name은 apple, price는 1000, stock은 50 인 값 저장
hset product:1 name "apple" price 1000 stock 50 
hget product:1 price
# 모든 객체값 get
hgetall product:1
# 특정 요소 값 수정
hset product:1 
#특정 요소의 값 증가
hincrby product:1
hget product:1
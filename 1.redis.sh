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

# bash쉘을 활용하여 재고감소 프로그램 작성



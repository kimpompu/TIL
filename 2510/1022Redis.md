# 251021 TIL

## Redis


### Docker로 Redis 설치
```bash
docker pull redis
docker run --name my-redis -p 6379:6379 -d redis
```

### docker-compose.yml 으로 설치
```yaml
version: '3.8'

services:
  # Redis 서비스 정의
  redis:
    image: redis:latest # 사용할 Redis 이미지 (latest 또는 redis:alpine 권장)
    container_name: my-redis-server # 컨테이너 이름 지정
    ports:
      - "6379:6379" # 호스트:컨테이너 포트 매핑
    volumes:
      # 데이터를 영속적으로 보관하기 위한 볼륨 설정 (선택 사항)
      - redis_data:/data 
    command: redis-server --appendonly yes # AOF(데이터 영속성) 활성화
    
  # (선택 사항) Spring Boot 애플리케이션 서비스 예시
  # app:
  #   image: your-spring-boot-image
  #   ports:
  #     - "8080:8080"
  #   depends_on:
  #     - redis # redis 서비스가 먼저 시작되도록 의존성 설정
  #   environment:
  #     - SPRING_REDIS_HOST=redis # Docker 네트워크에서 서비스 이름으로 통신

# 볼륨 정의
volumes:
  redis_data:
    driver: local
```
```bash
docker-compose up -d
```

### Redis 자료형

| 자료형           | 설명                            | 주요 명령어                             | 설명                      |
|------------------|---------------------------------|------------------------------------------|---------------------------|
| **String**       | 문자열 저장, 숫자/문자 모두 가능 | `SET key val`                            | 문자열 저장               |
|                  |                                 | `GET key`                                | 문자열 조회               |
|                  |                                 | `INCR key`                               | 정수 1 증가               |
|                  |                                 | `DECR key`                               | 정수 1 감소               |
|                  |                                 | `APPEND key val`                         | 문자열 끝에 덧붙이기      |
| **List**         | 순서 있는 값들의 목록 (스택/큐)  | `LPUSH key val`                          | 왼쪽 삽입                 |
|                  |                                 | `RPUSH key val`                          | 오른쪽 삽입               |
|                  |                                 | `LPOP key`                               | 왼쪽에서 꺼냄             |
|                  |                                 | `RPOP key`                               | 오른쪽에서 꺼냄           |
|                  |                                 | `LRANGE key start stop`                  | 범위 조회                 |
|                  |                                 | `LLEN key`                               | 리스트 길이               |
| **Set**          | 중복 없는 원소의 집합            | `SADD key val`                           | 원소 추가                 |
|                  |                                 | `SREM key val`                           | 원소 제거                 |
|                  |                                 | `SMEMBERS key`                           | 모든 원소 조회            |
|                  |                                 | `SISMEMBER key val`                      | 포함 여부 확인            |
|                  |                                 | `SCARD key`                              | 원소 개수                 |
| **Sorted Set**   | 점수 기반 정렬된 집합 (우선순위 큐) | `ZADD key score val`                  | 원소 추가                 |
|                  |                                 | `ZRANGE key start stop [WITHSCORES]`     | 범위 조회                 |
|                  |                                 | `ZREM key val`                           | 원소 제거                 |
|                  |                                 | `ZSCORE key val`                         | 점수 조회                 |
|                  |                                 | `ZCARD key`                              | 원소 개수                 |
| **Hash**         | Key 안에 Field-Value 쌍 저장     | `HSET key field val`                     | 필드 추가                 |
|                  |                                 | `HGET key field`                         | 필드 값 조회              |
|                  |                                 | `HDEL key field`                         | 필드 삭제                 |
|                  |                                 | `HGETALL key`                            | 모든 필드/값 조회         |
|                  |                                 | `HLEN key`                               | 필드 수 조회              |
| **HyperLogLog**  | 고유 값 수 추정용 자료구조       | `PFADD key val`                          | 원소 추가                 |
|                  |                                 | `PFCOUNT key`                            | 고유값 수 추정            |
|                  |                                 | `PFMERGE dest source1 source2`           | 여러 키 병합              |
| **Bitmaps**      | 비트 단위 데이터 처리            | `SETBIT key offset val`                  | 비트 설정                 |
|                  |                                 | `GETBIT key offset`                      | 비트 조회                 |
|                  |                                 | `BITCOUNT key`                           | 비트 1 개수 조회          |
| **Streams**      | 시간순 로그/메시지 큐            | `XADD key * field val`                   | 항목 추가                 |
|                  |                                 | `XRANGE key start end`                   | 범위 조회                 |
|                  |                                 | `XREAD STREAMS key id`                   | 항목 읽기                 |
| **기타 명령어**  |                                 | `KEYS *`                                 | 전체 키 조회 (주의)       |
|                  |                                 | `EXPIRE key sec`                         | TTL 설정                  |
|                  |                                 | `TTL key`                                | TTL 확인                  |
|                  |                                 | `FLUSHALL`                               | 전체 데이터 삭제 (주의)   |
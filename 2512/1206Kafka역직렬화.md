# 251206 TIL

## PostgreSQL 
### PostgreSQL 비밀번호 인증 실패
1. 오류
```FATAL: password authentication failed for user "comment" (28P01)```
2. 원인
- Docker 컨테이너 재실행 시, 로컬 볼륨(infra-data)에 이전 설정으로 생성된 데이터가 남아있어 .env의 새 비밀번호가 적용되지 않음.
3. 해결방법
`docker-compose down` 후 로컬의 `infra-data` 폴더를 삭제(`rm -rf`)하고 다시 up.

### 포트 충돌 및 DB 접속 오류
1. 오류
`Connection refused` 또는 비밀번호 오류 지속.
2. 원인
- 로컬 PC에 설치된 PostgreSQL(5432)과 Docker 컨테이너가 충돌
3. 해결방법
- Docker 외부 포트를 5433으로 변경하고 application.yml 접속 정보도 5433으로 수정.

## MongoDB
### MongoDB 트랜잭션 오류
1. 오류
```Sessions are not supported by the MongoDB cluster```
2. 원인
- 로컬 Docker의 MongoDB는 Standalone 모드인데, `@Transactional`을 사용하여 트랜잭션 세션을 요청함.
3. 해결방법
- Service 메서드에서 @Transactional 어노테이션 제거

### 순환 참조
1. 오류
```The dependencies of some of the beans in the application context form a cycle```
2. 원인
- MongoDB 의존성만 주입하였는데 구현체 클래스 이름을 `CommentJpaRepositoryImpl`로 지음. `Spring Data JPA`가 이를 커스텀 구현체로 인식하여 자동 스캔하면서 무한 루프 발생.
3. 해결방법
- 이름에서 `JPA` 제거

## Kafka
### Kafka 역직렬화 실패
1. 오류
```
MessageConversionException: Cannot convert from [java.lang.String] to [DTO]
```
2. 원인
- Producer(보내는 쪽)와 Consumer(받는 쪽)의 DTO 패키지 경로가 달라서, Kafka 헤더의 타입 정보와 불일치.
    - JsonSerializer와 JsonDeserializer는 기본적으로 **"자바 객체 간의 완벽한 이동"**을 목표로 설계    
3. 해결
``` yml
spring:
  kafka:
    consumer:
      value-deserializer: org.springframework.kafka.support.serializer.ErrorHandlingDeserializer
      properties:
        spring.deserializer.value.delegate.class: org.springframework.kafka.support.serializer.JsonDeserializer
        # 헤더에 있는 타입 정보(보낸 클래스명) 무시하기
        spring.json.use.type.headers: false
        # 매핑 클래스 지정
        spring.json.value.default.type: com.eyedle.notification_service.presentation.dto.request.NotificationKafkaDto
```
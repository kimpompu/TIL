# 0922 TIL

### 1. `@Transactional`

>___개념___   
- DB의 ACID 원칙을  보장
    - ACID : 일광선, 원자성, 고립성, 지속성
- 트랜잭션의 시작과 종료를 자동으로 처리한다.
- 예외가 발생하면 자동으로 rollback

>___속성___
- isolation
- readOnly
- rollbackFor

### 2. `Persistence Context`
> ___생명주기___
- 비영속(Transient) : 객체가 생성된 상태. pesist()되지 않은 상태.
- 영속(Managed) : pesist(), find() 혹은 detached 상태에서 merge()된 상태. EntityManager의 관리 대상
- 준영속(Detached) : detach(), clear() 되어 관리대상에서 제거됨. 
- 제거(Removed) : remove(). 삭제가 예약된 상태로 commit()이나 flush()되면 `delete`쿼리 실행
*** 트랜잭션 단위

```Java
public void example(EntityManager em) {
    em.getTransaction().begin();

    User user = new User();
    user.setName("Alice");
    em.persist(user);  
    // 즉시 Insert되지 않고, 영속성 컨텍스트에 저장됨 (쓰기 지연)

    user.setName("Alice Smith");
    // 변경 감지

    User sameUser = em.find(User.class, user.getId());
    // 1차 캐시에서 Alice 찾아서 반환.

    em.getTransaction().commit();
    
}
```

> ___쓰기지연___
SQL을 즉시 DB에 반영하지 않고, commit() 또는 flush()가 일어날 때 한 번에 실행함

### 3. `RestTemplate`
>`정의`
외부의 Restful API를 호출하기 위해 요청을 보내고 응답을 받을 때까지 대기하는 동기식 HTTP 클라이언트.
스프링 5 이후 부터 기존 코드의 유지보수 외엔 `WebClient` 대체 사용이 권장됨

>`Methods`
- `getForEntity(url, Class<T> responseType)` : ResponseEntity<T> 반환
- `postForEntity(URI url, Object request, Class<T> responseType)` : ResponseEntity<T> 반환
- `exchange(RequestEntity<?> entity, Class<T> responseType)` : ResponseEntity<T> 반환
    ```Java
            MyRequest body = ...
            RequestEntity request = RequestEntity
                .post(URI.create("https://example.com/foo"))
                .accept(MediaType.APPLICATION_JSON)
                .body(body);
            ResponseEntity<MyResponse> response = template.exchange(request, MyResponse.class);
    ```
>출처 [RestTemplate (Spring Framework 6.2.11 API)](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.html)
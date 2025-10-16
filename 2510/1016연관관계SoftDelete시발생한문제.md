# 251016 TIL

## UPDATE시 N+1 문제
- 가게가 삭제될 때 연관된 Entity들을 같이 softDelete 하는 것을 구현하던 중 관련 Entity를 get() 하고 softDelete() 메소드를 실행하는 과정에서 N+1 문제 발생
- SELECT - UPDATE 순으로 진행되는 것을 UPDATE만 하고싶었다

### 1. `Fetch Join`
`JPQL`의 `@Query` 어노테이션 설정 후 쿼리 작성
- Store를 조회할 때 한 번에 연관된 객체들을 조회하면 되지 않을까 했지만, 관련 Entity들의 depth가 2단계 이상인 것들도 있어 보류 (`Store` -> `StoreImage` -> `Image`)

### 2. `Bulk Update`
- Update를 대용량으로 처리할 수 있음
- Store Id를 Key로 실행하면 되지 않을까 생각했다.
- 하지만 결국 서비스단에서 여러번 query를 실행하게 되는 것은 고민점이다.
- 현재는 테스트 단계라 일단 N+1를 감수하고 작성된 코드로 진행하기로 했다.


- Bulk 주의점
```Java 
@Modifying(clearAutomatically = true, flushAutomatically = true)
```
벌크 업데이트시 영속성 컨텍스트와 처리된 데이터간 차이가 발생할 수 있기 때문에 옵션을 설정하거나 Entity Manager를 초기화(clear(), flush()) 해줘야한다.

> 참고
- [Fetch Join과 Bulk Update으로 N + 1 문제 해결하기](https://jiwon.oopy.io/55d96085-110c-425d-8a08-bbe6a947f8df)

- [JPA N+1 문제 해결 방법 및 실무 적용 팁 - 삽질중인 개발자](https://programmer93.tistory.com/83)
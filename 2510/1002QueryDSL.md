# 1002 TIL

### 1. QueryDSL 쿼리 작성 방법
[1] 설정
(1) build.gradle에 추가

```Java
	implementation 'com.querydsl:querydsl-jpa:5.0.0:jakarta'
	annotationProcessor "com.querydsl:querydsl-apt:5.0.0:jakarta"
	annotationProcessor "jakarta.annotation:jakarta.annotation-api"
	annotationProcessor "jakarta.persistence:jakarta.persistence-api"
```

(2) build/generated 하위 entitiy 클래스에 Q 클래스 생성 확인

(3) config 파일 생성해 Bean 등록
```Java
    @Configuration
    @RequiredArgsConstructor
    public class QueryDSLConfig {

        private final EntityManager entityManager;

        @Bean
        public JPAQueryFactory jpaQueryFactory() {
            return new JPAQueryFactory(entityManager);
        }
    }
```

[2]. 쿼리 작성법

```Java
List<Tuple> results = jpaQueryFactory.select(user.name, order.count()) // 필요한 필드만 선택
                                     .from(order) // 기본 엔터티 지정
                                     .join(order.user, user) // 조인 관계 설정
                                     .where(user.age.gt(25)) // 조건 추가
                                     .groupBy(user.id) // user로 그룹핑
                                     .fetch();
```
_join은 항상 선행되는 parameter로 from에 기재한 table을 기재해야한다._

[3]. 쿼리 메소드
- .select(fieldName1, fieldName2, ...) : select할 필드명을 기재
    - .count / .sum() / .avg() : 집계함수. select 절에서 사용
- .from(entity) : 조회할 테이블
- .selectFrom(entity) : select할 entity와 from의 entity가 동일할 경우 사용
- .where(조건) : where 절, 조건은 BooleanExpression을 사용. 
    - .and() : where ... and ... and()만 있는 경우 ,로 생략해서 사용 가능
    - .or()  : where ... or ....
    - .eq("name") : where ... = "name"
    - .ne("name") : where ... <> "name"
    - .eq("name").not() : where ... <> "name"
    - field.isNotNull() : where field is not null
    - .in(20,40) : where ... in (20,40)
    - .notIn(20,40) : where ... not in (20,40)
    - .between(100,200) : where ... between 100 and 200 
    - .goe(100) : where ... >= 100
    - .gt(100) : where ... > 100
    - .loe(100) : where ... <= 100
    - .lt(100) : where ... < 100
    - field.like("keyword%") : where ... like 'keyword'
    - field.contains("keyword") : where ... like '%keyword%'
    - field.startsWith("keyword") : where ... like 'keyword%'
- .update()  
- .set() 
- .delete()
- .groupBy()

- .fetch() : 쿼리 실행 결과를 리스트로 반환
- .fetchOne() : 단 건 조회
- .fetchFirst() 
- .fetchResults() : 페이지네이션, total count 쿼리 수행
- .fetchCount() : count 수 반환
- .orderBy() : 정렬순서 지정
    - .desc()
    - .asc()
    - .nullLast(), nullsFirst() : null 데이터 정렬 순서

- .getTotal(): 
- .getLimit()
- .getOffset()


>참고
[QueryDSL(2) - 쿼리 생성 방법, 기본 문법](https://ykh6242.tistory.com/entry/QueryDSL2-%EC%BF%BC%EB%A6%AC-%EC%83%9D%EC%84%B1-%EB%B0%A9%EB%B2%95-%EA%B8%B0%EB%B3%B8-%EB%AC%B8%EB%B2%95)
[[Java Spring Boot] QueryDSL 사용하기](https://kangth97.tistory.com/42)

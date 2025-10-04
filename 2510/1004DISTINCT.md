# 1004 TIL

### 1. `Order by expression "S1_0.CREATED_AT" must be in the result list in this case`
(1).상황
```bash

2025-10-04T20:11:46.319+09:00  WARN 32736 --- [l-1:housekeeper] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Thread starvation or clock leap detected (housekeeper delta=55s164ms249µs100ns).

2025-10-04T20:11:51.044+09:00 ERROR 32736 --- [nio-8080-exec-3] o.a.c.c.C.[.[.[/].[dispatcherServlet]    : Servlet.service() for servlet [dispatcherServlet] in context with path [] threw exception [Request processing failed: com.querydsl.core.types.ExpressionException: No constructor found for class com.sparta.delivery.backend.store.dto.ResGetListStoreDto with parameters: [class java.util.UUID, class java.lang.String, class java.lang.Integer, class java.lang.Double, class java.lang.Integer, class java.lang.Integer, class com.sparta.delivery.backend.store.entity.StoreStatusEnum, class java.lang.Integer]] with root cause


com.querydsl.core.types.ExpressionException: No constructor found for class com.sparta.delivery.backend.store.dto.ResGetListStoreDto with parameters: [class java.util.UUID, class java.lang.String, class java.lang.Integer, class java.lang.Double, class java.lang.Integer, class java.lang.Integer, class com.sparta.delivery.backend.store.entity.StoreStatusEnum, class java.lang.Integer]

at com.querydsl.core.util.ConstructorUtils.getConstructorParameters(ConstructorUtils.java:121) ~[querydsl-core-5.1.0.jar:na]

at com.querydsl.core.types.ConstructorExpression.<init>(ConstructorExpression.java:84) ~[querydsl-core-5.1.0.jar:na]

at com.querydsl.core.types.ConstructorExpression.<init>(ConstructorExpression.java:74) ~[querydsl-core-5.1.0.jar:na]

at com.querydsl.core.types.Projections.constructor(Projections.java:121) ~[querydsl-core-5.1.0.jar:na]

at com.sparta.delivery.backend.store.repository.StoreRepositoryImpl.getStores(StoreRepositoryImpl.java:63) ~[main/:na
```

    QueryDSL을 사용해서 페이징과 키워드 검색을 구현하던 중 오류 발생.
    내가 구현하고 싶었던 건 정렬 우선순위 1번에 가게가 OPEN 인 것을 설정하고 싶었다.
    하지만 ORDER BY 절 작성시 계속 충돌이 발생했다.

    처음에는 Dto 내에 생성자와 파라미터가 다른 줄 알고 수정했다.
    하지만 계속 오류가 발생했다.


```bash
2025-10-04T20:24:06.351+09:00 ERROR 18752 --- [nio-8080-exec-9] o.a.c.c.C.[.[.[/].[dispatcherServlet]    : Servlet.service() for servlet [dispatcherServlet] in context with path [] threw exception [Request processing failed: org.springframework.dao.InvalidDataAccessResourceUsageException: could not prepare statement [Order by expression "CASE WHEN S1_0.STATUS = ?1 THEN ?2 ELSE 1 END" must be in the result list in this case; SQL statement:
```

`SELECT DISTINCT` 를 H2에서 쓸 때 자주 발생하는 오류로 `ORDER BY`와 `SELECT`에 나온 정렬이 다르게 인식해서 발생한다고 했다.

> 일단 ORDER BY에서 가게 OPEN 조건을 제거 후 SELECT에 정렬조건인 CREATED_AT을 추가했다.

> 성공

# 0923 TIL

### 1. JPA Query Method
| **Keyword**         | **Sample**                    | **JPQL Snippet**                                             |
|---------------------|-------------------------------|--------------------------------------------------------------|
| **Distinct <br>중복제거**         | findDistinctByLastnameAndFirstname | select distinct …​ where x.lastname = ?1 and x.firstname = ?2 |
| **And 조건**              | findByLastnameAndFirstname    | … where x.lastname = ?1 and x.firstname = ?2                  |
| **Or 조건**               | findByLastnameOrFirstname     | … where x.lastname = ?1 or x.firstname = ?2                   |
| **Is, Equals 같음**       | findByFirstname, findByFirstnameIs, findByFirstnameEquals | … where x.firstname = ?1 (or … where x.firstname IS NULL if the argument is null) |
| **Between 사잇값**          | findByStartDateBetween        | … where x.startDate between ?1 and ?2                         |
| **LessThan 미만**         | findByAgeLessThan             | … where x.age < ?1                                            |
| **LessThanEqual 이하**    | findByAgeLessThanEqual        | … where x.age <= ?1                                           |
| **GreaterThan 초과**      | findByAgeGreaterThan         | … where x.age > ?1                                            |
| **GreaterThanEqual 이상** | findByAgeGreaterThanEqual    | … where x.age >= ?1                                           |
| **After 이후**            | findByStartDateAfter          | … where x.startDate > ?1                                      |
| **Before 이전**           | findByStartDateBefore         | … where x.startDate < ?1                                      |
| **IsNull, Null <br>Null 체크**     | findByAge(Is)Null             | … where x.age is null                                         |
| **IsNotNull, NotNull <br>NotNull 체크** | findByAge(Is)NotNull         | … where x.age is not null                                     |
| **Like <br>키워드검색**             | findByFirstnameLike           | … where x.firstname like ?1                                   |
| **NotLike <br>키워드미포함**          | findByFirstnameNotLike       | … where x.firstname not like ?1                               |
| **StartingWith <br>시작문자열검색**     | findByFirstnameStartingWith   | … where x.firstname like ?1 (parameter bound with appended %) |
| **EndingWith <br>끝문자열검색**       | findByFirstnameEndingWith     | … where x.firstname like ?1 (parameter bound with prepended %)|
| **Containing <br>포함**       | findByFirstnameContaining     | … where x.firstname like ?1 (parameter bound wrapped in %)    |
| **OrderBy 정렬**          | findByAgeOrderByLastnameDesc  | … where x.age = ?1 order by x.lastname desc                   |
| **Not**              | findByLastnameNot             | … where x.lastname <> ?1 (or … where x.lastname IS NOT NULL if the argument is null) |
| **In 포함**               | findByAgeIn(Collection<Age> ages) | … where x.age in ?1                                          |
| **NotIn 미포함**            | findByAgeNotIn(Collection<Age> ages) | … where x.age not in ?1                                      |
| **True <br>true체크**             | findByActiveTrue()            | … where x.active = true                                       |
| **False <br>false체크**            | findByActiveFalse()           | … where x.active = false                                      |
| **IgnoreCase <br>대문자변환**       | findByFirstnameIgnoreCase     | … where UPPER(x.firstname) = UPPER(?1)                        |
>출처 [JPA Query Methods](https://docs.spring.io/spring-data/jpa/reference/jpa/query-methods.html#page-title)


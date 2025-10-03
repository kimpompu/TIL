# 1003 TIL

### 1. `ConcurrentModificationException`

(1).`ConcurrentModificationException` 발생 상황
Collection 을 `for each`로 돌면서 remove() 하려다 발생

(2). 원인
___반복문을 통해 Collection이 변경되는 순간 발생___

(3). 해결방법
- List로 수정
- for문 밖에서 수정하기
- Iterator 사용

> 참고
[List 순회 중 만난 ConcurrentModificationException과 컬렉션 불변성](https://m.blog.naver.com/tmondev/220393974518)
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
# 0930 TIL

### 1. PR에 코드 수정해서 commit하기

PR을 올리고 팀원들의 리뷰를 받아 코드를 수정했다.
기존에 올린 PR을 닫지 않고 수정하고 싶어서 방법을 찾아봤다.

```bash
git add .
git commit --amend -m "message"
git push origin branchname
```

push하려는데 충돌이 있어서 해결 후 merge 했다.

> 참고
[[Github] Pull Request 수정 후 다시 올리기](https://mmoooonn.tistory.com/17)

### 2. Wrapper class 사용 이유

Entity 클래스의 field를 정의하는데 팀원들이 `int` 대신 `Integer` 사용하자고 제안했다. 해당 필드가 null 값이 들어올 수도 있는 필드기 때문이다.

> Wrapper class

Java에서 원시 자료형(Primary type)을 객체로 다룰 수 있게 해주는 클래스이다.

   - 종류
    - int -> Integer
    - boolean -> Boolean
    - char -> Character
    - double -> Double
    - float -> Float
    - long -> Long
    - short -> Short
    - byte -> Byte
- 역할
    - 객체로 변환 : 컬렉션, 제너릭 같은 기능 사용 가능
    - null 값 가능 : null값을 가질 수 있음
    - utility method 사용 가능
    

    > 참고
    [[Java] 엔티티를 정의 할 때 int 대신 Integer를 사용하는 이유
](https://elsem.tistory.com/124)
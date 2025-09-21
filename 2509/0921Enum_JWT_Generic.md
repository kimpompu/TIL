# 0921 TIL

### 1. Enum
>정의
상수 열거형

>선언
```Java
public enum Season { SPRING, SUMMER, FALL, WINTER}
```
* 클래스처럼 `첫 문자를 대문자로 작명`한다.
* `열거 상수`는 모두 `대문자`로 작성하며, 여러 단어로 이루어진경우 `_`를 사용해 구분한다.

>제공 메소드
- `values()` : 모든 상수를 배열로 반환
- `valueOf(String name)` : 해당 name을 가진 상수 반환

>자체 필드, 메소드 추가
```Java
public enum Quarter {

    Q1("1분기"),
    Q2("2분기"),
    Q3("3분기"),
    Q4("4분기");

    private final String koreanName;

    Quarter(String koreanName){
        this.koreanName = koreanName;
    }

    public String getKoreanName() {
        return koreanName;
    }

}


```
- 동작원리
```Java
public static final Quarter Q1 = new Quarter("1분기");
```

>참고
- [[Java] Enum 사용하시나요?
](https://velog.io/@hyeok_1212/Java-enum-%EC%82%AC%EC%9A%A9%ED%95%98%EC%8B%9C%EB%82%98%EC%9A%94)


### 2. JWT
>정의     
JSON Web Token의 약자. 인증과 권한허가 방식으로 사용하는 토큰 기반 인증 방식

>토큰 구조
`header`.`payload`.`signature`

>Header 구조
```
Authorization: Bearer <token>
```

>사용방식
1. 유저가 서버에 인증을 요청한다.
2. 서버에서 access token을 발급해서 return한다.
3. 유저는 API를 이용할 때마다 Header에 토큰을 포함해 접근을 요청하고, 서버는 secret key와 비교해 검증한다.

> JWT 검증
```Java
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
```

> JWT에서 데이터 추출
```Java
String username = Jwts.parserBuilder()
    .setSigningKey(secretKey)      // 검증용 키 설정
    .build()                       // 파서 객체 생성
    .parseClaimsJws(token)         // 토큰 파싱 및 서명 검증
    .getBody()                     // payload(claims) 가져오기
    .getSubject();                 // subject(주로 사용자 식별값) 추출
```

>참고
- [Introduction to JSON Web Tokens](https://www.jwt.io/introduction#how-json-web-tokens-work)
- [😎 알고 쓰자, JWT(Json Web Token).](https://velog.io/@chuu1019/%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90-JWTJson-Web-Token)

### 3. Generic
>정의
내부에서 사용할 데이터 타입을 외부에서 지정하는 것

>예시
```Java
List<T> letters = ArrayList<>();
```
>타입 파라미터
___Reference 타입만 할당할 수 있음___
- `T` : Type 
- `E` : Element 
- `K` : Key
- `V` : Value
- `N` : Number
- `S`, `U`, `V `: 2,3,4번째에 선언된 타입   

>참고
- [자바 제네릭(Generics) 개념 & 문법 정복하기](https://inpa.tistory.com/entry/JAVA-%E2%98%95-%EC%A0%9C%EB%84%A4%EB%A6%ADGenerics-%EA%B0%9C%EB%85%90-%EB%AC%B8%EB%B2%95-%EC%A0%95%EB%B3%B5%ED%95%98%EA%B8%B0)
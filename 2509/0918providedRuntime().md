# 0918 TIL

### 1. Build 오류 `providedRuntime()`
> ___발생___    
> 프로젝트 진행 중 build.gradle 을 수정한 뒤 build 실패   

```Java
Could not find method providedRuntime() for arguments [org.springframework.boot:spring-boot-starter-tomcat] on object of type org.gradle.api.internal.artifacts.dsl.dependencies.DefaultDependencyHandler.
```
</br>

> ___원인___
>  - Java나 War 플러그인이 적용 안 됨   

<br>

> ___해결___
  ```Java
    plugins {
        id 'war' 
    }
 ```

<br><br><br>

> 참고   
> [[TIL] 최종 프로젝트 2일 차](https://velog.io/@a_rubz/TIL-%EC%B5%9C%EC%A2%85-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-2%EC%9D%BC-%EC%B0%A8)
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
<br>
<br>
<br>

### 2. Git 오류 `fetch first`   
> ___발생___    
> TIL 파일 작성 후 VSCode 터미널에서 git에 push하려는데 `! [rejected]        main -> main (fetch first)` 오류가 발생했다.

 </br>

> ___원인___
>  - 어제 Github Repository에서 README 파일을 직접 수정한 후에 로컬에 pull을 받지 않았음

<br>

> ___해결___
  ```bash
    git pull origin
 ```

> 참고   
> [[Git] push 중 fetch first 에러](https://velog.io/@rkio/Git-push-%EC%A4%91-fetch-first-%EC%97%90%EB%9F%AC)
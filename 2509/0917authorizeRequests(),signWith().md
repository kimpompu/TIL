
# 0917 TIL


### 1. `authorizeRequests()` deprecated
</br>

Filter 코드 작성 중 `deprecated` 오류 발생   
구글링해보니  `authorizeHttpRequests()` 을 사용하면 된다고 한다   

메소드 이름만 변경했는데 잘 작동한다.



> 수정 전
~~~Java
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeRequests(authorize -> authorize
                .requestMatchers("/auth/signIn").permitAll()
                .anyRequest().authenticated()
            )
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            );

        return http.build();
    }
~~~
</br>

> 수정 후

~~~Java
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/auth/signIn").permitAll()
                        .anyRequest().authenticated()
                )
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                );

        return http.build();
    }
~~~
</br>
</br>

*  `Spring Security`에서 보안 문제로 `authorizeRequests()` 대신 `authorizeHttpRequests()`을 사용하도록 권장하고 있다.
    <a href="https://docs.spring.io/spring-security/reference/servlet/authorization/authorize-http-requests.html" target="_blank">공식문서</a>
    * 참고
        > https://dmaolon00.tistory.com/entry/authorizeRequests-is-deprecated-%ED%95%B4%EA%B2%B0-Spring-Security-Configuration





### 2. `signWith(java.security.Key, io.jsonwebtoken.SignatureAlgorithm)` deprecated
</br>

Token 발급 코드 작성 중 `signWith()` 메소드에 `deprecated` 오류 발생   
`signWith()`은 키에 지정된 알고리즘을 통해서 토큰에 서명할 수 있는 메소드
</br>
기존 `signWith(java.security.Key, io.jsonwebtoken.SignatureAlgorithm)`는 `jjwt 0.12.0` 버전부터 `deprecated`


> 수정 전
~~~Java
    private final SecretKey secretKey;

    public AuthService(@Value("${service.jwt.secret-key}") String secretKey) {
        this.secretKey = Keys.hmacShaKeyFor(Decoders.BASE64URL.decode(secretKey));
    }


    public String createAccessToken(String user_id) {
        return Jwts.builder()
                .claim("user_id", user_id)
                .claim("role", "ADMIN")
                .issuer(issuer)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + accessExpiration))
                .signWith(secretKey, io.jsonwebtoken.SignatureAlgorithm.HS512)
                .compact();
    }
~~~

</br>


> 수정 후
~~~Java
    private final SecretKey secretKey;

    public AuthService(@Value("${service.jwt.secret-key}") String secretKey){
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.secretKey = Keys.hmacShaKeyFor(keyBytes);
    }

    public String createAccessToken(String user_id){
        return Jwts.builder()
                .claim("user_id", user_id)
                .claim("role","ADMIN")
                .issuer(issuer)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() * expiration))
                .signWith(secretKey)
                .compact();
    }
~~~   
</br>

> 다른 방법
```Java
    private final SecretKey secretKey;

    public AuthService(@Value("${service.jwt.secret-key}") String secretKey){
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.secretKey = Keys.hmacShaKeyFor(keyBytes);
    }

    public String createAccessToken(String user_id){
        return Jwts.builder()
                .claim("user_id", user_id)
                .claim("role","ADMIN")
                .issuer(issuer)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() * expiration))
                .signWith(secretKey, Jwts.SIG.HS512)
                .compact();
    }
```

* 참고
    > https://lenagend.tistory.com/17   
    </br>
    > https://blog.letsdev.me/jjwt-signwith-2024?source=more_articles_bottom_blogs
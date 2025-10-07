# 1007 TIL

### JUnit
자바 단위테스트(Unit Test) 프레임워크

```Java

class CalculatorTest {

    Calculator calculator;

    @BeforeEach
    void setUp() {
        calculator = new Calculator();
    }

    @Test
    @DisplayName("더하기 기능 테스트")
    void testAdd() {
        Assertions.assertEquals(5, calculator.add(2, 3));
    }

    @Test
    @DisplayName("나누기 - 0으로 나누면 예외 발생")
    void testDivideByZero() {
        Assertions.assertThrows(ArithmeticException.class, () -> {
            calculator.divide(10, 0);
        });
    }

    @AfterEach
    void tearDown() {
       
    }
}
```

```Java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    UserRepository userRepository;

    @InjectMocks
    UserService userService;

    @Test
    void testFindUser() {
        Mockito.when(userRepository.findById(1L))
               .thenReturn(Optional.of(new User(1L, "Alice")));

        User user = userService.findUser(1L);

        Assertions.assertEquals("Alice", user.getName());
    }
}
```

> 테스트 코드 작성원칙
- Given(준비): 테스트에 필요한 환경과 입력 데이터를 설정 (객체 생성, Mocking 설정 )
- When(실행): 테스트하려는 실제 메서드를 실행
- Then(검증): 실행 결과를 확인하여 예상한 값과 일치하는지, 혹은 예상한 예외가 발생했는지 검증(JUnit의 Assertions 사용)

> 사용방법 - 의존성 추가
```Java
dependencies {
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```



> 어노테이션

| 어노테이션            |                                               |
|------------------------|---------------------------------------------------|
| `@Test`               | 테스트 메서드 정의                                |
| `@BeforeEach`         | 각 테스트 메서드 실행 전 실행 (초기화)       |
| `@AfterEach`          | 각 테스트 메서드 실행 후 실행 (정리)         |
| `@BeforeAll`          | 모든 테스트 시작 전 한 번 실행 (static 필요)      |
| `@AfterAll`           | 모든 테스트 끝난 후 한 번 실행 (static 필요)      |
| `@DisplayName`        | 테스트 이름 지정            |
| `@Disabled`           | 해당 테스트를 실행하지 않음                       |
| `@Nested`             | 중첩 테스트 클래스 정의 (계층적 테스트)    |
| `@Tag`                | 테스트 그룹핑 태그 지정                           |
| `@RepeatedTest`       | 테스트 반복 실행                                  |
| `@ParameterizedTest`  | 다양한 입력값으로 테스트 실행                    |
| `@SpringBootTest`      | 전체 Spring Context 로딩 후 통합 테스트 수행                         |
| `@WebMvcTest`          | Spring MVC 레이어(Controller)만 로딩하여 테스트                      |
| `@DataJpaTest`         | JPA 관련 컴포넌트만 로딩하여 Repository 테스트                       |
| `@MockBean`            | Spring Bean을 목(mock) 객체로 교체                                   |
| `@TestConfiguration`   | 테스트에서만 사용할 Spring 설정 정의                                 |
| `@AutoConfigureMockMvc`| `MockMvc`를 자동 설정 (WebMvcTest와 함께 또는 단독으로 사용 가능)     |

> Assertion 메소드

| 메소드                                    |                                |
|-------------------------------------------|------------------------------------|
| `assertEquals(expected, actual)`          | 기대값과 실제값 비교               |
| `assertNotEquals(a, b)`                   | a와 b가 다름을 검증                |
| `assertTrue(condition)`                   | 조건이 true인지 확인               |
| `assertFalse(condition)`                  | 조건이 false인지 확인              |
| `assertThrows(Exception.class, () -> {})` | 특정 예외 발생 여부 확인           |
| `assertAll()`                             | 여러 Assertion을 그룹으로 테스트   |
| `assertTimeout()`                         | 일정 시간 안에 실행되는지 확인     |

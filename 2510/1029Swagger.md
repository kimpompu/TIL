# 251029 TIL

## API 테스트 어노테이션

1. `@WebMvcTest` : Controller만 부분적으로 테스트하기 위해 제공. MVC와 관련된 웹 레이어만 로드해 테스트 수행

2. `@SpringBootTest` : 스프링 부트 애플리케이션 전체 컨텍스트를 로드하여 통합 테스트를 수행

3. `@AutoConfigureMockMvc` : MockMvc 객체 자동으로 구성. HTTP 요청과 응답을 모의로 검증

4. `@Transactional` : 각 테스트 메서드를 트랜잭션 내에서 실행. 테스트가 끝난 후 데이터가 롤백

5. `@ActiveProfiles("dev")` : 테스트 실행시 사용할 프로필을 선택

## 더미 데이터 추가
```Java
@Configuration
@Profile("dev")  // dev 프로필일 때만 빈이 등록됨
public class DataLoader {

    @Bean
    public CommandLineRunner loadData(UserRepository userRepository) {
        return args -> {
            if (userRepository.count() == 0) {  // 데이터가 없는 경우에만 더미 데이터 추가
                User user1 = new User(); // Builder 패턴 사용해도 됨
                user1.setName("홍길동");
                user1.setEmail("hong@example.com");
                userRepository.save(user1);

                User user2 = new User();
                user2.setName("임꺽정");
                user2.setEmail("lim@example.com");
                userRepository.save(user2);
            }
        };
    }
}
```

## Swagger
- 애플리케이션의 RESTful API 문서를 자동으로 구성

### Swagger 추가
1. Swagger 의존성 추가
```Groovy
plugins {
	id 'java'
	id 'org.springframework.boot' version '3.4.0'
	id 'io.spring.dependency-management' version '1.1.6'
	// 플러그인 추가
	id 'com.epages.restdocs-api-spec' version "0.19.4"
}


dependencies {

	... 기타 의존성 ...

	// restdocs & openapi
	testImplementation 'org.springframework.restdocs:spring-restdocs-mockmvc'
	implementation 'org.springdoc:springdoc-openapi-starter-webmvc-ui:2.8.9'
	testImplementation 'com.epages:restdocs-api-spec-mockmvc:0.19.4'
}
```

2. OpenAPI 의존성 추가
```Groovy


... 기존 그래들 설정 ...


// 컴파일 시 빌드 폴더를 지웁니다.
compileJava {
	dependsOn 'clean'
}

// OpenApi에 들어갈 메타데이터를 추가합니다.
// 모놀리식일 경우 해당 프로젝트의 주소를 입력하고,
// MSA일 경우 게이트웨이의 주소를 입력하면 됩니다.
openapi3 {
	servers = [
			{
				url = 'http://localhost:19080'
			}
	]
	title = 'USER API'
	description = ''
	version = '1.0.0'
	format = 'json'
}

// task를 만듭니다.
tasks.register('setDocs') {
  // openapi3 태스크를 먼저 실행합니다. 
	dependsOn 'openapi3'
	// 문서가 다 생성되면 build 파일에 복사합니다.
	// MSA일 경우 파일명이 중복될 수 있으므로, 
	// 파일명 뒤에 서비스명을 붙여줍시다. 
	doLast {
		copy {
			from "build/api-spec"
			include "*.json"
			include "*.yaml"
			into "build/resources/main/static/springdoc"
			rename { String fileName ->
				if (fileName.endsWith('.json')) {
					return fileName.replace('.json', '-user-service.json')
				} else if (fileName.endsWith('.yaml')) {
					return fileName.replace('.yaml', '-user-service.yml')
				}
				return fileName
			}
		}
	}
}

// bootRun 실행 시 문서 생성 태스크를 실행합니다.
bootRun {
	dependsOn 'setDocs'
}

// bootJar 실행 시 문서 생성 태스크를 실행합니다.
bootJar {
	dependsOn 'setDocs'
}
```

```YML
spring:
  application:
    name: user-service
server:
  port: 19100
eureka:
  client:
    service-url:
      defaultZone: http://localhost:19090/eureka/

# 모놀리식에서 문서를 출력할 경우 아래 설정을 해주어야하나,
# MSA환경에서는 각 서비스가 swagger-ui를 생성할 필요는 없기 때문에 아래 설정이 하지 않아도 됩니다.
springdoc:
  swagger-ui:
    enabled: true
    path: /docs
    url: /springdoc/openapi3-user-service.json
    operations-sorter: alpha
    tags-sorter: alpha
  api-docs:
    enabled: true
    path: /api-docs-user-service
```
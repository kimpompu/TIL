# Swagger

## Swagger 사용방법

### 설치

1. 의존성 추가
```Java
    dependencies {
        // swagger
    implementation 'org.springdoc:springdoc-openapi-starter-webmvc-ui:2.5.0'
    }
```

2. SwaggerConfig 파일 생성
```Java
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@OpenAPIDefinition(
	info = @Info(title = "test API",
		description = " REST API 명세서입니다.",
		version = "v1.0.0")
)

@Configuration
public class Swagger {

	@Bean
	public GroupedOpenApi testApi() {
		return GroupedOpenApi.builder()
			.group("test API")
			.pathsToMatch("/api/test/**")
			.build();
	}

}
```

### Controller 어노테이션
- @Tag
- @Operation
- @ApiResponses

### DTO 어노테이션

- @Schema
    - name
    - description
    - required
    - properties
    - implementation

### 설정 확인
`run server` - `http://localhost:{portNumber}/swagger-ui.html`





> 출처
[Swagger 설정 및 사용방법](https://velog.io/@wjd15sheep/Swagger-%EC%84%A4%EC%A0%95-%EB%B0%8F-%EC%82%AC%EC%9A%A9%EB%B0%A9%EB%B2%95)
# 251023 TIL

## Redis

### application.yml
```yaml
spring:
  redis:
    host: localhost  # Redis 서버 주소 (Docker 사용 시 컨테이너 이름)
    port: 6379       # Redis 기본 포트
```
### RedisTemplate
1. RedisConfig 설정
```Java
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;

@Configuration
public class RedisConfig {

    /** RedisTemplate 커스터마이징 */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
        RedisTemplate<String, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        // Key Serializer: String으로 설정 (가독성 및 일관성 확보)
        template.setKeySerializer(new StringRedisSerializer());
        template.setHashKeySerializer(new StringRedisSerializer());
        
        // Value Serializer: 객체를 JSON 형태로 직렬화하여 저장
        template.setValueSerializer(new new Jackson2JsonRedisSerializer<>(Object.class));
        template.setHashValueSerializer(new Jackson2JsonRedisSerializer<>(Object.class));

        return template;
    }
}
```

2. @EnableCaching 어노테이션 작성
```Java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@EnableCaching // Spring Caching 활성화
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

3. caching할 메소드 위에 어노테이션

| 어노테이션         | 설명                                                            | 동작 방식                             |
| ------------- | ------------------------------------------------------------- | --------------------------------- |
| `@Cacheable`  | 메서드 호출 시, 캐시에 해당 키의 결과가 있으면 반환하고, 없으면 메서드를 실행 후 그 결과를 캐시에 저장. | 📚 읽기 전용 캐싱 — 캐시 Hit 시 메서드 실행 안 함 |
| `@CachePut`   | 메서드를 항상 실행하고, 그 결과를 캐시에 저장하거나 업데이트.                           | 🔄 캐시 갱신 — 최신 데이터로 캐시 업데이트        |
| `@CacheEvict` | 메서드 호출 시, 캐시에서 특정 항목 또는 전체를 삭제합니다.                            | 🧹 캐시 제거 — 예: DB 변경 후 캐시 무효화      |


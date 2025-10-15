# 251015 TIL

## Git Tag
특정 커밋에 대해 포인트를 표시하고 강조하는데 사용. 소프트웨어 릴리즈 버전 표시용.
프로젝트에서는 태그 생성 후 remote에 push하면 Git Action으로 배포

### 태그 생성
```bash
git tag {name}
```

```bash
git tag -a {name} -m "commit message"
```

```bash
git tag -a {name} {commitHash} -m "commit message"
```

### 태그 푸시
```bash
git push origin {tagName}
```

### 태그 삭제

- 로컬 태그 삭제
```bash
git tag -d {tagName}
```

- 원격 태그 삭제
```bash
git push origin --delete tag
```

> 참고
- [Git Tag 기본 개념 및 사용법](https://jwh0124.tistory.com/68)
# 기술 스택 및 선택 근거

## Flutter 환경

- **Flutter SDK**: ^3.10.4
- **Dart SDK**: ^3.10.4
- **타겟 플랫폼**: iOS, Android

---

## 패키지 구성

### 상태관리 & 라우팅

| 패키지 | 용도 | 선택 이유 |
|--------|------|----------|
| `flutter_riverpod` | 상태관리 | 타입 안전, 자동 dispose, 테스트 용이 |
| `riverpod_annotation` | 코드 생성 어노테이션 | 보일러플레이트 최소화 |
| `go_router` | 선언적 라우팅 | ShellRoute, 딥링크, Riverpod 연동 |

### 비디오 플레이어

| 패키지 | 용도 | 선택 이유 |
|--------|------|----------|
| `video_player` | 영상 재생 | Flutter 공식 패키지, 안정적, 커뮤니티 지원 |

`better_player`는 유지보수 불확실성으로 제외했습니다.

### 데이터 모델

| 패키지 | 용도 | 선택 이유 |
|--------|------|----------|
| `freezed_annotation` | 불변 모델 어노테이션 | immutable + copyWith + == 자동 생성 |
| `json_annotation` | JSON 직렬화 | 향후 실제 API 연동 대비 |

### 코드 생성 (dev_dependencies)

| 패키지 | 용도 |
|--------|------|
| `build_runner` | 코드 생성기 실행 |
| `riverpod_generator` | Riverpod provider 생성 |
| `freezed` | 불변 모델 코드 생성 |
| `json_serializable` | JSON 직렬화 코드 생성 |

### UI

| 패키지 | 용도 |
|--------|------|
| `cached_network_image` | 네트워크 이미지 캐싱 |
| `marquee` | 음악 정보 흐르는 텍스트 |

---

## 사용하지 않은 패키지와 이유

| 패키지 | 제외 이유 |
|--------|----------|
| `better_player` | 유지보수 불확실, deprecated 이슈 |
| `get_it` / `injectable` | Riverpod이 DI 역할도 수행하므로 중복 |
| `dio` / `retrofit` | Mock 데이터 사용, HTTP 클라이언트 불필요 |
| `bloc` | Riverpod 선택으로 제외 |
| `provider` | Riverpod이 상위호환 |

---

## 코드 생성 명령어

```bash
# 전체 코드 생성
dart run build_runner build --delete-conflicting-outputs

# 감시 모드 (파일 변경 시 자동 생성)
dart run build_runner watch --delete-conflicting-outputs
```

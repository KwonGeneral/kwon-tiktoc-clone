# TikTok Clone

Flutter로 구현한 TikTok 스타일 숏폼 영상 피드 앱입니다.

## 실행 영상

[example.MP4](./example.MP4) 파일을 참고해 주세요.

---

## 실행 방법

### 요구 환경
- Flutter 3.38.x (Dart 3.10.x)
- iOS 17+ / Android API 24+
- Xcode 16+ (iOS 빌드 시)

### 설치 및 실행

```bash
# 1. 패키지 설치
flutter pub get

# 2. 코드 생성 (freezed, json_serializable, riverpod_generator)
dart run build_runner build --delete-conflicting-outputs

# 3. 실행
flutter run
```

> iOS 실행 시 `ios/` 폴더에서 `pod install`이 자동으로 수행됩니다.

---

## 사용한 패키지

| 패키지 | 용도 |
|--------|------|
| `flutter_riverpod` + `riverpod_annotation` | 상태 관리 (Riverpod 2.0 + 코드 생성) |
| `go_router` | 선언적 라우팅 + ShellRoute 기반 하단 네비게이션 |
| `video_player` | 영상 재생 (HLS/MP4 지원) |
| `camera` | 15초 동영상 촬영 |
| `video_compress` | 영상 압축 + 썸네일 생성 |
| `image_picker` | 갤러리에서 프로필 이미지 선택 |
| `flutter_image_compress` | 이미지 압축 |
| `cached_network_image` | 네트워크 이미지 캐싱 |
| `freezed_annotation` + `freezed` | Immutable Entity/Model 코드 생성 |
| `json_annotation` + `json_serializable` | JSON 직렬화/역직렬화 |
| `http` | REST API 통신 |
| `shared_preferences` | 로컬 상태 영속화 (좋아요, 북마크, 팔로우 등) |
| `share_plus` | 영상 공유 기능 |
| `permission_handler` | 카메라/마이크 권한 요청 |
| `uuid` | 디바이스 고유 ID 생성 |

---

## 프로젝트 구조

Clean Architecture 기반으로 Domain / Data / Presentation 3개 레이어로 분리했습니다.

```
lib/
├── main.dart                    # 앱 진입점
├── app/                         # 앱 설정
│   ├── route/                   # GoRouter 설정 + 경로 상수
│   └── theme/                   # AppColors, AppFontSizes, AppTextStyles, AppTheme
├── core/                        # 공통 유틸리티
│   ├── constants/               # 앱 상수 (AppConstants, AppStrings)
│   ├── di/                      # Riverpod Provider (DI)
│   ├── extensions/              # BuildContext 확장
│   ├── services/                # DeviceIdService
│   └── utils/                   # 포맷 유틸, 랜덤 닉네임 생성기
├── domain/                      # 순수 Dart만 사용 (외부 의존성 없음)
│   ├── entity/                  # Video, User, Comment, Notification, PostImage
│   ├── repository/              # Repository 인터페이스
│   └── usecase/                 # GetVideoFeed, GetComments, ToggleLike, ToggleBookmark
├── data/                        # Domain 인터페이스 구현
│   ├── datasource/              # Remote/Local DataSource
│   ├── model/                   # freezed + json_serializable Model
│   └── repository/              # Repository 구현체
└── presentation/                # Feature별 UI
    ├── feed/                    # 영상 피드 (PageView, 오버레이, 댓글)
    ├── camera/                  # 15초 동영상 촬영
    ├── publish/                 # 영상/이미지 게시 + R2 업로드
    ├── profile/                 # 마이 프로필 (영상/북마크/좋아요 탭)
    ├── user_profile/            # 타 유저 프로필
    ├── friends/                 # 친구 목록 + 검색
    ├── notifications/           # 알림 (팔로우/좋아요/댓글/시스템)
    ├── settings/                # 설정 페이지
    ├── image_detail/            # 이미지 상세 (줌)
    ├── common/                  # 공통 위젯 (하단 네비게이션, 로딩)
    └── main/                    # MainShell (하단 탭 네비게이션)
```

### 레이어 의존성 규칙

```
Presentation → Domain ← Data
```

- **Domain**: 순수 Dart. Flutter/패키지 의존성 없음
- **Data**: Domain의 Repository 인터페이스를 구현
- **Presentation**: Riverpod Provider를 통해서만 Data에 접근 (직접 import 금지)

---

## 구현 기능 목록

### 필수 기능
- **Vertical Video Feed**: PageView 기반 세로 스크롤, 현재 화면 자동 재생, 이탈 시 자동 정지
- **Video Player**: video_player 사용, Autoplay / Pause / Resume, Buffering 처리, HLS + MP4 fallback
- **Overlay UI**: 프로필 아바타, 좋아요/댓글/북마크/공유 버튼, 영상 설명, 음악 정보 마키

### 가산점 기능 (전부 구현)
- **Like Toggle**: 좋아요 토글 + 로컬 상태 영속화
- **Double Tap Like**: 더블탭 하트 애니메이션
- **Infinite Scroll**: 피드 끝에서 다음 페이지 자동 로드
- **상태 관리**: Riverpod 2.0 (riverpod_generator + @riverpod 어노테이션)
- **확장 가능한 프로젝트 구조**: Clean Architecture (Domain/Data/Presentation 분리)

### 추가 구현 기능
- **댓글 시스템**: 댓글 + 답글 2depth, 다크 테마 바텀시트, 좋아요/싫어요
- **카메라 촬영**: 15초 동영상 녹화, 카메라 전환, 녹화 타이머
- **게시 + 업로드**: 영상/이미지 R2 서버 업로드, 설명/해시태그 입력, 썸네일 자동 생성
- **프로필**: 프로필 이미지 변경, 자기소개 편집, 영상/북마크/좋아요 탭, 팔로워/팔로잉 목록
- **친구 페이지**: 추천 유저 목록, 이름/ID 검색, 팔로우/언팔로우
- **알림**: 팔로우/좋아요/댓글/시스템 카테고리별 알림
- **팔로잉 탭**: 팔로잉한 유저 영상만 필터링
- **공유**: share_plus 연동 영상 공유
- **이미지 게시**: 사진 촬영/선택 + 업로드 + 이미지 상세 줌
- **멀티유저**: 디바이스 UUID 기반 유저 식별, 랜덤 닉네임 자동 생성
- **삭제**: 본인 영상/이미지 삭제 (서버 동기화)
- **API 연동**: REST API (GET /videos, POST /upload, DELETE /videos/:id 등)
- **로컬 저장소**: SharedPreferences 기반 좋아요/북마크/팔로우/닉네임/프로필 영속화

---

## Q1. 앱 구조 설계

### 폴더 구조 설계 이유

Clean Architecture를 채택하여 **Domain / Data / Presentation** 3개 레이어로 분리했습니다.

- **Domain 레이어**는 순수 Dart만 사용하며 Entity, Repository 인터페이스, UseCase를 포함합니다. 외부 프레임워크(Flutter, 패키지)에 의존하지 않아 비즈니스 로직의 테스트와 교체가 용이합니다.
- **Data 레이어**는 Domain의 Repository 인터페이스를 구현하며, DataSource(Remote/Local)와 Model(JSON 직렬화)을 담당합니다. API 응답 형식이 바뀌어도 Model만 수정하면 되고, Domain에는 영향이 없습니다.
- **Presentation 레이어**는 Feature별로 `view/`, `provider/`, `widget/` 폴더를 나누어 각 기능의 UI, 상태 관리, 재사용 위젯을 독립적으로 관리합니다.

이 구조를 선택한 이유는 **관심사 분리**입니다. 예를 들어, 서버 API가 변경되면 Data 레이어의 DataSource/Model만 수정하면 되고, UI를 변경해도 비즈니스 로직은 건드릴 필요가 없습니다.

### 상태 관리 방식 선택 이유

**Riverpod 2.0** (riverpod_generator + @riverpod 어노테이션)을 선택했습니다.

- **코드 생성 기반**: `@riverpod` 어노테이션으로 보일러플레이트를 최소화하고, 타입 안전한 Provider를 자동 생성합니다.
- **autoDispose 기본 적용**: 화면 이탈 시 불필요한 상태가 자동으로 정리되어 메모리 누수를 방지합니다.
- **AsyncNotifier 패턴**: API 호출 등 비동기 작업의 Loading/Error/Data 상태를 `AsyncValue`로 자연스럽게 처리합니다.
- **Provider 간 의존성**: Provider가 다른 Provider를 `ref.watch`로 구독하여 반응형 데이터 흐름을 구성합니다. 예를 들어 `feedProvider`가 `videoRepositoryProvider`를 의존하고, UI가 `feedProvider`를 watch하는 단방향 데이터 흐름이 형성됩니다.

### Video Player Lifecycle 처리 방식

**VideoPlayerManager**를 중앙 관리자로 설계하여 영상 재생 라이프사이클을 처리합니다.

```
PageView 스크롤 → onPageChanged → VideoPlayerManager.playAt(index)
```

- **Controller 캐싱**: 현재 재생 중인 영상 ±2 범위의 VideoPlayerController를 미리 생성하고 캐싱하여, 스크롤 시 즉시 재생이 가능합니다.
- **자동 재생/정지**: `playAt(index)` 호출 시 이전 영상은 pause, 현재 영상은 play. 범위 밖 컨트롤러는 dispose하여 메모리를 관리합니다.
- **HLS + MP4 Fallback**: HLS URL을 우선 시도하고, 404 에러 시 MP4 URL로 자동 전환합니다.
- **Buffering 처리**: 영상 로딩 중에는 서버 썸네일을 표시하여 검은 화면을 방지합니다.
- **앱 복원**: 마지막 시청 영상 인덱스를 SharedPreferences에 저장하여, 앱 재시작 시 해당 위치부터 재개합니다.

---

## Q2. 확장성 설계

이 앱을 실제 TikTok 규모 서비스로 확장한다면 다음 부분을 변경/개선해야 합니다.

### Video Preload 전략

현재는 ±2 범위의 컨트롤러를 미리 생성하는 수준입니다. 대규모 서비스에서는:

- **Adaptive Bitrate Streaming**: 네트워크 상태에 따라 자동으로 화질을 조절하는 HLS Adaptive Streaming을 활용해야 합니다. 현재도 HLS를 지원하지만, 클라이언트 측 bandwidth 감지 + 해상도 전환 로직이 추가로 필요합니다.
- **CDN Edge Caching**: 사용자 위치 기반 CDN 엣지 서버에서 영상을 서빙하여 초기 로딩 시간을 최소화합니다.
- **Preload 범위 동적 조절**: Wi-Fi 환경에서는 ±3~4, 모바일 데이터에서는 ±1로 preload 범위를 동적으로 조절하여 데이터 사용량과 UX를 균형있게 관리해야 합니다.

### 네트워크 처리

현재는 `http` 패키지로 단순 REST 호출을 하고 있습니다. 확장 시:

- **Dio + Interceptor**: 토큰 갱신, 요청 재시도, 로깅, 에러 핸들링을 Interceptor 체인으로 일원화해야 합니다.
- **Pagination Cursor**: 현재 offset 기반 페이지네이션을 cursor 기반으로 전환하여, 실시간 피드 업데이트 시 데이터 중복/누락을 방지해야 합니다.
- **오프라인 지원**: 네트워크 단절 시 로컬 캐시 데이터를 표시하고, 복구 시 자동 동기화하는 전략이 필요합니다.
- **GraphQL 또는 gRPC**: 다양한 클라이언트(iOS/Android/Web)의 데이터 요구사항이 달라질 때, 오버페칭을 줄이기 위해 GraphQL 도입을 고려할 수 있습니다.

### 상태 관리 구조

현재 Riverpod autoDispose 기반으로 잘 동작하지만, 규모가 커지면:

- **상태 정규화**: 현재 각 Provider가 독립적으로 데이터를 보유하는데, 동일 영상이 피드/프로필/검색에서 각각 다른 상태를 가질 수 있습니다. 중앙 Entity Store를 도입하여 ID 기반으로 상태를 정규화해야 합니다.
- **Optimistic Update 고도화**: 현재도 좋아요/팔로우에 optimistic update를 적용했지만, 실패 시 rollback과 충돌 해결 전략을 체계화해야 합니다.
- **Server-Driven UI**: 피드 구성을 서버에서 결정하고 클라이언트는 렌더링에 집중하는 방식으로, A/B 테스트와 기능 플래그를 유연하게 적용할 수 있습니다.

### 성능 최적화

- **영상 메모리 관리**: 현재 ±2 범위 캐싱도 메모리 이슈가 발생할 수 있으므로, LRU Cache 기반으로 최대 보유 컨트롤러 수를 제한하고, 메모리 압박 시 공격적으로 해제해야 합니다.
- **이미지 최적화**: 프로필 이미지, 썸네일을 WebP 포맷으로 전환하고, 해상도별 variant를 제공하여 네트워크 트래픽을 줄여야 합니다.
- **Lazy Loading Widget**: 화면에 보이지 않는 위젯의 빌드를 지연시키고, `RepaintBoundary`를 활용하여 불필요한 리페인트를 방지해야 합니다.
- **Native Platform 연동**: 영상 디코딩 등 성능 임계점이 있는 부분은 Platform Channel을 통해 네이티브 코드로 처리하는 것을 고려해야 합니다.

---

## Q3. 가장 어려웠던 문제

### 문제 상황

영상 피드에서 **VideoPlayerController의 메모리 누수와 동시성 문제**가 가장 어려웠습니다.

빠르게 스크롤하면 여러 VideoPlayerController가 동시에 initialize되면서 **OutOfMemoryError**가 발생했고, 이미 dispose된 컨트롤러에 play()가 호출되어 크래시가 나는 상황이었습니다. 특히 HLS 영상의 경우, 초기화에 시간이 걸리는 동안 사용자가 이미 다른 영상으로 넘어가면서 경쟁 조건(race condition)이 빈번하게 발생했습니다.

### 시도한 해결 방법

1. **단순 dispose 호출**: 페이지 변경 시 이전 컨트롤러를 즉시 dispose했으나, 비동기 initialize 도중에 dispose가 호출되면 에러가 발생했습니다.
2. **모든 컨트롤러 캐싱**: 메모리 절약을 위해 제거했지만, 반대로 컨트롤러가 너무 많이 쌓여 OOM이 발생했습니다.

### 최종 해결 방법

**3단계 방어 전략**을 적용했습니다.

1. **`_disposed` Set 관리**: dispose된 영상 ID를 Set으로 추적하여, 비동기 초기화 완료 후에도 이미 dispose된 컨트롤러에 play()가 호출되지 않도록 가드를 설정했습니다.
2. **범위 기반 캐싱 (±2)**: 현재 재생 중인 영상 기준 ±2 범위만 컨트롤러를 유지하고, 범위 밖 컨트롤러는 즉시 dispose합니다. 이때 `_cleanupControllers()`에서 범위 검사 후 안전하게 해제합니다.
3. **HLS → MP4 Fallback + Timeout**: HLS 초기화가 10초 이상 걸리면 타임아웃 후 MP4로 전환하며, 404 에러 시에도 자동으로 MP4 URL로 재시도합니다.

이 조합으로 빠른 스크롤 시에도 안정적인 재생과 메모리 관리가 가능해졌습니다.

---

## AI 사용 내역

### AI 사용 여부

**사용함** — Claude Code (Claude Opus)를 전체 개발 과정에서 활용했습니다.

### 역할 분담

| 역할 | 담당 |
|------|------|
| **아키텍처 설계** | 본인 (Clean Architecture, 레이어 분리 규칙, 폴더 구조) |
| **Phase 계획 및 우선순위** | 본인 (22개 Phase 기획, 일정 관리) |
| **코드 구현** | Claude Code (Domain/Data/Presentation 전 레이어) |
| **QA 테스트** | 본인 (실기기 테스트 후 버그 리포트) |
| **버그 수정** | Claude Code (QA 피드백 기반 수정) |
| **코드 리뷰** | Claude Code (code-reviewer 에이전트, 독립 리뷰) + 본인 (최종 승인) |

### AI를 사용한 작업 범위

- **코드 생성**: Entity, Model, Repository, DataSource, Provider, Widget 등 전체 코드
- **코드 생성 도구 실행**: `build_runner`, `dart analyze`, `dart format` 등
- **버그 수정**: QA에서 발견된 UI 오버플로우, 메모리 누수, 동시성 문제 등 수정
- **리팩토링**: 하드코딩 상수화, import 경로 정리, 코드 품질 개선
- **PR 생성 및 리뷰**: GitHub PR 생성, 독립적 코드 리뷰 수행

### 본인이 직접 작성/수행한 부분

- 프로젝트 아키텍처 설계 (Clean Architecture 레이어 규칙, 폴더 구조)
- 전체 Phase 계획 수립 (22개 Phase, 우선순위, 리스크 관리)
- 각 Phase별 요구사항 정의 및 작업 지시
- QA 테스트 (실기기에서 모든 기능 검증, 스크린샷 기반 버그 리포트)
- 모든 코드 변경에 대한 최종 승인 (PR 리뷰 후 머지)
- Git 브랜치 전략 설계 (main ← dev ← feature/* 워크플로우)

### AI 대화 기록

프로젝트의 `docs/ai_logs/` 폴더에 전체 Phase별 AI 대화 로그가 저장되어 있습니다.

총 **35개 세션**의 대화 기록이 있으며, 주요 내용은 다음과 같습니다:

| Phase | 날짜 | 주요 작업 |
|-------|------|----------|
| Phase 0~9 | 04/01 | 프로젝트 셋업, Domain/Data 레이어, 비디오 피드, 오버레이 UI, 네비게이션, 프로필, 무한 스크롤 |
| Phase 11~13 | 04/02 | 버그 수정, API 연동, 로컬 DB 영속화 |
| Phase 14~20 | 04/02 | 댓글, 공유, 친구, 카메라, 게시/업로드, 알림, 프로필 강화 |
| Fix 21A~21L | 04/02~03 | QA 기반 버그 수정 12회 (UI, 메모리, 동시성, HLS 등) |
| Feature 23~26 | 04/03 | 프로필 이미지, 이미지 게시, 디바이스 UUID, 랜덤 닉네임 |

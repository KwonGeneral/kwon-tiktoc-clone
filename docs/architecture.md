# 아키텍처 설계

## 설계 철학

이 프로젝트는 **정석 클린아키텍처**를 적용하여, 도메인 중심으로 설계합니다.

### 핵심 원칙
1. **의존성 역전**: Domain은 어떤 레이어에도 의존하지 않음
2. **단일 책임**: 각 클래스는 하나의 책임만 가짐
3. **인터페이스 분리**: Repository는 추상화로 정의, 구현은 Data 레이어
4. **UseCase = 비즈니스 로직**: API 엔드포인트가 아닌 "사용자 행위" 기준

---

## 레이어 구조

```
┌─────────────────────────────────────────────┐
│               Presentation                   │
│  (Widget, Provider, State, Router)           │
├─────────────────────────────────────────────┤
│                 Domain                       │
│  (Entity, Repository Interface, UseCase)     │
├─────────────────────────────────────────────┤
│                  Data                        │
│  (Model, Repository Impl, DataSource)        │
└─────────────────────────────────────────────┘
```

### 의존성 방향
```
Presentation → Domain ← Data
```
- Presentation은 Domain에 의존
- Data는 Domain에 의존 (Domain의 Repository 인터페이스를 구현)
- Domain은 아무것에도 의존하지 않음 (순수 Dart)

---

## 폴더 구조

```
lib/
├── main.dart                          # 앱 진입점
│
├── app/                               # 앱 설정
│   ├── app.dart                       # MaterialApp + ProviderScope
│   ├── route/
│   │   ├── app_router.dart            # GoRouter 설정
│   │   └── route_paths.dart           # 경로 상수
│   └── theme/
│       ├── app_theme.dart             # ThemeData
│       ├── app_colors.dart            # 색상 정의
│       └── app_text_styles.dart       # 텍스트 스타일
│
├── core/                              # 공통 유틸리티
│   ├── constants/
│   │   └── app_constants.dart         # 앱 상수
│   ├── utils/
│   │   ├── format_utils.dart          # 숫자 포맷 (1.2K, 5.5M 등)
│   │   └── duration_utils.dart        # 시간 포맷
│   └── extensions/
│       └── context_extensions.dart    # BuildContext 확장
│
├── domain/                            # 도메인 레이어 (순수 Dart)
│   ├── entity/
│   │   ├── video.dart                 # Video 엔티티
│   │   ├── user.dart                  # User 엔티티
│   │   └── comment.dart              # Comment 엔티티
│   ├── repository/
│   │   ├── video_repository.dart      # 비디오 관련 추상 인터페이스
│   │   └── user_repository.dart       # 유저 관련 추상 인터페이스
│   └── usecase/
│       ├── get_video_feed.dart        # 비디오 피드 가져오기
│       ├── toggle_like.dart           # 좋아요 토글
│       ├── get_comments.dart          # 댓글 가져오기
│       └── toggle_bookmark.dart       # 북마크 토글
│
├── data/                              # 데이터 레이어
│   ├── model/
│   │   ├── video_model.dart           # Video DTO (→ Entity 변환)
│   │   ├── user_model.dart            # User DTO
│   │   └── comment_model.dart         # Comment DTO
│   ├── datasource/
│   │   ├── video_datasource.dart      # 추상 데이터소스
│   │   └── mock_video_datasource.dart # Mock 구현
│   └── repository/
│       ├── video_repository_impl.dart # VideoRepository 구현체
│       └── user_repository_impl.dart  # UserRepository 구현체
│
└── presentation/                      # 프레젠테이션 레이어
    ├── feed/                          # 피드 기능
    │   ├── view/
    │   │   └── feed_page.dart         # 피드 메인 페이지
    │   ├── provider/
    │   │   ├── feed_provider.dart     # 피드 상태 관리
    │   │   └── feed_state.dart        # 피드 상태 클래스
    │   └── widget/
    │       ├── video_card.dart        # 개별 비디오 카드
    │       ├── video_overlay.dart     # 오버레이 UI
    │       ├── side_action_bar.dart   # 우측 아이콘 바
    │       ├── video_description.dart # 하단 영상 정보
    │       ├── top_tab_bar.dart       # 상단 탭 바
    │       └── like_animation.dart    # 더블탭 하트 애니메이션
    ├── profile/                       # 프로필 기능
    │   ├── view/
    │   │   └── profile_page.dart
    │   ├── provider/
    │   │   └── profile_provider.dart
    │   └── widget/
    │       └── profile_header.dart
    ├── common/                        # 공통 위젯
    │   ├── bottom_nav_bar.dart        # 하단 네비게이션
    │   └── loading_indicator.dart     # 로딩 인디케이터
    └── main/                          # 메인 셸
        └── main_shell.dart            # BottomNav + GoRouter ShellRoute
```

---

## 도메인 엔티티 설계

### Video
```dart
class Video {
  final String id;
  final String videoUrl;
  final String thumbnailUrl;
  final User user;
  final String description;
  final String musicName;
  final int likeCount;
  final int commentCount;
  final int bookmarkCount;
  final int shareCount;
  final bool isLiked;
  final bool isBookmarked;
}
```

### User
```dart
class User {
  final String id;
  final String username;
  final String displayName;
  final String avatarUrl;
  final bool isFollowing;
  final int followerCount;
  final int followingCount;
}
```

### Comment
```dart
class Comment {
  final String id;
  final User user;
  final String content;
  final DateTime createdAt;
  final int likeCount;
  final bool isLiked;
}
```

---

## Repository 인터페이스 설계

### VideoRepository
```dart
abstract class VideoRepository {
  Future<List<Video>> getVideoFeed({required int page, required int limit});
  Future<Video> toggleLike({required String videoId});
  Future<Video> toggleBookmark({required String videoId});
  Future<Video> getVideoDetail({required String videoId});
}
```

### UserRepository
```dart
abstract class UserRepository {
  Future<User> getUserProfile({required String userId});
  Future<User> toggleFollow({required String userId});
}
```

Repository 인터페이스는 "어디서 데이터를 가져오는지"가 아닌 "무슨 기능이 필요한지" 기준으로 정의합니다.

---

## UseCase 설계

비즈니스 로직 기준으로 정의합니다:
```
GetVideoFeed    → "사용자가 피드를 본다"
ToggleLike      → "사용자가 좋아요를 누른다"
ToggleBookmark  → "사용자가 북마크한다"
GetComments     → "사용자가 댓글을 본다"
```

### UseCase 패턴
```dart
class GetVideoFeed {
  final VideoRepository _repository;

  GetVideoFeed(this._repository);

  Future<List<Video>> call({required int page, int limit = 10}) {
    return _repository.getVideoFeed(page: page, limit: limit);
  }
}
```

---

## 상태관리 (Riverpod)

### Provider 의존성 구조
```
videoRepositoryProvider → getVideoFeedUseCaseProvider → feedProvider
                        → toggleLikeUseCaseProvider   ↗
```

### Feed Provider (AsyncNotifier 패턴)
```dart
@riverpod
class FeedNotifier extends _$FeedNotifier {
  @override
  Future<FeedState> build() async {
    final videos = await ref.read(getVideoFeedUseCaseProvider).call(page: 0);
    return FeedState(videos: videos, currentPage: 0);
  }

  Future<void> loadMore() async { ... }
  Future<void> toggleLike(String videoId) async { ... }
  Future<void> toggleBookmark(String videoId) async { ... }
}
```

### Riverpod 선택 이유
1. **코드 생성 기반**: riverpod_generator로 보일러플레이트 최소화
2. **타입 안전**: 컴파일 타임에 의존성 검증
3. **자동 dispose**: autoDispose로 메모리 누수 방지
4. **테스트 용이**: ProviderContainer로 오버라이드 가능

---

## 라우팅 (GoRouter)

```dart
GoRouter(
  initialLocation: '/feed',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(path: '/feed', builder: ... → FeedPage),
        GoRoute(path: '/discover', builder: ... → DiscoverPage),
        GoRoute(path: '/notifications', builder: ... → placeholder),
        GoRoute(path: '/profile', builder: ... → ProfilePage),
      ],
    ),
  ],
)
```

### GoRouter 선택 이유
1. **선언적 라우팅**: 경로를 한곳에서 관리
2. **ShellRoute**: 하단 네비게이션 바 유지하면서 내부 페이지 전환
3. **딥링크 지원**: 향후 확장 시 유리
4. **Riverpod 연동**: redirect에서 인증 상태 체크 가능

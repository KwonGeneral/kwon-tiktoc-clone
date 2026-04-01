# TikTok Clone - Flutter Project

## Quick Commands
- `flutter pub get` — 패키지 설치
- `flutter test` — 테스트 실행
- `dart run build_runner build --delete-conflicting-outputs` — 코드 생성
- `dart format lib/` — 코드 포매팅
- `dart analyze lib/` — 정적 분석

## Architecture: Clean Architecture

```
Presentation → Domain ← Data
```

- **Domain**: 순수 Dart만 사용, 외부 의존성 금지
- **Data**: Domain의 Repository 인터페이스를 구현
- **Presentation**: Riverpod Provider + Flutter Widget

### Layer Rules
- Domain 레이어는 Data, Presentation을 절대 import하지 않음
- Data 레이어는 Presentation을 import하지 않음
- Presentation은 Data를 직접 import하지 않음 (Provider를 통해서만)

## Folder Structure
```
lib/
├── main.dart
├── app/          # 앱 설정 (Router, Theme)
├── core/         # 공통 유틸리티
├── domain/       # Entity, Repository Interface, UseCase
├── data/         # Model, DataSource, Repository Impl
└── presentation/ # Feature별 (view/, provider/, widget/)
```

## State Management: Riverpod
- `riverpod_generator` + `@riverpod` 어노테이션 사용
- AsyncNotifier 패턴 (비동기 상태)
- autoDispose 기본 적용

## Routing: GoRouter
- ShellRoute로 하단 네비게이션 유지
- 경로 상수는 `route_paths.dart`에 정의

## Coding Conventions
- 파일명: snake_case (`video_repository.dart`)
- 클래스명: PascalCase (`VideoRepository`)
- private 변수: `_underscore`
- Entity: freezed 사용, immutable
- Model: freezed + json_serializable
- import 순서: dart → package → project → relative

## Git Branch Strategy
- `main` ← `dev` ← `feature/*`, `fix/*`, `docs/*`, `chore/*`
- feature/fix 브랜치는 dev 기준으로 생성
- feature → dev: 일반 Merge (커밋 히스토리 보존)
- dev → main: Squash Merge (릴리즈 단위)
- 브랜치명: `feature/phase-{번호}-{설명}`, `fix/{설명}`, `docs/{설명}`
- 커밋 메시지: Conventional Commits (feat, fix, docs, refactor, test, chore, style)
- main, dev에 직접 커밋 금지 — PR만 허용

## Skills & Workflow

### Phase 작업 흐름
```
/phase-start    → 계획 확인 + 브랜치 생성
(코드 구현)     → 사용자 검토
/phase-done     → 전체 자동 수행:
                   검증 → 로그 저장 → 문서 업데이트 → 커밋 → PR → 리뷰 → 머지
```
개별 실행도 가능: /phase-complete, /commit-push, /pr-create, /pr-review, /pr-merge

### 보조 스킬
- `/test` — flutter test 실행 + 결과 분석
- `/analyze` — dart analyze 실행 + 에러 수정
- `/update-docs` — 코드 변경에 맞춰 문서 업데이트
- `/save-log` — 현재 세션 AI 대화 로그 저장 (.docs/ai_logs/)

### Agent
- `code-reviewer` — PR 코드 리뷰 전용 에이전트 (코드 작성 맥락과 분리된 독립적 리뷰)
- `/pr-review` 실행 시 자동으로 이 에이전트를 호출

### 규칙
- 모든 스킬은 사용자가 `/명령어`로 직접 호출할 때만 실행
- 커밋, PR, 머지는 절대 자동 실행하지 않음
- Phase 계획은 `.docs/03_phase_plan.md` 참조

## Don'ts
- Domain 레이어에 Flutter/패키지 의존성 추가 금지
- Widget에서 직접 Repository 호출 금지 (Provider 통해서만)
- 하드코딩된 문자열 금지 (상수로 분리)
- `print()` 사용 금지 (debugPrint 또는 logger 사용)

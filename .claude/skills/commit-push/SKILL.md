---
name: commit-push
description: 현재 변경 사항을 커밋하고 푸시합니다. 사용자이 명시적으로 요청할 때만 실행합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob
---

현재 변경 사항을 커밋하고 푸시합니다.

## 절차

1. `git status`로 변경된 파일 목록을 확인하세요.
2. `git diff --staged` 및 `git diff`로 변경 내용을 분석하세요.
3. 변경 파일을 선별적으로 스테이징하세요 (관련 파일만).
   - 자동 생성 파일(*.g.dart, *.freezed.dart)은 변경 시 함께 커밋
   - .docs/, mission.txt, notice.txt 등 비공개 파일은 절대 커밋 금지
   - 불필요한 임시 파일은 제외
4. Conventional Commits 형식으로 커밋 메시지를 작성하세요.
   - Co-Authored-By 라인을 절대 추가하지 마세요. 커밋 작성자는 사용자 본인만 표시되어야 합니다.
5. 현재 브랜치를 원격 저장소에 푸시하세요.
6. 커밋 해시와 푸시 결과를 나에게 알려주세요.

## 커밋 타입 가이드

| 타입 | 용도 | 예시 |
|------|------|------|
| `feat` | 새 기능 | `feat: 비디오 피드 구현` |
| `fix` | 버그 수정 | `fix: 비디오 자동재생 이슈 수정` |
| `docs` | 문서 변경 | `docs: README 업데이트` |
| `refactor` | 리팩토링 | `refactor: Provider 구조 개선` |
| `test` | 테스트 | `test: VideoRepository 유닛 테스트 추가` |
| `chore` | 설정/빌드 | `chore: 프로젝트 초기 셋팅` |
| `style` | 포맷/스타일 | `style: dart format 적용` |

## 규칙

- 커밋 메시지 subject는 50자 이내로 간결하게 작성
- 여러 종류의 변경이 섞여 있으면 가장 주요한 변경 기준으로 타입 결정
- 변경 사항이 없으면 그대로 종료
- main, dev 브랜치에 직접 커밋/푸시 금지 — feature/* 브랜치에서만 커밋
- 현재 브랜치가 main 또는 dev이면 경고하고 중단

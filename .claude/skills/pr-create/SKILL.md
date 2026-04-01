---
name: pr-create
description: 현재 브랜치에서 GitHub PR을 생성합니다. 코드 리뷰는 /pr-review에서 별도 수행합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob
---

현재 브랜치에서 PR을 생성합니다.

## 절차

1. 현재 브랜치 확인 (main이나 dev이면 중단)
2. 푸시되지 않은 커밋이 있으면 먼저 푸시
3. base 브랜치 결정:
   - feature/*, fix/*, docs/*, chore/* → base: dev
   - 사용자가 "main에 PR" 이라고 하면 → base: main
4. 변경 내용 분석:
   - `git log {base}..HEAD --oneline` 으로 커밋 목록 확인
   - 변경 파일 목록 확인
5. PR 생성:
   - `gh pr create --base {base}`
   - 제목: Conventional Commits 형식
   - 본문: 작업 내용 요약 + 변경 파일 + 체크리스트
6. PR URL을 사용자에게 보고

## PR 제목 규칙
- feature → dev: `feat: Phase {번호} - {설명}`
- fix → dev: `fix: {설명}`
- dev → main: `feat: {기능 묶음 설명}`

## 규칙
- 이 스킬에서는 PR 생성만 수행. 리뷰와 머지는 하지 않음
- PR 생성 후 "/pr-review로 코드 리뷰를 진행할 수 있습니다" 안내

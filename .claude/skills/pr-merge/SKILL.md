---
name: pr-merge
description: 사용자이 승인한 PR을 머지합니다. 사용자의 명시적 요청 없이는 실행하지 않습니다.
user-invocable: true
allowed-tools: Bash, Read
---

사용자이 승인한 PR을 머지합니다.

## 절차

1. 현재 열려있는 PR 확인: `gh pr list`
2. 머지 대상 PR 확인 (번호 또는 현재 브랜치 기준)
3. 머지 전략 결정:
   - feature/* → dev: 일반 Merge (`gh pr merge --merge --delete-branch`)
   - dev → main: Squash Merge (`gh pr merge --squash --delete-branch`)
4. 머지 실행
5. 로컬 브랜치 정리:
   - `git checkout dev`
   - `git pull`
   - `git branch -d {머지된 브랜치}`
6. 결과를 사용자에게 보고

## 규칙
- 사용자이 "머지해" 라고 하기 전에는 절대 실행하지 않음
- 머지 전 리뷰가 완료되었는지 확인
- dev → main 머지 시 반드시 Squash Merge 사용

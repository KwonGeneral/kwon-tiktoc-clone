---
name: phase-done
description: Phase 작업 완료 후 전체 마무리 프로세스를 자동으로 순서대로 수행합니다. (검증 → 로그 저장 → 커밋 → PR → 리뷰 → 머지)
user-invocable: true
allowed-tools: Bash, Read, Write, Edit, Grep, Glob, Agent
---

Phase 작업이 끝난 후 마무리 프로세스를 순서대로 수행합니다.
사용자가 이 스킬 하나만 호출하면 아래 전체가 자동으로 진행됩니다.

## 순서

### Step 1: Phase 완료 검증
- `.docs/03_phase_plan.md`에서 현재 Phase 체크리스트 확인
- `.docs/09_requirement_checklist.md`에서 과제 요구사항 확인
- `dart analyze lib/` 실행
- 누락 항목이 있으면 여기서 중단하고 사용자에게 보고

### Step 2: 대화 로그 저장
- 이번 세션 대화 내용을 `.docs/ai_logs/phase-{번호}-{날짜}.md`에 요약 저장

### Step 3: 문서 업데이트
- `.docs/03_phase_plan.md` 체크리스트 업데이트
- `.docs/09_requirement_checklist.md` 해당 항목 체크
- `docs/architecture.md`, `CLAUDE.md` 변경 필요 시 업데이트

### Step 4: 커밋 + 푸시
- 변경 파일 선별적 스테이징 (비공개 파일 제외)
- Conventional Commits 형식으로 커밋
- Co-Authored-By 라인을 절대 추가하지 않음 (커밋 작성자는 사용자 본인만 표시)
- 현재 브랜치에 푸시
- main/dev 브랜치이면 중단

### Step 5: PR 생성
- `gh pr create --base dev`
- 제목: `feat: Phase {번호} - {설명}`
- 본문: 작업 내용 요약 + 변경 파일 + 체크리스트

### Step 6: 코드 리뷰
- code-reviewer 에이전트를 호출하여 독립적 리뷰 수행
- GitHub PR에 리뷰 코멘트 작성
- 이슈 발견 시: 사용자에게 보고하고 여기서 중단
- 이슈 없으면: Approve 작성 후 다음 단계로

### Step 7: 머지
- feature → dev: 일반 Merge (`gh pr merge --merge --delete-branch`)
- 로컬 브랜치 정리 (checkout dev, pull, 브랜치 삭제)

### Step 8: 완료 보고
- 전체 결과 요약 보고
- 다음 Phase 안내

## 중단 조건
- Step 1에서 누락 항목 발견 시 → 중단, 사용자에게 보고
- Step 6에서 리뷰 이슈 발견 시 → 중단, 사용자에게 보고
- 어느 단계든 에러 발생 시 → 중단, 사용자에게 보고

## 규칙
- 각 단계 시작 전 간단히 "Step N 진행합니다" 표시
- 중단 시 어디서 멈췄는지, 왜 멈췄는지 명확히 보고
- 문제 해결 후 사용자가 다시 /phase-done 하면 남은 단계부터 재개

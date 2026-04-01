---
name: phase-start
description: 새로운 Phase를 시작합니다. Phase 계획을 확인하고 feature 브랜치를 생성합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob
---

새로운 Phase를 시작합니다.

## 절차

1. `.docs/03_phase_plan.md`를 읽어서 시작할 Phase의 작업 내용을 확인하세요.
2. 해당 Phase의 체크리스트를 나에게 보여주세요.
3. 이전 Phase가 완료되었는지 확인하세요.
4. 작업 시작 전, 현재 git 상태가 깨끗한지 확인하세요.
5. dev 브랜치에서 feature 브랜치를 생성하세요:
   - `git checkout dev && git pull`
   - `git checkout -b feature/phase-{번호}-{설명}`
6. Phase 작업을 시작하기 전에 작업 계획을 나에게 설명하세요.

## 규칙
- Phase는 순서대로 진행합니다 (0 → 1 → 2 → ...)
- 이전 Phase가 미완료면 먼저 완료 후 진행합니다.
- 작업 시작 전 반드시 나에게 계획을 공유하고 승인을 받으세요.

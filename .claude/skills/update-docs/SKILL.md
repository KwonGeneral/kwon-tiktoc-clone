---
name: update-docs
description: 코드 변경 사항을 기반으로 공개 문서(docs/, CLAUDE.md)와 비공개 문서(.docs/)를 업데이트합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob, Edit, Write
---

현재 변경 사항을 기반으로 문서를 업데이트합니다.

## 절차

1. `git diff --name-only` 및 `git status`로 변경된 파일 목록을 확인하세요.
2. 아래 체크리스트를 기반으로 업데이트 대상을 판단하세요.

## 체크리스트

### CLAUDE.md
- [ ] **Architecture**: 레이어 구조나 디렉토리 변경 시 트리 업데이트
- [ ] **Coding Conventions**: 새 컨벤션이 추가되었으면 반영
- [ ] **Quick Commands**: 빌드/테스트 명령 변경 시 업데이트
- [ ] **Don'ts**: 새 금지 규칙이 추가되었으면 반영

### docs/ 파일별
- [ ] `docs/architecture.md` — 폴더 구조, 엔티티, Repository, UseCase 변경 시
- [ ] `docs/tech_decisions.md` — 패키지 추가/제거 시

### 비공개 문서 (.docs/)
- [ ] `.docs/03_phase_plan.md` — Phase 체크리스트 업데이트
- [ ] `.docs/06_ai_usage_log.md` — AI 사용 기록 (Phase 완료 시)

## 규칙
- 변경 사항이 없는 문서는 건드리지 마세요.
- 실제 코드와 일치하는지 검증하세요.
- 공개 문서(docs/, CLAUDE.md)에 내부 전략이 노출되지 않도록 주의하세요.
- 업데이트 완료 후 변경된 문서 목록을 나에게 알려주세요.

---
name: phase-complete
description: 현재 Phase의 완료 상태를 검증합니다. 체크리스트 대비 실제 구현을 비교합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob, Edit
---

현재 Phase를 완료 처리합니다.

## 절차

1. `.docs/03_phase_plan.md`를 읽어서 현재 Phase의 체크리스트를 확인하세요.
2. 각 항목이 실제로 구현되었는지 코드/파일을 검증하세요.
3. `dart analyze lib/` 실행하여 경고/에러 확인하세요.
4. 검증 결과를 나에게 보고하세요:
   - 완료된 항목
   - 누락된 항목
   - 코드 품질 이슈
5. 모든 항목이 완료되면:
   - `.docs/03_phase_plan.md` 체크리스트 업데이트
   - 공개 문서 업데이트 필요 여부 확인
   - 커밋 준비 안내

## 규칙
- 누락된 항목이 있으면 Phase 완료 처리하지 마세요.
- 코드 품질 이슈가 있으면 먼저 수정하세요.
- 완료 후 나에게 다음 Phase 시작 여부를 확인하세요.

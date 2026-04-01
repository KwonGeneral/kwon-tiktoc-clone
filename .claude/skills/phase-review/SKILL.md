---
name: phase-review
description: 현재 Phase의 완료 상태를 검토합니다. Phase 계획 문서와 실제 구현을 비교하여 누락된 항목을 확인합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob
---

Phase 완료 검토를 수행하세요:

1. `.docs/03_phase_plan.md`를 읽어서 현재 진행 중인 Phase의 체크리스트 확인
2. 실제 파일/코드와 비교:
   - 모든 체크리스트 항목이 구현되었는지 확인
   - 누락된 항목 목록 작성
3. 코드 품질 확인:
   - `dart analyze lib/` 실행
   - 미사용 import 확인
   - 아키텍처 레이어 규칙 위반 확인 (Domain이 Data/Presentation import하는지)
4. 결과 보고:
   - 완료된 항목 ✅
   - 누락된 항목 ❌
   - 코드 품질 이슈
   - 다음 Phase 시작 가능 여부

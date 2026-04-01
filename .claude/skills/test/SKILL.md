---
name: test
description: Flutter 테스트를 실행하고 결과를 분석합니다. 테스트 실패 시 원인을 분석하고 수정 방안을 제시합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep
---

Flutter 테스트를 실행하고 결과를 분석하세요:

1. `flutter test` 실행
2. 결과 요약:
   - 총 테스트 수
   - 성공/실패 수
3. 실패한 테스트가 있으면:
   - 실패 원인 분석
   - 수정 방안 제시
4. 모든 테스트 통과 시 간단히 "All tests passed" 보고

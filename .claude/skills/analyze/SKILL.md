---
name: analyze
description: dart analyze를 실행하여 정적 분석 경고/에러를 확인하고 수정합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Edit
---

정적 분석을 실행하고 결과를 처리하세요:

1. `dart analyze lib/` 실행
2. 결과 요약:
   - 에러 수
   - 경고 수
   - 정보 수
3. 에러가 있으면 즉시 수정
4. 경고는 목록으로 보고하고 수정 여부 확인
5. 목표: 경고/에러 0개

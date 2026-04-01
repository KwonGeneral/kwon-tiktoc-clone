---
name: pr-review
description: PR의 코드를 리뷰합니다. code-reviewer 에이전트를 호출하여 코드 작성 맥락과 완전히 분리된 독립적 리뷰를 수행합니다.
user-invocable: true
allowed-tools: Bash, Read, Grep, Glob, Agent
---

code-reviewer 에이전트를 사용하여 PR 코드 리뷰를 수행하세요.

## 절차

1. 리뷰 대상 PR 확인:
   - `gh pr list` 로 열린 PR 목록 확인
   - 사용자가 PR 번호를 지정하면 해당 번호, 아니면 현재 브랜치의 PR
2. PR 번호를 확인한 후, code-reviewer 에이전트를 호출하세요:
   - Agent tool 사용, subagent_type 지정 없이 `.claude/agents/code-reviewer.md`의 규칙에 따라 리뷰 수행
   - PR 번호를 전달
3. 에이전트의 리뷰 결과를 사용자에게 보고하세요:
   - 통과: "리뷰 통과. /pr-merge로 머지할 수 있습니다"
   - 이슈: "이슈 N개 발견. 수정 후 다시 /pr-review 해주세요"

## 규칙
- 반드시 code-reviewer 에이전트를 통해 리뷰 (메인 대화에서 직접 리뷰하지 않음)
- 이 스킬에서는 리뷰만 수행. 머지는 하지 않음

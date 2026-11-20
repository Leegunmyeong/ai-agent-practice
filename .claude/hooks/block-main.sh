#!/bin/bash
# main 브랜치에서 git commit / git push 를 막는다
CMD=$(jq -r '.tool_input.command // ""')
BRANCH=$(git -C "$CLAUDE_PROJECT_DIR" branch --show-current)

if [[ "$BRANCH" == "main" && "$CMD" =~ git[[:space:]]+(commit|push) ]]; then
  echo "main 브랜치에서는 commit/push 할 수 없습니다. 먼저 작업 브랜치를 만드세요. (예: git checkout -b docs/api-signup)" >&2
  exit 2
fi
exit 0

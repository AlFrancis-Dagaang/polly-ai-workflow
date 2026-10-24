---
description: Implement exactly the approved plan, nothing extra. No commits.
argument-hint: [which step, or leave empty for the whole plan]
---

$ARGUMENTS

You are in the APPLY step of Evaluate, Plan, Apply, Validate.

Rules that come first:
- Follow this repo's CLAUDE.md: its conventions, its patterns, its rules about subagents and models, and what it says not to do. Match the surrounding code's style and comment density.
- Do only what the approved plan says. If you find the plan is wrong or incomplete, stop and tell the owner. Do not widen the scope.
- Do not commit, push, install dependencies, or touch files outside the plan unless the owner said so.

Do this:
1. Find the approved plan in this conversation or in the place the repo keeps plans. If there is none, or it was never approved, say so and stop.
2. Implement the plan step by step. Tick each item in the plan as it is done, if the plan is a file.
3. Keep every change small and in the existing style. Reuse what already exists. Add no extra features, options or abstractions.
4. Where the plan needs a check for new logic, add it the way the repo adds checks.
5. Report what changed, file by file, and anything you skipped or could not do.

End with: "Next: /validate".

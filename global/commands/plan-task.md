---
description: Write a checkable plan for the evaluated task, then stop and wait for approval.
argument-hint: [anything to add or change in the plan]
---

$ARGUMENTS

You are in the PLAN step of Evaluate, Plan, Apply, Validate. Plan only. Build nothing.

Rules that come first:
- Follow this repo's CLAUDE.md. Put the plan where it says plans go, in the format it asks for, and name the brief, story or registry entry it says a plan must touch. If it names no place, show the plan in the chat and do not create a file.
- Do not create any other file, and do not edit code, docs or config.
- If the owner told you not to touch certain docs, leave them out of the plan and say so.

Do this:
1. Use the evaluation from this conversation. If there is none, say so and ask whether to run /evaluate first.
2. Write the plan with checkboxes, file by file: what changes, in what order, and why. Keep it the smallest change that fully solves the task. Name what you are leaving out. For a new feature, make the first items the files CLAUDE.md requires (the brief, the registry row, the story files); list them, do not create them yet. /apply creates them after approval.
3. List how each step will be checked: the repo's own checks, and what you will look at to prove it works.
4. List open questions and any choice you made that the owner should confirm.

Then stop and wait for approval. Do not start applying. End with: "Next: /apply once you approve."

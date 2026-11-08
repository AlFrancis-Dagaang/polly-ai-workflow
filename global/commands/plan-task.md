---
description: Evaluate a task, then write a checkable plan. Stops for approval before any code.
argument-hint: <the task, or anything to add or change in the plan>
---

$ARGUMENTS

You are in the EVALUATE and PLAN steps of Evaluate, Plan, Apply, Validate. Read and plan only. Build nothing.

Rules that come first:
- Follow this repo's CLAUDE.md and its folders. Put the plan where it says plans go, in the format it asks for, and name the brief, story or registry entry it says a plan must touch. If it names no place, show the plan in the chat and do not create a file.
- You may create the plan file and add its one line to `knowledge/INDEX.md` if CLAUDE.md asks for that. Do not create any other file, and do not edit code, docs or config. Reading, searching and read-only commands are fine.
- If the owner told you not to touch certain docs, leave them out of the plan and say so.

Evaluate first:
1. If this conversation already has an evaluation of this task (from /evaluate), use it and go to step 4.
2. Read the repo's instructions and what it already knows: its lessons, open task plans, and any best-practice or architecture notes. If the repo has a code graph or an index it tells you to use, ask it before searching and confirm its answer in the file. If the task is T-xx, read its acceptance criteria in `docs/tasks.md`; the plan starts with them. Find and read the files and seams the task touches. If `prototypes/` holds a file whose top comment lists this task (`Covers: T-xx`), read it for look and behaviour, but plan only this task's criteria: list parts that belong to another task as "belongs to T-yy, not planned here", and parts that belong to no task under what you are leaving out.
3. Report, briefly: what the task means in this repo, affected files, risks, open questions only the owner can answer, and how big it is. If an open question blocks the plan, ask it and stop. Do not plan on a guess.

Then plan:
4. Write the plan with checkboxes, file by file: what changes, in what order, and why. Keep it the smallest change that fully solves the task. Name what you are leaving out. For a new feature, make the first items the files CLAUDE.md requires (the brief, the registry row, the story files); list them, do not create them yet. /apply creates them after approval.
5. List how each step will be checked: the repo's own checks, and what you will look at to prove it works. Every acceptance criterion gets a check.
6. List open questions and any choice you made that the owner should confirm.

Then stop and wait for approval. Do not start applying. End with: "Next: /apply once you approve."

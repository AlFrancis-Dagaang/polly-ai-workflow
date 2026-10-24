---
description: Evaluate a task before planning it. Read-only: affected files, risks, open questions. Then stop.
argument-hint: <the task>
---

Task: $ARGUMENTS

You are in the EVALUATE step of Evaluate, Plan, Apply, Validate. Read and report only.

Rules that come first:
- Follow this repo's CLAUDE.md and its folders. Use the places it names for plans, lessons, docs and checks. Do not invent folders or files.
- Make no edits, create no files, run no commits. Reading, searching and read-only commands are fine.
- If the task is unclear, ask the one question that unblocks it, then stop.

Do this:
1. Read the repo's instructions (CLAUDE.md and any file it points to) and note the rules that apply to this task.
2. Check what the repo already knows: its lessons, its open task plans, and any best-practice or architecture notes. Say which ones are relevant, or that there are none.
3. If the repo has a code graph or an index it tells you to use, ask it before searching. Treat its answer as a lead and confirm it in the file.
4. Find the files and seams the task touches. Read the ones you will need to understand.
5. Report, briefly:
   - What the task means in this repo, in two or three sentences.
   - Affected files, and what each one needs.
   - Risks and anything that could break for users or other parts of the system.
   - Open questions only the owner can answer.
   - How big it is, and whether it needs a plan (the repo's rule for that, if it has one).

Then stop. Do not plan or apply. End with: "Next: /plan-task".

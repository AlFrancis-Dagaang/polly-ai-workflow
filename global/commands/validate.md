---
description: Prove the work does what it should. Run the repo's checks, sort findings, suggest a review.
argument-hint: [anything specific to check]
---

$ARGUMENTS

You are in the VALIDATE step of Evaluate, Plan, Apply, Validate.

Rules that come first:
- Follow this repo's CLAUDE.md for what counts as checked and done, and for the commands to run. Use the repo's own checks. Do not invent test commands, and do not claim a check passed if you did not run it.
- Report faithfully. If something fails, show the output. If you skipped something, say so.
- Do not commit. Do not fix anything beyond what the owner asked; list it instead.

Do this:
1. Run the repo's checks that apply to what changed, and show the results.
2. Prove the behaviour, not only the build: run it, render it, or exercise the real flow when the repo's rules or the task call for that.
3. Compare the result with the plan and the acceptance points the owner gave. Say what is met and what is not.
4. Sort every finding as:
   - Blocker: must be fixed before this is done.
   - Fix now: small, cheap, worth doing in this change.
   - Backlog: real but outside this task.
5. If the repo has a definition of done or a registry to update, walk through it and list what is open.
6. Say plainly what you did not check and any risk the owner must know.
7. Look back over this task, including any review findings, and say whether a lesson is owed: a correction from the owner, a claim you had to retract, or a mistake that cost rework. Name it in one line, and say where the repo keeps lessons. Do not write the lesson file; the owner decides.

End with: "Next: /code-review before calling it done."

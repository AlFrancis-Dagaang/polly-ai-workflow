---
name: retro
description: Review a finished milestone: what shipped, what cost rework, what to change in the brief, the backlog and the workflow.
argument-hint: "[milestone name]"
disable-model-invocation: true
---

$ARGUMENTS

You are reviewing what has been built so far, from evidence, and proposing what to change. Report first, change last.

Rules that come first:
- If the repo root has no `.polly` file, say "Not a polly project, /retro only runs in one." and stop.
- If no task in `docs/tasks.md` has `Status: done`, say "Nothing finished yet, nothing to review." and stop.
- Write only: one new file in `knowledge/retros/`, one line in `knowledge/INDEX.md`, and the edits to `docs/brief.md` and `docs/tasks.md` that I approve one by one. Never change a done task, renumber a task, or delete a lesson or decision. Never write anything outside this project.
- Write nothing until I approve the draft and each proposed change.

Do this:
1. Pick the span: the text after `/retro`, else everything since the newest file in `knowledge/retros/`, else the whole project. Say which.
2. Read the evidence, not memory: `docs/brief.md`, `docs/tasks.md`, the plan and outcome in `knowledge/tasks/T-xx.md` for each done task in the span, the lessons, decisions and best-practices from the span, and `git log` for the span. A task with no outcome recorded counts as "no record": say so and don't guess.
3. Report in the chat, briefly:
   - Shipped: the done tasks, and whether the brief's done signal is met.
   - Cost rework: where a plan was wrong or work was redone, each with its evidence (lesson, commit, plan note).
   - Patterns: the same kind of lesson or backlog item twice or more.
   - Still open: backlog items and follow-ups left in the task outcomes.
4. Ask at most 2 questions, one at a time, only about what the evidence can't answer.
5. Propose changes, each as a short before/after, approved one at a time:
   - Brief: v1 scope, non-goals or the done signal that reality has overtaken. Edit in place and quote what moved.
   - Backlog: new tasks from the follow-ups, appended with the next free number in the `/tasks` format (`## T-xx: Title`, one `Status: todo` line, criteria), and a suggested reorder of the `todo` tasks. A task that no longer matters is proposed for dropping, never silently removed.
   - Workflow: at most 3 suggestions for the workflow repo (a skill that asked a wasted question, a rule that didn't match what happened, whether /code-review missed repo-specific issues), each tied to evidence. Show them in the chat only; write them nowhere.
6. Draft the retro file, one screen:
   ```
   # Retro: <span or milestone>
   Date: YYYY-MM-DD   Span: <first task or date> to <last>
   ## Shipped
   ## What cost rework
   ## What we changed
   Brief and backlog edits made, one line each.
   ## Workflow suggestions
   The ones worth keeping, with the evidence.
   ```
7. Show the draft and wait for my OK.
8. Write `knowledge/retros/YYYY-MM-DD-<slug>.md` (date from `date +%F`, slug of 2–4 words; if the file exists, add `-2`, `-3`, and so on, never overwrite). Add one line under "## Retros" in `knowledge/INDEX.md`: `- [Title](retros/<file>) — the main finding in a few words`. Then make the approved brief and backlog edits.

End with: "Next: /plan-task T-xx" for the first open task, or "All tasks done. Next: /tasks to add more, or ship it."

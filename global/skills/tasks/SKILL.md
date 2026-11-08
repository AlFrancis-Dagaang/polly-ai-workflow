---
name: tasks
description: Slice the brief and architecture into vertical tasks with checkable acceptance criteria. Third step of a polly project.
argument-hint: "[what to add or change]"
disable-model-invocation: true
---

$ARGUMENTS

You are writing the task list: small vertical slices, each with criteria I can check. Slice first, write last.

Rules that come first:
- If the repo root has no `.polly` file, say "Not a polly project, /tasks only runs in one." and stop.
- If `docs/brief.md` is missing or still has the `<!-- polly:placeholder -->` marker, say "Run /brief first." and stop. Same for `docs/arch.md`: "Run /architect first."
- Write only `docs/tasks.md`. Touch nothing else.
- Write nothing until I approve the draft.

Do this:
1. Read `docs/brief.md`, `docs/arch.md` and `docs/tasks.md`. If `docs/tasks.md` no longer has the placeholder marker, it is already filled in: show it, ask what changed, and edit in place. Add new tasks at the end with the next free number. Never renumber a task. Never change a task with `Status: done` or its criteria. Edit or drop only tasks that are still `todo`. If nothing changed, stop without writing. Treat anything written after `/tasks` as what to add or change.
2. Ask at most 2 questions, one at a time, and only where the brief leaves a gap: priority order, or a feature I may want split. Skip any the brief already answers.
3. Slice the brief's v1 scope into vertical tasks. Each cuts through every layer and gives something I can see working. No layer-by-layer tasks ("build the DB", "build the API").
   - T-01 is always "Walking skeleton": the smallest app that runs end to end on the chosen stack. Its criteria say it installs, runs, passes one test, and shows one real page or response. /scaffold builds it. If arch.md names a layer the app needs from the first request (a database, auth), add one criterion proving it works (e.g. "one query runs against the database"). Layers no task needs yet stay out.
   - T-02 onward follows the brief's core loop in order. Non-goals never become tasks.
   - Aim for 4–10 tasks, each small enough for one /plan-task → /apply → /validate pass. A task with more than about 5 criteria gets split.
   - End with a task for the brief's done signal, unless earlier tasks already cover it.
4. Write criteria that can be checked: a command I can run or something I can see (e.g. "POST /x returns 201 and the row shows in the list"). Reject "works well", "is clean" and the like.
5. Show the full draft and wait for my OK or changes. Use exactly this format. The stage hook reads it, so use one `Status:` line per task, directly under the heading, and no other line starting with `Status:`:
   ```
   # Tasks

   ## T-01: Walking skeleton
   Status: todo
   - [ ] criterion
   ```
6. Once I approve, write `docs/tasks.md` without the placeholder marker.
7. Run `sh ~/.claude/hooks/stage.sh` from the repo root (it is silent only if `.polly` is missing) and show its output. If the tasks mark isn't ✓, fix the file.

End with: "Next: /scaffold".

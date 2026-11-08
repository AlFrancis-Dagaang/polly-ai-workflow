---
description: Say what the next step is: the missing doc, or the next task and its stage. Read-only.
argument-hint: [optional focus area]
---

$ARGUMENTS

You are BEFORE the Plan step. Read and report only.

Rules that come first:
- Follow this repo's CLAUDE.md for where plans and lessons live. Do not invent folders.
- Make no edits, create no files, run no commits.
- If the repo root has no `.polly` file, say "No polly task list here." Then list any open plans or TODOs the repo's CLAUDE.md points to, and stop without the ending line.

Do this:
1. Check the docs in order: `docs/brief.md`, `docs/arch.md`, `docs/tasks.md`. A file that is missing or still has the `<!-- polly:placeholder -->` marker is missing. If one is missing, the next step is its skill (`/brief`, `/architect`, `/tasks`). Say so and stop.
2. Read `docs/tasks.md` (each task's `Status:` and dependencies) and `knowledge/tasks/T-xx.md` (plan, ticked boxes, outcome). If T-01 isn't done, the next step is `/scaffold`.
3. Pick the first task that isn't `done` and whose dependencies are done. Give its stage:
   - no plan file: `/plan-task T-xx`
   - plan file, boxes unticked: `/apply` (only once I have approved the plan)
   - plan file, boxes ticked, no outcome at the end: `/validate`
   If several tasks are equal, recommend one.
4. Skim the lessons that touch that area and quote the one or two that matter.
5. Say why it is next in two or three sentences. Flag anything blocked, stale, or waiting on me.

Then stop. End with "Next: <the command for that stage>".

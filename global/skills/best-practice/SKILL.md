---
name: best-practice
description: Research current docs before adding something new to the codebase, then write a short note the plan can rely on.
argument-hint: "<what you want to add>"
disable-model-invocation: true
---

$ARGUMENTS

You are researching how to add one thing the right way, from current docs. Research first, write last. Build nothing.

Rules that come first:
- If there is no text after `/best-practice`, ask one question, "What are you adding?", and stop.
- Where it writes: if the repo root has a `.polly` file, use polly's folders. Otherwise follow this repo's CLAUDE.md for where best-practice notes live. If it names none, ask me for a path, once, and offer to add a line to CLAUDE.md saying where; add it only if I say yes. Never create folders or an `INDEX.md` on your own. Add an index line only if an index file already exists there.
- Write only one new note there and one index line (if an index exists). Touch no code, docs or config. Install nothing. Never edit an old note.
- Write nothing until I approve the draft.

Do this:
1. Read `docs/arch.md` if it exists, and the existing best-practice notes. If a note already covers the topic, show it and ask whether it is still current. If yes, stop. If no, write a new note that names the one it replaces.
2. Check the project first: the installed versions (`package.json` or the lockfile), and whether the codebase already has a way to do this (a helper, a pattern, a dependency). If it does, say so. "Use what's here, add nothing" is a valid answer.
3. Research current docs, not memory: the official docs for the tool at the version this project pins, and its changelog or migration notes if the version is recent. Use two or three sources and keep each URL. If sources disagree or the docs are thin, say so, and suggest `/spike` when only running code can settle it.
4. If there is more than one way, list at most 3, each with one line on why it would win, and recommend one. Match the project's stack (`docs/arch.md` if present, else the manifest). No new dependency if the standard library or an installed package does the job. Don't recommend anything deprecated or unmaintained.
5. Draft the note, one screen:
   ```
   # <Topic>
   Date: YYYY-MM-DD   Versions: <the pinned versions this applies to>
   ## Question
   What we want to add, in one line.
   ## Recommendation
   What to do, and why, in a few lines.
   ## How
   The steps or the minimal snippet, as the docs show it.
   ## Avoid
   Pitfalls and deprecated approaches found in the research.
   ## Sources
   - <title> — <url>
   ```
6. Show the draft and wait for my OK or changes.
7. Write `<best-practices folder>/YYYY-MM-DD-<slug>.md` (date from `date +%F`, slug of 2–4 words; if the file exists, add `-2`, `-3`, and so on, never overwrite). Add one line under "## Best practices" in the index, if one exists: `- [Title](best-practices/<file>) — the recommendation in a few words`.

End with: "Next: /plan-task (the plan will use this note)." In a polly project name the open task (`/plan-task T-xx`), or if none is open, "Next: /tasks to add one."

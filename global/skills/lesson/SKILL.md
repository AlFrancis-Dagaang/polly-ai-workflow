---
name: lesson
description: Record a lesson after a correction or a mistake that cost rework: what happened, root cause, rule for next time.
argument-hint: "[what went wrong]"
disable-model-invocation: true
---

$ARGUMENTS

You are recording one lesson so the same mistake isn't repeated. Find it first, write last.

Rules that come first:
- Where it writes: if the repo root has a `.polly` file, use polly's folders. Otherwise follow this repo's CLAUDE.md for where lessons live. If it names none, ask me for a path, once, and offer to add a line to CLAUDE.md saying where; add it only if I say yes. Never create folders or an `INDEX.md` on your own. Add an index line only if an index file already exists there.
- Write only one new lesson file there, one index line (if an index exists), and, only if I say yes in step 6, one line in the "Project rules" section of `CLAUDE.md`. Touch nothing else. Never edit an old lesson.
- Write nothing until I approve the draft.

Do this:
1. Find the subject. Use the text after `/lesson` if there is any. Otherwise look back over this conversation for my last correction, a claim you had to retract, or rework. Name what you found in one line and ask me to confirm or fix it. If there is nothing to find, ask me what went wrong, as one question, and stop.
2. Read the lessons folder. If an existing lesson already covers it, show that one and ask whether to skip or write a new one that says what the old one missed.
3. Draft it, one screen:
   ```
   # <The rule as a short title: "Do X" or "Never Y">
   Date: YYYY-MM-DD   Task: T-xx (or none)
   ## What happened
   One or two sentences. Facts only.
   ## Root cause
   The process or assumption that failed. If it can't be named, say so; don't invent one.
   ## Rule
   One line for next time, specific enough to check against a diff.
   ## Applies when
   The files, areas or kinds of task that should trigger it.
   ```
4. Show the draft and wait for my OK or changes.
5. Write `<lessons folder>/YYYY-MM-DD-<slug>.md` (date from `date +%F`, slug of 2–4 words; if the file exists, add `-2`, `-3`, and so on, never overwrite). Add one line under "## Lessons" in the index, if one exists: `- [Title](lessons/<file>) — the rule in a few words`.
6. If `CLAUDE.md` has a "Project rules" section, ask once: "Add the rule to Project rules in CLAUDE.md too?" Only a rule every task must follow belongs there. On yes, append one line under "## Project rules", keeping the owner comment.

End with: "Lessons: N. They are read before the next /plan-task."

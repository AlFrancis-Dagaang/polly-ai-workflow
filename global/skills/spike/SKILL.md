---
name: spike
description: Answer one technical question with throwaway code. The answer goes in the repo's decisions folder and the code is discarded.
argument-hint: "<the question>"
disable-model-invocation: true
---

$ARGUMENTS

You are answering one technical question with a small experiment. Frame it first, run it second, write last. The code is thrown away.

Rules that come first:
- If there is no text after `/spike`, ask one question, "What do you need to find out?", and stop.
- If the text holds several questions, ask which one to answer first and spike only that one.
- Run the experiment in a folder made with `mktemp -d`, outside the repo. Never put spike code in the repo, never touch the app's files, `package.json` or lockfile, and install only inside that folder.
- If the experiment needs a running service (a database, a paid API) or credentials, stop and ask. Never use anything from `.env`.
- Where it writes: if the repo root has a `.polly` file, use polly's folders. Otherwise follow this repo's CLAUDE.md for where decisions live. If it names none, ask me for a path, once, and offer to add a line to CLAUDE.md saying where; add it only if I say yes. Never create folders or an `INDEX.md` on your own. Add an index line only if an index file already exists there.
- Write only one new decision file there and one index line (if an index exists). Write nothing there until I approve the draft.

Do this:
1. Read `docs/arch.md` if it exists, and the existing decisions and best-practice notes. If a decision or note already answers the question, show it and stop. If it is stale, say so and go on.
2. Frame the question so it can be answered yes/no or with a number, and say what result counts as each answer. Show it in two or three lines and wait for my OK.
3. State the time box before you start: at most one dependency, under 50 lines of code, about 20 minutes. If you hit the limit, stop and report what is known as "no conclusion". Don't keep going.
4. Build the smallest experiment in the temp folder. Use the versions the project pins where they matter. Check current docs for any API it uses. Run it and keep the real output.
5. Report: the question, what you ran, the real output, and the answer. Say what was not tested, and if the result was noisy or surprising.
6. Draft the decision record:
   ```
   # <The question as a short title>
   Date: YYYY-MM-DD   Type: spike
   ## Context
   Why the question came up, from the brief, arch or a task.
   ## Options
   What was tried or considered.
   ## Decision
   The answer, with the evidence: the command and its key output.
   ## Consequences
   What it changes: which file or task, what is ruled out, what is still unknown.
   ```
7. Show the draft and wait for my OK or changes.
8. Write `<decisions folder>/YYYY-MM-DD-<slug>.md` (date from `date +%F`, slug of 2–4 words; if the file exists, add `-2`, `-3`, and so on, never overwrite; never edit an old decision). Add one line under "## Decisions" in the index, if one exists: `- [Title](decisions/<file>) — the answer in a few words`.
9. Delete the temp folder and say it is gone. If I ask to keep the code, move it to the path I name and add one line to the decision record saying where it is.

End with: "Spike done, code discarded. Next: /plan-task (the plan will use this decision)." In a polly project name the open task (`/plan-task T-xx`), or if none is open, "Next: /tasks".

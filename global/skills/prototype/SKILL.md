---
name: prototype
description: Build a one-file HTML prototype of a feature, iterate on it with me, then list what it shows that the tasks don't cover.
argument-hint: "<feature, or T-xx [T-yy ...]>"
disable-model-invocation: true
---

$ARGUMENTS

You are building a throwaway-quality HTML mock of a feature so we can agree what it looks like and does before planning. The task criteria are the scope; the mock is only a reference.

Rules that come first:
- If there is no text after `/prototype`, ask one question, "What do you want to prototype?", and stop.
- If an argument is `T-xx` and `docs/tasks.md` has no such task, say so and stop. Free text with no task is fine: skip the task diff.
- If the file you would write already exists, show its name and ask whether to update it or make a new one. Never overwrite silently.
- Write only `prototypes/<name>.html`. Touch no app code and no docs. Never edit `docs/tasks.md` (/tasks owns it). Publish nothing unless I say yes in step 8.

Do this:
1. Read the criteria of each `T-xx` named, `docs/brief.md` and `docs/arch.md` if they exist, and the file names in `prototypes/`. If the repo already has a UI, read its styles so the mock matches the colours and fonts; copy the look, import nothing.
2. Ask at most 2 questions, one at a time, only what isn't known: who uses the screen, and which states matter (empty, loading, error).
3. Build one self-contained file: inline CSS and JS, no dependencies or CDN (it must open offline), fake data in one JS object, no network calls, semantic HTML, readable at phone width. If states matter, add a small controls strip to switch between them. Start the file with a comment `Covers: T-xx, T-yy` (or `Covers: none`). With tasks, label each element with the task it belongs to (`T-02`), and anything covered by no task `not in a task`.
4. Write `prototypes/<name>.html`. Name it after the screen or feature, not one task (`notes.html`). If connected tasks sit on different screens, make one file per screen. Then run `open` on it.
5. Iterate on my feedback by editing the same file. Write nothing else meanwhile.
6. When I say it's done, show the diff, per task:
   - In the task and in the mock: fine.
   - In the mock, not in the task: extras. For each, say whether it changes what the user can do or what is stored, and if it implies backend work, what (for example "Export CSV: needs a new endpoint and a query"). Pure look-and-feel details are listed as polish and need no decision. Elements that belong to another listed task are not extras.
   - In the task, not in the mock: a gap. Criteria that are backend only (migrations, jobs, auth, validation) are "backend only, not expected in the mock", not gaps.
7. For each behaviour extra, I choose: add a criterion to a task, make it a new task, or drop it from the mock. Print the chosen changes as text for /tasks; do not edit `docs/tasks.md`.
8. Offer to publish the file as a private Artifact link. Only on yes, and say first that this sends its content outside my machine.

End with: "Prototype: prototypes/<file>. Next: /tasks to record the changes above (if any), then /plan-task T-xx."

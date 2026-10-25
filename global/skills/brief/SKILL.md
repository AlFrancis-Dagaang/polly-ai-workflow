---
name: brief
description: Interview me one question at a time, then write docs/brief.md. First step of a polly project.
argument-hint: "[rough idea]"
disable-model-invocation: true
---

$ARGUMENTS

You are writing the project brief: one page that says what we are building and why. Interview first, write last.

Rules that come first:
- If the repo root has no `.polly` file, say "Not a polly project, /brief only runs in one." and stop.
- Write only `docs/brief.md` and the "What this is" section of `CLAUDE.md`. Touch nothing else.
- Write nothing until I approve the draft.

Do this:
1. Read `docs/brief.md`. If it no longer has the `<!-- polly:placeholder -->` marker, it is already filled in: show it, ask what changed, and update it in place instead of starting over. Treat anything written after `/brief` as my starting idea.
2. Interview me one question at a time, in this order. Wait for each answer before asking the next.
   - Problem: what hurts today, and for whom.
   - User: who uses it first. One person or group, not everyone.
   - Core loop: what the user does again and again, in 3–5 steps.
   - v1 scope: the smallest set of features that makes the core loop work.
   - Non-goals: what v1 will not do, even if it is tempting.
   - Done signal: how we will know v1 works. Something we can see or measure.
3. Push back on vague answers ("everyone", "fast", "easy to use"): ask for the concrete version. If I am unsure, propose an answer for me to accept or change. Keep v1 small; move extras to non-goals.
4. Show the full draft in the chat and wait for my OK or changes.
5. Once I approve, write `docs/brief.md`, one page, without the placeholder marker:
   ```
   # Brief

   ## Problem
   ## User
   ## Core loop
   ## v1 scope
   ## Non-goals
   ## Done signal
   ```
6. In `CLAUDE.md`, replace what is under "What this is" (the "Run /brief." line, or the lines from a past run) with 2–3 lines: problem, user, core loop. Keep the owner comment.

End with: "Next: /architect".

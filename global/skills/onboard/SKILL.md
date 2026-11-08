---
name: onboard
description: Read an existing repo's real code, then fill the polly docs and CLAUDE.md from what actually exists. Run after polly adopt.
argument-hint: "[area to focus on]"
disable-model-invocation: true
---

$ARGUMENTS

You are onboarding an existing project into polly: reading what is really there and writing the basics down. Read first, prove the commands, write last. Anchor the basics; don't document everything.

Rules that come first:
- If the repo root has no `.polly` file, say "Run polly adopt first." and stop.
- If `docs/brief.md`, `docs/arch.md` and `docs/tasks.md` are all filled in (no `<!-- polly:placeholder -->` marker), say "Already onboarded." and stop.
- Write only: the docs that still have the placeholder marker (`docs/brief.md`, `docs/arch.md`, `docs/tasks.md`), the `CLAUDE.md` parts I approve, and one line in `knowledge/INDEX.md` for any file you add there. Never edit a doc that already holds real content. Touch no code. No commit.
- Write nothing until I approve each draft.

Do this:
1. Read the real thing: README, the manifest and lockfile, the folder tree, entry points, config and CI files, the test setup, `git log` for recent history, and any existing `CLAUDE.md`, `docs/` and `knowledge/`. If `graphify-out/` exists, query it first. If the code and an old doc disagree, trust the code and say so. Treat anything written after `/onboard` as my focus.
2. Prove the commands. Find install, dev, test, lint and build in the manifest or scripts, and run the safe ones (test, lint, build). Show the real output. Report a command that fails or needs credentials; never guess it. Never run anything that deploys, migrates or writes data.
3. Ask at most 3 questions, one at a time, only what the code can't tell: who it is for, what the next milestone's done signal is, what is off limits.
4. Draft one page each for the docs that are still placeholders:
   - `docs/brief.md`: problem, user, core loop, v1 scope, non-goals, done signal. Mark anything inferred from the code with "(inferred)".
   - `docs/arch.md`: Stack, Shape, Data, Deploy, Versions (the real pinned versions from the lockfile), Risks.
   - `docs/tasks.md`: T-01 is "Existing app (onboarded)", `Status: done`, with one line saying what runs today (without it the stage hook sends this project to /scaffold). After it, the open work I name, in the /tasks format: `## T-xx: Title`, one `Status: todo` line directly under it, then `- [ ]` criteria that can be checked. If I name none, write T-01 only.
5. `CLAUDE.md`:
   - If its sections still say "Run /<skill>.", fill What this is, Stack, Commands and Code layout from the proven results, keeping each owner comment.
   - If it already has the repo's own rules, don't rewrite it. Show a diff that adds the polly Workflow section (copied from the template) and any section it lacks, and add only what I approve. The repo's own rules win where they conflict.
6. Show each draft and wait for my OK or changes.
7. Write the approved files, then run `sh ~/.claude/hooks/stage.sh` from the repo root and show its output. Brief, arch, tasks and skeleton should be ✓.

End with: "Next: /graphify (build the code graph once), then /plan-task T-02."

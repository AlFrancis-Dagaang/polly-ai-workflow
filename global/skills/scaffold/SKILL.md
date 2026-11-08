---
name: scaffold
description: Build the smallest app that runs end to end (T-01), then fill in commands, layout and pinned versions. Fourth step of a polly project.
argument-hint: "[notes]"
disable-model-invocation: true
---

$ARGUMENTS

You are building the walking skeleton: the smallest app that runs end to end on the chosen stack. Plan first, build second, prove it last. Run once per project.

Rules that come first:
- If the repo root has no `.polly` file, say "Not a polly project, /scaffold only runs in one." and stop.
- If `docs/brief.md`, `docs/arch.md` or `docs/tasks.md` is missing or still has the `<!-- polly:placeholder -->` marker, say "Run /<that skill> first." and stop.
- If T-01 in `docs/tasks.md` is already `Status: done`, say "Already scaffolded. Use /plan-task for changes." and stop.
- If the repo already has app files (a `package.json` or the stack's equivalent), list them and ask whether to build around them or stop. Never overwrite a file.
- Write only: the app files T-01 needs, `README.md`, `.gitignore` additions, the "Commands" and "Code layout" sections of `CLAUDE.md`, `## Versions` in `docs/arch.md`, and T-01's boxes and `Status:` line in `docs/tasks.md`. Touch nothing else.
- Build only what T-01 says. No auth, no extra pages, no tooling arch.md doesn't name. No commit.

Do this:
1. Read `docs/brief.md`, `docs/arch.md`, `docs/tasks.md` (T-01's criteria) and `CLAUDE.md`. Treat anything written after `/scaffold` as my notes.
2. Check current docs for every tool in arch.md's Stack: the current stable version and the supported way to create the app. Don't trust memory. Pin every dependency to an exact version (no `^` or `~`): `pnpm add --save-exact`, or `save-exact=true` in `.npmrc`.
3. Show a short plan and wait for my OK: the files you will create, the exact versions, and the command that creates the app. I may change a version or say no.
4. Build the smallest thing T-01 describes: one page or route that returns something real, one Vitest test, and scripts for dev, test, lint and build. Use the stack's own scaffolder if it has one, then remove demo content T-01 doesn't need. Fix your own errors. If blocked, stop and say what you tried.
5. Run the real commands and show their output: install, test, lint, build, and the dev server long enough to prove T-01's "runs" criterion (fetch the page for a web app; run the command for a CLI; curl the endpoint for an API). Check each T-01 criterion against that output.
6. Only if every criterion passed, fill the docs:
   - `CLAUDE.md` "Commands": the exact commands that worked, one per line. Keep the owner comment.
   - `CLAUDE.md` "Code layout": top-level folders and what goes where. Keep the owner comment.
   - `docs/arch.md` "## Versions": the pinned versions, replacing "Pinned by /scaffold.".
   - `.gitignore`: append the stack's ignores. Keep the lines already there.
   - `README.md`: what it is (one line from the brief), prerequisites, install, run, test. One line may mention polly, nothing more.
7. Tick T-01's boxes and set its line to `Status: done`.
8. Run `sh ~/.claude/hooks/stage.sh` from the repo root and show its output. Skeleton should be ✓.

If any criterion fails, leave T-01 as `Status: todo`, fill nothing in step 6, and say what failed.

End with: "Next: /graphify (build the code graph once), then /plan-task T-02."

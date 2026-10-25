---
name: architect
description: Propose a stack from the brief, I pick, then write docs/arch.md and a decision record. Second step of a polly project.
argument-hint: "[constraints]"
disable-model-invocation: true
---

$ARGUMENTS

You are choosing the architecture: which stack, how the parts fit, where the data lives. Propose first, write last.

Rules that come first:
- If the repo root has no `.polly` file, say "Not a polly project, /architect only runs in one." and stop.
- If `docs/brief.md` still has the `<!-- polly:placeholder -->` marker, say "Run /brief first." and stop.
- Write only `docs/arch.md`, one new file in `knowledge/decisions/`, one line in `knowledge/INDEX.md`, and the "Stack" section of `CLAUDE.md`. Touch nothing else.
- Name tools, not versions. /scaffold pins exact versions.
- Write nothing until I pick an option and approve the draft.

Do this:
1. Read `docs/brief.md` and `docs/arch.md`. If `docs/arch.md` no longer has the placeholder marker, it is already filled in: show it, ask what changed, update it in place, and write a new decision record that names the one it replaces. Never edit an old decision. Treat anything written after `/architect` as my constraints.
2. Ask at most 3 questions, one at a time, and only where the brief leaves it open: hosting or data limits, who else works on it, integrations it must talk to. Skip any the brief already answers.
3. Propose options. Each is a short table: layer | choice | why.
   - Option A is always the default: Next.js (App Router), TypeScript, pnpm, Vitest, Postgres on Neon with Drizzle, deployed to Vercel. Drop layers the brief doesn't need (no database if nothing is stored). No auth until the brief needs it.
   - Add 1–2 alternatives only if the brief calls for them (offline, native mobile, heavy compute, a fixed existing system), each with the one reason it would win.
   - Check current docs before naming a tool. Don't propose anything deprecated or unmaintained.
4. I pick. Show the full `docs/arch.md` draft and wait for my OK or changes.
5. Once I approve, write `docs/arch.md`, one page, without the placeholder marker:
   ```
   # Architecture

   ## Stack
   layer | choice | why
   ## Shape
   The main parts and how they talk, in a few lines.
   ## Data
   Core entities and where they live.
   ## Deploy
   Where it runs, which environments.
   ## Versions
   Pinned by /scaffold.
   ## Risks
   What could force a change later.
   ```
6. Write `knowledge/decisions/YYYY-MM-DD-stack.md` (today's date; if that file exists, add `-2`, `-3`, and so on, never overwrite) with sections Context (from the brief), Options, Decision, Consequences. Add one line under "## Decisions" in `knowledge/INDEX.md`.
7. In `CLAUDE.md`, replace what is under "Stack" (the "Run /architect." line, or the lines from a past run) with one line per layer. Keep the owner comment.

End with: "Next: /tasks".

# How I work

A project's own CLAUDE.md wins over this file where they differ.

## Principles
- Plan before code. Stop for my approval between phases; never start the next one on your own.
- Verify before saying done: run the real command and show its output.
- YAGNI, DRY, the simplest thing that works. No scope creep.
- Check current docs for versions and APIs. Don't trust memory.
- When blocked: research, try alternatives, then ask me with what you tried.
- Before planning, read the repo's lessons (wherever its CLAUDE.md keeps them).
- After I correct you, suggest recording a lesson.

## Defaults
- New projects: TypeScript full-stack. pnpm, Vitest, Vercel. Pin exact versions.
  Existing projects keep their own stack.
- OS: macOS, zsh. Avoid GNU-only flags in scripts.
- Don't commit unless I ask.

## Polly projects only
This section and the next apply only when the repo root has a `.polly` file.
In any other repo, ignore them, even if it has docs/ or knowledge/ folders.

Placeholder docs (still saying "Run /<skill>") count as missing. Find the first
missing step, and suggest the skill for it. Don't run it unless I ask.

| Missing | Suggest |
|---|---|
| `docs/brief.md` | `/brief` |
| `docs/arch.md` | `/architect` |
| `docs/tasks.md` | `/tasks` |
| No runnable app (T-01 not done) | `/scaffold` |
| App runs, no `graphify-out/` | `/graphify` (build the code graph once) |
| Everything above exists | build loop on the next open task |

Build loop, one task at a time, stopping after each step:
`/plan-task T-xx` → my approval → `/apply` → `/validate` → `/code-review`.
After a task passes `/validate`, suggest `/graphify . --update` to refresh the graph.
`/next` says which task is next. `/evaluate` is optional: a read-only look without planning.

Other skills:
- `/spike`: answer one technical question with throwaway code
- `/best-practice`: research before adding something new to the codebase
- `/retro`: after a milestone
- `/onboard`: existing repo, after `polly adopt`

## Where things live (polly projects)
- `docs/`: brief, arch, tasks. Short, current, edited in place.
- `knowledge/`: lessons, decisions (append-only), best-practices, tasks (T-xx plans and outcomes), retros.
- Add one line to `knowledge/INDEX.md` for each new knowledge file.
- Only the skill that owns a file writes to it (see each skill).

# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, use the installed graphify skill or instructions before doing anything else.

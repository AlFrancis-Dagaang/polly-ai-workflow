# How I work

## Principles
- Plan before code. Stop for my approval between phases; never start the next one on your own.
- Verify before saying done: run the real command and show its output.
- YAGNI, DRY, the simplest thing that works. No scope creep.
- Check current docs for versions and APIs. Don't trust memory.
- When blocked: research, try alternatives, then ask me with what you tried.
- Read `knowledge/lessons/` before planning a task.
- After I correct you, suggest `/lesson`.

## Defaults
- Stack: TypeScript full-stack. pnpm, Vitest, Vercel. Pin exact versions.
- OS: macOS, zsh. Avoid GNU-only flags in scripts.
- Don't commit unless I ask.

## Project lifecycle
Projects made with `polly` share one layout. Placeholder docs (still saying
"Run /<skill>") count as missing. Find the first missing step, and suggest the
skill for it. Don't run it unless I ask.

| Missing | Suggest |
|---|---|
| `docs/brief.md` | `/brief` |
| `docs/arch.md` | `/architect` |
| `docs/tasks.md` | `/tasks` |
| No runnable app (T-01 not done) | `/scaffold` |
| Everything above exists | build loop on the next open task |

Build loop, one task at a time, stopping after each step:
`/plan-task T-xx` → my approval → `/apply` → `/validate` → `/code-review`.
`/next` says which task is next. `/evaluate` is optional: a read-only look without planning.

Other skills:
- `/spike`: answer one technical question with throwaway code
- `/best-practice`: research before adding something new to the codebase
- `/retro`: after a milestone
- `/onboard`: existing repo, after `polly adopt`

## Where things live
- `docs/`: brief, arch, tasks. Short, current, edited in place.
- `knowledge/`: lessons, decisions (append-only), best-practices, tasks (T-xx plans and outcomes), retros.
- Add one line to `knowledge/INDEX.md` for each new knowledge file.
- Only the skill that owns a file writes to it (see each skill).

# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, use the installed graphify skill or instructions before doing anything else.

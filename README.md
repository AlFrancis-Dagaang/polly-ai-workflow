# polly-ai-workflow

My Claude Code workflow for starting and building projects without a PRD, BRD
or architecture doc. `polly` creates the structure; Claude fills it in as we
work: interview, lightweight docs, scaffold, then build task by task with a
stop for my review after each step.

Design and decisions: [PLAN.md](PLAN.md). ⏳ = not built yet.

## Install (once per machine)
```sh
git clone <this repo> ~/polly-ai-workflow
cd ~/polly-ai-workflow && ./install.sh
```
`install.sh` symlinks `global/` into `~/.claude/` and `bin/polly` into
`~/.local/bin/`. Anything it replaces is backed up to
`~/.claude/backups/polly-<time>/`. Edits to files in this repo go live at once.
Rerun it after adding a new skill or command, or after moving this folder.

## New project
| # | Run | What happens |
|---|---|---|
| 1 | `cd ~/Developer && polly my-app && cd my-app && claude` | Creates the structure, `.polly` marker, git and first commit. Claude sees `Next: /brief` |
| 2 | `/brief` | Interviews me one question at a time → `docs/brief.md` |
| 3 | `/architect` | Proposes TS full-stack (+ alternatives when the brief needs them), I pick → `docs/arch.md` + decision record |
| 4 | `/tasks` ⏳ | Vertical slices with acceptance criteria → `docs/tasks.md`. T-01 is the walking skeleton |
| 5 | `/scaffold` ⏳ | Smallest app that runs end to end. Fills CLAUDE.md commands and layout, writes README.md |
| 6 | `/graphify` | Builds the code graph in `graphify-out/` (gitignored). Claude queries it before searching code |

## Build loop (repeat for each task)
| # | Run | What happens |
|---|---|---|
| 7 | `/next` | Optional: which task is next, and why |
| 8 | `/plan-task T-02` | Evaluates, then writes a plan to `knowledge/tasks/T-02.md`. **Stops for approval** |
| 9 | *approve* | Or ask for changes and re-plan |
| 10 | `/apply` | Implements exactly the plan, nothing extra |
| 11 | `/validate` | Runs checks, checks acceptance criteria and lessons, sets `Status: done` |
| 12 | `/code-review` | Built-in bug hunt on the diff |
| 13 | `/graphify . --update` | Refresh the graph with what changed |
| 14 | *commit* | Claude never commits unless asked |

Then back to 7. `/evaluate` is available for a read-only look without planning.

## When needed
| When | Run |
|---|---|
| I corrected Claude, or a mistake cost rework | `/lesson` ⏳ → `knowledge/lessons/` |
| A milestone is done | `/retro` ⏳ |
| Adding something new to the codebase | `/best-practice` ⏳, before `/plan-task` |
| A technical question I can't answer yet | `/spike` ⏳ |
| Bringing an existing repo into polly | `polly adopt` ⏳ → `/onboard` ⏳ |

## Existing (non-polly) repos
The EPAV commands (`/next`, `/evaluate`, `/plan-task`, `/apply`, `/validate`)
work in any repo: they follow that repo's own CLAUDE.md for where plans,
lessons and checks live. Polly-specific behaviour (stage line, lifecycle
suggestions) applies only where a `.polly` file is at the repo root.

## Layout
```
bin/polly          new project (polly <name> [dir]), polly adopt ⏳
global/CLAUDE.md   loaded in every session: principles, defaults, lifecycle
global/commands/   EPAV build loop
global/skills/     one folder per skill
global/hooks/      stage.sh: SessionStart stage line for polly projects
template/          copied into each new project
install.sh         links all of the above into ~/.claude/
```

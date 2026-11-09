# Polly guide: every skill and command

Type these yourself in a Claude Code session. Claude does not run them on its own
(except `/graphify`, which also triggers on codebase questions).
Flow and install: [README.md](README.md). Design: [PLAN.md](PLAN.md).

**Where:** "polly" = repo has a `.polly` file. "any repo" = works anywhere.

## The path, in order

```
polly my-app → /brief → /architect → /tasks → /scaffold → /graphify
   then per task:  /plan-task → approve → /apply → /validate
```

If you forget where you are, run `/next`.

## Terminal command

| Command | Use | Example |
|---|---|---|
| `polly <name> [dir]` | Create a new polly project (structure, `.polly`, git, first commit) | `cd ~/Developer && polly my-app && cd my-app && claude` |
| `polly adopt [dir]` | Add the missing polly files to an existing git repo. Never overwrites or commits | `polly adopt .` then `/onboard` |

## Project setup skills (polly only)

| Skill | When | What it does | Writes |
|---|---|---|---|
| `/brief` | First, in a new project | Interviews you one question at a time | `docs/brief.md` |
| `/architect` | After the brief | Proposes a stack (default TS full-stack) plus alternatives if needed. You pick | `docs/arch.md`, a decision record |
| `/tasks` | After arch | Splits work into vertical slices with acceptance criteria. T-01 is the walking skeleton | `docs/tasks.md` |
| `/scaffold` | After tasks | Builds the smallest app that runs end to end | App, CLAUDE.md commands and layout, README.md |
| `/graphify` | Once the app runs | Builds a code graph Claude queries before searching code. Refresh with `/graphify . --update` after a task | `graphify-out/` (gitignored) |
| `/onboard` | After `polly adopt` | Fills the docs from the real code | `docs/`, CLAUDE.md |

## Build loop commands (any repo)

They follow that repo's own CLAUDE.md for where plans and lessons go.

| Command | When | What it does |
|---|---|---|
| `/next` | Lost, or starting a session | Read-only. Names the missing doc or the next task and its stage, and ends with the command to run |
| `/evaluate T-02` | You want a look before committing to a plan | Read-only. Affected files, risks, open questions. Then stops |
| `/plan-task T-02` | Start of a task | Evaluates, then writes a checkable plan (a check per acceptance criterion). **Stops for your approval** |
| `/apply` | After you approve the plan | Implements exactly the plan, nothing extra. No commits |
| `/validate` | After apply | Runs the repo's checks, checks acceptance criteria and lessons, sorts findings. In polly, when all pass it sets `Status: done` and writes `## Outcome` in the plan |

Rule: one step at a time. Each one stops and waits for you.

## Notes and thinking skills (any repo unless noted)

| Skill | When | What it does |
|---|---|---|
| `/lesson` | After you corrected Claude, or a mistake cost rework | Records the lesson where the repo's CLAUDE.md says (polly: `knowledge/lessons/`) |
| `/best-practice` | Before adding something new to the codebase (before `/plan-task`) | Records or looks up the practice for it first |
| `/spike` | A technical question you can't answer yet | Answers it with throwaway code, then reports |
| `/prototype T-04` | Task has a screen, before `/plan-task` | One-file HTML mock in `prototypes/`. Criteria stay the scope; the mock is a reference only |
| `/retro` | A milestone is done (polly only) | Reads task outcomes in `knowledge/tasks/` and writes a retro |

Outside polly, `/lesson`, `/best-practice` and `/spike` ask once where notes go if CLAUDE.md names no place. `/retro` and `/onboard` are polly-only.

## Git skills (any repo)

| Skill | What it does |
|---|---|
| `/commit` | Reviews changes, flags secrets, drafts a message in the repo's style, shows it and waits for OK, stages files by name, commits. Never pushes |
| `/create-pr` | Drafts the PR from the commits, shows the `gh` account and repo, pushes and opens it only after OK. Never merges. Needs `gh` (`brew install gh`, `gh auth login` per profile) |

## Session skill

| Skill | What it does |
|---|---|
| `/next-session` | Session getting long? Checks git, then prints a short prompt (done, decisions, state, bugs, what's left). Run `/clear`, paste it. Writes no file. For a stuck debug session use `claude-mem:handoff` instead |

## Optional

| Skill | Use |
|---|---|
| `/code-review` | Built-in bug hunt on the diff. Only when you ask for it |

## Typical session

```
/next                  → says: next is T-02, stage plan
/plan-task T-02        → plan written, stops
(you read it, say "approved")
/apply                 → code written
/validate              → checks pass, T-02 marked done
/graphify . --update
/commit                → you OK the message
/create-pr             → you OK the push
/next-session          → paste into a fresh session after /clear
```

After a correction, run `/lesson`. Screen involved? `/prototype T-xx` before `/plan-task`.

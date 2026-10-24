# My Claude Code Workflow — Final Plan

## Goal
A personal workflow for starting projects without a PRD, BRD, or architecture doc.
A new project starts with the structure already in place. Claude fills it in as we
work: interview me, write lightweight docs, scaffold, then build task by task.

Inspired by Nexus EPAV (Evaluate → Plan → Apply → Validate, with review stops) and
the daVinci boilerplate (knowledge base, lessons loop, research before new things).

## Decisions
| Question | Decision |
|---|---|
| OS | macOS (zsh, BSD tools). Scripts are POSIX sh / zsh-safe and avoid GNU-only flags. |
| Default stack | TypeScript full-stack. /architect proposes this first, plus 1–2 alternatives when the brief calls for them. |
| Tooling | pnpm, Vitest (Playwright only when a task needs e2e), deploy to Vercel. /scaffold pins exact versions. |
| Evaluate vs plan | Merged into **/plan-task**: evaluate, stop if a question blocks, else plan, then stop for approval. `/evaluate` stays optional. Applies everywhere, work repos too. |
| Build loop | **My existing EPAV commands** (`apply`, `evaluate`, `next`, `plan-task`, `validate`), moved into `global/commands/`. Not rewritten as skills. Polly projects wire them up through the template CLAUDE.md "Workflow" section. |
| Code review | **Built-in `/code-review`**, no custom agent. `/validate` checks acceptance criteria and lessons/project rules; /code-review hunts bugs. Revisit in /retro if reviews miss repo-specific issues. |
| Stage hook | **SessionStart only.** It prints a short stage summary once per session. No per-prompt injection. |
| Domain-features registry | **Skipped.** arch.md (code layout) and knowledge/INDEX.md cover it. /retro can add it later if needed. |

## Repo structure
```
polly-ai-workflow/
├── PLAN.md
├── README.md                 — what this is, install, polly usage
├── install.sh                — link global/ into ~/.claude/ (see Install rules)
├── bin/
│   └── polly                 — one CLI, two subcommands:
│                                 polly <name> [dir]  — copy template/, git init, first commit
│                                 polly adopt [dir]   — add missing template files to an existing repo, never overwrite
├── global/
│   ├── CLAUDE.md             — habits + lifecycle guide (< ~60 lines)
│   ├── hooks/
│   │   └── stage.sh          — SessionStart: report project stage + suggest next skill
│   ├── commands/             — EPAV build loop (repo-agnostic; follows each repo's CLAUDE.md)
│   │   ├── next.md           — which task is next → /plan-task
│   │   ├── evaluate.md       — optional read-only look
│   │   ├── plan-task.md      — evaluate + plan, stop for approval
│   │   ├── apply.md          — implement exactly the plan
│   │   └── validate.md       — checks, criteria, lessons/rules → /code-review
│   └── skills/
│       ├── brief/SKILL.md
│       ├── architect/SKILL.md
│       ├── tasks/SKILL.md
│       ├── spike/SKILL.md
│       ├── scaffold/SKILL.md
│       ├── lesson/SKILL.md
│       ├── retro/SKILL.md
│       ├── best-practice/SKILL.md
│       └── onboard/SKILL.md
└── template/
    ├── CLAUDE.md             — empty sections tagged with their owning skill + fixed Workflow section
    ├── .gitignore            — .DS_Store, .env* (stack ignores come from /scaffold)
    ├── .polly                — marker: this repo is a polly project (hook + lifecycle apply)
    ├── docs/
    │   ├── brief.md          — placeholder: "Run /brief"
    │   ├── arch.md           — placeholder: "Run /architect"
    │   └── tasks.md          — placeholder: "Run /tasks"
    └── knowledge/
        ├── INDEX.md
        ├── lessons/.gitkeep
        ├── decisions/.gitkeep
        ├── best-practices/.gitkeep
        ├── tasks/.gitkeep
        └── retros/.gitkeep
```

## Lifecycle: 9 new skills + 5 existing EPAV commands
**SHAPE**
- `/brief` asks me one question at a time and writes docs/brief.md: problem, user, core loop, v1 scope, non-goals, done signal. One page.
- `/architect` defaults to TS full-stack (pnpm/Vitest/Vercel) plus 1–2 alternatives. I pick, and it writes docs/arch.md plus a decision record.
- `/tasks` writes vertical slices with checkable acceptance criteria to docs/tasks.md. T-01 is always the walking skeleton.
- `/spike` runs a throwaway experiment to answer one technical question. The result goes in knowledge/decisions/ and the code is discarded.

**SKELETON**
- `/scaffold` builds the smallest app that runs end to end (T-01). It fills the CLAUDE.md commands and code layout, and pins exact versions in arch.md. Run once per project.
  After it, `/graphify` builds the code graph (`graphify-out/`, gitignored); `/graphify . --update` after each validated task.
  It also writes `README.md` for humans who clone the repo: what it is, prerequisites, install, run, test. Nothing about polly beyond one line.

**BUILD LOOP** (existing EPAV commands, one task at a time, stop after each step)
- `/next` (optional): which task is next.
- `/plan-task T-xx`: evaluate (affected files, risks, open questions). It stops if a question blocks; otherwise it writes a file-by-file plan in knowledge/tasks/T-xx.md. **Stop.** No code until I approve. `/evaluate` is available for a look without planning.
- `/apply`: implement exactly the approved plan, with no scope creep. If the plan turns out wrong, stop and say so instead of improvising.
- `/validate`: run the repo's checks and show the real output, check each acceptance criterion and the lessons/project rules, sort findings (blocker / fix now / backlog), say whether a lesson is owed, and set `Status: done` when everything passes.
- `/code-review` (built in): bug hunt on the diff.

**LEARN**
- `/lesson` runs after a correction: what happened, root cause, rule for next time. Written to knowledge/lessons/.
- `/retro` runs after a milestone: review, update the brief and backlog, and suggest improvements to this workflow repo.
- `/best-practice` researches current docs before something new enters the codebase. Written to knowledge/best-practices/.

**EXISTING PROJECTS**
- `/onboard` reads the real code and fills the docs and knowledge from what actually exists. Anchor the basics, don't document everything at once. Use it after `polly adopt`.

## Who owns which file
| File | Written by |
|---|---|
| docs/brief.md | /brief, /retro (updates) |
| docs/arch.md | /architect, /scaffold (versions), /onboard |
| docs/tasks.md | /tasks, /validate (status), /retro (backlog) |
| CLAUDE.md sections | /brief (what), /architect (stack), /scaffold (commands, layout), /onboard. Workflow section: fixed by the template. |
| knowledge/tasks/ | /plan-task (plan), /apply (ticks), /validate (outcome) |
| knowledge/lessons/ | /lesson |
| knowledge/decisions/ | /architect, /spike (append-only) |
| knowledge/best-practices/ | /best-practice |
| knowledge/retros/ | /validate (follow-ups), /retro |
| knowledge/INDEX.md | any skill that adds a knowledge file appends one line |

## SessionStart hook (global/hooks/stage.sh)
- Runs once per session. It is silent unless the repo root has a `.polly` marker file (made by `polly` / `polly adopt`). Folder names alone aren't enough: older projects (l1a-agent, leavetrack) also have docs/ + knowledge/.
- Output stays under 10 lines, for example:
  `Stage: brief ✓ · arch ✗ · tasks ✗ · scaffold ✗ → next: /architect`
  `In progress: T-03 (planned, not applied)` · `Lessons: 4 (read knowledge/lessons/ before planning)`
- Reads task status from docs/tasks.md, which must use this format (/tasks writes it, /validate flips status):
  ```
  ## T-01: Walking skeleton
  Status: todo        <- or: done
  - [ ] acceptance criterion
  ```
  A task with `knowledge/tasks/T-xx.md` but not done is "in progress".
- A doc counts as missing if it is absent or still contains `<!-- polly:placeholder -->` (skills remove the marker when they fill the doc).

## Install rules (install.sh)
- **Backups:** anything replaced is moved to `~/.claude/backups/polly-<time>/` (same relative path) before linking.
- **Global CLAUDE.md:** the graphify section is carried into global/CLAUDE.md. Back up the old file, then symlink.
- **Commands:** `global/commands/*.md` are owned by this repo. Back up the existing file in `~/.claude/commands/`, then symlink.
- **Skills:** symlink each `global/skills/<name>` on its own, not the whole skills/ folder, so `graphify/` and `synced/` stay where they are. An existing skill of the same name is skipped, never replaced.
- **Hooks:** symlink `global/hooks/stage.sh`. Merge the SessionStart entry into ~/.claude/settings.json with `python3` (no jq dependency) and don't touch the other keys.
- **PATH:** symlink `bin/polly` into `~/.local/bin/` (and warn if that dir isn't on PATH in ~/.zshrc).
- `CLAUDE_HOME` / `LOCAL_BIN` env vars override the targets, for sandbox tests.
- Idempotent: safe to re-run. Print what it linked or skipped.

## Principles (go into global/CLAUDE.md)
- Plan before code, and stop for my approval between phases.
- Verify before saying done: show the real command output.
- YAGNI, DRY, the simplest thing that works.
- Check current docs for versions and APIs. Don't trust memory.
- When blocked, research and try alternatives, then ask me and say what you tried.
- Read knowledge/lessons/ before planning a task.

## Build order (one piece at a time, test before moving on, commit after each)
1. `global/CLAUDE.md` (with the graphify section carried over)
2. `template/` + `bin/polly` (test: stamp a throwaway project)
3. `install.sh` + `global/hooks/stage.sh` (test: new session in the stamped project shows the stage line)
4. `/brief` (test on a real project)
5. `/architect`, `/tasks`, `/scaffold`
6. ~~Build loop~~ done early: EPAV commands moved into the repo, /plan-task merged with evaluate, template wired
7. `/lesson`, `/retro`, `/best-practice`, `/spike`
8. `polly adopt` + `/onboard` (test on an existing repo)
9. README.md: written early as the usage guide; tick off ⏳ items as each piece lands

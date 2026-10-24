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
| Evaluate vs plan | Merged into **/plan-task**: evaluate (files, risks, questions), then write the plan. One stop for approval. |
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
│   ├── agents/
│   │   └── code-reviewer.md  — used by /validate
│   └── skills/
│       ├── brief/SKILL.md
│       ├── architect/SKILL.md
│       ├── tasks/SKILL.md
│       ├── spike/SKILL.md
│       ├── scaffold/SKILL.md
│       ├── plan-task/SKILL.md
│       ├── apply/SKILL.md
│       ├── validate/SKILL.md
│       ├── lesson/SKILL.md
│       ├── retro/SKILL.md
│       ├── best-practice/SKILL.md
│       └── onboard/SKILL.md
└── template/
    ├── CLAUDE.md             — empty sections, each tagged with the skill that fills it
    ├── .gitignore            — .DS_Store, .env* (stack ignores come from /scaffold)
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

## Lifecycle and skills (12)
**SHAPE**
- `/brief` asks me one question at a time and writes docs/brief.md: problem, user, core loop, v1 scope, non-goals, done signal. One page.
- `/architect` defaults to TS full-stack (pnpm/Vitest/Vercel) plus 1–2 alternatives. I pick, and it writes docs/arch.md plus a decision record.
- `/tasks` writes vertical slices with checkable acceptance criteria to docs/tasks.md. T-01 is always the walking skeleton.
- `/spike` runs a throwaway experiment to answer one technical question. The result goes in knowledge/decisions/ and the code is discarded.

**SKELETON**
- `/scaffold` builds the smallest app that runs end to end (T-01). It fills the CLAUDE.md commands and code layout, and pins exact versions in arch.md. Run once per project.

**BUILD LOOP** (one task at a time, stop after each step)
- `/plan-task T-xx`: evaluate (affected files, risks, open questions), then a file-by-file plan in knowledge/tasks/T-xx.md. **Stop.** No code until I approve.
- `/apply`: implement exactly the approved plan, with no scope creep. If the plan turns out wrong, stop and say so instead of improvising.
- `/validate`: run build, lint, and tests and show the real output. Check each acceptance criterion, review the code through the `code-reviewer` subagent, record the outcome in T-xx.md, and update the status in docs/tasks.md.

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
| CLAUDE.md sections | /brief (what), /architect (stack), /scaffold (commands, layout), /onboard |
| knowledge/tasks/ | /plan-task, /validate |
| knowledge/lessons/ | /lesson |
| knowledge/decisions/ | /architect, /spike (append-only) |
| knowledge/best-practices/ | /best-practice |
| knowledge/retros/ | /validate (follow-ups), /retro |
| knowledge/INDEX.md | any skill that adds a knowledge file appends one line |

## SessionStart hook (global/hooks/stage.sh)
- Runs once per session. It is silent unless the project has the template layout (`docs/` and `knowledge/`), so other repos are unaffected.
- Output stays under 10 lines, for example:
  `Stage: brief ✓ · arch ✗ · tasks ✗ · scaffold ✗ → next: /architect`
  `In progress: T-03 (planned, not applied)` · `Lessons: 4 (read knowledge/lessons/ before planning)`
- A doc counts as missing if it is absent or still contains `<!-- polly:placeholder -->` (skills remove the marker when they fill the doc).

## Install rules (install.sh)
- **Global CLAUDE.md:** the existing ~/.claude/CLAUDE.md has the graphify section. Move that section into global/CLAUDE.md, back up the old file to `CLAUDE.md.bak.<date>`, then symlink.
- **Skills:** symlink each `global/skills/<name>` on its own, not the whole skills/ folder, so `graphify/` and `synced/` stay where they are.
- **Name clash:** claude.ai-synced skills named `apply`, `evaluate`, `next`, `plan-task`, `validate` already exist. Before building, check which one wins. If the synced copies shadow the local ones, either remove them from the claude.ai sync or rename mine (e.g. a `w-` prefix). Decide at build step 4.
- **Agents/hooks:** symlink `global/agents/*` and `global/hooks/stage.sh`. Merge the SessionStart entry into ~/.claude/settings.json with `python3` (no jq dependency) and don't touch the other keys.
- **PATH:** symlink `bin/polly` into `~/.local/bin/` (and warn if that dir isn't on PATH in ~/.zshrc).
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
4. Resolve the synced-skill name clash, then `/brief` (test on a real project)
5. `/architect`, `/tasks`, `/scaffold`
6. `/plan-task`, `/apply`, `/validate` + `code-reviewer` agent
7. `/lesson`, `/retro`, `/best-practice`, `/spike`
8. `polly adopt` + `/onboard` (test on an existing repo)
9. README.md

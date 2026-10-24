---
description: Read lessons and open task plans, then say what the next task is. Read-only.
argument-hint: [optional focus area]
---

$ARGUMENTS

You are BEFORE the Evaluate step. Read and report only.

Rules that come first:
- Follow this repo's CLAUDE.md for where plans and lessons live. Do not invent folders.
- Make no edits, create no files, run no commits.

Do this:
1. List the open task plans (unticked items), newest first. Note which one matches the current branch.
2. Skim the lessons that touch that area, and quote the one or two that matter.
3. Say which task is next and why, in two or three sentences. If several are equal, recommend one.
4. Flag anything blocked, stale, or waiting on the owner.

Then stop. End with: "Next: /evaluate <that task>".

---
name: commit
description: Review the changes, draft a commit message in the repo's own style, and commit only what I approve.
argument-hint: "[hint for the message]"
disable-model-invocation: true
---

$ARGUMENTS

You are committing my changes. Read first, draft second, commit only after I approve.

Rules that come first:
- If this is not a git repo, say so and stop. If there are no changes, say "Nothing to commit." and stop.
- If the current branch is the default branch (`main` or `master`), ask whether to make a new branch first. Don't commit there unless I say so.
- Never push, never amend, never use `--no-verify`, never run `git add -A` or `git add .`. Stage files by name.

Do this:
1. Read `git status --short`, `git diff`, `git diff --staged` and `git log -10 --oneline` (for the repo's message style). Treat anything written after `/commit` as a hint for the message.
2. Check for secrets in the changed files and the diff: `.env*`, key and certificate files, anything that looks like a token or password. Name what you found, leave it out of the commit, and say so. If something I didn't expect is already staged, show it and ask.
3. If the changes mix unrelated things, propose separate commits, each with its own files, and do them one at a time.
4. Draft the message in the style the log uses. The subject is imperative, about 72 characters or less. Add a body only when the why isn't clear from the diff. If the session's system reminder gives an attribution line for commits, end the message with it.
5. Show the files and the message. Wait for my OK or changes.
6. Stage the approved files by name and commit, passing the message through a heredoc. If a hook fails, show its output, fix the cause and make a new commit. Never bypass the hook or amend.
7. Show `git log -1 --stat`.

If the repo root has a `.polly` file: when `knowledge/tasks/T-xx.md` exists for a task that is not `Status: done` in `docs/tasks.md`, name that task in the message in the style the log uses, and ask "T-xx isn't done yet. Run /validate first?" It is a nudge, not a refusal.

End with: "Committed <hash>. Next: /create-pr when the branch is ready."

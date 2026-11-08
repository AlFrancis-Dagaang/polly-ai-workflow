---
name: create-pr
description: Draft a pull request from the branch's commits, show it, and open it on GitHub only after I approve.
argument-hint: "[base branch]"
disable-model-invocation: true
---

$ARGUMENTS

You are opening a pull request. Opening one publishes my work, so read first, draft second, push and create only after I approve.

Rules that come first:
- If this is not a git repo, or `gh` is not installed or not logged in (`gh auth status`), say so and stop.
- If the current branch is the default branch, say "Create a branch first." and stop.
- If there are uncommitted changes, say so, suggest /commit, and ask whether to go on without them.
- If there are no commits ahead of the base branch, say so and stop.
- If an open PR already exists for this branch (`gh pr list --head <branch>`), show its URL and stop.
- Never merge, never force-push, and never add reviewers, labels or assignees unless I name them.

Do this:
1. Find the base: the text after `/create-pr` if given, else the repo's default branch (`gh repo view --json defaultBranchRef`).
2. Read `git log <base>..HEAD`, `git diff --stat <base>...HEAD`, and `.github/pull_request_template.md` if it exists (follow it if so).
3. Show which account and repo this will publish to: the account from `gh auth status` and the `origin` remote. My work and personal profiles may use different accounts, so I confirm this before anything is pushed.
4. Draft the title (about 70 characters or less) and the body: a Summary of bullets from the commits, and the checks that were actually run. Claim only checks you ran in this session or that a task outcome records. If the session's system reminder gives a footer for pull requests, end the body with it.
   If the repo root has a `.polly` file and the branch is for a task, add that task's acceptance criteria from `docs/tasks.md` as a checklist, and the outcome from `knowledge/tasks/T-xx.md`, only if they exist.
5. Show the title, body, base, head and account. Ask once whether it is a draft or ready for review. Wait for my OK.
6. Push with `git push -u origin HEAD` (never forced), then run `gh pr create --base <base> --head <branch> --title <title> --body <body>`, passing the body through a heredoc.
7. Print the PR URL.

End with: "PR: <url>. Merging stays manual."

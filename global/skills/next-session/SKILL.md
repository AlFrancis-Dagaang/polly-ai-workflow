---
name: next-session
description: Write a short prompt I can paste into a fresh session to continue this one: what we did, where we are, decisions, open bugs, what's next.
argument-hint: "[what the next session should start on]"
disable-model-invocation: true
---

$ARGUMENTS

You are writing the prompt that starts my next session. Print it in the chat; write no file. Check the real state first, then draft.

Rules:
- State only what this session established or what you just checked. Anything unverified goes under "Not checked", never as fact.
- No secrets or credentials. No code or log dumps: use file paths and commit hashes.
- If a file already holds something (PLAN.md, CLAUDE.md, a lesson), name the file and skip the content.

Do this:
1. Run `git branch --show-current`, `git status -sb` and `git log -5 --oneline`. If it is not a git repo, skip this and say so in State.
2. From this conversation, collect: the goal, what was done and how it was verified, decisions with a few words of why, bugs hit and how they ended, and what is left in order. Treat anything written after `/next-session` as what the next session should start on.
3. Print one fenced block, 25 lines or fewer, in this shape:
   ```
   Continue <topic>. Context:
   - Done and verified: ... (commit hashes)
   - Decisions: ... (why)
   - State: branch, clean or dirty, pushed or not
   - Bugs and open issues: ...
   - Not checked: ...
   - Left, in order: ...
   - How I work: only the rules that mattered this session
   Start with: <the first action>.
   ```

End with: "Paste this into a new session after /clear."

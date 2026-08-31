---
name: wrap
description: Close out a session on the workspace-scaffold repo — refresh ROADMAP.md, log learnings to DECISIONS.md, update ticket status, check IMPROVEMENTS.md for anything at threshold, commit, and summarize. Use when Logan says he's wrapping up, done for now, or ending the session.
---

# /wrap

Session close-out. Keeps this repo's context true and keeps the improvement loop honest. Do all six, briefly. Keep the numbered labels — the scaffold uses them to merge updates into this file.

1. **Roadmap freshness.** Re-read `ROADMAP.md`. If today's work changed what's true — a focus item finished, the core changed, scope shifted — update it and refresh the "Last updated" date. If the goal itself now looks wrong, say so and ask; never silently rewrite direction.
2. **Learnings.** Did anything surprising happen — a template that didn't fit, a rule that turned out ambiguous, a decision that forecloses something? Append each as one dated line to `DECISIONS.md`. Settled things only; candidates go in step 4. If genuinely nothing, append nothing.
3. **Work status.** Update the status of any ticket touched this session, using one of the six values in `tickets/README.md` — if none fits, say so rather than inventing a word. If a ticket closed and its `source:` was an IMPROVEMENTS.md heading, confirm the "→ incorporated" line is there.
4. **Improvements check.** Read `IMPROVEMENTS.md`. Any heading with two or more occurrences and no "→ incorporated" line and no open ticket? Name it in the summary and ask whether to open one. Don't open it unasked.
5. **Commit.** Stage and commit the session's changes with a message that says what changed in the *skill* — the rule, template, or step that moved — not just which files did. This repo has no build, so git history is the only undo. Suggest the message; let Logan approve.
6. **Summary.** Short, in three parts: what changed, what was verified (and on which real repo), and what's left — split into **do now, before closing** and **queued for next session**. If a template changed and no scaffolded repo was re-aligned, that's a do-now.

Keep the whole close-out tight — a minute, not its own project.

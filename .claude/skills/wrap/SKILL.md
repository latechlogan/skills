---
name: wrap
description: Close out a session on the skills repo — refresh ROADMAP.md, log learnings to DECISIONS.md, update ticket status, commit, and summarize. Use when Logan says he's wrapping up, done for now, or ending the session.
---

# /wrap

Session close-out. Keeps this repo's context true. Do all five, briefly.

1. **Roadmap freshness.** Re-read `ROADMAP.md`. If today's work changed what's true — a focus item finished, the core changed, scope shifted — update it and refresh the "Last updated" date. If the goal itself now looks wrong, say so and ask; never silently rewrite direction.
2. **Learnings.** Did anything surprising happen — a template that didn't fit, a rule that turned out ambiguous, a decision that forecloses something? Append each as one dated line to `DECISIONS.md`. If genuinely nothing, append nothing.
3. **Work status.** Update the status of any ticket touched this session, using one of the six values in `tickets/README.md` — if none fits, say so rather than inventing a word.
4. **Commit.** Stage and commit the session's changes with a message that says what changed in the *skill* — the rule, template, or step that moved — not just which files did. This repo has no build, so git history is the only undo. Suggest the message; let Logan approve.
5. **Summary.** Short, in three parts: what changed, what was verified (and on which real repo or conversation), and what's left — split into **do now, before closing** and **queued for next session**. If a scaffold template changed and no scaffolded repo was re-aligned, that's a do-now.

Keep the whole close-out tight — a minute, not its own project.

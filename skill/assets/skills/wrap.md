---
name: wrap
description: Close out a work session — refresh ROADMAP.md so it never goes stale, log learnings to DECISIONS.md, update the status of in-flight work, commit, and summarize with a clear do-now / next-session split. Use when the user says they're wrapping up, done for now, ending the session, or asks to close out.
---

# /wrap

Session close-out. This is the maintenance step that keeps the workspace's context files true, so future sessions don't optimize for a stale goal or relearn old lessons. Do all five, briefly. Keep the numbered labels — the scaffold uses them to merge updates into this file.

1. **Roadmap freshness.** Re-read `ROADMAP.md`. If today's work changed what's true — a focus item finished, scope shifted, something got cut — update it and refresh the "Last updated" date. The `## Current goal` section is what other tools read as this project's status, so it must be current. If the goal itself now looks wrong, say so and ask; never silently rewrite direction.
2. **Learnings.** Did anything surprising happen — a bug with a non-obvious cause, a tool quirk, a decision that forecloses alternatives, something a stakeholder said? Append each as one dated line to `DECISIONS.md`. If genuinely nothing, append nothing; padding the log dilutes it.
3. **Work status.** Update the status of any {{UNIT_OF_WORK — ticket / research file / …}} touched this session. If nontrivial work happened with no unit of work behind it, note that as a process miss — once — without belaboring it.
4. **Commit.** Stage and commit the session's changes with a message that says what changed in the *product*, not just which files moved. For a repo with no build, git history is the only undo. Suggest the message; let the user approve.
5. **Summary.** Short, in three parts: what changed, what was verified (and how), and what's left. Split what's left explicitly into **do now, before closing** (anything that leaves state inconsistent if skipped) and **queued for next session** (everything else). Never leave an undifferentiated pile.

Keep the whole close-out tight — a minute, not its own project.

<!-- ADAPT WHEN INSTALLING: add project-specific steps between 3 and 4 if the repo has state to leave consistent (e.g. "Queue hygiene", "Research output"). Drop **Commit** only if the repo isn't git-tracked — and say so in DECISIONS.md, since that leaves the log with no undo. Don't remove the other four. -->

---
name: ticket
description: Park work for later with its context intact — a future session, or another workspace, picks it up cold. Use when the user describes nontrivial work, asks to "make a ticket," or when something surfaces mid-session that shouldn't be tackled now but shouldn't be lost.
---

# /ticket

Write the ticket to `tickets/NNN-short-slug.md` (next number in sequence). The reader is a session that wasn't here — write everything it will need, now, while the context is deep. If the request is too vague to fill the fields honestly, ask the narrowing questions first; don't guess.

Use this exact structure:

```markdown
---
status: open
kind: defect | improvement
created: YYYY-MM-DD
---

# NNN — [short title]

## Job
[What to do, one or two sentences. Specific, not "improve X."]

## Context
[What the writer knows that the reader won't: what was observed, where, why it matters now, and what was already tried or ruled out. Name files in full.]

## Scope
[Which parts of the product/files this touches. What it deliberately does NOT touch.]

## Done looks like
[Observable finish line — what a reviewer can see or click to confirm it's done.]

## Boundary
[Constraints: consistency requirements, things that need ask-first approval per CLAUDE.md's permissions, anything intentionally deferred.]

## Plan
[Written now, by the writer, who has the context: the files that change, the order of the work, and how it will be verified. Mark it `(proposed)` if it hasn't been approved; the executor confirms before editing.]
```

Rules:

- Set `kind` deliberately. `defect` = something a user hits today that fails, misleads, or embarrasses; it jumps the queue per ROADMAP.md's triage rule. `improvement` = real work with no active harm behind it. Ticket number is creation order, not priority. If the project only ever has one kind, delete the field and the triage rule together.
- One ticket = one task, one finish line, one reviewable change. If the request contains two jobs, write two tickets and ask which comes first.
- If "done looks like" can't be written as something observable, the ticket isn't ready — keep narrowing.
- If the job matches nothing in ROADMAP.md's current focus, say so before proceeding; the user may still want it, but the mismatch should be a decision, not an accident.
- **Name files so a path can't resolve twice.** Two different readers resolve a ticket's paths: the session executing it, from the workspace root, and whoever opens the file, from `tickets/`. Those differ by one level, so a bare `../DECISIONS.md` is wrong for one of them — and where workspaces nest, both levels hold a real file, so the wrong one loads with no error. Write paths from the workspace root, and when a parent and child share a filename, name both in full (`parent-dir/DECISIONS.md`, `child-dir/DECISIONS.md`).
- Write `## Plan` at creation, not later — the writer has the context and the executor won't. Whether work may start before the plan is approved is CLAUDE.md's Working style rule, not this skill's; the ticket just makes sure the plan exists to approve.

<!-- ADAPT WHEN INSTALLING: if this project uses GitHub Issues instead of tickets/, change the destination to opening an issue with the same fields. -->

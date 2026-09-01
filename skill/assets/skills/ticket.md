---
name: ticket
description: Turn a loose request into a written ticket before work starts. Use when the user describes nontrivial work to do, asks to "make a ticket," or starts describing a feature, fix, or change that will take more than a trivial edit.
---

# /ticket

Write the ticket to `tickets/NNN-short-slug.md` (next number in sequence) before any implementation. A ticket is a small, clear assignment with a visible finish line. If the request is too vague to fill the fields honestly, ask the narrowing questions first — do not guess and do not start work.

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

## Scope
[Which parts of the product/files this touches. What it deliberately does NOT touch.]

## Done looks like
[Observable finish line — what a reviewer can see or click to confirm it's done.]

## Boundary
[Constraints: consistency requirements, things that need ask-first approval per CLAUDE.md's permissions, anything intentionally deferred.]

## Plan
[Empty until approved. Then: the files that change, the order of the work, and how it will be verified.]
```

Rules:

- Set `kind` deliberately. `defect` = something a user hits today that fails, misleads, or embarrasses; it jumps the queue per ROADMAP.md's triage rule. `improvement` = real work with no active harm behind it. Ticket number is creation order, not priority. If the project only ever has one kind, delete the field and the triage rule together.
- One ticket = one task, one finish line, one reviewable change. If the request contains two jobs, write two tickets and ask which comes first.
- If "done looks like" can't be written as something observable, the ticket isn't ready — keep narrowing.
- If the job matches nothing in ROADMAP.md's current focus, say so before proceeding; the user may still want it, but the mismatch should be a decision, not an accident.
- **Name files so a path can't resolve twice.** Two different readers resolve a ticket's paths: the session executing it, from the workspace root, and whoever opens the file, from `tickets/`. Those differ by one level, so a bare `../DECISIONS.md` is wrong for one of them — and where workspaces nest, both levels hold a real file, so the wrong one loads with no error. Write paths from the workspace root, and when a parent and child share a filename, name both in full (`parent-dir/DECISIONS.md`, `child-dir/DECISIONS.md`).
- After writing the ticket, propose a plan (inspect relevant context files and code first) and wait for approval before editing anything that affects product behavior. Once approved, write the plan into the ticket's `## Plan` section — a plan that lives only in chat is lost.

<!-- ADAPT WHEN INSTALLING: if this project uses GitHub Issues instead of tickets/, change the destination to opening an issue with the same fields. -->

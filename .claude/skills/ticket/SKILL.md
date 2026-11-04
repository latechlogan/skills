---
name: ticket
description: Park a proposed change to a skill in this repo as a ticket with its context and plan written in. Use when Logan describes a nontrivial change to a SKILL.md, a template or reference, or a project skill, or when he says "make a ticket."
---

# /ticket

Write the ticket to `tickets/NNN-short-slug.md` (next number in sequence). The reader is a session that wasn't here — write everything it will need now, while the context is deep. If the request is too vague to fill the fields honestly, ask the narrowing questions first.

Use this exact structure:

```markdown
---
status: open
created: YYYY-MM-DD
source: request
---

# NNN — [skill-name]: [short title]

## Job
[Which skill, and what changes in it, one or two sentences.]

## Context
[What the writer knows that the reader won't: which real repo showed the problem, what it looked like there, what was already tried. Name files in full.]

## Scope
[Which files, named from the repo root (`project-kickoff/SKILL.md`, `workspace-scaffold/assets/templates/REVIEW.md`). What it does NOT touch. If it touches the kickoff → scaffold hand-off, name both sides.]

## Done looks like
[Observable — e.g. "existing-workspace mode run on career-trajectory proposes exactly N operations and nothing else."]

## Boundary
[workspace-scaffold: does it hold for a non-code repo? Does it change the wrap-residue contract or a step label? If yes, which scaffolded repos need migrating. Other skills: what existing projects or hand-offs does it affect?]

## Plan
[Written now: files that change, in order, and which real repo or conversation it gets tested on. Mark `(proposed)` until Logan approves; don't edit before then.]
```

Rules:

- One ticket = one change. A template change and a SKILL.md change that aren't the same idea are two tickets.
- If the job matches nothing in ROADMAP.md's current focus, say so before proceeding.
- **Name files so a path can't resolve twice.** Two different readers resolve a ticket's paths: the session executing it, from the workspace root, and whoever opens the file, from `tickets/`. Those differ by one level, so a bare `../DECISIONS.md` is wrong for one of them — and where workspaces nest, both levels hold a real file, so the wrong one loads with no error. Write paths from the workspace root, and when a parent and child share a filename, name both in full (`Webflow/DECISIONS.md`, `DJCon/DECISIONS.md`).
- Write `## Plan` at creation — the writer has the context. Wait for approval before editing.

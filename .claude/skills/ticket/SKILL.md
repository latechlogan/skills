---
name: ticket
description: Turn a proposed change to the workspace-scaffold skill or its templates into a written ticket before editing. Use when Logan describes a nontrivial change to SKILL.md, a template, or a project skill, when an IMPROVEMENTS.md heading reaches threshold and he says yes, or when he says "make a ticket."
---

# /ticket

Write the ticket to `tickets/NNN-short-slug.md` (next number in sequence) before any edit. If the request is too vague to fill the fields honestly, ask the narrowing questions first.

Use this exact structure:

```markdown
---
status: open
created: YYYY-MM-DD
source: [request | IMPROVEMENTS.md#slug]
---

# NNN — [short title]

## Job
[What changes in the skill/templates, one or two sentences.]

## Scope
[Which files: SKILL.md, which templates, which project skills. What it does NOT touch.]

## Done looks like
[Observable — e.g. "existing-workspace mode run on career-trajectory proposes exactly N operations and nothing else."]

## Boundary
[Does it hold for a non-code repo? Does it change the wrap-residue contract or a step label? If yes, which scaffolded repos need migrating.]

## Plan
[Empty until approved. Then: files that change, in order, and which real repo it gets tested on.]
```

Rules:

- One ticket = one change. A template change and a SKILL.md change that aren't the same idea are two tickets.
- If the job matches nothing in ROADMAP.md's current focus, say so before proceeding.
- If the ticket came from IMPROVEMENTS.md, link the heading in `source:` and, when the ticket closes, add an "→ incorporated" line under that heading so it stops counting.
- **Name files so a path can't resolve twice.** Two different readers resolve a ticket's paths: the session executing it, from the workspace root, and whoever opens the file, from `tickets/`. Those differ by one level, so a bare `../DECISIONS.md` is wrong for one of them — and where workspaces nest, both levels hold a real file, so the wrong one loads with no error. Write paths from the workspace root, and when a parent and child share a filename, name both in full (`Webflow/DECISIONS.md`, `DJCon/DECISIONS.md`).
- After writing the ticket, propose a plan and wait for approval. Then write the plan into `## Plan`.

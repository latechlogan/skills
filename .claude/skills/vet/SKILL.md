---
name: vet
description: Vet a change to a skill in this repo against REVIEW.md before calling it done. Use when Logan asks to review or vet changes, says a template change is finished, or asks "is this ready."
---

# /vet

Review the current changes against `REVIEW.md`, and sort every finding into exactly one of three buckets:

- **Must fix** — a skill loading another skill's files, a broken kickoff → scaffold hand-off, or for workspace-scaffold: breaks re-alignment for an existing repo (a step label, a core file name, the wrap-residue contract), adds homework to a template, has the skill modifying itself, or is wrong for a non-code repo while claiming to be core.
- **Should fix** — real but survivable; note it and let Logan decide timing.
- **Fine as is** — worth mentioning, no action needed.

Rules:

- No hooks here, so nothing is verified elsewhere — but don't invent mechanical findings either. Judgment only, on the things `REVIEW.md` names.
- **Trace the change through one real case.** For a project-kickoff change, walk the changed phase through a real kickoff's `docs/` and check its hand-off still lands. For any workspace-scaffold template or SKILL.md change, walk through what Step 3b would propose on career-trajectory (or the newest scaffolded repo). If the answer is "an operation that doesn't make sense there," that's the finding.
- Review against the ticket. Changes outside its scope go in must-fix as "unexplained scope change" unless there's a stated reason.
- Read the changed SKILL.md passage cold, as a fresh session would — is there anything that only makes sense given the conversation that wrote it?
- End with a one-line verdict: clear, clear after must-fixes, or hold.
- Offer to fix must-fix items, but don't fix them silently — each fix is its own reviewable change.

---
status: done
created: 2026-08-27
source: IMPROVEMENTS.md#unit-of-work-keyed-on-code
---

# 001 — Unit-of-work rule: key on deliverable shape, not on code

## Job
Change SKILL.md's unit-of-work rule from "code repo → ticket default" to "discrete deliverables with an observable finish line → ticket; exploratory or continuous work → the project names its own unit."

## Scope
`skill/SKILL.md` — the "Decided per project" bullet and Step 2's unit-of-work question. `skill/assets/templates/CLAUDE.md`'s `{{UNIT_OF_WORK_RULE}}` hint. Does not touch the ticket template's fields, /vet, or /wrap.

## Done looks like
Re-reading the rule against both real cases gives the right answer without exception: RCRM (no code, 32 tickets) → tickets; career-trajectory (no code, research files) → its own unit. No sentence in SKILL.md ties tickets to code.

## Boundary
Holds for non-code repos by construction — that's the point. Doesn't change any step label or the wrap-residue contract, so no scaffolded repo needs migrating. Approved as part of the RCRM migration plan, 2026-08-27.

## Plan
Edit the two SKILL.md passages and the one template hint. Test by reading each against RCRM and career-trajectory. Mark the IMPROVEMENTS.md heading incorporated.

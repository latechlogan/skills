---
status: done
created: 2026-08-27
source: IMPROVEMENTS.md#ticket-kind-field
---

# 003 — `kind:` field and triage rule in the ticket template

## Job
Add `kind: defect | improvement` to the ticket frontmatter in `assets/skills/ticket.md`, and a one-line triage rule to the ROADMAP.md template ("defects before improvements" or the project's own ordering) so ticket order reflects priority rather than creation order — the pattern RCRM invented and DJCon copied verbatim.

## Scope
`skill/assets/skills/ticket.md` — frontmatter block in the structure, one rule line explaining when each kind applies. `skill/assets/templates/ROADMAP.md` — a `{{TRIAGE_RULE}}` hint under "This cycle's focus." `skill/assets/templates/tickets-README.md` — one sentence naming the field. Does not touch /vet, /wrap, CLAUDE.md, or the ticket's body sections.

## Done looks like
- `/ticket` on a fresh scaffold writes frontmatter with `kind:`, and asking "which ticket next?" in that repo produces an answer from the triage rule, not from ticket number.
- Existing-workspace mode on RCRM and DJCon proposes **no** operations for this — their variant is already the template's.
- A project with only one kind of work (a research repo with no defects) can delete the field without anything else breaking; the template says so.

## Boundary
Holds for non-code repos — both occurrences are ops repos. Doesn't change a step label or the wrap-residue contract. Two open questions to settle in the plan: (1) whether `defect | improvement` is the right closed set or the template should show it as an example with the project naming its own kinds; (2) whether the triage rule lives in ROADMAP.md (where RCRM put it, and where /wrap already refreshes) or in tickets/README.md. Recommendation: closed set as the default with "rename to fit" permitted; rule in ROADMAP.md so it sits next to the focus list it orders. Repos that would get a merge: career-trajectory and chief-of-staff only if they use tickets (they don't — no-op).

## Plan
Approved 2026-08-27, with one change from the ticket's Scope: the triage rule goes in a `## Triage rule` section of ROADMAP.md (where RCRM and DJCon both already have it — matching them verbatim is what makes 3b propose zero operations), not as a hint under "This cycle's focus". Open question (1) settled: closed set `defect | improvement` as the default; a one-kind project deletes field and rule together. (1) `assets/skills/ticket.md`: `kind:` in the frontmatter block + a "Set `kind` deliberately" rule. (2) `templates/ROADMAP.md`: `## Triage rule` section, marked deletable. (3) `templates/tickets-README.md`: one sentence. (4) Test by reading: RCRM and DJCon tickets carry `kind:` and a `## Triage rule` section → no operations; chief-of-staff and career-trajectory have no tickets (chief-of-staff's `tickets/` is README only) → no-op. (5) "→ incorporated".

Done 2026-08-27. Steps 1–3 applied; step 4 verified by grep; step 5 applied.

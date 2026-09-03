---
status: dropped
created: 2026-09-02
source: request
---

# 011 — An `## Outcome` section in the ticket template

## Job
Add an `## Outcome` section to the ticket structure in `skill/assets/skills/ticket.md` — one or two lines written at close-out saying what shipped and what it actually changed — so a closed ticket carries its result, not just its intent.

## Scope
`skill/assets/skills/ticket.md` — one new section at the end of the structure block, plus one rule saying it stays empty until close-out and who fills it. `skill/assets/skills/wrap.md` — the **Work status** step gains a clause: when a ticket moves to `done`, write its Outcome. Mirrored into this repo's `.claude/skills/ticket/SKILL.md` and `.claude/skills/wrap/SKILL.md`.

Does **not** touch: `SKILL.md`'s core section (see Boundary), `/vet`, `skill/assets/templates/tickets-README.md`, the ticket frontmatter fields, the status enum, or any step label. Does **not** add a core file — this is deliberately the smaller alternative to the `WORK-LOG.md` evidence ledger named in ticket 010's follow-ups, which stays unticketed at one occurrence.

## Done looks like
- `/ticket` on a fresh scaffold writes a structure containing `## Outcome`, empty, and `/wrap` fills it when it sets a ticket to `done`.
- Re-reading `workspace-scaffold/tickets/010-core-as-data-contract.md` against the new section: its improvised `### Test results, 2026-09-01` heading is what `## Outcome` is for, and would have had a home. That improvisation — the only non-template heading across all ten tickets in this repo — is the motivating occurrence.
- A repo whose unit of work is not tickets (`career-trajectory`) is unaffected: no file it has gains a section.
- Answers a question `[learning]` lines structurally cannot: DECISIONS.md fires on *surprise*, so an ordinary result that surprised no one is never logged. `## Outcome` fires on *close-out*, so it records the unremarkable case too.

## Boundary
Holds for a non-code repo — it's a section in a markdown template, and the two repos most likely to use it (RCRM, Trinity) have no code.

Does **not** change the wrap-residue contract (`ROADMAP.md ## Current goal` + the DECISIONS.md tail) or any step label. No scaffolded repo needs migrating: an absent `## Outcome` on an existing ticket is not a defect, and closed tickets are not backfilled.

**Open question for the plan — shape or behavior?** `SKILL.md`'s core section puts ticket *body* sections under "Decided per project," not in the data contract; only the H1 and the `status`/`kind`/`created` frontmatter are contract. So `## Outcome` enters as a reference-implementation default, not as shape — unless another workspace would need to *read* it, which is the test the core section sets. Recommendation: keep it out of the contract for now. A parent workspace building a rollup from its children's shipped work is the case that would change that; `Webflow/` is the repo to watch, and Trinity's stakeholder-reporting `WORK-LOG.md` is evidence that need is real but currently one project's business.

## Plan

### Dropped 2026-09-02
Dropped in the cleanup pass. An `## Outcome` section is an improvement, not a defect, and the scaffold is frozen to defects; results keep going to DECISIONS.md `[learning]` lines. `/ticket` did gain `## Context` and plan-at-creation, which is the parking half of what this ticket wanted.

---
status: dropped
created: 2026-08-31
source: request
---

# 007 — Step 3b: reconcile a changed template section against an existing one

## Job
Step 3b's operation table has no operation for the most common template change there is: a template file that already exists in a repo, whose section the repo customized or named differently. `add` fires only when a section is *missing*; `rename` covers skills and file casing, not sections; `merge` is defined for an installed skill's numbered steps. So a changed template section either duplicates or silently doesn't propagate.

## Scope
`skill/SKILL.md` — Step 3b's operation table gains a row (or `merge` is widened past skills). Does not touch the templates themselves, /ticket, /vet, /wrap, or any step label.

## Done looks like
Walking Step 3b over `Webflow/RCRM/tickets/README.md` against ticket 006's new `## Status` section proposes **one** operation that ends with RCRM holding a single status vocabulary — not an `add` that leaves `## Frontmatter` and `## Status` side by side with two lists. RCRM's own additions (the A1–A26 migration history, the `grep -l 'kind: defect'` recipe) survive untouched, per 3b's "never remove project-specific adaptations."

## Boundary
Holds for a non-code repo — the gap is about any template file, not tickets specifically; `career-trajectory`'s REVIEW.md has the same exposure. Doesn't change a step label or the wrap-residue contract.

The hard part is the judgment call this row has to encode: when a repo's version of a section is *better* than the template's, the answer is an IMPROVEMENTS.md line, not an overwrite. 3b's "never regenerate REVIEW.md, never rewrite CLAUDE.md prose" instinct has to survive whatever gets written here — this row must not become a licence to flatten a repo's accumulated judgment.

Real evidence to design against, four installed `tickets/README.md` files: RCRM (`## Frontmatter` + grep recipe + migration history), Trinity, DJCon, OuachitaTerminals. All four already document the same six values ticket 006 ratified, so the vocabulary itself needs no change — only the structure does. That makes this a clean test case: the right answer is visibly "reconcile, don't overwrite."

## Plan
Dropped 2026-09-01 — superseded by ticket 010. The core is now a data contract; Step 3b no longer reconciles skill bodies or template prose, so the operation this ticket wanted has nothing to act on. The one shape-level case here (a status vocabulary that must stay single) is covered by the frontmatter minimum in the core section.

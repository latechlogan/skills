---
status: open
created: 2026-08-28
source: IMPROVEMENTS.md#existing-backlog-migration
---

# 004 — Step 3a: how to migrate an existing backlog into the workspace

## Job
Four repos (RCRM, DJCon, Trinity, OuachitaTerminals) arrived with a loose action list — a backlog, a launch checklist, an executable prompt — and each time the mapping into the scaffold was improvised. Write the mapping into SKILL.md Step 3a so it's applied, not reinvented: items → tickets grouped by finish line; gotchas → DECISIONS.md; don't-break-these → CLAUDE.md "Rules that must not bend"; blocked-on-stakeholder → ROADMAP.md "Waiting on"; verify blocks → `scripts/verify-live.sh` (or /vet step 1); nice-to-haves → a ROADMAP "backlog (not tickets yet)" list rather than tickets; then delete the source file and log the dissolution.

## Scope
`skill/SKILL.md` — Step 3a gets a "Brownfield with an existing work queue" paragraph. Possibly a `{{WAITING_ON}}` hint in `assets/templates/ROADMAP.md`, since two of four repos added that section by hand (Trinity, OuachitaTerminals; RCRM and DJCon have none). Does not touch /ticket, /vet, /wrap, or the step labels.

## Done looks like
Re-reading the paragraph against the four real cases reproduces what each session did without an exception: RCRM's SEO backlog (32 tickets), DJCon's TRINITY-CONNECTION.md (one ticket, file deleted), Trinity's SEO-BACKLOG (26 tickets + Waiting-on), Ouachita's LAUNCH-CHECKLIST + connection prompt (13 tickets + post-launch list + Waiting-on). A fifth repo with a backlog needs no improvisation.

## Boundary
Holds for non-code repos — all four occurrences are. Doesn't change a step label or the wrap-residue contract; no scaffolded repo needs migrating. Open question for the plan: whether "Waiting on (humans)" is a core ROADMAP section or stays a per-project addition — it appeared in 2 of 4 ops repos but in none of the solo repos (career-trajectory, chief-of-staff, newsletter). Recommendation: template hint marked deletable, not a core section.

## Plan
[Empty until approved.]

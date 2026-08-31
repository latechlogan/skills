---
status: done
created: 2026-08-31
source: request
---

# 006 — Close the ticket status enum

## Job
Make `assets/templates/tickets-README.md` the single authority for ticket status values, with a closed list of six — `open | in-progress | blocked | deferred | done | dropped` — and a rule that a repo wanting a seventh word logs it to IMPROVEMENTS.md instead of inventing it locally.

## Scope
`skill/assets/templates/tickets-README.md` (the enum, a gloss per value, which values mean "not actionable", the anti-drift rule) and one clause in `skill/assets/skills/wrap.md` step 3 pointing at the README as the authority. Mirrored into this repo's `tickets/README.md` and `.claude/skills/wrap/SKILL.md`.

Does **not** touch: `/ticket` (a new ticket is always `open`), `/vet`, `SKILL.md`, any step label, the ROADMAP or CLAUDE.md templates. Does not add a `tickets/done/` archive — dropped this pass, logged to IMPROVEMENTS.md instead. Does not add the `## Waiting on` ROADMAP section; that is open ticket 004's job.

## Done looks like
Every status value in use across the 79 real tickets in RCRM, Trinity, DJCon and OuachitaTerminals maps to exactly one enum entry, with `closed` (Trinity/027) the single exception, migrated to `done`. The template names the six and says where a seventh goes.

Distributing it to the four already-installed READMEs is **not** in this ticket. Step 3b has no operation that reconciles a changed template section against an existing customized one — RCRM keeps its list under `## Frontmatter`, so a re-alignment run would most likely *add* `## Status` beside it and leave two vocabularies in one file. That gap is ticket 007.

## Boundary
Holds for a non-code repo — the enum lives in `tickets/README.md`, which only exists where tickets are the unit of work; `career-trajectory` (research file, no `tickets/`) is untouched. No step label changes and the wrap-residue contract (`ROADMAP.md ## Current goal` + `DECISIONS.md` tail) is not involved, so no scaffolded repo needs re-aligning for this.

Off-cycle: this matches none of ROADMAP.md's current focus items (scaffold a code project, the Step 2 scope fix, nested-workspace guidance). Taken deliberately as a small hygiene change, not an accident.

One scaffolded-repo edit is required and is ask-first: `Trinity/tickets/027-jsonld-escaping-probe.md`, `status: closed` → `status: done`.

Accepted limitation: the anti-drift rule is a convention, not a mechanical check. Nothing stops a seventh word; it depends on /wrap reading the README.

## Plan
Approved 2026-08-31.

1. `skill/assets/templates/tickets-README.md` — the enum as a closed list, one line per value, the actionable/not-actionable split, the anti-drift rule.
2. `skill/assets/skills/wrap.md` — one clause in step 3 naming the README as the authority. Label **3. Work status** stays verbatim.
3. Mirror into `tickets/README.md` and `.claude/skills/wrap/SKILL.md`.
4. Fix ticket 004's count: it says three of four repos hand-wrote `## Waiting on`; it is two (Trinity, OuachitaTerminals).
5. Log the dropped archive idea to IMPROVEMENTS.md with today's evidence.
6. Ask before the `Trinity/027` migration. Then /vet, then /wrap.

---
status: done
created: 2026-08-31
source: IMPROVEMENTS.md#handoff-ticket-relative-paths
---

# 009 — Ticket paths must be unambiguous across nested workspaces

## Job
A bare `../DECISIONS.md` in a ticket silently points at the wrong file. In a nested workspace the parent and the child each have a `DECISIONS.md` exactly one directory apart, so both resolutions hit a real file and neither is ever an error. The executing session resolves relative to the child folder; whoever reads or edits the ticket resolves relative to the ticket's own location (`child/tickets/`). Those differ by one level. Add a rule to the ticket template that any file a ticket cites is named unambiguously.

## Scope
`skill/assets/skills/ticket.md` — one rule under Rules. Does **not** touch SKILL.md (that's ticket 008), /vet, /wrap, the frontmatter fields, or any step label.

## Done looks like
A ticket citing a context file names it so that a fresh session executing the hand-off and a human reading the file resolve the *same* file — DJCon's proven fix is naming both in full (`Webflow/DECISIONS.md`, `DJCon/DECISIONS.md`). Re-reading the DJCon tickets against the rule flags 004 (still a bare `../DECISIONS.md`) and passes 005 and 003, which Logan corrected by hand on 2026-08-31 — the rule has to reproduce that fix without firing on it.

## Boundary
The rule is only load-bearing where workspaces nest, but it costs nothing in a standalone repo, so it stays core rather than becoming a nested-only clause.

**No migration needed — corrected 2026-08-31 after checking.** The 15 existing tickets carrying a bare `../` (Trinity 8, OuachitaTerminals 4, DJCon 3, RCRM 0) are *correct*: in that program `../DECISIONS.md` consistently means the parent, and all 16 references resolve there, verified by date and content against both logs. The convention is documented in each site's CLAUDE.md and DECISIONS.md, in all three installed /wrap and /ticket skills, and about 30 references outside `tickets/` depend on it — while `Webflow/CLAUDE.md` itself uses the full form, because it loads in every child session where `../` would be wrong. The one real violation was DJCon 005 using the string to mean the child; Logan fixed it, and 003, by hand.

So the rule is for *new* tickets, where no convention is established. Retrofitting a working documented one would churn 15 correct files and force ~30 more edits to keep the rest coherent.

Evidence is one occurrence, below the threshold of two, but it is a defect rather than a candidate: it misfired twice in a single session, a correction note nearly shipped against the wrong log, and the failure is silent by construction — no error, just a wrong file.

## Plan
Approved 2026-08-31.

1. `skill/assets/skills/ticket.md` — one rule under Rules: a file a ticket cites is named unambiguously, from the workspace root, and where a parent and child share a filename both are named in full. Never a bare `../`.
2. Deliberately **not** mirrored into `assets/templates/tickets-README.md` — one home for the rule.
3. Mirror into this repo's `.claude/skills/ticket/SKILL.md`, as ticket 006 did for the enum.
4. /vet, testing by re-reading DJCon 004 and 005 against the rule; both must flag.
5. Migrating the 15 affected tickets (Trinity 8, OuachitaTerminals 4, DJCon 3) is a **separate pass**, ask-first — live work in Logan's directories.

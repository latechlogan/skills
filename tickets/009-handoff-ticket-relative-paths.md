---
status: in-progress
created: 2026-08-31
source: IMPROVEMENTS.md#handoff-ticket-relative-paths
---

# 009 — Ticket paths must be unambiguous across nested workspaces

## Job
A bare `../DECISIONS.md` in a ticket silently points at the wrong file. In a nested workspace the parent and the child each have a `DECISIONS.md` exactly one directory apart, so both resolutions hit a real file and neither is ever an error. The executing session resolves relative to the child folder; whoever reads or edits the ticket resolves relative to the ticket's own location (`child/tickets/`). Those differ by one level. Add a rule to the ticket template that any file a ticket cites is named unambiguously.

## Scope
`skill/assets/skills/ticket.md` — one rule under Rules. Does **not** touch SKILL.md (that's ticket 008), /vet, /wrap, the frontmatter fields, or any step label.

## Done looks like
A ticket citing a context file names it so that a fresh session executing the hand-off and a human reading the file resolve the *same* file — DJCon's proven fix is naming both in full (`Webflow/DECISIONS.md`, `DJCon/DECISIONS.md`). Re-reading DJCon 004 and 005 against the rule flags both.

## Boundary
The rule is only load-bearing where workspaces nest, but it costs nothing in a standalone repo, so it stays core rather than becoming a nested-only clause.

Migration is the real cost and is **ask-first**: 15 existing tickets carry a bare `../` reference — Trinity 8, OuachitaTerminals 4, DJCon 3 (RCRM 0). They are live work in Logan's directories, so the plan should propose fixing them as a separate pass, not as part of the template change.

Evidence is one occurrence, below the threshold of two, but it is a defect rather than a candidate: it misfired twice in a single session, a correction note nearly shipped against the wrong log, and the failure is silent by construction — no error, just a wrong file.

## Plan
Approved 2026-08-31.

1. `skill/assets/skills/ticket.md` — one rule under Rules: a file a ticket cites is named unambiguously, from the workspace root, and where a parent and child share a filename both are named in full. Never a bare `../`.
2. Deliberately **not** mirrored into `assets/templates/tickets-README.md` — one home for the rule.
3. Mirror into this repo's `.claude/skills/ticket/SKILL.md`, as ticket 006 did for the enum.
4. /vet, testing by re-reading DJCon 004 and 005 against the rule; both must flag.
5. Migrating the 15 affected tickets (Trinity 8, OuachitaTerminals 4, DJCon 3) is a **separate pass**, ask-first — live work in Logan's directories.

---
status: deferred
created: 2026-08-31
source: IMPROVEMENTS.md#nested-workspaces
---

# 008 — SKILL.md guidance for workspaces that aren't standalone

## Job
SKILL.md assumes every workspace stands alone. Two shapes have now been scaffolded that don't, and both were improvised: a **parent over children** (`Webflow/` over four site workspaces, relying on Claude Code loading ancestor CLAUDE.md files parent-first) and a **sibling outside the tree** (`ats-sync`, deliberately placed where no ancestor CLAUDE.md loads but which still needs the program's shared rules). Write what SKILL.md should say about each.

## Scope
`skill/SKILL.md` — a section on non-standalone workspaces, reachable from Step 2 (detect the shape) and Step 3. Likely a line-budget note in `assets/templates/CLAUDE.md`.

Does **not** touch `/ticket` — the relative-path defect from the same IMPROVEMENTS heading is ticket 009. Does not touch /vet, /wrap, or any step label.

## Done looks like
Re-reading the section against both real cases reproduces what each session decided, without improvisation:

- **Parent:** CLAUDE.md held to ~35 lines rather than 60, because it loads in every child session; every path in it explicit, since each child has its own ROADMAP/REVIEW/DECISIONS; the unit of work lives in the children (hand-off tickets); one git repo for the tree, not nested repos.
- **Sibling:** no ancestor CLAUDE.md loads, so every shared rule is an explicit pointer to the other workspace, and workspace-generic learnings need a /wrap step that routes them back ("Owed to Webflow/"). Step 2 should say to read a sibling workspace's conventions before scaffolding — here they were the main input.

A third nested repo scaffolds from the section rather than from a prior repo's example.

## Boundary
Holds for non-code repos — both occurrences are. No step label changes and the wrap-residue contract is untouched.

Interacts with REVIEW.md's "does CLAUDE.md's template still land under 60 lines when filled?" check, which has no notion of a stricter parent budget; that check needs a nested-case clause or the two rules contradict.

**Evidence is thinner than it looks.** This ticket has two occurrences, not the three the IMPROVEMENTS heading showed — the third was the ticket-009 defect filed under the same heading. ROADMAP focus item 4 sets "three instances before abstracting" for exactly this work. Opened at two on Logan's call, then **deferred 2026-08-31**: hold until a third nested workspace is scaffolded. Two shapes (parent-over-children, sibling-outside-the-tree) are two data points that already disagree with each other; a third would say more about what generalizes than any amount of reasoning from these two.

**Resume when:** a third non-standalone workspace is scaffolded — then this ticket goes to `open` and the plan is written against all three.

## Plan
[Empty until approved.]

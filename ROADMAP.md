# Roadmap

Last updated: 2026-09-02 <!-- /wrap refreshes this; if this date is more than ~2 weeks old, treat the goal as suspect and ask before optimizing for it -->

## Current goal
Make the core a data contract that workspaces can rely on. Success is one workspace's session acting on another workspace's state — current goal, recent learnings, open work — using only the core section of SKILL.md, without reading the other workspace's CLAUDE.md or skill bodies. The scaffold owns the shape and audits conformance; behavior is each project's own.

## This cycle's focus
1. ~~**Ticket 010 — the core as a data contract.**~~ Done 2026-09-01. Both tests passed: RCRM audit proposed zero operations; a reader with only the core section got Trinity's goal, last three learnings, and 26 open tickets by kind right. Three spec gaps the read exposed (unit-of-work discovery, ticket H1, which statuses need attention) were closed the same day.
2. **Step 2 scope-gathering fix** — ticket 005, **in-progress** 2026-09-02. The paragraph is written and vetted: Step 2 gains "when the repo isn't the product, probe the product first," stated as a predicate with the site probe as one parenthetical example, plus a guarded look-back bullet in Step 3b. Retrodiction reaches all nine findings across DJCon, Trinity and OuachitaTerminals. Not done: the ticket's first success condition is a *greenfield* run on an ops repo, and existing-workspace mode runs Step 2 abbreviated, so a re-align run tests this weakly. Closes on the next ops-repo scaffold.
3. **Follow-ups named by ticket 010.** The **evidence ledger** was examined 2026-09-02 and declined as a core file: ticket 010's "nowhere for results" was overstated — DECISIONS.md `[learning]` lines already carry results — and the two candidate artifacts are different things (Trinity's `WORK-LOG.md` is stakeholder reporting, one project's behavior; ticket 010's improvised `### Test results` heading is close-out verification). **Ticket 011** takes the narrower half: an `## Outcome` section in the ticket template, open, plan not yet approved. The **cross-workspace toolkit** (current goals, open tickets by kind, recent learnings) is still uncreated and parked — it is the first real consumer of the data contract.
4. **Nested-workspace guidance** — ticket 008, **deferred** until a third non-standalone workspace exists. Less pressing under a data contract: a nested child conforms to the same shape, and the parent's pointers are behavior.

Superseded 2026-09-01: "prove the minimal core on a real code project, with a Stop hook that blocks." Hooks were already per project; proving them proves a behavior, not the core. Ticket 007 (a merge operation for Step 3b) dropped with the merge machinery.

Done before this cycle: first look-back (RCRM, 4 evidence-backed findings); retro loop's first real use; ticket 006, the status enum; ticket 009, unambiguous ticket paths; this repo took ticket 002's Commit step.

## Explicitly out of scope
- Multi-user / team features (shared managed settings, org-wide policy distribution). This is a solo-developer scaffold.
- Routines and scheduled agents as part of the core. Suggested only when a project has real inputs.
- Tiers, project-type templates, or any per-project-type fork of the core. The core is the core; everything else is decided per project.
- The skill editing its own templates.
- Propagating behavior between workspaces — skill bodies, hooks, ticket conventions. The scaffold audits shape; a project that wants another project's behavior copies it deliberately.

## Definition of done for this cycle
Ticket 010 is closed (done 2026-09-01). Ticket 005 has a plan or a logged decline — **met 2026-09-02**, plan approved and implemented. Remaining: the two IMPROVEMENTS.md headings at threshold with no ticket — `mechanical-check-without-hook-event` and `hand-off-ticket-across-folders` (two occurrences each) — have a ticket or a logged decline.

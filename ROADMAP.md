# Roadmap

Last updated: 2026-09-11 <!-- /wrap refreshes this; if this date is more than ~2 weeks old, treat the goal as suspect and ask before optimizing for it -->

## Current goal
Stable. The shape is proven — three repos audit with zero operations — and the read path is proven: in career-trajectory on 2026-09-02, a session opened with the goal and DECISIONS tail in context before its first tool call, and a printed learning visibly shaped its output. The scaffold changes for defects only, when Logan decides by looking at repos. Success is that nothing needs to happen here; a stale date on this file means "check that's still true," not "find work."

## This cycle's focus
Nothing active. Residual items, each on its own trigger:
1. **Hook and opening line in the other repos** — done 2026-09-03: Webflow tree (parent + four sites) and ats-sync, applied as one approved batch pass driven from a session here — Logan's call, reversing this item's "never as a pass from here." career-trajectory had both since 09-02. Every scaffolded repo now carries the read path; /ticket Context + plan-at-creation went with it.
2. **Ticket 005** closes on the next greenfield ops-repo scaffold.
3. **Ticket 008** stays deferred until a third non-standalone workspace exists.
4. **The cross-workspace toolkit** — resolved 2026-09-11, not built here. It lands as a read-only script in `~/notes` (`bin/repos`, plan in ticket 014) that walks each repo's goal, open work by status, and last commit. The notes repo is the consumer, so the reader lives there; the scaffold changes nothing. First real use of the shape as a data contract across repos.

## Explicitly out of scope
- Multi-user / team features. This is a solo-developer scaffold.
- Routines and scheduled agents as part of the shape. Suggested only when a project has real inputs.
- Tiers, project-type templates, or any per-project-type fork of the shape.
- The skill editing its own templates, or collecting findings from the repos it scaffolds.
- Propagating behavior between workspaces — skill bodies, hooks, ticket conventions. A project that wants another project's behavior copies it deliberately.
- Improvements. Defects only: shipped instructions that contradict reality or leave a session improvising.
- A standing "take initiative" instruction in the shape. Initiative is a mode a repo invokes (a `/next` skill, a routine) — per project.

## Definition of done for this cycle
Met 2026-09-02. There is no next cycle until a defect or a decision opens one.

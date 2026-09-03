# Roadmap

Last updated: 2026-09-02 <!-- /wrap refreshes this; if this date is more than ~2 weeks old, treat the goal as suspect and ask before optimizing for it -->

## Current goal
The shape is stable and the scaffold is hands-off; it changes only for defects, and only when Logan decides by looking at repos. The open question is whether the read path — a session loading the goal and the DECISIONS tail at start — actually changes what a session *does*. Success is one real repo where, after adopting the new CLAUDE.md opening line or the SessionStart hook, a session opens with the previous session's context and acts on it unprompted: picks up parked work, or connects a goal to something it can recommend.

## This cycle's focus
1. **Adopt the read path in one real repo.** career-trajectory already carries a local version of the opening line; the SessionStart hook has never been installed anywhere. Install it in one repo (career-trajectory or an ops repo), run a fresh session, and record in that repo's DECISIONS.md whether the session started with context. That is the test the 2026-09-02 pivot rests on.
2. **Ticket 005 closes on the next ops-repo scaffold** — the probe paragraph is written; it needs a greenfield run to prove.
3. **Existing repos and the new templates.** Nothing is owed: the shape didn't change, so 3b proposes nothing. The new opening line, the `## Context` ticket section, and the trimmed REVIEW.md reach existing repos only if adopted deliberately. Do it repo by repo when a session is there anyway, not as a pass from here.

Deferred: ticket 008 (nested-workspace guidance) until a third non-standalone workspace exists. The cross-workspace toolkit stays parked until the within-repo read path is proven — it's the same idea, one level up.

## Explicitly out of scope
- Multi-user / team features. This is a solo-developer scaffold.
- Routines and scheduled agents as part of the shape. Suggested only when a project has real inputs.
- Tiers, project-type templates, or any per-project-type fork of the shape.
- The skill editing its own templates, or collecting findings from the repos it scaffolds.
- Propagating behavior between workspaces — skill bodies, hooks, ticket conventions. A project that wants another project's behavior copies it deliberately.
- Improvements. The scaffold is frozen to defects: shipped instructions that contradict reality or leave a session improvising.

## Definition of done for this cycle
One repo has the SessionStart hook installed and a DECISIONS.md `[learning]` line saying what the first session after it did differently, or that it did nothing differently. Either answer closes the cycle.

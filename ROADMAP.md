# Roadmap

Last updated: 2026-08-31 <!-- /wrap refreshes this; if this date is more than ~2 weeks old, treat the goal as suspect and ask before optimizing for it -->

## Current goal
Prove the minimal core on a real code project. The scaffold has only ever run on markdown-only and ops repos; hooks and a Stop hook that actually blocks have never fired on a repo with a build. Success is one code project scaffolded end to end and a Stop hook blocking a bad finish at least once.

## This cycle's focus
1. **Scaffold the next code project** greenfield — a site or app with a formatter and a test/typecheck command — and install the standard two hooks for real.
2. ~~Decide the two headings at threshold~~ — done 2026-08-27 via tickets/002 (Commit step in /wrap) and tickets/003 (`kind:` + triage rule). career-trajectory and chief-of-staff get the Commit merge on their next existing-workspace run.
3. **Step 2 scope-gathering fix** — "when the repo isn't the product, inspect the product" (`scope-gathering-reads-docs-not-product`, now three occurrences — DJCon, Trinity, OuachitaTerminals — and ticket 005 is open).
4. **Nested-workspace guidance** — ticket 008, **deferred** until a third non-standalone workspace exists. At two instances (`Webflow/` parent-over-children, `ats-sync` sibling-outside-the-tree), not the three the IMPROVEMENTS heading appeared to show — the third occurrence was a separate defect, now ticket 009. The "three instances before abstracting" rule stands.

Done this cycle: first look-back (RCRM, 4 evidence-backed findings, not noise); retro loop's first real use (two sessions, six honest lines, no padding — the wording holds); ticket 006, the status enum (off-cycle hygiene — the template's four values were behind the four Webflow repos' six; ats-sync had inherited the stale four); ticket 009, unambiguous ticket paths.

## Explicitly out of scope
- Multi-user / team features (shared managed settings, org-wide policy distribution). This is a solo-developer scaffold.
- Routines and scheduled agents as part of the core. Suggested only when a project has real inputs.
- Tiers, project-type templates, or any per-project-type fork of the core. The core is the core; everything else is decided per project.
- The skill editing its own templates.

## Definition of done for this cycle
One real code repo carries the full core plus tickets and hooks, a Stop hook has blocked at least once, and both threshold headings have a ticket or a logged decline.

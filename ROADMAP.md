# Roadmap

Last updated: 2026-11-04 <!-- /wrap refreshes this; if this date is more than ~2 weeks old, treat the goal as suspect and ask before optimizing for it -->

## Current goal
One repo holds all of Logan's skills, and adding a skill is a new folder plus a symlink, nothing more. Consolidation landed 2026-11-04. workspace-scaffold and project-kickoff came in with full history, and the symlinks point here. The next skill is the first one to start in this repo, and it's the test of whether "new folder plus symlink" is really all it takes. workspace-scaffold stays stable: it changes for defects only, when Logan decides by looking at repos. A stale date on this file means "check that's still true," not "find work."

## This cycle's focus
1. **The next skill.** Logan has one in mind. Start it as `<name>/` with a ticket, symlink it, and log anything the repo's shape made awkward.
2. **workspace-scaffold ticket 005** closes on the next greenfield ops-repo scaffold.
3. **workspace-scaffold ticket 008** stays deferred until a third non-standalone workspace exists.

Done items from before the consolidation (the hook and opening line rollout, the cross-workspace toolkit in `~/notes`, ticket 015) are in DECISIONS.md and git history.

## Explicitly out of scope
- A plugin marketplace (`.claude-plugin/marketplace.json`) or any packaging or release layer. Add one only when someone other than Logan needs to install these skills.
- Shared code or files between skill folders. Each folder stands alone.
- Multi-user or team features. These are solo-developer skills.
- For workspace-scaffold specifically:
  - Routines and scheduled agents as part of the shape. Suggested only when a project has real inputs.
  - Tiers, project-type templates, or any per-project-type fork of the shape.
  - The skill editing its own templates, or collecting findings from the repos it scaffolds.
  - Propagating behavior between workspaces: skill bodies, hooks, ticket conventions. A project that wants another project's behavior copies it deliberately.
  - Improvements. Defects only: shipped instructions that contradict reality or leave a session improvising.
  - A standing "take initiative" instruction in the shape. Initiative is a mode a repo invokes (a `/next` skill, a routine), per project.

## Definition of done for this cycle
The next skill exists as a folder here, is symlinked and loading in sessions, and went through /ticket → /vet → /wrap without a change to this repo's workspace files beyond its own entries.

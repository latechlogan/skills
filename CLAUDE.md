# skills

Source repo for Logan's Claude Code skills. One folder per skill, each symlinked into `~/.claude/skills/`, so edits here are live in every session immediately.
For: Logan alone.

Read ROADMAP.md for what matters right now. Read REVIEW.md before declaring work done. Check DECISIONS.md before changing anything that looks odd — most choices have a logged reason. Entries before 2026-11-04 are all about workspace-scaffold; this repo was that skill's repo until then.

## Commands
No build, test, or lint — this repo is markdown and JSON.
- `/ticket` — write a ticket before changing a skill
- `/vet` — check a change against REVIEW.md
- `/wrap` — close a session

## Where things live
- `<skill-name>/` — one skill, exactly what gets installed: `SKILL.md` plus whatever it loads (`assets/`, `references/`). Nothing else goes in a skill folder.
- `workspace-scaffold/` — the shared repo shape. `SKILL.md`'s "core" section is the data contract every scaffolded repo keeps; `assets/templates/` has one template per core file, `assets/skills/` has /ticket, /vet, /wrap as installed into projects.
- `project-kickoff/` — plans a new project, then hands off to workspace-scaffold (Phase 7 of its `SKILL.md`).
- `tickets/` — this repo's unit of work, one numbered sequence for all skills.
- `.claude/skills/` — this repo's own /ticket, /vet, /wrap.
- README.md — the symlink setup and how to add a skill.

## Working style
- A change to a skill starts as a ticket (/ticket) with its plan written in; wait for approval before editing. Typos and wording fixes don't need one.
- A skill never reaches into another skill's folder. One skill can name another and hand off to it, the way project-kickoff invokes workspace-scaffold, but it doesn't load the other skill's files. That keeps each folder movable on its own.
- A change to one side of the kickoff → scaffold hand-off checks the other side in the same ticket.
- Every workspace-scaffold template change asks: does this hold for a non-code repo? Is it shape (data another workspace reads) or behavior (one project's business, not the core's)? Does it break the wrap-residue contract (ROADMAP.md `## Current goal` + DECISIONS.md tail)?
- Test on a real repo, not in the abstract. Scaffolded repos are workspace-scaffold's test suite; a real kickoff conversation is project-kickoff's.
- Run /vet before calling anything done; /wrap at the end of a session.

## Permissions
- Free: read anything, edit files here, propose plans, append to DECISIONS.md.
- Ask first: renaming a skill or a scaffold core file (it cascades to every symlink and scaffolded repo), changing the wrap-residue contract, deleting a template, editing any scaffolded repo from here.
- Human-owned: deciding what enters the scaffold's shape. The skill never edits its own templates, and it does not collect findings from the repos it scaffolds — the shape changes when Logan decides it should, by looking at repos.

## Learnings
When something surprising happens or a choice forecloses alternatives, append one dated line to DECISIONS.md.

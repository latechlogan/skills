# workspace-scaffold

Source repo for the `workspace-scaffold` Claude Code skill: the files a Claude Code session needs so it never starts green (CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, /vet, /wrap), in one shape every one of Logan's repos shares. The shape is a data contract — files, sections, log-line grammar — so any workspace can read another's state; everything about how a repo behaves is that repo's own.
For: Logan alone. Consistency across repos is for him — no context-switching — not for Claude.

Read ROADMAP.md for what matters right now. Read REVIEW.md before declaring work done. Check DECISIONS.md before changing anything that looks odd — most template choices have a logged reason.

## Commands
No build, test, or lint — this repo is markdown and JSON.
- `/ticket` — write a ticket before changing a template or the skill
- `/vet` — check a change against REVIEW.md
- `/wrap` — close a session

## Where things live
- `skill/` — the skill itself. `~/.claude/skills/workspace-scaffold` is a symlink to this directory, so edits are live in every session immediately. See README.md.
- `skill/SKILL.md` — the spec and both entry paths (greenfield, existing workspace). The "core" section is the data contract every scaffolded repo keeps.
- `skill/assets/templates/` — one template per core file. `skill/assets/skills/` — /ticket, /vet, /wrap as installed into projects.
- `tickets/` — this repo's unit of work.

## Working style
- A change to a template, a skill, or SKILL.md starts as a ticket (/ticket) with its plan written in; wait for approval before editing. Typos and wording fixes don't need one.
- Every template change asks: does this hold for a non-code repo? Is it shape (data another workspace reads) or behavior (one project's business, not the core's)? Does it break the wrap-residue contract (ROADMAP.md `## Current goal` + DECISIONS.md tail)?
- Test on a real repo, not in the abstract. The scaffolded repos are the test suite; run existing-workspace mode on one before calling a template change done.
- Run /vet before calling anything done; /wrap at the end of a session.

## Permissions
- Free: read anything, edit files here, propose plans, append to DECISIONS.md.
- Ask first: renaming a core file or skill (it cascades to every scaffolded repo), changing the wrap-residue contract, deleting a template, editing any scaffolded repo from here.
- Human-owned: deciding what enters the shape. The skill never edits its own templates, and it does not collect findings from the repos it scaffolds — the shape changes when Logan decides it should, by looking at repos.

## Learnings
When something surprising happens or a choice forecloses alternatives, append one dated line to DECISIONS.md.

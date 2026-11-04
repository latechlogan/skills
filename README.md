# skills

Logan's Claude Code skills, one folder per skill.

| Skill | What it does |
| --- | --- |
| `project-kickoff/` | Plans a new project before any code exists: brief, stack, data model, architecture, trust layer, delivery. It runs as a gated, resumable conversation, leaves the plan in the project's `docs/`, then hands off to workspace-scaffold. |
| `workspace-scaffold/` | Gives a repo the files a Claude Code session needs so it never starts green (`CLAUDE.md`, `ROADMAP.md`, `REVIEW.md`, `DECISIONS.md`, `/vet`, `/wrap`) in one shape every repo shares. See `workspace-scaffold/SKILL.md` for the spec. |

This repo is itself a scaffolded workspace. Changes to any skill go through its own `/ticket` → `/vet` → `/wrap`.

## Symlink setup

This repo is the source of truth. Each entry in `~/.claude/skills/` is a symlink to a skill folder here, so edits are live in every session with no install step:

```
~/.claude/skills/project-kickoff    -> ~/repos/skills/project-kickoff
~/.claude/skills/workspace-scaffold -> ~/repos/skills/workspace-scaffold
```

On a new machine, or after adding a skill:

```sh
git clone git@github.com:latechlogan/skills.git ~/repos/skills
for d in ~/repos/skills/*/; do [ -f "$d/SKILL.md" ] && ln -sfn "${d%/}" ~/.claude/skills/"$(basename "$d")"; done
```

## Layout

```
CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md   # this repo's own core
tickets/                                          # one ticket sequence for all skills
.claude/skills/{ticket,vet,wrap}/                 # this repo's own skills
project-kickoff/
├── SKILL.md                    # principles, phases, hand-off to the scaffold
├── references/                 # stack familiarity, code quality gates; consulted mid-phase
└── assets/                     # templates the phases write into a project's docs/ and .claude/agents/
workspace-scaffold/
├── SKILL.md                    # the spec, greenfield path, existing-workspace path
└── assets/
    ├── skills/                 # /ticket, /vet, /wrap as installed into projects
    └── templates/              # CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, tickets-README.md, hooks-example.json
```

A skill folder holds only what gets installed. Workspace files live at the root.

## History

Both skills had their own repos until 2026-11-04 (`latechlogan/project-kickoff`, `latechlogan/workspace-scaffold`, now archived). Their full commit histories were merged in here, so `git log --follow <skill>/SKILL.md` reaches back past the move.

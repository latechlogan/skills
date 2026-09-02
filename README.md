# workspace-scaffold

Source repo for the `workspace-scaffold` Claude Code skill. A minimal, consistent core for every project — `CLAUDE.md`, `ROADMAP.md`, `REVIEW.md`, `DECISIONS.md`, `/vet`, `/wrap` — with the unit of work, hooks, and extra skills decided per project. See `skill/SKILL.md` for the spec.

This repo is itself a scaffolded workspace: it has the same four files and skills, and improvements to the skill go through its own `/ticket` → `/vet` → `/wrap`.

## Symlink setup

This repo is the source of truth for the skill. `~/.claude/skills/workspace-scaffold`
is a **symlink pointing at `skill/` in this repo** — not the other way around:

```
~/.claude/skills/workspace-scaffold -> /Users/loganbaugh/repos/workspace-scaffold/skill
```

Because it's a symlink to the whole directory, edits made here are live immediately
in every Claude Code session — no copy or install step.

To recreate the link on a new machine:

```sh
ln -s "$PWD/skill" ~/.claude/skills/workspace-scaffold
```

## Layout

```
CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md   # this repo's own core
IMPROVEMENTS.md                                   # candidates the skill logs after each run; 2 occurrences → ticket
tickets/                                          # this repo's unit of work
.claude/skills/{ticket,vet,wrap}/                 # this repo's own skills
skill/
├── SKILL.md                    # the spec, greenfield path, existing-workspace path, retro
└── assets/
    ├── skills/                 # /ticket, /vet, /wrap as installed into projects
    └── templates/              # CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, tickets-README.md, hooks-example.json
```

## Re-aligning an existing workspace

Run the skill in any repo that already has a `CLAUDE.md`. It audits structure against the core and usage against reality, proposes only additive operations (add / rename / migrate), and never regenerates `REVIEW.md`, rewrites `CLAUDE.md` prose, or touches a `DECISIONS.md` entry.

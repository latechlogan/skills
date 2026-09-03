# workspace-scaffold

Source repo for the `workspace-scaffold` Claude Code skill. It gives a repo the files a Claude Code session needs so it never starts green — `CLAUDE.md`, `ROADMAP.md`, `REVIEW.md`, `DECISIONS.md`, `/vet`, `/wrap` — in one shape every repo shares, with the unit of work, hooks, and everything else decided per project. See `skill/SKILL.md` for the spec.

This repo is itself a scaffolded workspace: it has the same four files and skills, and changes to the skill go through its own `/ticket` → `/vet` → `/wrap`.

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
tickets/                                          # this repo's unit of work
.claude/skills/{ticket,vet,wrap}/                 # this repo's own skills
skill/
├── SKILL.md                    # the spec, greenfield path, existing-workspace path
└── assets/
    ├── skills/                 # /ticket, /vet, /wrap as installed into projects
    └── templates/              # CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, tickets-README.md, hooks-example.json
```

## Re-aligning an existing workspace

Run the skill in any repo that already has a `CLAUDE.md`. It audits the repo's structure against the shape, proposes only additive operations (add / rename / migrate), and never regenerates `REVIEW.md`, rewrites `CLAUDE.md` prose, or touches a `DECISIONS.md` entry. It does not read skill bodies and does not carry findings back here.

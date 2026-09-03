---
name: workspace-scaffold
description: Give a repo the files a Claude Code session needs so it never starts green — the current goal, what was decided and learned, the bar work must clear, and a place to park work for later — in one shape every repo shares, so any session can read any repo's state. CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, /vet and /wrap; the unit of work, hooks, and everything else decided per project. Use whenever the user starts a new project or repo, says "set up this repo/project/workspace," asks to scaffold or structure a project for Claude Code, drops into a codebase with no CLAUDE.md, or asks to re-run, upgrade, or re-align an existing workspace to the current scaffold.
---

# Workspace Scaffold

A session in a repo should never start green. It should know the current goal, what earlier sessions decided and learned, the bar the work has to clear, and what was parked for later — without the user re-explaining any of it. This skill gives a repo the files that hold that context and the one habit (`/wrap`) that keeps them true, so the context is in the repo rather than in anyone's memory.

Every project gets the **same minimal shape** — four files, two skill names, one line grammar — so a session in one repo can read another repo's state and know what it will find. The shape is the whole of what's shared. How a repo behaves — its unit of work, its hooks, what its skills do, what it's for — is decided per project, once, and logged. Consistency is for the human; Claude reads each repo fresh and only needs the content to be right.

Four principles govern every decision below:

1. **Structure is the scaffold's; content and behavior are the project's.** The core file set, skill names, section skeleton, and line grammar are fixed. Everything inside them is written for this specific project and is never regenerated once it exists.
2. **Mechanical vs. judgment.** Anything a machine can verify (format, lint, types, tests, build) goes in hooks — deterministic, runs every time. REVIEW.md holds only judgment calls. Never duplicate a hook check inside REVIEW.md. One exception: a mechanical check whose trigger isn't something Claude does in-session (a live site after a publish, an export after a manual run) has no hook event to fire on — it becomes a script that `/vet` runs first, before the judgment pass.
3. **Self-maintaining.** Stale context is worse than none, because Claude optimizes for a stale goal confidently. Maintenance is baked into the loop (DECISIONS.md, roadmap freshness in /wrap) rather than left to memory.
4. **Never leave homework.** Replace every `{{PLACEHOLDER}}`, delete every section that doesn't apply. A half-filled template is worse than no template.

## The core (every project)

The core is a **data contract, not a behavior contract**. What every scaffolded workspace shares is the shape of its data — which files exist, which sections they carry, and the line grammar inside them — so that a session in one workspace can read another's state without knowing how that workspace works. How a workspace behaves (what its skills do between start and residue, its hooks, its unit of work, how it finds and makes its own improvements) is decided per project and is nobody else's business. Greenfield builds the shape; existing-workspace mode audits conformance to it and nothing else.

**The residue (why the core exists):** at any moment a workspace's state is `ROADMAP.md`'s `## Current goal` plus the most recent dated lines in `DECISIONS.md`. Every `/wrap` leaves those two current — that is the contract's write path. The read path is that every session in the workspace loads both *at start*, before doing anything, and other workspaces and tools read exactly these; CLAUDE.md's opening lines say so, and a project can add a `SessionStart` hook that prints them (Step 4). Don't move the goal anywhere else.

The shape:

- `CLAUDE.md` — under 60 lines. Sections: intro line(s), `## Commands`, `## Working style`, `## Permissions`, `## Stakeholders` only if someone other than the user owns the project, and `## Learnings` last. Project-specific sections (e.g. "Where things live", "Rules that must not bend") go between Commands and Working style. That order is the greenfield default; the audit checks that the sections exist, not where they sit. This file *is* the workspace's behavior; an outside reader needs only its "where things live" pointers.
- `ROADMAP.md` — `## Current goal`, `## This cycle's focus`, `## Explicitly out of scope`, `## Definition of done for this cycle`. How much each section carries is the project's call; the sections exist.
- `REVIEW.md` — judgment checks only, sorted into must fix / should fix / fine as is. A workspace handing work in reads this as the bar it must clear.
- `DECISIONS.md` — append-only dated log, one line per entry: `- YYYY-MM-DD — [decision|learning] entry`. **Never rewrite or reorder existing entries.** The `[learning]` lines are the workspace's raw material for its own improvements; a project needs no separate improvements file.
- **Unit of work** — per project (below). An outside reader discovers it by the presence of `tickets/`; if there is none, the project's CLAUDE.md names it. When it is tickets, every ticket is `tickets/NNN-slug.md` with an H1 of `# NNN — title`, and its frontmatter carries at least `status`, `kind`, and `created`; further fields are the project's. `status` is one of the six in `tickets/README.md`, and `open`, `in-progress`, and `blocked` are the three that still need attention.
- `/vet` and `/wrap` (`.claude/skills/<name>/SKILL.md`) — the names and the residue are the contract; the bodies are the project's. `/vet` applies REVIEW.md to the current work. `/wrap` closes a session and leaves `## Current goal` current and DECISIONS.md appended. `assets/skills/` holds reference implementations for greenfield, not bodies to keep in sync.

Uppercase names so the four files cluster with CLAUDE.md and README.md at the top of a listing — "about the repo, not part of the product."

Everything above was already true of every scaffolded workspace before it was written down; the spec records what they converged on. A change to the shape is rare and goes through the scaffold repo's tickets. A behavior one project adds — a /wrap step, a ticket field, a script — is that project's decision, logged in its own DECISIONS.md. It becomes a scaffold finding only if it is *data another workspace would need to read*.

## Decided per project

Each of these is a fact about the repo, not a tier. Decide once during scaffolding, and log the decision in DECISIONS.md so it isn't re-litigated every session.

- **Unit of work.** Every project has one; /vet reviews against it and /wrap updates its status. The question is the *shape of the work*, not whether there's code. **Discrete deliverables with an observable finish line** — a feature, a fix, a page change, a site defect — get the ticket: `tickets/NNN-slug.md` written by `/ticket` (`assets/skills/ticket.md`), holding job, scope, done-looks-like, boundary, and the approved plan. Written scope before the change; you'd want a stated reason to skip it. (A Webflow ops repo with no code and 32 tickets is the canonical yes.) **Exploratory or continuous work** — research, drafting, a context store — names its own unit: a dated research file, a proposal, a draft. CLAUDE.md's Working style says what it is. Don't install /ticket where the project already has a natural unit; that's a redundant artifact.
- **Hooks.** If the repo has a formatter, a PostToolUse hook on Edit|Write runs it. If it has a test/typecheck/build command, a Stop hook runs it. Neither → install nothing, log it.
- **Extra skills and sections.** Whatever the project needs (a `/brief`, a "Rules that must not bend" section). Freely added; never part of the core.

## Step 1: Detect mode

- **No `CLAUDE.md`** → greenfield. Steps 2, 3a, 4, 5, 6.
- **`CLAUDE.md` exists** → existing workspace. Steps 2 (abbreviated), 3b, 4, 5, 6. Covers both a repo scaffolded by an earlier version of this skill and a brownfield repo with its own CLAUDE.md: audit against the core, add what's missing, keep what's there.

## Step 2: Gather scope

Extract what you can from the conversation and the repo before asking anything: language/framework, tests, build step, formatter, deploy signs, existing README or docs. Every question you can answer by looking is one you don't ask.

**When the repo isn't the product, probe the product first.** For a code repo the repo *is* the product and this is a no-op — skip it. When the repo is a few markdown files describing something that lives elsewhere, inspect that thing before asking anything, and treat every claim the existing docs make about it as unverified until the probe agrees. Two moves: get the product's own state from the authoritative source (for a site: last-published date, live domains, `curl` of the key pages counting whatever that project actually tracks, a sweep for old branding or placeholder text, robots/sitemap, whether analytics exists), then reconcile the two in both directions — every claim the docs make about the product, and everything the product shows that no doc mentions. The specific probe is the project's; the discipline is that a doc's claim is a hypothesis. Carry what it finds into Step 3a as dated `[learning]` lines in DECISIONS.md, and write ROADMAP.md's goal from the probe rather than from the docs.

Then ask what remains open, in one batch, conversationally:

- **What is this?** One sentence. (CLAUDE.md's first line.)
- **Who is it for?** A customer, an internal stakeholder, just the user? (Intro line; REVIEW.md's language section.)
- **What does done look like right now?** The current goal and what's out of scope. (ROADMAP.md.)
- **Does anyone else own this?** A client, a boss. If yes: who approves what, what never ships without sign-off. (Stakeholders section.)
- **What's the unit of work?** Is the work a series of discrete deliverables with a checkable finish line (→ tickets), or exploratory/continuous (→ ask what a finished piece looks like and name that)? Code is not the deciding factor.
- **What inputs flow in?** Only matters for Step 5.
- **Brownfield:** commands that build/test/lint/format it; conventions the code follows that aren't written down.

For an existing workspace, most of this is already in the files. Read them; ask only about what's genuinely unclear.

## Step 3a: Scaffold (greenfield)

Templates live in `assets/templates/`. Read each one, then write the project's files fully customized from Step 2 — every placeholder replaced, every inapplicable section deleted.

- **CLAUDE.md stays lean.** It loads every session. Short rules and commands here; anything longer becomes a file CLAUDE.md points to with a one-line note on when to read it.
- **REVIEW.md holds judgment only.** Before writing any check, ask: could a hook verify this? If yes, it's a hook. Items read like questions a thoughtful reviewer asks, not a CI config in prose. The project-specific sections are usually the most valuable part; the template's generic sections get deleted when they have nothing to say.
- **DECISIONS.md starts nearly empty and grows.** Seed it with what this conversation learned, plus the per-project decisions (unit of work, hooks or not).
- **Brownfield: document, don't impose.** CLAUDE.md describes the code as it is, flagging inconsistencies rather than silently fixing them.
- **Brownfield with an existing work queue.** A repo often arrives with a loose action list — a backlog, a launch checklist, a prompt someone wrote to execute. Dissolve it into the shape rather than keeping it beside it: items → the unit of work, grouped by finish line (nice-to-haves stay a plain list in ROADMAP.md, not tickets yet); gotchas and things already tried → DECISIONS.md; must-not-break rules → CLAUDE.md; anything blocked on a person → ROADMAP.md (a "Waiting on" section if the project wants one); a hand-run verify block → a script `/vet` runs first. Then delete the source file and log the dissolution as one `[decision]` line.

## Step 3b: Audit and align (existing workspace)

Read everything that exists: CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, `.claude/skills/*`, `.claude/settings.json`. Two audits:

**Structure** — compare against the shape. Every gap maps to exactly one operation:

| Operation | When | Rule |
|---|---|---|
| **add** | A core file, section, or skill is missing | Write it from the template, customized from what the existing files already say about the project. |
| **rename** | A core skill exists under a different name, or a core file is lowercase | Rename, keep the body, update every reference in CLAUDE.md, skills, and living docs. Leave historical DECISIONS.md entries as written. |
| **migrate** | Content lives in the wrong place (e.g. the goal is a line in CLAUDE.md) | Move it, then update whatever pointed at the old location. |

Skill bodies are not audited. A `/wrap` that grew Facts and Commit steps, a `/vet` that runs a script first — that is the project's behavior, and the audit doesn't look at it. The only questions about a skill are whether it exists under the core name and whether its residue lands where the shape says.

**Fit** — two things worth telling the user, not fixing: a ROADMAP.md date more than a month stale while commits continued means the roadmap isn't earning its place or `/wrap` isn't being run; an empty `tickets/` after real work means tickets don't fit here. Either is the project's call.

**Never:** regenerate REVIEW.md, rewrite CLAUDE.md prose, or touch an existing DECISIONS.md entry. That content is the project's accumulated judgment and is the most valuable thing in the repo.

Show the plan as a short list — one line per operation — and **wait for approval before applying**. Then apply, and append one dated `[decision]` line to DECISIONS.md naming what changed. If the audit finds nothing to do, say so in one line and stop.

## Step 4: Skills and hooks

**Skills.** Copy `vet.md` and `wrap.md` (and `ticket.md` if tickets are the unit of work) from `assets/skills/` to `.claude/skills/<name>/SKILL.md` and adapt each to the project — what to adapt is marked in the file. `/wrap`'s **Commit** step is dropped only when the repo isn't git-tracked — log that in DECISIONS.md, and suggest `git init`. In existing-workspace mode, add a missing skill; never rewrite one that exists.

**Hooks.** Propose them and **ask before writing `.claude/settings.json`** — hooks execute shell commands, and that's the user's call. `assets/templates/hooks-example.json` has the current shape; the essentials:

- PostToolUse hooks receive JSON on stdin; the edited file is `.tool_input.file_path`.
- A Stop hook only blocks Claude from finishing if it exits with code 2 — a test command needs `|| exit 2` to enforce anything.
- If the test suite is slow, put typecheck/lint on Stop and leave the full suite to /vet.
- A `SessionStart` hook that prints `## Current goal` and the last few DECISIONS.md lines is the mechanical form of the read path — offer it to every project; it has no failure mode and costs nothing.
- A mechanical check with no in-session trigger (principle 2's exception) is not a hook. It's a script; `/vet` runs it first.

## Step 5: Suggest routines (only with real inputs)

Recurring background work is the layer most often set up prematurely. Only suggest a routine when Step 2 confirmed an input stream exists. Safest first: a read-only **morning brief** over the input folders; a read-only **weekly review** of open issues/tickets; a **PR review** against REVIEW.md. Name the exact input paths. If no inputs exist yet, scaffold the folder and say the routine becomes worth turning on once things land there.

## Step 6: Hand off

Anything improvised during the run — a section the template lacked, a fit that was awkward — is a `[learning]` line in *this* project's DECISIONS.md, where the next session here will read it. The scaffold does not collect findings from projects; it changes when its owner decides it should, by looking at repos. **This skill never edits its own templates.**

**Hand off.** Short summary: what was created or changed, the per-project decisions and why, what runs automatically vs. what's a habit, and the two habits that remain on the user — start nontrivial work as the project's unit of work; run /wrap at session end. The repo is now the documentation.

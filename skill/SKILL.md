---
name: workspace-scaffold
description: Scaffold or re-align a self-enforcing Claude Code workspace around a minimal consistent core — CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, and the /vet and /wrap skills that keep them honest — with the unit of work, hooks, and extra skills decided per project. Use whenever the user starts a new project or repo, says "set up this repo/project/workspace," asks to scaffold or structure a project for Claude Code, drops into a codebase with no CLAUDE.md, or asks to re-run, upgrade, or re-align an existing workspace to the current scaffold.
---

# Workspace Scaffold

Turn a repo into a workspace that enforces good working habits by itself. The core belief: a workflow you have to remember is a workflow you'll drop. Everything this skill produces either lives in the repo (context files Claude reads every session) or runs automatically (hooks), so nothing depends on the user's memory.

Every project gets the **same minimal core** — four files, two skill names, one line grammar — so there is nothing to re-learn between repos and any workspace can read any other's state. Everything else is decided per project, once, at scaffold time, and the decision is logged. Consistency is for the human; Claude reads each repo fresh and only needs the content to be right.

Four principles govern every decision below:

1. **Structure is the scaffold's; content and behavior are the project's.** The core file set, skill names, section skeleton, and line grammar are fixed. Everything inside them is written for this specific project and is never regenerated once it exists.
2. **Mechanical vs. judgment.** Anything a machine can verify (format, lint, types, tests, build) goes in hooks — deterministic, runs every time. REVIEW.md holds only judgment calls. Never duplicate a hook check inside REVIEW.md.
3. **Self-maintaining.** Stale context is worse than none, because Claude optimizes for a stale goal confidently. Maintenance is baked into the loop (DECISIONS.md, roadmap freshness in /wrap) rather than left to memory.
4. **Never leave homework.** Replace every `{{PLACEHOLDER}}`, delete every section that doesn't apply. A half-filled template is worse than no template.

## The core (every project)

The core is a **data contract, not a behavior contract**. What every scaffolded workspace shares is the shape of its data — which files exist, which sections they carry, and the line grammar inside them — so that a session in one workspace can read another's state without knowing how that workspace works. How a workspace behaves (what its skills do between start and residue, its hooks, its unit of work, how it finds and makes its own improvements) is decided per project and is nobody else's business. Greenfield builds the shape; existing-workspace mode audits conformance to it and nothing else.

**The residue (why the core exists):** at any moment a workspace's state is `ROADMAP.md`'s `## Current goal` plus the most recent dated lines in `DECISIONS.md`. Every `/wrap` leaves those two current. Other workspaces and tools read exactly these; don't move the goal anywhere else.

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

## Step 3b: Audit and align (existing workspace)

Read everything that exists: CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, `.claude/skills/*`, `.claude/settings.json`. Two audits:

**Structure** — compare against the shape. Every gap maps to exactly one operation:

| Operation | When | Rule |
|---|---|---|
| **add** | A core file, section, or skill is missing | Write it from the template, customized from what the existing files already say about the project. |
| **rename** | A core skill exists under a different name, or a core file is lowercase | Rename, keep the body, update every reference in CLAUDE.md, skills, and living docs. Leave historical DECISIONS.md entries as written. |
| **migrate** | Content lives in the wrong place (e.g. the goal is a line in CLAUDE.md) | Move it, then update whatever pointed at the old location. |

Skill bodies are not audited. A `/wrap` that grew Facts and Commit steps, a `/vet` that runs a script first — that is the project's behavior, and the audit doesn't look at it. The only questions about a skill are whether it exists under the core name and whether its residue lands where the shape says.

**Usage (the look-back)** — evidence about whether the scaffold *fit*, which no self-assessment can produce:
- Is ROADMAP.md's date more than a month stale while commits continued? The roadmap isn't earning its place in this project, or /wrap isn't being run — find out which.
- Is the unit of work being used? An empty `tickets/` after real work means tickets don't fit here.
- Did the project rename or drop a core skill? That's a signal about the name or the skill.
- Did the docs disagree with the product? *(Only where the repo isn't the product; skip it otherwise.)* That's evidence the Step 2 probe earned its place — or, if they always agreed, that it didn't.
- Did the project add *data another workspace would need to read* — a file, a section, a frontmatter field? That's a shape candidate. Behavior it added (a skill step, a script) is its own and is not a finding.
Each finding is a line for IMPROVEMENTS.md (Step 6), not something to "fix" in the project.

**Never:** regenerate REVIEW.md, rewrite CLAUDE.md prose, or touch an existing DECISIONS.md entry. That content is the project's accumulated judgment and is the most valuable thing in the repo.

Show the plan as a short list — one line per operation — and **wait for approval before applying**. Then apply, and append one dated `[decision]` line to DECISIONS.md naming what changed. If the audit finds nothing to do, say so in one line and stop.

## Step 4: Skills and hooks

**Skills.** Copy `vet.md` and `wrap.md` (and `ticket.md` if tickets are the unit of work) from `assets/skills/` to `.claude/skills/<name>/SKILL.md` and adapt each to the project — what to adapt is marked in the file. `/wrap`'s **Commit** step is dropped only when the repo isn't git-tracked — log that in DECISIONS.md, and suggest `git init`. In existing-workspace mode, add a missing skill; never rewrite one that exists.

**Hooks.** Propose them and **ask before writing `.claude/settings.json`** — hooks execute shell commands, and that's the user's call. `assets/templates/hooks-example.json` has the current shape; the essentials:

- PostToolUse hooks receive JSON on stdin; the edited file is `.tool_input.file_path`.
- A Stop hook only blocks Claude from finishing if it exits with code 2 — a test command needs `|| exit 2` to enforce anything.
- If the test suite is slow, put typecheck/lint on Stop and leave the full suite to /vet.

## Step 5: Suggest routines (only with real inputs)

Recurring background work is the layer most often set up prematurely. Only suggest a routine when Step 2 confirmed an input stream exists. Safest first: a read-only **morning brief** over the input folders; a read-only **weekly review** of open issues/tickets; a **PR review** against REVIEW.md. Name the exact input paths. If no inputs exist yet, scaffold the folder and say the routine becomes worth turning on once things land there.

## Step 6: Retro and hand off

**Retro.** Before summarizing, answer once: *could any of this have been done better?* Three sources, in order of trustworthiness:

1. **Look-back findings** from Step 3b (existing workspaces only) — evidence, not opinion.
2. **Corrections the user made during the run** — a proposed file they cut, a name they changed, a scope they narrowed.
3. **Your own retro** — something improvised because a template lacked it, a section deleted wholesale, an awkward fit.

A finding belongs to the scaffold only if it is about the **shape** (data a workspace lacked, a section that was always empty, a field another workspace needed to read) or the **procedure** (a question Step 2 didn't ask, an operation Step 3b lacked). A behavior a project wanted — a skill step, a script, a ticket convention — goes in that project's DECISIONS.md and stops there.

Record each in `IMPROVEMENTS.md` in the scaffold repo (the parent of this skill's directory — resolve the symlink). One `## slug` heading per candidate, occurrences as dated lines tagged with the project and the source. **Read the file first**; if an existing heading describes the same thing, add an occurrence to it rather than a new heading — matching is on meaning, not wording. Three lines max per run; if genuinely nothing, write nothing. Padding this file destroys its signal.

**Threshold.** If any heading now has two or more occurrences and no ticket, say so in the handoff: "this has come up twice — want it as a ticket in the scaffold repo?" The user decides. **This skill never edits its own templates**; improvements go through the scaffold repo's own /ticket → /vet → /wrap like any other change.

**Hand off.** Short summary: what was created or changed, the per-project decisions and why, what runs automatically vs. what's a habit, and the two habits that remain on the user — start nontrivial work as the project's unit of work; run /wrap at session end. The repo is now the documentation.

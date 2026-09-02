---
status: done
created: 2026-09-01
source: request
---

# 010 — The core is a data contract, not a behavior contract

## Job
Rewrite the core section of `skill/SKILL.md` so that what every scaffolded repo shares is the *shape of its data* — which files exist, which sections they carry, and the line grammar inside them — and nothing about how the repo behaves. Behavior (what /wrap does between its start and its residue, hooks, the unit of work, how improvements are found and made) is the repo's own. The scaffold owns the shape and audits conformance to it; it stops owning skill bodies and stops propagating behavior between repos.

## Scope
- `skill/SKILL.md` — "The core (every project)" becomes the spec of the shape: the four files, their required sections, the DECISIONS.md line grammar (`- YYYY-MM-DD — [decision|learning] entry`, already in the template and already what all seven scaffolded repos write), the ticket frontmatter minimum (`status`, `kind`, `created`) *when* the unit of work is tickets, and the /vet and /wrap **names plus residue** only. Step 3b's operation table loses `merge` (skill bodies are no longer the scaffold's to reconcile) and audits shape conformance only. Step 6's retro narrows to shape and procedure findings.
- `skill/assets/skills/vet.md` and `wrap.md` — stay as reference implementations installed on greenfield. The "keep the numbered labels — the scaffold uses them to merge" line goes; the labels can stay as plain structure.
- `IMPROVEMENTS.md` (this repo) — the intro paragraph narrows what belongs here: something the shape lacks, or a scaffolding-procedure miss. A behavior one repo wanted (a /wrap step, a ticket field) is that repo's decision, logged in that repo's DECISIONS.md, and is only a scaffold finding if it is *data another repo would need to read*.
- `ROADMAP.md` (this repo) — the current goal changes from "prove hooks on a code repo" to "one workspace's session acts on another workspace's residue using only the spec."
- `tickets/007` — dropped, superseded: the operation it wanted to add is the merge machinery this ticket removes.
- `CLAUDE.md` (this repo) — the intro line and the three "every template change asks" questions get reworded to match; the merge-rule question goes.

**Does not touch:** any scaffolded repo. Every one of them already conforms to the shape this ticket writes down, so there is no migration. Does not touch the templates' content (CLAUDE.md, ROADMAP.md, REVIEW.md, DECISIONS.md, tickets-README.md) beyond wording that refers to merging. Does not add a file to the core. Two follow-ups are deliberately out of scope and get their own tickets if wanted:
- an evidence ledger (Trinity's `WORK-LOG.md` — one occurrence, below the rule of three; the core has intent, reasoning, and work, but nowhere for results);
- a toolkit in this repo that reads the shape across workspaces (current goals, open tickets by kind, recent learnings; `verify-live.sh` exists twice because there was no home for a shared tool).

## Done looks like
- The core section of `skill/SKILL.md` can be read by a session in one workspace and used to find, in a second workspace it has never opened, the current goal, the last three learnings, and the open tickets by kind — without reading that workspace's CLAUDE.md or any skill body. Tested for real: a session in `~/repos/career-trajectory` reads `Documents/TrinityGroup/Webflow/Trinity/` this way and gets the right answers.
- Existing-workspace mode run on `Documents/TrinityGroup/Webflow/RCRM/` proposes zero operations. RCRM's /wrap (Facts + Commit steps) and its `verify-live.sh`-in-/vet arrangement are not findings; they are the repo's behavior, which the audit no longer looks at.
- `IMPROVEMENTS.md` headings `wrap-commit-step` and `ticket-kind-field` read, under the new intro, as things that would today go in the originating repo's DECISIONS.md. (They stay — the log is append-only — but the intro makes the boundary visible.)
- Ticket 007 is `dropped` with a one-line reason pointing here.

## Boundary
Holds for a non-code repo by construction: the shape is four markdown files and one line grammar; career-trajectory (no tickets, no hooks) conforms today.

Does **not** change the wrap-residue contract. `ROADMAP.md ## Current goal` plus the DECISIONS.md tail stays the residue; this ticket promotes it from "the cross-repo contract" (one line at the bottom of the core section) to *the point of the core*. The DECISIONS line grammar and the ticket frontmatter minimum are added to the contract, but every scaffolded repo already writes both, so no repo migrates.

Step labels in /vet and /wrap stop being load-bearing. That is the one thing a scaffolded repo could notice: a future template improvement to a /wrap step no longer propagates. That is the intended trade — the propagation was the pain — and a repo that wants the improvement copies it deliberately.

## Plan
Approved 2026-09-01. Files change in this order:

1. `skill/SKILL.md` — core section rewritten as the shape spec; wrap-residue paragraph moves to the top as the reason the core exists.
2. `skill/SKILL.md` — Step 3b loses the `merge` row; audit is shape conformance only; look-back findings must be about shape or procedure.
3. `skill/SKILL.md` — Step 6 retro narrowed to the same boundary.
4. `skill/assets/skills/wrap.md`, `vet.md` — drop the "keep the numbered labels, the scaffold merges on them" line. Nothing else.
5. `IMPROVEMENTS.md` — intro paragraph rewritten with the boundary; headings untouched.
6. `CLAUDE.md`, `ROADMAP.md` (this repo) — intro and the "every template change asks" questions reworded; new current goal and focus list.
7. `tickets/007` — status `dropped`, one-line pointer here.
8. Test on real repos: existing-workspace mode on `Documents/TrinityGroup/Webflow/RCRM/` expects zero operations; then a session in `~/repos/career-trajectory` reads `Documents/TrinityGroup/Webflow/Trinity/` using only the spec. Results recorded here and in DECISIONS.md.
9. /vet, then /wrap.

### Scope additions, 2026-09-01
Three files outside the listed scope changed, each a direct consequence: `README.md` (the operation list no longer says merge), `REVIEW.md` (the step-label check tested for the merge machinery this removes; replaced with a shape-vs-behavior check), and `skill/assets/templates/CLAUDE.md` (Stakeholders moved before Learnings to match five of six repos — see the audit test).

### Test results, 2026-09-01
- **RCRM audit (Step 3b):** zero operations proposed. /wrap's Facts and Commit steps and `verify-live.sh`-in-/vet were correctly not findings. Two look-back lines went to IMPROVEMENTS.md (`ticket-site-field`, `two-staleness-thresholds`). One ambiguity surfaced — RCRM has `## Stakeholders` before `## Learnings`, against the spec's stated order — and five of six repos with a Stakeholders section do the same, so the spec was wrong, not the repos: reordered to match, and the audit now checks section existence, not position.
- **Cross-workspace read (Trinity, from the core section alone):** a reader given only the core spec and the path returned the current goal, the last three `[learning]` lines, and 26 open tickets by kind, all matching a direct check. It opened ROADMAP.md, DECISIONS.md, `tickets/README.md`, and ticket frontmatter; not CLAUDE.md, `.claude/`, or REVIEW.md. Three honest guesses, each now closed in the spec: how to discover the unit of work (presence of `tickets/`), where a ticket's title lives (the `# NNN — title` H1, which every ticket in six repos already has), and which statuses still need attention (`open`, `in-progress`, `blocked` — Trinity's `tickets/README.md` predates the table that says so).

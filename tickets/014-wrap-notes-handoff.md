---
status: open
created: 2026-09-11
source: request
---

# 014 — /wrap hands off to ~/notes

## Job
Add a numbered **Notes hand-off** step to `skill/assets/skills/wrap.md`: after Commit, every project's /wrap appends one line to `~/notes/log.md` and updates only its own items in `~/notes/todo.md`. Logan gets one cross-repo todo list and log without any repo knowing about any other.

## Context
`~/notes` was scaffolded 2026-09-11 as a personal log/todo repo, not a workspace: no ROADMAP/REVIEW/tickets, `README.md` is the contract. Its grammar: `log.md` has one `## YYYY-MM-DD` H2 per day, newest at top, entries chronological within the day, each `- HH:MM [source] text`; `todo.md` has `## Work`, `## Personal`, `## Done` with items `- [ ] [source] text`; `domains.md` maps source → `work` | `personal`. A `note` shell function writes `[note]`/`[note:p]` entries; `/review` there triages them into todo.md; `bin/brief` prints a section plus provenance ("last /wrap: day time [source]"). The repo side of that contract is this ticket.

Why push, not pull: the shape's read path (goal + DECISIONS tail) already lets ~/notes *read* every repo, and a pull would need no /wrap change. But "follow-ups surfaced this session" is judgment only the wrapping session has, so todo items can only be written at wrap time. The cost is that /wrap gains its first write outside its own workspace, and a dependency on `~/notes` existing.

Why a ticket and not an edit from ~/notes: SKILL.md says the skill never edits its own templates and bodies are the project's; ROADMAP.md lists "propagating behavior between workspaces" out of scope and the scaffold as "defects only." This is an improvement, not a defect. **The freeze is Logan's to lift; approving this plan is that decision.** Precedent: ticket 002 added Commit as a template step, and the 2026-09-03 batch content pass shows how a template change reaches existing copies.

The fleet as of 2026-09-11, verified on disk, is 12 /wrap copies, none of them user-level (`~/.claude/commands/` does not exist; `~/.claude/skills/` has no wrap): `~/repos/{career-trajectory,chief-of-staff,newsletter,workspace-scaffold}` and `~/Documents/TrinityGroup/{Webflow,Webflow/DJCon,Webflow/OuachitaTerminals,Webflow/RCRM,Webflow/Trinity,Social,Strategy,repos/ats-sync}`. `~/notes` carries its own override (commit and stop) and is excluded. Step labels differ per copy (DJCon has a **Facts** step, newsletter a **Time log** step); all end with **Commit** then **Summary**, except career-trajectory and chief-of-staff, which have no Commit step.

**Source identity is not the git root basename.** The four Webflow sites share one git repo, so `git rev-parse --show-toplevel` names all of them `Webflow`. The source must be the workspace's own folder name (the directory holding `.claude/skills/wrap`): `DJCon`, not `Webflow`. `~/notes/domains.md` is keyed on those names.

## Scope
`skill/assets/skills/wrap.md` — one new numbered step between **Commit** and **Summary**, Summary renumbered, frontmatter description and "do all N" count updated, ADAPT note gains one sentence (drop the step when `~/notes` does not exist, log it). `skill/SKILL.md` — one sentence in Step 4's Skills paragraph saying the same.

Does **not** touch: `/vet`, `/ticket`, any template under `assets/templates/`, the residue contract (ROADMAP goal + DECISIONS tail is unchanged; this adds a write target, it does not move the residue), or any of the 12 project copies. Fleet adoption is a separate content pass (Plan step 4), not this edit.

## Done looks like
- A greenfield scaffold on a git-tracked repo installs `/wrap` with **Notes hand-off** between Commit and Summary.
- Read against `~/Documents/TrinityGroup/Webflow/DJCon/.claude/skills/wrap/SKILL.md`, the step's source rule yields `DJCon`, and against `~/repos/newsletter` it yields `newsletter`.
- A /wrap run in a scaffolded repo appends exactly one line to `~/notes/log.md` under today's heading (creating it at the top if absent), changes only `[<source>]` lines in `~/notes/todo.md`, leaves every other line byte-identical, and prints the before/after of each changed line in-session.
- `~/notes/bin/brief` reports that wrap as "Last /wrap: <day> <time> [<source>]".
- A /wrap run in `~/notes` itself does none of this (the override there commits and stops).

## Boundary
Holds for non-code repos; 10 of the 12 copies are markdown repos.

Adds a step label, **Notes hand-off**. Any future merge keys on it; no existing copy uses that label, so no collision.

Residue contract unchanged. New: /wrap's first side-effect outside the workspace. If `~/notes` is missing the step must be inert, not an error.

Nested workspaces (ticket 008's territory): the source rule above is what makes the step correct in the Webflow tree. The Webflow *parent* /wrap writes `[Webflow]`; a site session writes its site name. Both rows exist in `~/notes/domains.md`.

Scaffolded repos needing migration: all 12 listed above. Per the 2026-09-03 precedent, a batch pass driven from this repo is safe only with exact-match insertion that asserts the anchor (`N. **Summary.**`) appears exactly once per file, renumbers, and appends one `[decision]` line to each repo's own DECISIONS.md. career-trajectory and chief-of-staff lack a Commit step, so their anchor is Summary directly.

## Plan
(proposed) Do not edit before Logan approves.

1. `skill/assets/skills/wrap.md`: insert the step below between `4. **Commit.**` and Summary; Summary becomes 6; "Do all five" becomes six; frontmatter description adds "hand off to ~/notes"; ADAPT note adds "drop **Notes hand-off** if `~/notes` does not exist, and log it."

   ```
   5. **Notes hand-off.** Source is this workspace's folder name (the directory holding `.claude/skills/wrap`), not the git root — nested workspaces share a git root. Re-read `~/notes/log.md` and `~/notes/todo.md` immediately before writing; other sessions may have wrapped. Then:
      - Append one line to today's `## YYYY-MM-DD` section of `log.md`, creating the section at the top if it is missing: `- HH:MM [<source>] shipped: …; open: …`.
      - In `todo.md`, touch only lines tagged `[<source>]`. Mark finished ones `[x]` and move them to `## Done`. Add follow-ups surfaced this session as `- [ ] [<source>] text` under the section `~/notes/domains.md` assigns this source; if the cell is blank, ask. Every other line stays byte-identical.
      - Print the before/after of each `todo.md` line you changed so it can be reviewed in-session.
      If `~/notes` does not exist, skip this step silently.
   ```

2. `skill/SKILL.md`, Step 4 Skills paragraph: one sentence, "**Notes hand-off** assumes `~/notes`; drop it where that repo does not exist and log the drop."
3. Test by reading, no execution: apply the source rule to DJCon (expect `DJCon`) and newsletter (expect `newsletter`); confirm `~/notes/README.md`'s grammar matches the step's output line for line.
4. Fleet pass, separately approved: exact-match insert before each copy's `N. **Summary.**` line (assert one match), renumber Summary, append `- 2026-MM-DD — [decision] /wrap gained a Notes hand-off step (workspace-scaffold ticket 014).` to that repo's DECISIONS.md. 12 files. Commit each repo. career-trajectory and chief-of-staff: also decide whether to add the missing Commit step while there (ticket 002 left that to each repo's own session).
5. `~/notes/decisions.md`: one line recording that the repo side of the contract shipped via this ticket.

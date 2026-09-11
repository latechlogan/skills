---
status: dropped
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

### Dropped 2026-09-11 — reframed as pull
The push plan (a **Notes hand-off** step in every /wrap; text in git at 2a89cdc) rested on the prompt's assumption that /wrap is one user-level file. It is 12 per-repo copies, so push meant a 12-file behavior propagation the 2026-09-02 pivot ruled out, plus a second copy of each repo's open work in `todo.md` that would drift from the repo. Logan chose pull: nothing changes in the scaffold or in any /wrap; `~/notes` reads the shape. The plan below executes in a `~/notes` session, which has none of this context — it is written to be followed cold.

### Plan for `~/notes` (pull)

1. **`domains.md` gains a `path` column.** `| repo | path | domain |`, paths absolute (`~` allowed). Nested Webflow sites point at the site folder, not the git root. Update the prose: source name is the workspace folder name, and this table is what `bin/repos` walks.
2. **`bin/repos [-p]`** — read-only, `/bin/sh`, standard macOS tools, same conventions as `bin/brief`. For each row whose domain matches (`work` by default, `personal` with `-p`), print one block:
   - Repo name, then `ROADMAP.md`'s `Last updated:` date; append `(stale)` if older than 14 days.
   - `## Current goal`: the section body up to the next H2, first non-empty line only.
   - Open work. If `tickets/` exists: count of tickets by `status:` for `open`, `in-progress`, `blocked`; list the H1 titles of `in-progress` and `blocked` ones (those are active or need chasing; `open` is a count). If no `tickets/`: the bullet lines under `## This cycle's focus`.
   - Last commit, scoped to the folder so shared-repo sites report their own: `git -C <path> log -1 --format='%ad %s' --date=format:'%Y-%m-%d %H:%M' -- .`
   - A row whose path is missing or has no `ROADMAP.md` prints one line saying so and moves on. Never exits non-zero for one bad repo.
3. **`bin/brief`** calls `bin/repos` with the same flag after the todo section. Drop the footer's "Last /wrap" line: `log.md` never carries repo entries under pull, and each repo block already shows its last commit. Keep the notes-since-review count.
4. **`README.md`**: `[source]` on todo/log items is `note`, `note:p`, or a repo name that /review assigns by hand; nothing is written here by any repo's /wrap. Remove the rule about another repo's /wrap touching only its own items. Add `bin/repos` under Files and Commands. Fix "git root basename" to folder name.
5. **`.claude/skills/wrap/SKILL.md`** description: drop "the real /wrap ... writes here"; it reads via `bin/repos`.
6. **`decisions.md`**: one line — pull chosen over push, why (12 copies, drift), pointer to workspace-scaffold ticket 014. Amend nothing earlier.
7. **Test on real repos**, not in the abstract: run `bin/repos` and check DJCon reports its own last commit (not Webflow's), RCRM shows counts not 50 titles, career-trajectory (no tickets) shows its focus list, and a deliberately wrong path prints one line and the run continues.

Known gaps, accepted: "what shipped" is a commit message, not prose. career-trajectory and chief-of-staff have no Commit step in /wrap, so their stamp lags until they add one (ticket 002 left that to each repo).

## Review 2026-09-11 (workspace-scaffold session, before approval)

Ticket was written from a `~/notes` session without this repo's context. Fleet facts verified on disk: 12 copies, one `**Summary.**` anchor each, career-trajectory and chief-of-staff lack Commit, Trinity has 7 steps, ats-sync's Commit step carries a two-repo note. `~/notes` grammar and `bin/brief`'s provenance line match the ticket.

**Corrections to the text as written**
- Step text says "skip this step silently" when `~/notes` is missing; the ADAPT note and the SKILL.md sentence say "log it." Pick one — log it, matching the Commit precedent.
- `~/notes/README.md` still defines `[source]` as "git root basename"; `domains.md` and this ticket say folder name. README is the contract there and is wrong. Fix belongs in `~/notes`, plan step 5.
- "Why push, not pull" does not mention ROADMAP.md focus item 4 — the cross-workspace read tool, already parked here and explicitly exempt from the defects-only freeze. That is the pull design, and the ticket argues against it without knowing it exists.

**Where the plan breaks this repo's principles**
- Plan step 4 (the fleet pass) is "propagating behavior between workspaces," which ROADMAP.md lists out of scope. The 2026-09-03 precedent was the read path, which SKILL.md places in the core; a notes write is not shape — no scaffolded repo keeps any new data. Under ticket 010, steps 1–2 change only a greenfield default and reach none of the 12 existing copies; step 4 is the whole ticket, and it is the part the pivot ruled out.
- The `todo.md` write gives every repo's open work a second home. Open work already lives in the repo's residue (`## Current goal`, focus list, tickets with status open / in-progress / blocked). `[<source>]` items in `todo.md` would be a copy that has to be kept in sync by an LLM step under a "byte-identical otherwise" rule that nothing enforces. That is the dual-write problem the read path was adopted to avoid.
- The push argument — "follow-ups surfaced this session are judgment only the wrapping session has" — is true, but the shape's answer is that /wrap writes them into the repo (a ticket, a focus item). A follow-up that exists only in `~/notes/todo.md` is one the repo's next session never sees. If that is happening, it is a defect in that repo's /wrap, and a push would paper over it.

**Better solution: pull, built in `~/notes`**
A read-only script beside `bin/brief` that, for each repo in `domains.md`, prints `## Current goal`, open work (tickets with an attention-needing status, or the focus list where there are no tickets), and the last commit time as "last /wrap". Zero scaffold changes, zero fleet pass, no write contention, the freeze holds, and it is ROADMAP item 4 landing where its consumer lives. Personal items stay `[note]` entries as today.

If Logan still wants a push, the defensible half is the `log.md` line only — an append-only event, no state to keep in sync, same discipline as DECISIONS.md — and the `todo.md` write should be dropped. Its mechanical form is a `SessionEnd` hook per project (principle 2), not a /wrap body step; that is a settings.json install, still 12 repos.

Decision is Logan's: (a) reframe 014 as the pull script in `~/notes`, drop here; (b) keep push, log line only, fleet pass separately approved; (c) approve as written, lifting the freeze.

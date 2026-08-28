# Improvements

Candidate improvements to the scaffold, recorded by the skill at the end of each run (Step 6: Retro). One `## slug` heading per candidate; each occurrence is a dated line tagged with the project and the source — `look-back` (usage evidence on re-run), `correction` (the user changed something mid-run), or `retro` (the skill's own assessment). Read before writing; add to an existing heading when it's the same thing in different words.

**Threshold: two occurrences** without a ticket → surface it in the handoff and ask whether to open one in `tickets/`. The skill never edits its own templates; changes go through /ticket → /vet → /wrap here like any other work.

## ticket-forced-on-non-code-repo
- 2026-08-25 — chief-of-staff — dropped /ticket at scaffold time: "ceremony for a two-command project." (correction)
- 2026-08-26 — career-trajectory — added tickets/ for "research questions with a finish line"; redundant with the existing research/ file convention, removed the next day. (retro)
- → incorporated 2026-08-27: unit of work is decided per project; /ticket is the code default only.

## review-template-code-centric
- 2026-08-26 — career-trajectory — User experience and Risk sections had nothing to say for a research repo; deleted wholesale, REVIEW.md was 100% bespoke. (retro)

## unit-of-work-keyed-on-code
- 2026-08-27 — RCRM — "code repo → ticket default" is the wrong predicate. RCRM has no code and 32 tickets with a defect/improvement triage rule that it uses as its only prioritization. The real predicate is *discrete deliverables with an observable finish line*; exploratory/continuous work (research, drafts) is what names its own unit. (look-back)
- → incorporated 2026-08-27 via tickets/001.

## mechanical-check-without-hook-event
- 2026-08-27 — RCRM — `scripts/verify-live.sh` is mechanical but fires post-publish, which maps to no hook event (publishing isn't an Edit/Write). /vet runs it as step 1 instead. The mechanical/judgment split assumes every mechanical check is a hook; a third shape exists: mechanical checks that /vet runs first. (look-back)

## wrap-commit-step
- 2026-08-27 — RCRM — added a **Commit** step to /wrap because git history is the only undo for a no-build repo. career-trajectory didn't, but is also git-tracked. Plausibly every git-tracked project wants this in the template. (look-back)
- 2026-08-27 — DJCon — installed with the Commit step again (copied from RCRM's /wrap, not the template). Second git-tracked ops repo that wanted it. (retro)
- 2026-08-27 — newsletter — not git-tracked at scaffold time, so no Commit step and the CLAUDE.md template's "edit on feature branches" line had to be rewritten. Step 2 never asks whether the dir is a repo; a DECISIONS.md with no git history has no undo. (retro)
- → incorporated 2026-08-27 via tickets/002. The git-init check for Step 2 is *not* covered — new heading if it recurs.

## ticket-kind-field
- 2026-08-27 — RCRM — `kind: defect | improvement` in ticket frontmatter plus a triage rule in ROADMAP.md turned ticket order from creation order into real priority. Candidate for the ticket template. (look-back)
- 2026-08-27 — DJCon — installed RCRM's `kind:` + triage-rule variant of /ticket and ROADMAP.md verbatim instead of the template's; the triage rule immediately reordered the parent roadmap's priority for the site (dead Apply links over the entity connection). (retro)
- → incorporated 2026-08-27 via tickets/003.

## nested-workspaces
- 2026-08-27 — Webflow/ — a parent workspace over four sibling site workspaces, relying on Claude Code loading ancestor CLAUDE.md files (parent first). SKILL.md has no guidance for this shape: the parent CLAUDE.md needs a stricter line budget (it's a tax on every child session), explicit paths (a child has its own ROADMAP/REVIEW/DECISIONS), and a unit of work that lives in the children (the hand-off). Also: one git repo for the tree, not nested repos. (retro)

## hand-off-ticket-across-folders
- 2026-08-27 — Webflow/ — a ticket written by one workspace into another's `tickets/`, with `## Plan` filled at write time because the writer has the context and the executor doesn't. RCRM's ticket 028 ("execution happens in ../DJCon/") is the same shape, unnamed. (look-back)

## scope-gathering-reads-docs-not-product
- 2026-08-27 — DJCon — Step 2 says extract scope from "the conversation and the repo"; for an ops repo the repo is three files and the product is a live site. Probing it (curl, MCP list_sites) produced most of the workspace's content: a year-stale last publish, a CDN cache trap, five dead Apply links, a NAP inconsistency, no analytics — none in any doc, and the parent rollup's "Next" for the site was wrong because of it. Step 2 should say: when the repo isn't the product, inspect the product. (retro)

## wrap-gate-before-step-1
- 2026-08-27 — newsletter — the project needed a gate *before* step 1 ("did an issue draft ship?" — the kickoff's own wrap rule), but wrap.md's ADAPT note only permits insertions between 3 and 4. Added it as a bold pre-step so the numbered labels still merge. Some projects have a wrap question that must come first. (retro)

## unit-of-work-is-a-log-line
- 2026-08-27 — newsletter — third unit-of-work shape: deliverables are discrete (the issue), but *pipeline* work is gated by a logged friction line in DECISIONS.md ("automate only the most expensive step"). The log line is the ticket; a tickets/ folder would duplicate it. SKILL.md offers ticket-or-named-artifact; "an entry in the decision log" wasn't on the menu. (retro)

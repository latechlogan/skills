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
- 2026-08-28 — Trinity — same shape, third ops repo: the backlog's hand-run "Verify" block became `scripts/verify-live.sh`, run by /vet step 1, no hook. SKILL.md Step 4 still offers only hook-or-nothing. (retro)

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
- 2026-08-28 — ats-sync — the *sibling* variant: a code repo deliberately placed outside the `Webflow/` tree (so "editing is publishing" doesn't apply) that still needs the program's shared rules and DECISIONS. No ancestor CLAUDE.md loads, so every shared rule is an explicit `../../Webflow/…` pointer, and Webflow-generic learnings have to be routed to the other workspace via a /wrap step ("Owed to Webflow/"). Step 2 says nothing about reading a sibling workspace's conventions before scaffolding; here they were the main input. (retro)
- 2026-08-31 — Webflow/DJCon — the "explicit paths" warning above has a **silent** failure mode in hand-off tickets, and it bit twice in one session. Parent and child each have a `DECISIONS.md` one directory apart, so `../DECISIONS.md` resolves to a real file either way and is never an error — it just points at the wrong log. A hand-off resolves relative paths against the *executing session's* cwd (the child folder), while whoever reads or edits the ticket resolves them against the file's own location (`child/tickets/`). Those differ by exactly one level. DJCon ticket 004 used `../DECISIONS.md` for the parent log; a new ticket 005 used the same string for the child's; a correction note appended to ticket 003 nearly shipped pointing at the wrong one. Fix applied locally: name both files in full (`Webflow/DECISIONS.md`, `DJCon/DECISIONS.md`) wherever a ticket cites either. Candidate for the ticket template — every hand-off written into a nested workspace has this, and the other three sites' tickets still carry it. (look-back)

## hand-off-ticket-across-folders
- 2026-08-27 — Webflow/ — a ticket written by one workspace into another's `tickets/`, with `## Plan` filled at write time because the writer has the context and the executor doesn't. RCRM's ticket 028 ("execution happens in ../DJCon/") is the same shape, unnamed. (look-back)
- 2026-08-28 — ats-sync — the ticket arrived before the workspace: `Webflow/` wrote `repos/ats-sync/tickets/001` with a step 15 saying "this repo has no /vet, /wrap, CLAUDE.md" and deferring close-out to the parent. Scaffolding had to migrate that step. A hand-off into an unscaffolded repo is effectively a request to scaffold it; the ticket frontmatter also grew `depends on:` for the cross-workspace prerequisite. (look-back)

## scope-gathering-reads-docs-not-product
- 2026-08-27 — DJCon — Step 2 says extract scope from "the conversation and the repo"; for an ops repo the repo is three files and the product is a live site. Probing it (curl, MCP list_sites) produced most of the workspace's content: a year-stale last publish, a CDN cache trap, five dead Apply links, a NAP inconsistency, no analytics — none in any doc, and the parent rollup's "Next" for the site was wrong because of it. Step 2 should say: when the repo isn't the product, inspect the product. (retro)
- 2026-08-28 — Trinity — an 18-day-old, carefully maintained backlog said "all 16 Apply links go to the wrong portal"; the site said 6 are dead and 14 open jobs have no page at all. The roadmap's first two focus items came from the probe, not the docs. Second ops repo where this was the highest-value step of the run. (retro)
- 2026-08-28 — OuachitaTerminals — docs described a 07-27 audit as current; `get_site.lastPublished` was 08-19 with nothing logged. The homepage JSON-LD the docs called "fixed" carried unverified `openingHours` and no parent; the old site the connection prompt called old-brand-clean had `RGroup II`; the parent roadmap was waiting on an address the site already published. Third ops repo. (retro)
- → ticket 005, open 2026-08-28.

## wrap-gate-before-step-1
- 2026-08-27 — newsletter — the project needed a gate *before* step 1 ("did an issue draft ship?" — the kickoff's own wrap rule), but wrap.md's ADAPT note only permits insertions between 3 and 4. Added it as a bold pre-step so the numbered labels still merge. Some projects have a wrap question that must come first. (retro)

## unit-of-work-is-a-log-line
- 2026-08-27 — newsletter — third unit-of-work shape: deliverables are discrete (the issue), but *pipeline* work is gated by a logged friction line in DECISIONS.md ("automate only the most expensive step"). The log line is the ticket; a tickets/ folder would duplicate it. SKILL.md offers ticket-or-named-artifact; "an entry in the decision log" wasn't on the menu. (retro)

## existing-backlog-migration
- 2026-08-28 — Trinity — third repo (after RCRM, DJCon's TRINITY-CONNECTION.md) that arrived with a loose action list and had it migrated into tickets at scaffold time. Step 3a says "document, don't impose" and nothing about an existing work queue; the mapping (items → tickets grouped by finish line, gotchas → DECISIONS, don't-break-these → CLAUDE.md rules, blocked-on-stakeholder → ROADMAP "Waiting on", verify block → script) was improvised each time. (retro)
- 2026-08-28 — OuachitaTerminals — fourth: LAUNCH-CHECKLIST.md (must/should/nice) + TRINITY-CONNECTION.md → 13 tickets, a ROADMAP "Post-launch backlog (not tickets yet)" list for the nice-to-haves, gotchas → DECISIONS. Same mapping, improvised a fourth time; the "don't ticket the nice-to-haves yet" call was new. (retro)
- → ticket 004, open 2026-08-28.

## pre-launch-site-shape
- 2026-08-28 — OuachitaTerminals — a site that exists only on staging inverts the template's permission split: staging is the *only* publish target, "connect the domain" is the launch, and one ticket (013) has to own every un-draft and domain action. REVIEW.md's "did it ship?" section verifies against staging until a date, then the real host; /wrap needs a "rewrite CLAUDE.md at launch" step. None of that is in the templates — every line was bespoke. (retro)

## finished-ticket-archive
- 2026-08-31 — workspace-scaffold — Logan asked for a `tickets/done/` subdirectory so `tickets/` holds only work that still needs attention. Investigated and **declined for now**: across 79 tickets in RCRM/Trinity/DJCon/OuachitaTerminals only 6 would move (RCRM 1 of 32, Trinity 2 of 28, Ouachita 0 of 14, DJCon 3 of 5), while the actual clutter is 54 open + 11 blocked. The archive also forces two repairs it alone requires — /ticket's "next number in sequence" would re-issue an archived number, and SKILL.md:87's "an empty `tickets/` means tickets don't fit here" would start meaning the opposite. Revisit when one repo has a real pile of finished tickets; DJCon at 3-of-5 is the shape to watch. (correction)

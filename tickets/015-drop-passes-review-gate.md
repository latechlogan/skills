---
status: done
created: 2026-10-29
source: request
---

# 015 — Drop the Passes check from REVIEW.md

## Job
Delete the `## Passes` section from `skill/assets/templates/REVIEW.md` and from the three repos that carry a copy of it, so no agent reads "each reviewed before the next" as a reason to stop between steps.

## Context
Tickets were taking too long because agents stopped after every pass to report and ask to continue. Logan's review happens at two points: when he approves the plan, and when he agrees on the checks that prove it worked. He doesn't read the code in between, so stopping between passes only adds waiting.

Three places caused it. The global `~/.claude/CLAUDE.md` "Bite-size mode" line was the main one, and it was replaced on 2026-10-29 with "Plan small, then run through": small steps go in the plan and the commits, run through to done once the plan's approved, and stop only for ask-first, a wrong plan, or a check that won't go green. The global file loads in every session, so that part is already live everywhere.

The second is `skill/assets/templates/REVIEW.md` `## Passes`: "...it should have been several changes, each reviewed before the next." Copies of it live in:
- `~/repos/rm-weekly/REVIEW.md` (template wording)
- `~/repos/ff-weekly/REVIEW.md` (template wording)
- `~/repos/ff-waiver-tool/REVIEW.md` (shorter variant, no "each reviewed before the next")

Searched and clean: the Webflow tree, ats-sync, career-trajectory, newsletter, and every scaffolded CLAUDE.md. project-kickoff already treats review as milestone-level (`assets/trust.md`: "not line by line"), so it needs nothing. Its phase-by-phase stops are planning gates and stay.

Why delete instead of rewrite: once the check isn't "was it reviewed pass by pass," what's left is "does the work match the plan," and `## Scope and intent` already asks that. A rewritten Passes check would say the same thing twice.

## Scope
Touches `skill/assets/templates/REVIEW.md` and the three repo REVIEW.md files above, plus one DECISIONS.md line in each place. Leaves alone: SKILL.md, the template CLAUDE.md plan-approval rule (that's the one gate Logan wants), project-kickoff, and each repo's other REVIEW.md sections.

## Done looks like
- `grep -rn "## Passes" skill/ ~/repos/{rm-weekly,ff-weekly,ff-waiver-tool}/REVIEW.md` returns nothing.
- Each of the four places has one dated `[decision]` line saying the Passes check was removed and why.
- In each REVIEW.md, the section after the deleted one is untouched (diff shows only the removed lines).

## Boundary
- It holds for a non-code repo. Nothing about the check depended on code.
- The wrap-residue contract isn't touched.
- Editing scaffolded repos from here is ask-first. Approving this plan is that ask.
- `rm-weekly` has uncommitted slice 05 work, REVIEW.md included. The Passes lines aren't part of that diff, so the edit won't conflict, but it would land in the same working tree. Commit rm-weekly separately with only the Passes hunk staged, or hold it until slice 05 commits. Don't fold it into the slice 05 commit.

## Plan (approved 2026-10-29)
1. Template: delete `## Passes` plus its bullet and blank line from `skill/assets/templates/REVIEW.md`. Append a DECISIONS.md line.
2. Repos: in each of the three files, assert the exact section text appears once, then delete it. This is the exact-match, fail-loud pattern from the 2026-09-03 batch pass. Append a dated `[decision]` line to each repo's DECISIONS.md.
3. Commit: ff-weekly and ff-waiver-tool get one commit each. rm-weekly gets a commit with only the Passes hunk and the DECISIONS line staged (`git add -p`).
4. Verify with the grep in Done looks like, plus `git diff` on each REVIEW.md to confirm nothing else moved.
5. Run /vet here and close the ticket.

## Outcome
Done as planned. rm-weekly had already committed slice 05 by execution time, so no `git add -p` was needed. rm-weekly and ff-weekly were committed on their current feature branches, on top of unmerged work that also appends to DECISIONS.md, so branching from `main` would have conflicted. ff-waiver-tool got branch `drop-passes-check`. Nothing was merged. /vet found the same check in this repo's own `REVIEW.md` (a bullet under `## Scope and intent`, so the `## Passes` grep missed it) and it was removed too.

---
status: done
created: 2026-08-27
source: IMPROVEMENTS.md#wrap-commit-step
---

# 002 — Add a Commit step to the /wrap template

## Job
Add a numbered **Commit** step to `assets/skills/wrap.md` so every git-tracked project's session close-out ends with a commit, instead of each project re-adding it by hand (RCRM and DJCon both did, by copying RCRM's variant rather than the template).

## Scope
`skill/assets/skills/wrap.md` — one new numbered step between **Work status** (3) and **Summary** (4), plus the description line in frontmatter. `skill/SKILL.md` — the "Skills" paragraph of Step 4 gets one sentence saying the step is dropped when the repo isn't git-tracked. Does not touch /vet, /ticket, any template file, or the wrap-residue contract (ROADMAP goal + DECISIONS lines).

## Done looks like
- A greenfield scaffold on a git-tracked repo installs `/wrap` with the Commit step in position, and existing-workspace mode on RCRM and DJCon proposes a **merge** that recognizes their hand-added step as the same step (no duplicate).
- Existing-workspace mode on a non-git repo (newsletter, as of 2026-08-27) proposes nothing for this step.

## Boundary
Holds for non-code repos — the two occurrences *are* non-code repos. Adds a step label, so Step 3b's merge must key on it; the existing project copies use the label **Commit**, so use exactly that. Does not decide whether Step 2 should check for git or offer `git init` — the newsletter occurrence raises that, but it's a scope-gathering change, not a wrap change; separate ticket if it comes up again. Scaffolded repos needing a merge: RCRM, DJCon (already have it, verify label matches), career-trajectory, chief-of-staff (git-tracked, lack it).

## Plan
Approved 2026-08-27. (1) `assets/skills/wrap.md`: insert `4. **Commit.**` (wording generalized from RCRM's: message describes the product change, git is the only undo, suggest and let the user approve), renumber Summary to 5, description + "do all five", ADAPT note says drop Commit only if not git-tracked and log it. (2) `SKILL.md` Step 4 Skills paragraph: one sentence — Commit dropped only when not git-tracked, log it, suggest `git init`. (3) Test by reading: RCRM and DJCon already carry `5. **Commit.**` with the same label → 3b merge recognizes it, no duplicate; career-trajectory and chief-of-staff (both git-tracked) lack it → one merge proposal each on their next re-run; newsletter (not git-tracked) → no-op. (4) "→ incorporated" under the IMPROVEMENTS.md heading.

Done 2026-08-27. Steps 1–2 applied; step 3 verified by grep against all four repos; step 4 applied. Not done here: re-running existing-workspace mode on career-trajectory and chief-of-staff to actually apply the merge — that's each repo's own session.

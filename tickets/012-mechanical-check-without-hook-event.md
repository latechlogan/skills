---
status: done
created: 2026-09-02
source: IMPROVEMENTS.md#mechanical-check-without-hook-event
---

# 012 — A third home for a mechanical check with no hook event

## Job
`SKILL.md`'s mechanical-vs-judgment rule assumes every machine-checkable thing maps to a hook event, and hook events only fire on things Claude does in-session (PostToolUse on Edit/Write, Stop). A check that runs against a product published *outside* the session has no event and is barred from REVIEW.md, so it has no legal home. Add the third case both ops repos independently invented: a mechanical check that `/vet` runs as its first step.

## Scope
`skill/SKILL.md` — the "Mechanical vs. judgment" rule (line 15) gains the third case, and Step 4's **Hooks** paragraph gains one option beside hook-or-nothing: if the check is mechanical but its trigger isn't a tool call, it becomes a script that /vet runs before the judgment pass. `skill/assets/templates/REVIEW.md` — the "Judgment checks only" line gets a carve-out naming that script so it doesn't read as a contradiction. `skill/assets/skills/vet.md` — line 16 currently says "If the repo has no hooks, don't invent mechanical findings either; judgment only," which actively forbids the arrangement two repos use; it gains the exception.

Does **not** touch: the core section of SKILL.md (this is scaffolding procedure, not shape), `/wrap`, `/ticket`, the ROADMAP/CLAUDE.md/DECISIONS templates, the status enum, or any step label. Does not write anyone's verify script or say what it should check.

## Done looks like
- Re-reading Step 4 against `Webflow/RCRM/` and `Webflow/Trinity/` produces `scripts/verify-live.sh` run by /vet step 1 without improvisation — both repos reached it independently, and the change records what they converged on rather than inventing a mechanism.
- `skill/assets/skills/vet.md` no longer contradicts what those two repos actually do.
- A repo with a formatter and a test command is unaffected: the hook answer is still the first answer, and the third case only fires when no event exists.
- A repo with nothing mechanical to check (`career-trajectory`) gains nothing — REVIEW.md's alternate clause already covers it.

## Boundary
Holds for a non-code repo — both occurrences (RCRM 2026-08-27, Trinity 2026-08-28) are markdown-only ops repos, and the case only arises when the repo isn't the product. Related to ticket 005, which handles the same repo-isn't-the-product split in Step 2; this is the Step 4 half. Keep them separate: 005 is about discovering the product, this is about where a check on it lives.

No change to the wrap-residue contract and no step label moves, so no scaffolded repo needs migrating. `skill/assets/skills/vet.md` is a greenfield reference implementation under ticket 010's data contract, so the fix reaches new scaffolds only; RCRM and Trinity already do the right thing and are not owed an update.

**Weak evidence to check in the plan:** both occurrences are Webflow ops repos, which is arguably one context wearing two names — the same objection that got `finished-ticket-archive` declined. Confirm the rule is stated generally (mechanical check, no in-session trigger) and not as a site-publishing special case, or it fails the non-code test for the wrong reason.

## Plan

### Done 2026-09-02
Folded into SKILL.md principle 2 and Step 4, and `skill/assets/skills/vet.md` no longer forbids the verify-script-first arrangement. Done in the cleanup pass, not as its own change.

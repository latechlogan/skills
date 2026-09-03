---
name: vet
description: Vet current work against REVIEW.md before declaring it done. Use when the user asks to review or vet changes, says work is finished, asks "is this ready," or before committing/opening a PR for a nontrivial change.
---

# /vet

Review the current uncommitted or unpushed work against `REVIEW.md`, and sort every finding into exactly one of three buckets:

- **Must fix** — would break the product, lose data or state, confuse users on the main flow, or violate the permissions posture in CLAUDE.md.
- **Should fix** — real but survivable; note it and let the user decide timing.
- **Fine as is** — worth mentioning, no action needed.

Rules:

- Skip anything hooks already verify (formatting, lint, types, tests passing). If a hook failed, that's already visible — don't re-litigate it. If the project has a mechanical check with no hook event behind it ({{VERIFY_SCRIPT — e.g. `scripts/verify-live.sh` after a publish — or delete}}), run that first and report it plainly; then judgment only, on the things `REVIEW.md` names. Don't invent mechanical findings beyond that.
- Review against the {{UNIT_OF_WORK — the ticket in tickets/, the research question, …}} and `ROADMAP.md`'s current cycle. Changes outside the stated scope go in must-fix as "unexplained scope change" unless there's a stated reason. Anything from the out-of-scope list is must-fix regardless of how well built it is.
- Actually exercise the affected flow if the change is user-facing — run it and walk through it as a first-time user; don't review the diff alone.
- End with a one-line verdict: clear, clear after must-fixes, or hold.
- Offer to fix must-fix items, but don't fix them silently — each fix is its own reviewable change.

<!-- ADAPT WHEN INSTALLING: sharpen the must-fix definition and add project-specific checks (e.g. "diff the state files specifically") to match REVIEW.md's sections. -->

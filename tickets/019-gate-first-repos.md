---
status: open
kind: improvement
created: 2026-11-26
---

# 019 — project-kickoff and workspace-scaffold generate repos that check at the gates, ready for the factory

## Job
Change what the two setup skills prescribe so a new repo's enforcement sits at the gates (CI on the pull request, branch rules), not in every session and every push, and so the repo meets the factory's contract from day one.

## Context
- **Parked on 2026-11-26** from a review of purser (`~/repos/purser`, the first repo built with both skills) while bringing factory-v2 (`~/repos/factory-v2`) into it. Not specced: write "Done looks like" when it's picked up. This is phase 5 of that plan; purser's own fixes were its tickets 012 and 015.
- **What went wrong in purser, traced to these skills:**
  - `project-kickoff/SKILL.md` (Delivery, pre-push hook): "Mirrors CI by running the same check command. Local is the source of truth; CI is confirmation." Purser's pre-push ran the full check on every push. It fought spec stubs three times and blocked the factory, which pushes on every stage. Purser cut it to a secrets scan. The principle should be the reverse: CI and branch rules are the gate no session can skip; local hooks are a convenience.
  - `project-kickoff/SKILL.md` (Supply chain) and `references/quality-gates.md`: a dependency audit inside the check command. It fails for reasons unrelated to the change, blocked an unrelated ticket in purser, and would park every factory job. Purser moved it to a weekly workflow.
  - `workspace-scaffold/SKILL.md` (Hooks): "If it has a test/typecheck/build command, a Stop hook runs it." Unconditionally, on every stop, including sessions that changed nothing and orchestrators that write no code. Purser's and factory-v2's hooks now skip when the tree and refs are unchanged since the last green run (`~/repos/purser/.claude/hooks/stop-check.sh` is the worked example).
  - `project-kickoff/assets/trust.md` copies the settings JSON into the doc, and it drifted in purser within a week.
  - Acceptance tests "frozen" with no end date: purser now freezes them for their own ticket's build only (its DECISIONS.md 2026-11-25).
  - A Bash guard written as one regex in settings JSON leaked three times under review. Purser's is now a script that blocks by default with named exceptions (`~/repos/purser/.claude/hooks/bash-guard.sh`), and its docs call it best-effort.
- **The factory's contract** is being written down in factory-v2 ticket 021; the skills should generate to it.
- **Open question:** purser's spec-reviewer flow was a candidate for upstreaming into workspace-scaffold (purser DECISIONS.md 2026-11-04, 2026-11-05). In its spec-only form (the spec-reviewer checks the ticket and the escalation list; the factory writes the tests) it's smaller. Decide here or in its own ticket.

- **Second review, 2026-11-26** (the whole plan is in `~/repos/factory-v2/ROADMAP.md`, "This cycle's focus"). Added to the list above:
  - **The rule to write the skills around: a check should only block someone who can fix it.** Each purser clash is an instance: the audit blocked a builder that can't edit `package.json`, the Stop hook blocked an orchestrator that writes no code, pre-push blocked tests pushed red on purpose. Three gates hold (what goes in: an approved ticket; what merges: CI running the check command; what ships: branch rules). Everything else is feedback, and feedback is skippable, conditional, and never the only thing enforcing a rule.
  - **Slow checks are assigned to `/vet`, which a factory job never runs.** `project-kickoff/SKILL.md` Phase 5 and `assets/trust.md` send mutation testing, end-to-end tests and the axe run to `/vet`. For factory-built work they are then unenforced (purser's ticket 015 fixes its own copy). A check that must hold goes in the check command or a CI job on the pull request; `/vet` may run it earlier for a hands-on session.
  - **Phase 6 says the opposite of gate-first on CI minutes:** "heavy or slow checks stay local (Stop hook, pre-push) where minutes are free." With CI as the gate, and a factory that pushes on every stage (purser's pilot started seven runs for one job), Actions minutes on a private repo are a constraint to decide at kickoff: cancel superseded runs on a pull request, and say what a month of jobs costs against the plan's limit.
  - **Phase 5's check-command paragraph and `assets/trust.md`** both say "hooks call it, pre-push calls it, CI calls it". Phase 7's table maps `trust.md` mechanical checks to hooks. Both become: the check command and CI; hooks are optional.
  - **An approved ticket is the gate on what goes in.** The factory's `pickup` will refuse a ticket without a non-empty `approved:` in its frontmatter (factory-v2 ticket 021; Logan chose the field over a seventh status on 2026-11-26). That makes the field data another workspace reads, so it enters the scaffold's shape: `workspace-scaffold/assets/skills/ticket.md`, `assets/templates/tickets-README.md`, and the ticket line in `SKILL.md`'s core. Changing the shape is Logan's call; he made it with that decision.
  - **The open question below is answered: yes, in spec-only form** (Logan, 2026-11-26). The spec-reviewer is what sets `approved:`. It moves into the scaffold's `/ticket` as an optional step, with the escalation list living in the project's own docs.
  - **Where each change goes.** The scaffold serves every repo, including ones with no code; the factory needs an acceptance-test command, so it fits repos with a test suite. Factory-readiness is therefore a per-project decision made in project-kickoff, logged like the others. The scaffold changes only where its shape or a shipped defect is involved: the `approved:` field, the optional review step, and the Stop-hook wording and template.
  - **Ticket 018 (a guard against weakened tests) is built with this one.** It edits the same four files, and the factory's locked tests already cover half of it for factory-built work.

## Scope
`project-kickoff/SKILL.md`, `project-kickoff/references/quality-gates.md`, `project-kickoff/assets/trust.md` and `brief.md`, `workspace-scaffold/SKILL.md`, `project-kickoff/assets/reviewer.md` (018's question), `workspace-scaffold/assets/templates/` (hooks example, `tickets-README.md`), `workspace-scaffold/assets/skills/ticket.md`. Doesn't touch purser or factory-v2.

## Done looks like
(To be written at pickup.)

## Boundary
- Wait for factory-v2 ticket 021, which writes the contract down. The cloud run no longer holds this (Logan, 2026-11-26): the local pilot showed the integration, and the cloud run tests the cloud image.
- workspace-scaffold is meant to stay stable (ROADMAP.md): keep its change to the Stop-hook template and wording, the `approved:` field, and the optional review step in `/ticket`.

## Plan
Not planned yet.

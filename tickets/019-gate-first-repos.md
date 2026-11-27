---
status: open
kind: improvement
created: 2026-11-26
---

# 019 — project-kickoff and workspace-scaffold generate repos that check at the gates, ready for the factory

## Job
Change what the two setup skills prescribe so a new repo's enforcement sits at the gates (CI on the pull request, branch rules), not in every session and every push, and so the repo meets the factory's contract from day one.

## Context
- **Specced 2026-11-26** (Logan approved the plan below the same day). The work it waited on is done: factory-v2 ticket 021 wrote the contract (`~/repos/factory-v2/docs/design.md`, "What a target repo provides") and purser's tickets 012, 015 and 016 are the worked example. Parked the same day from a review of purser (`~/repos/purser`, the first repo built with both skills) while bringing factory-v2 (`~/repos/factory-v2`) into it. Not specced: write "Done looks like" when it's picked up. This is phase 5 of that plan; purser's own fixes were its tickets 012 and 015.
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
A repo kicked off and scaffolded from these skills comes out like purser is today, without the detours.

**The principle, stated once.**
1. `project-kickoff/SKILL.md` states the rule "a check blocks only someone who can fix it" and the three gates (what goes in: an approved ticket; what merges: CI running the check command on the pull request; what ships: branch rules). Hooks are named as feedback: optional, conditional, never the only thing enforcing a rule. The sentence "Local is the source of truth; CI is confirmation" is gone, and nothing else in either skill says hooks or pre-push "call" the check command as a gate.

**project-kickoff, Phase 5 (trust) and Phase 6 (delivery).**
2. The check command holds what a builder can fix: format, lint, typecheck, tests, the quality rules, a secrets scan. The dependency audit is a scheduled workflow, not part of it, with the reason given.
3. A check that must hold (mutation testing, end-to-end tests, the axe run) is placed in the check command or a CI job on the pull request. `/vet` may run it earlier; `/vet` is never its only home.
4. Pre-push is a secrets scan only. A Stop hook is optional and, if chosen, skips when nothing changed since its last green run.
5. Phase 6 treats CI minutes as a design input for a CI-gated repo: superseded pull-request runs are cancelled, and the brief records an estimate of a month's runs against the plan's limit. The advice to keep heavy checks local "where minutes are free" is gone.
6. Acceptance tests are frozen for their own ticket's build only; after that they are regression tests a later ticket may change when its Scope names the file and the change.
7. A command guard, when a project needs one, is a script that blocks by default with named exceptions, and the docs call it best-effort. Not a regex in settings JSON.
8. `assets/trust.md` links to the settings file instead of copying its JSON.
9. **Factory-readiness is asked at kickoff** and logged like any other decision: will an agent pipeline build tickets here? If yes, the brief lists what the repo provides (one check command that CI also runs, a command that runs named test files, a setup command, CI on pull requests, no hook that blocks every push or stop). The skill names the factory and does not load its files.
10. **The spec-reviewer** ships as `project-kickoff/assets/spec-reviewer.md`, in spec-only form: it reads the ticket and the project's escalation list in `docs/trust.md`, and returns approve, changes or escalate. Phase 7's hand-off table installs it.

**Test integrity (ticket 018).**
11. `references/quality-gates.md` has, per ecosystem it covers, the lint rule that fails a focused or disabled test, each checked against the tool's current docs, or "no tool; the reviewer carries it".
12. `assets/trust.md` has the row; `assets/reviewer.md` asks about any removed or loosened assertion and treats it as must-explain, not an automatic failure.

**workspace-scaffold (its shape changes in one place).**
13. The ticket template, `tickets-README.md` and the core section of `SKILL.md` carry an `approved:` frontmatter field: empty until the plan is approved, then the date. It means the same in every repo, code or not: someone with the say approved this plan. The closed status list is unchanged.
14. The scaffold's `/ticket` sets `approved:` when the user approves the plan. As an optional step, when `.claude/agents/spec-reviewer.md` exists it dispatches it first, sets the field on approve, and stops for the user on escalate.
15. The Hooks section says a Stop hook is optional and conditional, and `assets/templates/` ships a `stop-check.sh` that takes the project's check command and skips when the tree and refs are unchanged since its last green run. `hooks-example.json` calls it.

## Boundary
- **Existing repos are not migrated.** Purser already matches; factory-v2 and this repo are left alone.
- **workspace-scaffold stays stable:** its change is criteria 13 to 15 and nothing else. The `approved:` field is a change to the shared shape, Logan's call, made on 2026-11-26.
- **No skill loads another skill's or repo's files.** The factory's contract is restated in the brief's own words as five lines, with the factory named as the owner. That is a second copy of a fact; it is accepted because a skill folder has to stand alone, and criterion 9 keeps it to a list.
- **Deleted assertions are a reviewer question, not a hard fail** (018's open boundary, decided here): legitimate deletions happen, and a later ticket may change a finished test.
- Not in this ticket: a guard template (purser's is specific to its env files), and any change to `/vet` or `/wrap` in the scaffold.

## Plan (approved 2026-11-26)
The pattern is the one purser ended on: **enforce at the boundary, give feedback inside it.** Alternatives not picked: keeping the full check in pre-push with an escape hatch (still blocks the wrong party, just less often), and making factory-readiness part of the scaffold (the scaffold serves repos with no code).

1. **quality-gates.md first** (018, criterion 11): look up the focused/disabled-test rules in each ecosystem's current docs. Everything later cites this file.
2. **project-kickoff/SKILL.md:** add the principle (1), then rewrite the Phase 5 paragraphs for the check command, mechanical versus judgment, supply chain, UI gates, mutation testing and acceptance criteria (2, 3, 6, 7, 11), Phase 6's CI and pre-push paragraphs (4, 5), the factory-readiness question (9), and Phase 7's hand-off table (hooks optional; the spec-reviewer row).
3. **Assets:** `trust.md` (2, 3, 4, 6, 8, 12), `brief.md` (5, 9), `reviewer.md` (12), new `spec-reviewer.md` (10), generalised from purser's with its project words removed.
4. **workspace-scaffold:** the `approved:` field in three places (13), `/ticket` (14), the Hooks wording and the `stop-check.sh` template generalised from purser's (15). Ask the three template questions from CLAUDE.md for each.
5. **Check both sides of the hand-off** in one read: every row of Phase 7's table has a target that exists in the scaffold, and nothing the scaffold installs is unmentioned.
6. Two DECISIONS.md lines: the principle, and `approved:` entering the shape. `/vet`.

**Verification** (this repo has no tests, so each check is a named read or a real run):
- **A scratch repo, scaffolded for real.** In a throwaway directory with a tiny Node project and a CI workflow, a subagent follows the new workspace-scaffold from cold. Then factory-v2's `install.py` runs against it: the only contract warning allowed is "no ticket carries `approved:`", and it clears after the scratch `/ticket` approves one. This is the test that the two skills and the factory agree.
- **The Stop-hook template, run for real** in that repo: green run writes its stamp, an unchanged tree skips, an edited file runs again, a red run is retried.
- **A cold read.** A subagent given only the new `project-kickoff` text answers six questions drawn from purser's clashes (where does the audit run; what does pre-push run; where does mutation testing run for factory-built work; what does a Stop hook do in a session that changed nothing; when may a finished ticket's test change; who sets `approved:`). Each answer must match purser today.
- **Phrase check:** `grep` finds none of "source of truth; CI is confirmation", "where minutes are free", "pre-push calls it".
- `/vet` against this repo's REVIEW.md.

**What these checks won't catch:**
- **No real kickoff is run.** project-kickoff's true test is a conversation about a new project, and the cold read only shows the text is unambiguous on six points. The first real kickoff after this is the test; expect a follow-up ticket from it.
- **Only the Node rows of quality-gates.md are exercised.** The other ecosystems' rules are checked against docs, not run.
- **The scratch repo is tiny.** It can't show whether the Stop-hook template's fingerprint holds on a repo with submodules, large untracked trees or unusual ref layouts.
- **The contract is copied as five lines** into the brief. If the factory's contract changes, nothing here notices.


## Outcome
Built as planned on 2026-11-26; awaiting the main session's cold read and /vet. Plan steps 1 to 5 are done; step 6's DECISIONS.md lines are written. Where it differs from the plan or the criteria's wording:
- **The spec-reviewer is written in Phase 5**, beside the reviewer, and Phase 7's table has a row for it ("already in place; the scaffold's `/ticket` dispatches it"). That matches how `reviewer.md` is handled.
- **The Stop-hook template takes the check command as its arguments** (`stop-check.sh npm run check --silent`), so the command lives in `settings.json` and the script carries no placeholder. Purser's fingerprint is kept unchanged. Its header adds one pitfall: files the check writes must be gitignored, or the skip never fires.
- **Phase 7 got one sentence** naming what the scaffold installs with no kickoff input (`/wrap`, `/ticket` and its README, the SessionStart hook), so the hand-off check in step 5 has nothing unmentioned.
- **Verification run:** a scratch Node repo was scaffolded from the new text and factory-v2's `install.py` was run against it. The only contract warning was "no ticket carries `approved:`", and it cleared after a scratch ticket was approved through the scaffolded `/ticket`. A secrets-only pre-push drew no warning either. The Stop hook was run for real: a green run wrote the stamp, an unchanged tree skipped, an edited file ran again, a red run was retried, and a tag-only change ran it again. The phrase grep finds none of the three phrases.
- **Left alone, outside criteria 13 to 15:** workspace-scaffold's principle 2 and Step 3a still say mechanical checks "go in hooks", and the REVIEW.md template still says checks are "enforced by hooks". They now sit awkwardly with "hooks are feedback". This repo's own `tickets/README.md`, which mirrors the template, has no `## Approved` section.

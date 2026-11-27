---
status: open
created: 2026-11-06
source: request
---

# 018 — project-kickoff: guard against weakening tests to get green

## Job
Add a guard to the Phase 5 trust layer against an agent skipping, focusing, or deleting tests, or removing assertions, to make the checks pass. Mechanical where a tool can catch it; a reviewer question where it can't.

## Context
On 2026-11-06 the global `~/.claude/CLAUDE.md` gained the principle "Never weaken, skip, or delete a test to get to green. If a test looks wrong, say so." It came from `~/repos/swe-research/reports/Software design principles for agents.md`, which calls this the one hole in Logan's trust layer: his review is at the plan and the checks, so a test the agent rewrote to pass hides the failure from him. The report's placement table puts `.skip`, `.only`, and deleted assertions in a pre-commit or Stop hook, because prose in CLAUDE.md is guidance the model may decide doesn't apply.

The current trust layer doesn't cover it. `project-kickoff/assets/reviewer.md` item 2 catches tautological tests. Mutation testing catches tests that are too weak, but not a test rewritten to assert the wrong behavior. Nothing in `project-kickoff/references/quality-gates.md` or `project-kickoff/assets/trust.md` flags focused or disabled tests, or a net loss of assertions.

- **2026-11-26:** specced inside ticket 019 (its criteria 11 and 12, and the Boundary line on deleted assertions). Built and closed with it.
- **2026-11-26:** to be built together with ticket 019 (gate-first repos): same four files, and the lint rules land in the check command that 019 re-homes at the CI gate.

## Scope
- `project-kickoff/SKILL.md`: a Phase 5 concern for test integrity.
- `project-kickoff/references/quality-gates.md`: the lint rules per ecosystem for focused and disabled tests.
- `project-kickoff/assets/trust.md`: a row in the mechanical table.
- `project-kickoff/assets/reviewer.md`: a question for removed or loosened assertions.

The hand-off side: Phase 7 already maps `trust.md` mechanical checks to hooks and the check command, so workspace-scaffold needs no change. Confirm `workspace-scaffold/assets/templates/hooks-example.json` doesn't need a new shape. Existing repos are not migrated by this ticket.

## Done looks like
- A kickoff's `docs/trust.md` lists the guard, and its check command fails on a committed focused or disabled test.
- The reviewer treats any removed or loosened assertion as must-explain.
- The rule names in quality-gates.md are checked against current tool docs, not written from memory.

## Boundary
- Deleted-assertion detection isn't a lint rule. Decide in the plan between a diff-based check and a reviewer question. Legitimate test deletions happen, so a hard fail may be wrong.
- Some ecosystems may have no tool for this. Write that down; the reviewer carries it, per quality-gates.md's existing convention.

## Plan (proposed)
1. Look up current lint rules for focused and disabled tests in each ecosystem quality-gates.md covers, and add a row to each.
2. Add the row to `assets/trust.md`'s mechanical table.
3. Add the assertion question to `assets/reviewer.md`.
4. Add the Phase 5 concern to `SKILL.md`.
5. Test by retrofitting one repo that has a test suite (Logan picks which), append a `[decision]` line to DECISIONS.md, run /vet.

## Outcome
Built inside ticket 019 on 2026-11-26 (its criteria 11 and 12). `references/quality-gates.md` has a focused/disabled-test row per ecosystem, checked against current docs: the vitest, jest and playwright eslint plugins (set to error explicitly, because the recommended configs ship the disabled-test rules at warn), ruff's `TID251` banned-api for pytest and unittest skips (verified by a run with ruff 0.17.6), golangci-lint's `forbidigo` and ginkgolinter for Go, and "no tool; the reviewer carries it" for Rust (`clippy::ignore_without_reason` only requires a reason). `assets/trust.md` has the row, SKILL.md Phase 5 has the Test integrity concern, and `assets/reviewer.md` item 3 treats a removed or loosened assertion as must-explain, not an automatic failure. The plan's retrofit of one real repo didn't happen: no existing repo is migrated, and purser already has its own `scripts/check-tests.mjs`. `hooks-example.json` needed no new shape for this.

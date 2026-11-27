# {{PROJECT_NAME}} — Trust layer

<!-- Written by project-kickoff, Phase 5. Read when writing a unit of work, writing tests, adding a check, or deciding whether green means done. /ticket reads the escalation list and dispatches the spec-reviewer; /vet reads this and dispatches the reviewer. -->

## What green means here

Passing checks mean the code does what the acceptance criteria say and nothing mechanical is broken. They do not mean the right thing was built. The user reviews at milestones — against the sequence diagrams in `docs/architecture.md`, the acceptance criteria on each unit of work, and the slice boundaries — not line by line.

## Acceptance criteria

Every {{UNIT_OF_WORK}} carries a `## Done looks like` section written as checkable statements, approved by the user before implementation starts. Tests are named after the criteria they prove ({{NAMING_CONVENTION_EXAMPLE}}). A test that doesn't trace to a criterion is either a regression guard for a logged learning or a candidate for deletion.

A {{UNIT_OF_WORK}}'s acceptance tests are frozen while it is being built: a builder that finds one wrong stops and says so. Once it is done they are regression tests, and a later {{UNIT_OF_WORK}} may change one only when its Scope names the file and the change.

## Test layers

| Layer | Exists | Protects against | Runs in |
|---|---|---|---|
| Unit | {{YES_NO}} | {{FAILURE_MODE}} | check command |
| Integration | {{YES_NO}} | {{FAILURE_MODE}} | check command |
| End to end | {{YES_NO}} | {{FAILURE_MODE}} | {{CHECK_COMMAND_OR_CI_JOB}} |

Tests run against {{FIXTURES_FROM_DATA_MODEL}}; see `docs/data-model.md`.

## The check command

`{{CHECK_COMMAND}}` runs, in order: format check, lint (with the test-integrity and code-quality rules), typecheck, tests, secrets scan ({{SCANNER}}). It holds what a builder can fix and nothing else.

## Where the checks run

A check blocks only someone who can fix it. Three gates hold, and no session can skip them; everything else is feedback.

| Gate | Runs | Holds |
|---|---|---|
| Approved {{UNIT_OF_WORK}} | {{HOW_APPROVAL_IS_RECORDED — e.g. a non-empty `approved:` on the ticket}} | What goes in |
| CI (`{{WORKFLOW_PATH}}`) | `{{CHECK_COMMAND}}` on every pull request into `{{MAIN_BRANCH}}`, superseded runs cancelled{{IF_SLOW_CHECKS: ; plus {{SLOW_CHECK_JOBS — e.g. mutation testing on pull requests touching `src/core/`}}}} | What merges |
| Branch rules | `{{PRODUCTION_BRANCH}}` takes only a pull request with CI green; no force-push or delete | What ships |

A check that must hold is in the check command or a CI job on the pull request. `/vet` may run a slow one earlier in a hands-on session; it is never the only place one runs.

**Scheduled, not gating:** the dependency audit (`{{AUDIT_COMMAND — e.g. npm audit --audit-level=high}}`) runs weekly in `{{AUDIT_WORKFLOW_PATH}}`. It is not in the check command: a new advisory fails for reasons unrelated to the change being checked, and the builder may not be allowed to edit the dependencies. A failed run reaches the user.

## Mechanical vs judgment

**Mechanical (the check command, which CI runs).** Hooks add feedback on top, and nothing depends on them holding:

- PostToolUse on Edit|Write: `{{FORMATTER}}`
- Stop (optional): `{{CHECK_COMMAND_OR_FAST_SUBSET}}`, skipped when nothing changed since its last green run
- Pre-push: the secrets scan only (`{{SCANNER}}`). A pushed secret is the one thing a later check can't undo

**Judgment (REVIEW.md):**

- {{QUESTION_A_REVIEWER_ASKS}}
- {{QUESTION_A_REVIEWER_ASKS}}

## Code quality

Same split. A check that isn't in `{{CHECK_COMMAND}}` isn't enforced; a question that isn't in REVIEW.md isn't asked. There is no style guide: the language's conventions are known, the rows below catch the rest.

**Mechanical (in the check command):**

| Property | Tool | Threshold |
|---|---|---|
| Unused locals, params, imports | {{LINT_RULE}} | error |
| Unused exports, files, dependencies | {{KNIP_OR_VULTURE}} | error |
| Function size and complexity | {{RULES}} | {{THRESHOLDS — e.g. complexity 10, cognitive 15, 50 lines, depth 3, 4 params}} |
| Duplication | {{JSCPD}} | {{ZERO_NEW_OR_BASELINE}} |
| Layering — the arrows in `docs/architecture.md` | {{DEPCRUISE_OR_IMPORT_LINTER}} | error |
| Name shape | {{NAMING_RULE}} | error |
| Focused or disabled tests | {{TEST_LINT_RULES — e.g. `vitest/no-focused-tests`, `vitest/no-disabled-tests`}} | error |
{{IF_UI: | Accessibility, at source | {{A11Y_LINT — e.g. eslint-plugin-jsx-a11y}} | error |
| Accessibility, built pages | {{AXE_OR_PA11Y}} — {{IN_CHECK_OR_IN_A_CI_JOB}} | WCAG 2.1 AA, 0 violations |
| Bundle size | `size-limit` | {{KB}} per entry |}}

{{ROWS_WITH_NO_TOOL — "Every row has a tool" or "No tool for X in this ecosystem; the reviewer carries it"}} A removed or loosened assertion has no tool anywhere: the reviewer treats it as must-explain.
{{IF_NO_UI: UI gates skipped: no UI in v1. Revisit if the UI plan in `docs/architecture.md` is built.}}

Thresholds are tripwires, not targets: these are starting values, logged as decisions, moved once the first slices land.

**Judgment (REVIEW.md `## Readability`) — asked by a reader who was not in the session:**

- Do names use the module map's words? Could you say what a value holds without reading the implementation?
- Does each function do one thing, at one level of abstraction, and read top to bottom?
- Do comments say *why*? A comment that narrates the code, or commented-out code, is a finding.
- Is anything speculative — an abstraction with one caller, an option nobody asked for, handling for a case that cannot happen?
- Did the diff re-implement something the repo already had?
- Does every new file sit in the row `docs/architecture.md`'s placement table gives it, and follow the pattern of its neighbours?
- For each new dependency: is the name exactly the intended package, is it old enough and used enough to trust, and does the unit of work say why?
{{IF_UI_WITH_OTHER_USERS: - Does every new interactive element have an accessible name, a role, and a visible focus state? Walk the main flow with the keyboard only before calling it done. Automated checks find about half of real accessibility issues; this is the other half.}}

## Protected paths

The agent never reads or edits these, in any session:

- {{PATH — e.g. `.env`, `.env.*`}}
- {{PATH — e.g. `secrets/`}}
- {{PATH — e.g. production migrations, a directory of real data}}

CLAUDE.md's Permissions say "ask first"; this is the enforced form, and it keeps a secret out of the session transcript as well as the repo. Two things enforce it, both in [`.claude/settings.json`](../.claude/settings.json) (user approves — hooks run shell commands); that file is their one home, so it isn't copied here:

- `permissions.deny` entries keep the Read and Edit tools off these paths.
- A PreToolUse guard on Bash, `{{GUARD_SCRIPT — e.g. .claude/hooks/bash-guard.sh}}`, because a deny rule on Read does not stop `cat` on the same file. It blocks every mention of a protected path by default, with a short named list of exceptions ({{EXCEPTIONS}}). It is best-effort: it catches accidents in command text, and a command can reach a file without naming it.

## Mutation testing

{{ENABLED_OR_SKIPPED}} — {{REASON}}. {{IF_ENABLED: Tool: `{{STRYKER_OR_MUTMUT}}`; scope: `{{CORE_PATHS}}`; threshold: {{PERCENT}}; runs as a CI job on pull requests that touch `{{CORE_PATHS}}` (`{{COMMAND}}`). `/vet` may run it earlier; never the Stop hook.}}

## Escalation list

The spec-reviewer must escalate to the user, rather than approve, if a {{UNIT_OF_WORK}} does any of these:

- {{TRIGGER — e.g. changes a port, a module's interface, the module map, or the placement table in `docs/architecture.md`}}
- {{TRIGGER — e.g. changes the schema}}
- {{TRIGGER — e.g. adds a dependency not in the stack table in `docs/brief.md`}}
- {{TRIGGER — e.g. contradicts or changes a logged decision}}
- {{TRIGGER — e.g. goes beyond the brief's Done looks like, or touches Explicitly out of scope, a must-never item, or a protected path}}
- Still isn't approved after two rounds

The list is mechanical so the reviewer never weighs whether a change "really matters".

## The reviewers

Independent agents, each with its own context. Neither reads the conversation that produced the work — that separation is the point.

- **`.claude/agents/spec-reviewer.md`**, before the build, on the {{UNIT_OF_WORK}} alone: does it faithfully and checkably implement the docs, and does it hit the escalation list? It returns approve, changes, or escalate; `/ticket` sets `approved:` on approve.
- **`.claude/agents/reviewer.md`**, after the build: it receives the {{UNIT_OF_WORK}} and the diff, reads this file and REVIEW.md, runs the check command, and reports must fix / should fix / fine.

## For /vet

When the scaffold writes this project's `/vet`, its body should:

1. Run any script-only checks first ({{NONE_OR_LIST}}).
2. Dispatch the `reviewer` subagent with: the current {{UNIT_OF_WORK}} file, `git diff {{BASE}}`, and paths to `docs/trust.md` and `REVIEW.md`.
3. Return the reviewer's report unchanged; do not soften it.

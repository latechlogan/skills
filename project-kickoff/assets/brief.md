# {{PROJECT_NAME}} — Brief

<!-- Written by project-kickoff. Sections marked (Phase N) are filled in that phase; delete any section that doesn't apply rather than leaving it empty. -->

## What

{{ONE_SENTENCE}}

## Who

{{WHO_USES_IT_AND_HOW}}

## Done looks like

{{V1_AS_OBSERVABLE_BEHAVIOR}}

**Walking skeleton (milestone 1):** {{THINNEST_END_TO_END_PATH}} — tested, running on {{RUNTIME_TARGET}}.

## Explicitly out of scope

- {{NOT_THIS}}
- {{NOT_THAT}}

## Constraints

| Constraint | Value | Design response |
|---|---|---|
| Runs on | {{RUNTIME}} | |
| Hosted at | {{HOSTING_OR_NONE}} | |
| Budget | {{BUDGET}} | |
| Repo visibility | {{PUBLIC_OR_PRIVATE}} | {{CI_MINUTES_RESPONSE}} |
| Secrets | {{WHAT_THEY_ARE_AND_WHETHER_CI_HAS_THEM}} | |
| External APIs | {{NAME_AND_QUOTA}} | |
| Deadline | {{DATE_OR_NONE}} | |

**Must never happen:**

- {{NEVER_THIS}}

## Stakeholders

<!-- Delete if the user owns this outright. -->

{{WHO_APPROVES_WHAT}}

## Stack (Phase 2)

| Layer | Choice | Decided by |
|---|---|---|
| Language / runtime | {{CHOICE}} | {{FIT_OR_CONSTRAINT_OR_FAMILIARITY}} |
| Framework | {{CHOICE}} | |
| Persistence | {{CHOICE_OR_NONE}} | |
| Tests | {{CHOICE}} | |
| Format / lint / types | {{CHOICE}} | |
| Quality gates | {{DEAD_CODE_COMPLEXITY_DUPLICATION_LAYERING_TOOLS}} | |
| Hosting | {{CHOICE_OR_NONE}} | |

**Alternative considered:** {{ALTERNATIVE_AND_WHY_NOT}}

**Dependency policy:** lockfile committed; versions pinned; adding a dependency beyond {{THE_BAR}} is a logged decision, not a default.

## Delivery (Phase 6)

- **Deploy path:** {{PUSH_TO_MAIN_OR_TAG_OR_MANUAL}}
- **Rollback:** {{HOW}}
- **CI runs:** the check command (`{{CHECK_COMMAND}}`) on every pull request into `{{MAIN_BRANCH}}`{{IF_SLOW_CHECKS: , plus {{SLOW_CHECK_JOBS}}}}; superseded pull-request runs are cancelled
- **CI minutes:** {{LIMIT_OR_UNLIMITED}}; a month estimated at {{RUNS_PER_UNIT}} runs × {{UNITS_PER_MONTH}} units × {{MINUTES_PER_RUN}} min = {{TOTAL}} min against it
- **Branch rules:** `{{PRODUCTION_BRANCH}}` takes only a pull request with CI green (user switches them on in repo settings)
- **Pre-push:** the secrets scan only (`{{SCANNER}}`)
- **Dependency audit:** weekly scheduled workflow, not in the check command
- **Agent pipeline:** {{YES_OR_NO_AND_WHY}}. {{IF_YES: The repo provides what the factory (`factory-v2`, which owns this contract) needs:
  - one check command, the same one CI runs: `{{CHECK_COMMAND}}`
  - a command that runs named test files: `{{NAMED_TESTS_COMMAND — e.g. npx vitest run {files}}}`
  - a setup command for a fresh checkout: `{{SETUP_COMMAND — e.g. npm ci}}`
  - CI on pull requests into `{{MAIN_BRANCH}}`
  - no hook that blocks every push or every stop}}
- **Config:** validated at startup; `.env.example` committed; secrets in {{WHERE}}; CI has {{WHICH_SECRETS}}
- **Failure modes:** {{EXTERNAL_DEP}} — {{RETRY_TIMEOUT_IDEMPOTENCY}}
- **Between sessions:** Dependabot security updates {{ON_OR_WHY_NOT}} (user switches it on in repo settings); Renovate deferred

## Decisions

<!-- One per line, scaffold grammar. Lifted verbatim into DECISIONS.md at hand-off, then this section is deleted. -->

- {{YYYY-MM-DD}} — [decision] {{ENTRY}}

## Kickoff status

- [ ] 1 Brief
- [ ] 2 Stack
- [ ] 3 Data and state
- [ ] 4 Architecture and interfaces
- [ ] 5 Trust layer
- [ ] 6 Delivery
- [ ] 7 Scaffolded

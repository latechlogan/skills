---
name: project-kickoff
description: Plan a new project before any code or scaffolding exists — the brief and constraints, the stack, the data model, the architecture with diagrams, the interface and UI plan, the trust layer (tests, code quality gates, hooks, an independent reviewer agent), and delivery — in a gated conversation that leaves the plan in docs/ and hands off to workspace-scaffold. Use whenever the user wants to start, plan, kick off, or build something new that has no repo yet — "new project," "I want to build," "let's make a tool that," "start an app/script/site/service" — even if they ask for code directly; the planning comes first and the skill says so. Also use to resume an unfinished kickoff (docs/brief.md exists with an incomplete Kickoff status). Not for adding features to an existing project.
---

# Project Kickoff

When agents write the code, the user's understanding of the system has to come from somewhere other than writing it. This skill is that somewhere. It runs before any code exists and produces the plan the user will hold in their head while agents build: what the thing is and isn't, what it runs on, how data moves through it, where the boundaries are, and what has to be true before work counts as done. The scaffold gives a repo the files a session needs; the kickoff gives the user the model of the system those files describe.

The pain it exists to prevent, in the user's words: projects that come into existence all at once and feel like a magic box; review that can't keep up with generation; a CI limit discovered after the architecture was already set; a project that lived only in files when a thin UI would have made it usable.

## Principles

1. **Understanding is the deliverable.** Every artifact exists so the user can reason about the system at the architecture level, because that is the level they will review at. If a document wouldn't help them explain the system to someone else, it doesn't earn its place.
2. **Every concern gets a considered answer, including "skip."** No branches, no tiers. The concerns below are fixed; whether each is worth doing is a fact about *this* project, argued for by you, decided by the user, and logged either way. "Skipped: no persistence" is a valid decision. An early answer never silently routes the rest of the conversation.
3. **Propose, then ask.** Extract everything you can from what the user has already said before asking anything. For each open question, lead with a recommendation and its reason, then ask. A bare question makes the user do the thinking the skill exists to share.
4. **Familiarity is a real criterion.** Code the user can read is code they can review. When a tool outside their familiarity is clearly better, say so and name the trade; when familiarity is the deciding factor, say that too. Never assume a stack and never hide why one was chosen. See `references/stack-familiarity.md`.
5. **Phased, gated, resumable.** Each phase ends by writing its file and stopping. The state lives in `docs/`, not in the session, so a kickoff can pause after any phase and resume in a new one. The user decides the pace.
6. **Clean code is a gate, not a request.** Agents write more code than the job needs, reuse less of what exists, and almost never tidy on their own; a paragraph asking for readable code is the weakest lever there is. So the kickoff never writes a style guide. Everything a machine can check about readability — dead code, size, complexity, duplication, layering — goes in the check command; what needs a reader goes to the reviewer as questions; CLAUDE.md gets only the rules that differ from the language's defaults. See `references/quality-gates.md`.
7. **A check blocks only someone who can fix it.** Enforcement sits at three gates no session can skip: what goes in (a unit of work with an approved plan), what merges (CI running the check command on the pull request), and what ships (branch rules on the production branch). Everything else, the hooks included, is feedback: optional, conditional, and never the only thing enforcing a rule. A check that blocks the wrong party gets worked around: a dependency audit blocks a builder who can't edit the dependencies, a Stop hook that always runs blocks a session that changed nothing, a pre-push that runs the tests blocks tests pushed red on purpose. Phases 5 and 6 place every check by this rule.

## How a phase runs

Every phase follows the same loop:

1. Read what exists — the conversation, and any `docs/` files from earlier phases.
2. Cover the phase's concerns. For each, state what you'd do here and why, or recommend skipping and why. Ask. Keep it conversational; batch related questions, don't interrogate.
3. Write the phase's file from `assets/`, fully customized. Replace every `{{PLACEHOLDER}}`; delete every section that doesn't apply. A half-filled template is worse than none.
4. Append the phase's decisions to `docs/brief.md` `## Decisions`, one per line, in the scaffold's grammar so they lift straight into DECISIONS.md later: `- YYYY-MM-DD — [decision] entry`. Skips are decisions.
5. Mark the phase done in `docs/brief.md` `## Kickoff status`.
6. Stop and say, in one line: what was written, and that the user can continue to the next phase now or resume later by invoking the skill again. Wait for the answer.

**Resuming.** If `docs/brief.md` exists, read `## Kickoff status`, re-read the completed docs, and pick up at the first unfinished phase. Don't re-ask what the docs already answer.

**Diagrams** are Mermaid in markdown — they render in GitHub, VS Code, and Obsidian, and an agent can regenerate them. Hand-drawn diagrams show intent; where the ecosystem has a tool that emits a dependency graph from code (dependency-cruiser or madge for JS/TS, pydeps for Python), add it as a script so there is also a diagram that can't lie.

---

## Phase 1: Brief

**Why:** everything downstream is decided against the brief. The constraints inventory in particular is where the CI-limit problem gets caught — a constraint that isn't written down is one the architecture won't route around.

Writes `docs/brief.md` from `assets/brief.md`.

**Concerns:**

- **What and who.** One sentence for what it is; who uses it (the user, a stakeholder, a customer). These become CLAUDE.md's first lines at scaffold time.
- **Done looks like.** What v1 does, stated as observable behavior. Then the **walking skeleton**: the thinnest path end to end — one real input to one real output, tested, running where it will actually run. That is milestone one, always, because everything after it is an increment against something the user already understands. Name it concretely for this project.
- **Explicitly out of scope.** The best scope-creep control an agent has. Ask for it directly; agents add features when the boundary is implied.
- **Constraints inventory.** Go through each; "none" is an answer worth recording:
  - Where it runs (user's machine, a server, an edge runtime, a cron) and where it's hosted
  - Budget, including "must be free"
  - Repo visibility. Private repos on a free GitHub plan have a monthly cap on Actions minutes — check the current limit rather than assuming, and treat it as a design input in Phase 6
  - Secrets: what they are, whether CI can have them
  - External APIs and their quotas or rate limits
  - Time or deadline
  - Anything that must not happen (never write to the production DB, never email real users)
- **Stakeholders.** Only if someone other than the user owns it — who approves what.

Skip when: nothing here is skippable. A single-file script still has a runtime, a repo, and a finish line; the brief is just short.

---

## Phase 2: Stack

**Why:** the stack decides what the user can read, and reading is how review happens now.

Read `references/stack-familiarity.md` first. Then propose **one stack with reasons and one credible alternative**, covering language/runtime, framework, persistence, test runner, formatter/linter, and hosting as applicable. For each pick, say which of these decided it: fit for the problem, the constraints from Phase 1, or the user's familiarity. When a tool outside their familiarity would be better, name it, name the cost of not reading it fluently, and let them choose. Then ask.

**Dependency policy.** Decide it here and log it: lockfile committed, versions pinned, and the bar above which adding a dependency is a decision the agent logs rather than a thing it just does. Agents add libraries freely; the policy is what stops that. Three checks travel with every addition, because agents also add packages that sound right but aren't: the name is exactly the intended package, the package is old enough and used enough to trust (`npm view <name> time.created` and weekly downloads), and the reason is stated in the unit of work. Version freshness (Renovate) is deferred by default and logged as such — it fires on a calendar, not a signal — and revisited when a repo has users or a major falls behind.

**Quality gates.** With the linter, pick the tools that make "clean" checkable in this ecosystem — dead code (unused locals *and* unused exports, files, dependencies), function size and complexity, duplication, and layering — from `references/quality-gates.md`. Name them in the stack table; Phase 5 puts them in the check command with thresholds. A row the ecosystem has no tool for is a fact to write down, because it falls to the reviewer.

Writes to `docs/brief.md` `## Stack`.

Skip when: never. Even a script has a language and a runtime.

---

## Phase 3: Data and state

**Why:** the data model is usually more decisive than the architecture, and most testing and CI pain traces back to it — tests that need a real database, no fixtures, no seed data.

Writes `docs/data-model.md` from `assets/data-model.md`.

**Concerns:**

- Entities and their relationships (a Mermaid `erDiagram` if there's more than a couple)
- What is stored versus derived — derived data that gets stored is a bug factory
- Schema and migration approach, and who runs migrations
- Seed data and fixtures: what tests run against, where it lives, how it's regenerated
- For in-memory or file-based state: the shape, and where it's read and written

Skip when: there is no persistence and no state beyond a function's arguments. Log the skip; a project that later grows state will find the decision and know it was deliberate.

---

## Phase 4: Architecture and interfaces

**Why:** this is the map. The fog comes from not knowing what owns what and how data moves; the module table answers the first, the sequence diagrams answer the second. The interface plan is what makes a later UI cheap instead of a rewrite.

Writes `docs/architecture.md` from `assets/architecture.md`.

**Concerns:**

- **Module map.** A table: module — owns — receives — emits. One row per meaningful unit. If a row is hard to write, the boundary is wrong.
- **Container diagram.** Mermaid flowchart of the pieces and what talks to what. Intent, not detail.
- **Sequence diagram per primary use case.** One per "when the user does X" for the two to four things the system mainly does. These are the fog fix; boxes don't show flow.
- **Core and adapters.** Name the boundary between the logic and everything that touches the outside world (CLI, HTTP, DB, external APIs, a future UI). Logic behind an interface; each entry point is an adapter. This is the ports-and-adapters pattern; naming it lets the agent apply it consistently.
- **Where a new file goes.** Name the layers this project has and the one direction dependencies point, then write the placement table: kind of code → directory → what it may import. For an HTTP service the familiar vocabulary is controller → service → repository; that is ports-and-adapters with the controller and repository as adapters and the service as the core, so use the words the user reads and keep the direction. The table is what makes layering enforceable (Phase 5 writes one dependency rule per forbidden arrow) and what makes agent-written code predictable to read: a reader who knows the table knows where to look. The names in the module map are the names in the code; a module, type, or function called something else is a finding.
- **Primary interface, day one.** How the user interacts with the thing before any UI exists — a CLI, a REPL, an HTTP endpoint. Decide it so the project never lives only in files.
- **UI plan.** What a UI would show and which ports it would use, written even when no UI is built. Recommend building it only when the lift is small relative to the project; otherwise the plan is enough and the ports keep it cheap. If a UI is built in v1, that decision switches on Phase 5's UI gates — accessibility lint, an axe run, a bundle-size ceiling — regardless of who uses it; whether anyone but the user uses it decides the judgment half.
- **Observability.** Structured logging from the start, with a debug mode that shows data moving through the sequence diagrams at runtime. This is the other half of not having a magic box.
- **Build order.** Vertical slices — thin, end to end — never layer by layer. The walking skeleton from Phase 1 is slice one. List the first three or four slices in order.
- **Generated graph.** If the ecosystem has a tool for it, add the script and name it here.

Skip when: a single-purpose script with one path gets the module table and one sequence diagram and nothing else. Log it.

---

## Phase 5: Trust layer

**Why:** the user wants to trust green checks instead of reviewing every line. That only holds when the tests are independent of the code — tests written by the agent that wrote the implementation, in the same context, tend to pass because they test what was built, not what was asked for. This phase builds the independence.

Writes `docs/trust.md` from `assets/trust.md`, `.claude/agents/reviewer.md` from `assets/reviewer.md`, and, when the unit of work is a ticket, `.claude/agents/spec-reviewer.md` from `assets/spec-reviewer.md`.

**Concerns:**

- **Acceptance criteria.** Every unit of work carries checkable criteria written or approved by the user, and tests are named after them. Tests trace to the spec, not the implementation. Decide the convention here. A unit of work's acceptance tests are frozen while that unit is being built, because the freeze exists to stop a builder editing the tests it is graded by. Once the unit is done they are regression tests: a later unit of work may change one when its Scope names the file and the change, so the reviewer and the user see it.
- **Test layers for this project.** Which of unit, integration, end-to-end exist and why; what each protects against. Don't prescribe a pyramid — decide what this system's failure modes are and test at the layer where they show.
- **The check command.** One command — `npm run check`, `make check`, whatever fits — holding everything a builder can fix: format check, lint, typecheck, tests, the test-integrity and code-quality rules, and a secrets scan. CI runs it on every pull request, and that is the merge gate; one command means a session and CI never disagree about what green is. A check that must hold but is too slow for every run — mutation testing, end-to-end tests, the axe run — goes in a CI job on the pull request, scoped to the paths it judges when that saves minutes. `/vet` may run it earlier in a hands-on session, but `/vet` is never its only home: a session skill never runs on work an agent pipeline builds. Hooks are optional feedback. If the project wants a Stop hook, it skips when nothing changed since its last green run, so a session that changed nothing, or only orchestrated, is never blocked.
- **Mechanical versus judgment.** Split every check into what a machine verifies (→ the check command, or a CI job on the pull request) and what needs a reviewer's judgment (→ REVIEW.md). Never both: the scaffold's principle 2, that REVIEW.md never repeats a mechanical check, applies unchanged.
- **Code quality.** Split it the same way. Mechanical, into the check command with each threshold logged as a decision: unused locals and unused exports, orphan modules, function size and complexity, duplication, the layering rules from Phase 4's placement table, name shape. Judgment, into `docs/trust.md` `## Code quality` and from there REVIEW.md: do names use the module map's words, does each function do one thing, do comments say why, is anything speculative (an abstraction with one caller, an option nobody asked for, handling for a case that cannot happen), did the diff re-implement something the repo already had. `references/quality-gates.md` has the tools and starting thresholds by ecosystem. Thresholds are tripwires, not targets: start at the defaults and move them once the first slices land. Do not write a style guide — the language's conventions are already known, the gates catch the rest, and a long CLAUDE.md is how rules get ignored.
- **Test integrity.** The user reviews the plan and the checks, not the diff, so a test the agent skipped, focused, deleted, or loosened to get green hides the failure from them. A committed focused or disabled test fails the check command (the lint rule per ecosystem is in `references/quality-gates.md`; where there is none, say so in `docs/trust.md`). A removed or loosened assertion has no tool: the reviewer treats it as must-explain, not an automatic failure, because legitimate deletions happen.
- **Supply chain.** A dependency audit — `pnpm audit --audit-level=high`, `npm audit --audit-level=high`, or `pip-audit` — runs as a weekly scheduled workflow, not in the check command: a new advisory fails for reasons unrelated to the change being checked, and blocks a builder who may not be allowed to edit the dependencies. A failed run reaches the user, who decides the bump. The reviewer checks every new dependency against the Phase 2 policy. See `references/quality-gates.md` `## Supply chain`.
- **UI gates.** Only when Phase 4 built a UI: accessibility lint at source, an axe or pa11y run over the built pages, and a `size-limit` ceiling on the bundle. A static build runs axe in the check command; anything that needs a running server runs it in the end-to-end layer, placed like any slow check (above). Automated tooling finds roughly half of real accessibility issues; the other half is judgment, switched on by Phase 1's "who": if anyone but the user uses it, REVIEW.md gets a keyboard-only walk of the main flow and the reviewer asks whether every new interactive element has a name, a role, and a visible focus state. No UI → log "skipped: no UI" and move on.
- **Protected paths.** The files an agent must never read or edit in this project — `.env*`, `secrets/`, production migrations, anything holding real data — listed in `docs/trust.md`. At scaffold time the list becomes a permissions deny list for the file tools and a PreToolUse guard on Bash, because a deny rule on Read does not stop `cat .env`. CLAUDE.md's "ask first" is advisory; this is the enforced form, and it keeps a secret out of the session transcript as well as the repo. The guard is a script that blocks every mention of a protected path by default, with a short named list of exceptions, not a regex in the settings JSON: a pattern that lists the bad forms leaks each form nobody listed. The docs call it best-effort: it catches accidents in command text, and a command can reach a file without naming it.
- **Mutation testing.** Coverage says the code ran; mutation score says the tests would notice if it broke — it is the actual measurement of whether green means anything. Recommend it for core logic where wrong-and-green is expensive (Stryker for JS/TS, mutmut for Python); recommend skipping it for glue and scripts. When enabled it is a check that must hold, placed like any slow check (above), typically a CI job on pull requests that touch the core. Log the call.
- **The reviewer agent.** Write `.claude/agents/reviewer.md` for this project from the template: it gets the spec and the diff, reads `docs/trust.md` and REVIEW.md, runs the check command, and never reads the implementer's conversation. Its own context window is what makes it independent — and it is the reader the code quality judgment items are written for, which is why they are questions and not rules. At scaffold time, `/vet` dispatches it — write the `## For /vet` section in `docs/trust.md` so the scaffold knows.
- **The spec-reviewer.** When the unit of work is a ticket, write `.claude/agents/spec-reviewer.md` from the template. It reviews the ticket alone, before anything is built, against the docs and the escalation list in `docs/trust.md`, and returns approve, changes, or escalate. Its approve is what lets a ticket's `approved:` be set without the user reading the spec; escalate always reaches the user. Decide the escalation list here — the changes the user must see; `assets/trust.md` `## Escalation list` has the starting set. A mechanical list is what keeps the reviewer from judging how much a change matters.
- **What green doesn't catch.** Say it plainly in the doc: passing checks don't catch "built the wrong thing." The user's review moves from code-level to milestone-level — the sequence diagrams, the acceptance criteria, the slice boundaries — but it doesn't go to zero.

Skip when: a throwaway script may skip mutation testing and the reviewer; it still gets a check command and acceptance criteria, because those cost nothing.

---

## Phase 6: Delivery

**Why:** CI/CD that gets bolted on later inherits every limit the architecture didn't plan for. Deciding it now, with the Phase 1 constraints in view, is what makes it fit.

Writes to `docs/brief.md` `## Delivery`.

**Concerns:**

- **Where it runs and how it gets there.** The deploy target from Phase 1, the deploy path (push to main, tagged release, manual), and rollback.
- **CI provider and its limits.** CI is the merge gate: it runs the check command, plus the slow-check jobs from Phase 5, on every pull request into the main branch and into the production branch when that is a separate one (its branch rules need a green run), and on every push to the main branch when sessions push there directly. That makes Actions minutes on a private repo a design input. Cancel superseded runs on a pull request (a concurrency group with cancel-in-progress for pull requests, never for the main branch, where each push run needs a group of its own or a queued run is dropped). Then estimate a month — runs per unit of work, times units a month, times minutes per run — and record it in the brief against the plan's limit. An agent pipeline pushes after every stage, so one unit of work can start several runs.
- **Branch rules.** The ship gate: the production branch takes only a pull request with the check green, and can't be force-pushed or deleted. They are server-side, so they hold for every session and machine. They are a repository setting the user switches on; name them in the hand-off.
- **Pre-push hook.** A secrets scan only, because a pushed secret is the one thing a later check can't undo. It is best-effort: `--no-verify` or a clone without the hook set up skips it, so the check command's secrets scan in CI is the backstop: it can't unpush a secret, but it flags one to rotate. Everything else waits for CI on the result; a pre-push that runs the check blocks pushes that are red on purpose, such as acceptance tests written before the code.
- **Agent pipeline.** Ask: will an agent pipeline (the factory, `factory-v2`) build tickets here? Log the answer either way. If yes, the brief lists what the repo provides for it: one check command that CI also runs; a command that runs named test files; a setup command for a fresh checkout; CI on pull requests; no hook that blocks every push or every stop. The factory owns that contract; the list restates it so the kickoff needs nothing outside this skill. It fits only a repo with a test suite.
- **Configuration and secrets.** Config validated at startup so a missing variable fails loudly and early; a committed `.env.example`; secrets never in the repo; which secrets CI has, and what tests do without the ones it doesn't.
- **Failure modes.** For each external dependency: what happens when it's down or slow, retries, and whether operations are idempotent.
- **Dependency security between sessions.** The check command runs only when someone is working. Dependabot security updates (repo Settings → Code security) open a PR when an advisory lands between sessions, and only then. Like the branch rules, the agent cannot switch it on — name it in the hand-off as the user's. Version-update bots stay deferred per Phase 2.

Skip when: a local-only tool with no deploy target logs "no deploy; CI runs the check command on pull requests" and moves on.

---

## Phase 7: Hand off to workspace-scaffold

Invoke `workspace-scaffold`. Tell it the kickoff docs are the answers to its Step 2 and it should extract rather than re-ask. The mapping:

| Kickoff produced | Scaffold consumes it as |
|---|---|
| `brief.md` What / Who / Stakeholders | CLAUDE.md intro lines, `## Stakeholders` |
| `brief.md` Done looks like, walking skeleton | ROADMAP.md `## Current goal` (the skeleton), `## Definition of done` |
| `brief.md` Explicitly out of scope | ROADMAP.md `## Explicitly out of scope` |
| `brief.md` Constraints, must-not-happens | CLAUDE.md `## Rules that must not bend` |
| `brief.md` Stack, Delivery | CLAUDE.md `## Commands` (the check command, deploy; with an agent pipeline, the setup and named-test commands too) |
| `brief.md` Decisions | DECISIONS.md, lifted verbatim; then delete the section from brief.md |
| `docs/*.md` | CLAUDE.md `## Where things live` pointers, one line each with when to read it |
| `architecture.md` Build order | ROADMAP.md `## This cycle's focus` |
| `trust.md` mechanical checks | The check command and the CI workflow, built with the walking skeleton; nothing for the scaffold to install. Hooks are optional feedback: a formatter on save and a Stop hook that skips when unchanged, offered in the scaffold's Step 4 and installed then, before the walking skeleton, with `--requires` so it stays quiet until the check command can run; user approves |
| `trust.md` judgment checks | REVIEW.md |
| `trust.md` `## Code quality` mechanical rows | Already in the check command; nothing to install |
| `trust.md` `## Code quality` judgment questions | REVIEW.md `## Readability` |
| `trust.md` `## Protected paths` | `.claude/settings.json` `permissions.deny` plus a PreToolUse guard script on Bash that blocks by default; user approves |
| `brief.md` Delivery, Dependabot and branch-rules lines | The hand-off summary names both as the user's to switch on |
| `architecture.md` `## Where a new file goes` | CLAUDE.md `## Where things live` pointer: "read before adding a file" |
| `trust.md` `## For /vet` | The project's `/vet` body — dispatch the reviewer |
| `.claude/agents/reviewer.md` | Already in place; scaffold references it, doesn't rewrite it |
| `.claude/agents/spec-reviewer.md` (tickets only) | Already in place; the scaffold's `/ticket` dispatches it before setting `approved:` |

The scaffold also installs what needs no kickoff input: `/wrap`, `/ticket` and `tickets/README.md` when tickets are the unit of work, and the SessionStart hook that prints the residue.

Three lines belong in CLAUDE.md `## Working style` regardless of project: build in vertical slices, walking skeleton first; at each milestone, walk the user through the data path (against the sequence diagrams) before continuing; and before `/vet`, tidy the diff as its own step — dead code, names, duplication — with Claude Code's bundled `/simplify` or a stranger's read of the diff. The second is how understanding stays current after the kickoff ends; the third exists because a first draft is never the version a reader should get, and agents do not tidy unless told when.

After the scaffold runs, set `## Kickoff status` to complete. The repo is now the plan.

---

## Files this skill ships

| Path | Read when |
|---|---|
| `references/stack-familiarity.md` | Phase 2 — the user's read/write familiarity by tool |
| `references/quality-gates.md` | Phases 2 and 5 — tools and starting thresholds for dead code, complexity, duplication, layering, and focused or disabled tests, by ecosystem |
| `assets/brief.md` | Phase 1 template |
| `assets/data-model.md` | Phase 3 template |
| `assets/architecture.md` | Phase 4 template |
| `assets/trust.md` | Phase 5 template |
| `assets/reviewer.md` | Phase 5 — template for `.claude/agents/reviewer.md` |
| `assets/spec-reviewer.md` | Phase 5 — template for `.claude/agents/spec-reviewer.md` |

This skill never edits its own references or assets. A change to the familiarity map is the user's, made by hand.

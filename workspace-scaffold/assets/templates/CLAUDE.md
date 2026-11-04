# {{PROJECT_NAME}}

{{ONE_SENTENCE_WHAT_THIS_IS}}
For: {{WHO_THIS_IS_FOR}} — {{PAIN_AND_PROMISE_ONE_LINE — delete if this isn't a product with users}}

Before starting anything, read ROADMAP.md's `## Current goal` and the last few lines of DECISIONS.md — that's where the previous session left off, and what it learned. Read REVIEW.md before declaring work done.

## Commands
- Dev: {{DEV_COMMAND}}
- Test: {{TEST_COMMAND}}
- Build: {{BUILD_COMMAND}}
- {{LINT_TYPECHECK_FORMAT_COMMANDS}}
{{— or, if there is no code: "No build, test, or lint. This repo is markdown and Claude Code commands." followed by the project's own skills —}}

{{#PROJECT_SPECIFIC_SECTIONS — e.g. "Where things live", "Rules that must not bend". Only if the project needs them.}}

## Working style
- {{UNIT_OF_WORK_RULE — discrete deliverables: "Nontrivial work starts as a ticket (/ticket) and a plan. Wait for approval on the plan before editing when the change affects behavior, data, or dependencies." Exploratory/continuous work: name the project's unit, e.g. "Substantive research starts as a dated file in research/ with the question at the top."}}
- One piece of work at a time: one task, one finish line, one reviewable change.
- After building, inspect the result the way a user would — run it, click through, check the console — not just the diff.
- Run /vet before calling anything done; /wrap at the end of a session.
- Match existing style. Surprising changes outside the stated scope are a defect, not initiative.

## Permissions
- Free: read anything, propose plans, edit on feature branches, run local tests, update docs, draft PRs.
- Ask first: new dependencies, schema/migration changes, deleting files, touching {{PROJECT_SPECIFIC_SENSITIVE_AREAS — e.g. auth, payments, archive history}}.
- Human-owned: production deploys, customer data decisions, billing, anything that sends or authenticates externally.

{{#IF_STAKEHOLDER}}
## Stakeholders
- Owner: {{STAKEHOLDER_NAME_ROLE}}
- Never ships without their sign-off: {{SIGNOFF_ITEMS — e.g. public copy, pricing, brand assets}}
- Brand/voice standards: {{BRAND_STANDARDS_OR_POINTER}}
{{/IF_STAKEHOLDER}}

## Learnings
When something surprising happens or a choice forecloses alternatives, append one dated line to DECISIONS.md.

# Review standards

Judgment checks only — {{"lint, types, tests, and build are enforced by hooks and are not repeated here" OR "there is nothing mechanical to verify in this repo, so this file is the whole review surface"}}. Sort findings into **must fix / should fix / fine as is**.

## Scope and intent
- Does the change match its {{UNIT_OF_WORK — ticket / research question / …}} and ROADMAP.md's current cycle? If ROADMAP.md's date is stale, flag that before reviewing against it.
- Any files changed outside the stated scope? Surprising changes are where risk lives — name them explicitly.
- Did we add complexity the work didn't require? Anything from the out-of-scope list creeping in?
- Anything CLAUDE.md's Permissions marks ask-first or human-owned — was it actually approved?

## Passes
- Was this delivered in passes small enough to understand and review one at a time? A long solution is fine; a long *pass* isn't. If a change can't be explained in a few sentences, it should have been several changes, each reviewed before the next.

{{#PROJECT_SPECIFIC_SECTIONS — the checks that only make sense for this project: the main flow to exercise, the data that must not be lost, the copy that must use the audience's words. These are usually the most valuable part of the file.}}

{{#IF_STAKEHOLDER}}
## Stakeholder
- Anything here on the sign-off list in CLAUDE.md? Then it is not fine-as-is until approved.
- Does new copy match the brand/voice standards?
{{/IF_STAKEHOLDER}}

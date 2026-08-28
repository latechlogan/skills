# Review standards

Judgment checks only — {{"lint, types, tests, and build are enforced by hooks and are not repeated here" OR "there is nothing mechanical to verify in this repo, so this file is the whole review surface"}}. Sort findings into **must fix / should fix / fine as is**.

## Scope and intent
- Does the change match its {{UNIT_OF_WORK — ticket / research question / …}} and ROADMAP.md's current cycle? If ROADMAP.md's date is stale, flag that before reviewing against it.
- Any files changed outside the stated scope? Surprising changes are where risk lives — name them explicitly.
- Is the change small enough to review honestly, or should it have been split?
- Did we add complexity the work didn't require? Anything from the out-of-scope list creeping in?

## User experience
{{— delete this section if the project has no user-facing surface —}}
- Does the main flow still work end to end, tried as a user would (not just unit-tested)?
- What does a first-time user understand in the first 5 seconds of the affected screen?
- Are error and empty states handled, or only the happy path?
- Does the affected flow hold up at narrow widths?
- Any images without alt text, controls without labels, contrast problems, or keyboard traps introduced?
- If the surface is public: do title, meta, and headings still make sense for what this page is trying to communicate?

## Risk
{{— delete this section if nothing here applies —}}
- Does this touch auth, payments, personal data, migrations, or {{PROJECT_SPECIFIC_RISK_AREAS}}? If yes: was that in scope, and approved per CLAUDE.md's permissions?
- Could this change lose or corrupt existing data in any path?
- Any new external dependency or service — and was it approved?

## Language
- Does user-facing copy use the audience's own words ({{POINTER_TO_LANGUAGE_SOURCE — or delete}}), not internal vocabulary?

{{#PROJECT_SPECIFIC_SECTIONS — the checks that only make sense for this project. These are usually the most valuable part of the file.}}

{{#IF_STAKEHOLDER}}
## Stakeholder
- Anything here on the sign-off list in CLAUDE.md? Then it is not fine-as-is until approved.
- Does new copy match the brand/voice standards?
{{/IF_STAKEHOLDER}}

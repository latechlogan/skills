# Review standards

Judgment checks only — there is nothing mechanical to verify in this repo, so this file is the whole review surface. Sort findings into **must fix / should fix / fine as is**.

## Scope and intent
- Does the change match its ticket and ROADMAP.md's current cycle? If ROADMAP.md's date is stale, flag that first.
- Any files changed outside the ticket's scope? A change to `SKILL.md` that also quietly reworded a template is two changes.
- Did complexity arrive that the ticket didn't require — a new conditional, a new placeholder, a new step?

## Does it hold everywhere
The core is applied to every project. A template change that's right for a code repo and wrong for a research repo is wrong.
- Would this section, step, or placeholder make sense in a markdown-only repo? If not, is it clearly marked as per-project rather than core?
- Does it add a `{{PLACEHOLDER}}` that a scaffold run could plausibly leave unfilled? Homework is a defect.
- Does CLAUDE.md's template still land under 60 lines when filled?

## Does it survive re-alignment
Existing repos are audited by Step 3b against the shape, never against skill bodies.
- Does the change add something the audit would have to read a skill body or CLAUDE.md prose to check? Then it's behavior, not shape, and doesn't belong in the core.
- Does the change move the goal, the decisions log, or their section names? That's the wrap-residue contract; changing it means migrating every scaffolded repo and anything that reads them.
- If a core file or skill was renamed: is there a `rename` path in 3b for it, and were all template references updated?

## Self-improvement discipline
- Did the skill's Step 6 wording invite padding? "Three lines max, nothing is allowed" must survive every edit.
- Is anything in this change the skill modifying itself rather than a human deciding? That's must-fix.
- If an IMPROVEMENTS.md heading was incorporated, is it marked so it stops counting?

## Language
- Would a tired junior understand every name and instruction without the conversation that produced it? SKILL.md is read cold by a fresh session every time.

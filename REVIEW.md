# Review standards

Judgment checks only — there is nothing mechanical to verify in this repo, so this file is the whole review surface. Sort findings into **must fix / should fix / fine as is**.

## Scope and intent
- Does the change match its ticket and ROADMAP.md's current cycle? If ROADMAP.md's date is stale, flag that first.
- Any files changed outside the ticket's scope? A change to `SKILL.md` that also quietly reworded a template is two changes.
- Did complexity arrive that the ticket didn't require — a new conditional, a new placeholder, a new step?
- Does any skill now load a file from another skill's folder? Each folder has to stand alone.

## The kickoff → scaffold hand-off
project-kickoff Phase 7 feeds workspace-scaffold's Step 2, and the two drift apart silently.
- If either side changed, does the Phase 7 mapping table still match what the scaffold asks for and the core files it writes?
- Does a decision line written by the kickoff still match the scaffold's DECISIONS.md grammar (`- YYYY-MM-DD — [decision|learning] entry`)?

The sections below apply to workspace-scaffold changes only.

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

## Hands off
- Is anything in this change the skill modifying itself, or collecting findings from a project back into this repo? That's must-fix — the shape changes when Logan decides, by looking at repos.
- Does the change tell a scaffolded repo how to *behave* — a skill step, a hook, a convention — rather than what data to keep? Then it's a greenfield default at most, and the text should say so.

## Language
- Would a tired junior understand every name and instruction without the conversation that produced it? SKILL.md is read cold by a fresh session every time.

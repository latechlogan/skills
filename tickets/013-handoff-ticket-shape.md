---
status: dropped
created: 2026-09-02
source: IMPROVEMENTS.md#hand-off-ticket-across-folders
---

# 013 — The hand-off: a ticket one workspace writes into another's `tickets/`

## Job
`/ticket` assumes the writer and the executor are the same session in the same workspace. When one workspace writes a ticket into another's `tickets/`, that assumption breaks in a specific way: the writer holds the context and the executor won't, so `## Plan` has to be filled at write time rather than left empty for approval. Three Webflow site workspaces already document this convention in their own `tickets/README.md`; record the general half in the template so a fourth doesn't reinvent it.

## Scope
`skill/assets/skills/ticket.md` — a short "Hand-off" rule: when writing into another workspace's `tickets/`, fill `## Plan` at write time, name which workspace closes the ticket, and state the prerequisite if one exists. `skill/assets/templates/tickets-README.md` — one sentence so a reader of the receiving repo knows a ticket may not have originated there. Mirrored into this repo's `.claude/skills/ticket/SKILL.md`.

Does **not** touch: `SKILL.md` (see the deferred half below), `/vet`, `/wrap`, the status enum, or the path rule ticket 009 already added — that rule is what makes a hand-off's paths resolve, and this ticket assumes it rather than restating it.

Does **not** add `site:` or `mcp:` frontmatter to the core. Those appear in the DJCon/Trinity/Ouachita READMEs alongside the hand-off convention, but they are Webflow-program identifiers — `ticket-site-field` in IMPROVEMENTS.md is at one occurrence and notes the field duplicates the file path. The template gets the shape, not the program's fields.

## Done looks like
- Re-reading the rule against `Webflow/DJCon/tickets/README.md` ("created by `/ticket` here or by `/ticket` in a `Webflow/` session — a hand-off ... arrive with `## Plan` filled") reproduces the convention it already states, minus the program-specific frontmatter. Same for Trinity's and OuachitaTerminals' READMEs.
- A standalone repo with no sibling workspaces reads the rule as inert — it costs one paragraph and never fires.
- `/ticket`'s existing "propose a plan and wait for approval" rule and the hand-off's "fill the plan at write time" do not contradict each other after the change; whichever applies is decidable from where the ticket is being written.

## Boundary
Holds for a non-code repo — all the occurrences are markdown ops repos.

No wrap-residue or step-label change. No scaffolded repo needs migrating: the three sites already have the convention in their READMEs, and under ticket 010's data contract an installed `/ticket` body is the project's own anyway.

**Evidence quality — read before planning.** This heading is weaker than its count suggests, in two ways the plan should settle:

1. **Occurrence 2 is unverifiable.** It cites `repos/ats-sync/tickets/001` and a `depends on:` frontmatter field for a cross-workspace prerequisite. `~/repos/ats-sync` does not exist on disk as of 2026-09-02. `depends on:` does exist, but only in `Webflow/DJCon/tickets/006` and `007`, where both uses are *intra*-workspace (005 → 006, 005 → 007). So the cross-workspace use of that field is not currently attested anywhere. Leave `depends on:` out unless the plan finds the repo.
2. **The RCRM 028 claim looks like heading inflation.** IMPROVEMENTS.md calls `RCRM/tickets/028` "the same shape, unnamed." Reading it, it is closer to the inverse: 028 stays in the *originating* workspace, marked `blocked`, with "execution happens in `../DJCon/` and `../OuachitaTerminals/`" — a finding parked at home so it isn't lost, not a ticket written into an executor's folder. That is the same *topic* (work crossing a workspace boundary) and a different *failure*, which is exactly the trap the 2026-08-31 learning names. If the plan agrees, the honest count for the hand-off proper is one strong occurrence plus a documented three-repo convention, and the "parked cross-workspace finding" shape should be split into its own heading rather than counted here.

**Deferred, one occurrence:** a hand-off written into an *unscaffolded* repo is effectively a request to scaffold it (the ats-sync case). That is a `SKILL.md` Step 1 change, a different idea from the ticket's shape, and it rests on the occurrence that can't be verified. Its own ticket if it recurs.

## Plan

### Dropped 2026-09-02
Dissolved: `/ticket` now writes `## Plan` at creation for every ticket, so a hand-off is no longer a special case. The evidence-quality caveats in Boundary stand as written — the ats-sync occurrence was never verified and RCRM 028 was a different failure.

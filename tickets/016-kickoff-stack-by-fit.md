---
status: open
created: 2026-11-06
source: request
---

# 016 — project-kickoff: propose the stack by fit, not within familiarity

## Job
Change project-kickoff's Phase 2 default so the stack is proposed by fit to the problem, with Logan's familiarity treated as a trade to name rather than the boundary proposals stay inside.

## Context
Logan noticed Claude Code recommends the same stack over and over. On 2026-11-06 the global `~/.claude/CLAUDE.md` was changed to "pick by fit, not by my familiarity," with the skill tiers in `~/.claude/PROFILE.md` setting how much to explain, not what to choose.

The kickoff overrides that at exactly the moment the stack gets picked. `project-kickoff/references/stack-familiarity.md`, in "How to use this in Phase 2," opens with "Propose within Writes and Reads by default." `project-kickoff/SKILL.md` principle 4 ("Familiarity is a real criterion") frames it the same way. Every new project goes through Phase 2, so the global rule never reaches a stack decision.

Why the default changes now: Logan's role has shifted toward business systems work (vendor APIs, data moving between systems, operations software, applied AI), where the best tool is often outside his web stack. His value is in directing architecture and verifying results, not writing the code, so familiarity is a cost to weigh, not a limit.

What stays, because it's right: reading is still how review happens, so a pick outside his familiarity names the trade ("the trust layer carries more weight here"); familiarity still decides a close call, said in one sentence; one stack plus one credible alternative.

## Scope
- `project-kickoff/SKILL.md`: principle 4 and the Phase 2 opening paragraph.
- `project-kickoff/references/stack-familiarity.md`: its intro paragraph and "How to use this in Phase 2."

Does not touch the familiarity tables themselves (ticket 017), `project-kickoff/references/quality-gates.md`, or Phase 7. The kickoff → scaffold hand-off is unaffected: Phase 2 still writes `docs/brief.md` `## Stack`, which the scaffold reads unchanged.

## Done looks like
- `grep -rn "within Writes and Reads" project-kickoff/` returns nothing.
- Principle 4 and Phase 2 state fit as the default and familiarity as a trade to name.
- On the next real kickoff where the best fit is outside Writes/Reads, Phase 2 proposes that tool first and names the trade.

## Boundary
- Only new projects are affected; kickoff doesn't run on existing repos.
- Ticket 017 moves the familiarity data out of `stack-familiarity.md`. Do this ticket first, so 017 carries the revised usage rules rather than the old ones.

## Plan (proposed)
1. Rewrite principle 4: fit decides; familiarity is a cost to name. Keep the reasoning that code he can read is code he can review, recast as "outside familiarity, the trust layer carries more of the review."
2. Phase 2 opening paragraph: make "when a tool outside their familiarity is clearly better, propose it" the normal case rather than the exception.
3. `stack-familiarity.md` "How to use": replace the first bullet with "Propose what fits the problem. Familiarity is a weighed input, not a boundary." Keep the second and third bullets. Adjust the intro paragraph to match.
4. Verify with the grep, append a `[decision]` line to DECISIONS.md, run /vet. The behavioral check waits for the next real kickoff.

---
status: open
created: 2026-11-06
source: request
---

# 017 — project-kickoff: one home for Logan's tool familiarity

## Job
Make `~/.claude/PROFILE.md` the single record of Logan's tool familiarity, and reduce `project-kickoff/references/stack-familiarity.md` to the Phase 2 usage rules plus a pointer to it.

## Context
Two files record the same facts and already disagree:

| Tool | `stack-familiarity.md` | `~/.claude/PROFILE.md` |
|---|---|---|
| Node.js, Express | Writes | Working knowledge |
| Hono | Reads | Not listed (now means "new to me") |
| Vitest | Untested | Working knowledge |
| Jest | Writes | Not listed |

PROFILE.md was revised on 2026-11-06: tiers Strong / Solid / Working knowledge, a rule that anything unlisted means "new to me, teach the concepts," and a "Concepts I'm building" list replacing tool-by-tool entries for things he hasn't used. The revision was meant to stop the profile needing an update every time he hears of or tries a tool.

Why PROFILE.md and not the skill: explanation depth matters in every session, not only during a kickoff. The alternative, the skill owning the data and PROFILE.md pointing to it, would leave non-kickoff sessions without it.

Notes in `stack-familiarity.md` worth carrying into PROFILE.md: prefers Astro; Next.js is fine but disliked; reads Tailwind but writes it slowly; struggled with React Testing Library and Supabase (prefers plain PostgreSQL); likes Netlify and Railway, Cloudflare is fine, Vercel isn't a favorite.

## Scope
- `project-kickoff/references/stack-familiarity.md`: remove the tables; keep "How to use this in Phase 2" (as revised by ticket 016); add the pointer.
- `project-kickoff/SKILL.md`: Phase 2's "Read `references/stack-familiarity.md` first" and the files table entry.
- `~/.claude/PROFILE.md`: absorb the notes above. Outside this repo.

Does not touch quality-gates.md, any other phase, or workspace-scaffold.

## Done looks like
- `grep -rln "Supabase" ~/repos/skills ~/.claude` returns only `~/.claude/PROFILE.md` (and this ticket).
- Phase 2 reads PROFILE.md for familiarity and `stack-familiarity.md` only for how to use it.
- The four conflicts above are resolved by Logan, not by the executing session.

## Boundary
- The skill starts depending on a file outside its folder. That's acceptable while the skills are for Logan alone; note it in DECISIONS.md. It doesn't break the rule that a skill never reaches into another skill's folder.
- Editing `~/.claude/PROFILE.md` is outside this repo's permissions. Approving this plan is the ask.
- The two files use different axes: Writes/Reads (can he verify agent code by reading it) versus Strong/Solid/Working (how much to explain). Phase 2 cares about the first. Decide whether PROFILE.md's tiers carry both meanings or gain a line saying how they map.
- Depends on ticket 016.

## Plan (proposed)
1. Logan resolves the four conflicts and the axis question.
2. Add the familiarity notes to `~/.claude/PROFILE.md`.
3. Strip the tables from `stack-familiarity.md`, keep the usage rules, add the pointer, update its "maintained by hand" line.
4. Update `project-kickoff/SKILL.md` Phase 2 and its files table. The "never edits its own references" line still holds.
5. Verify with the grep, append a `[decision]` line to DECISIONS.md, run /vet.

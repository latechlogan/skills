# /tickets

One file per ticket, created by /ticket. Naming: `NNN-short-slug.md` (e.g., `007-waitlist-form.md`). The approved plan lives in the ticket too, under `## Plan`, so intent, scope, plan, and status are one file.

Tickets are durable so that work has a written finish line before it starts, /vet can review a change against what was actually asked, and routines have something real to read.

## Status

**This list is closed — these six are the only values.** /wrap sets them.

| status | means | still needs attention? |
| --- | --- | --- |
| `open` | not started | yes |
| `in-progress` | started, not finished | yes |
| `blocked` | can't proceed — someone else owes something | yes, chase the blocker |
| `deferred` | could proceed, deliberately not now | no |
| `done` | finished | no, permanently |
| `dropped` | abandoned, won't be done | no, permanently |

`blocked` and `deferred` both mean "not now," but only `blocked` has a person to chase. Keep them apart.

**Need a seventh word? Don't add it here.** Raise it in the workspace-scaffold repo — the scaffold that installed this file — where template candidates accumulate in its `IMPROVEMENTS.md`; at two occurrences it becomes a ticket and the template changes for every project. Inventing one locally makes this file the authority for one repo, which is how a shared vocabulary drifts apart.

## Kind

`kind: defect | improvement` is what makes ROADMAP.md's triage rule mechanical: defects jump the queue, improvements are ordered by leverage, and the ticket number is creation order — never priority.

If this project uses GitHub Issues instead, this folder can hold only the ticket template and /ticket should open issues instead — but keep the same fields and the same closed status list.

# /tickets

One file per ticket, created by /ticket. Naming: `NNN-short-slug.md`. The approved plan lives in the ticket under `## Plan`.

A ticket here is a change to the skill, a template, or a project skill. Improvements that reach two occurrences in IMPROVEMENTS.md become tickets; so do template changes Logan asks for directly. Wording fixes don't need one.

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

**Need a seventh word? Don't add it here.** Log it in `IMPROVEMENTS.md`; at two occurrences it becomes a ticket and `assets/templates/tickets-README.md` changes for every project. That template is the authority — this file mirrors it.

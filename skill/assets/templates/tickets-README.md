# /tickets

One file per ticket, created by /ticket. Naming: `NNN-short-slug.md` (e.g., `007-waitlist-form.md`). Status lives in the file's frontmatter (`status: open | in-progress | done | dropped`) and is updated by /wrap. `kind: defect | improvement` is what makes ROADMAP.md's triage rule mechanical: defects jump the queue, improvements are ordered by leverage, and the ticket number is creation order — never priority. The approved plan lives in the ticket too, under `## Plan`, so intent, scope, plan, and status are one file.

Tickets are durable so that work has a written finish line before it starts, /vet can review a change against what was actually asked, and routines have something real to read.

If this project uses GitHub Issues instead, this folder can hold only the ticket template and /ticket should open issues instead — but keep the same fields.

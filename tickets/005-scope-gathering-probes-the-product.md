---
status: open
created: 2026-08-28
source: IMPROVEMENTS.md#scope-gathering-reads-docs-not-product
---

# 005 — Step 2: when the repo isn't the product, probe the product

## Job
Step 2 says to extract scope from "the conversation and the repo." In three ops repos (DJCon, Trinity, OuachitaTerminals) the repo was a few markdown files and the product was a live site, and the docs were wrong about it every time — a year-stale publish, dead Apply links a maintained backlog didn't know about, an unlogged staging publish, unverified hours in shipped JSON-LD, a parent roadmap waiting on a fact the site already published. The probe produced most of each workspace's content. Add to Step 2: when the repo isn't the product, inspect the product before asking anything — and treat any existing doc's claims about it as unverified until the probe agrees.

## Scope
`skill/SKILL.md` — Step 2, one paragraph plus a short list of what a probe looks like for a site (last-published date, custom domains, `curl` of the key pages with the project's own marker counts, an old-brand/placeholder sweep, robots/sitemap, whether analytics exists). Maybe one line in Step 3b's look-back: "did the docs disagree with the product?" as a usage finding. Does not touch templates or skills.

## Done looks like
A greenfield run on an ops repo reads Step 2 and produces DECISIONS.md "[learning]" lines about the product before writing ROADMAP.md, without the operator having to think of it. The three occurrences' findings would each have been caught by the listed probe.

## Boundary
Holds for non-code repos — that's the case it's for; for a code repo the "product" is the repo and the paragraph is a no-op (say so explicitly so it doesn't add ceremony there). No step label or wrap-residue change; no migration. Keep it a paragraph, not a checklist — the exact probe is project-specific and the skill shouldn't pretend otherwise.

## Plan
[Empty until approved.]

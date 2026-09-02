---
status: in-progress
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
Approved 2026-09-02.

**Tension resolved (Scope vs. Boundary):** the Boundary wins. The Scope's six-item
site list doesn't generalize — against a product that isn't a site (a published
feed, an account someone else administers) five of six items are noise, which
teaches a session to skip the block rather than adapt it. What unifies all three
occurrences is two moves, not six commands: get the product's own state from the
authoritative source, then reconcile docs and product. So the rule is a predicate
and the six site items compress to one parenthetical example.

**Correction found by the retrodiction test:** the second move was first written
one-directional ("check each doc claim"), which reaches only 7 of the 9
occurrence findings. DJCon's CDN cache trap and Trinity's "14 open jobs have no
page at all" are *gap* findings — the product shows something no doc mentions, so
there is no claim to check. Claim-checking structurally cannot reach them. Fixed
by making the move bidirectional: every claim the docs make, **and** everything
the product shows that no doc mentions. Reaches 9 of 9.

Both are the same move as ticket 001, which replaced "code repo -> tickets" with
a deliverable-shape predicate: **specify the predicate, not the procedure.**

**Files, in order:**
1. `skill/SKILL.md` Step 2 — one paragraph after "Extract what you can from the
   conversation and the repo." Names the trigger (repo isn't the product), the
   no-op case (code repo), the two moves with a compressed site example, and the
   ordering requirement: probe findings land as dated `[learning]` lines in
   DECISIONS.md *before* ROADMAP.md is written. That last clause is what makes
   "Done looks like" checkable.
2. `skill/SKILL.md` Step 3b look-back — one bullet asking whether the docs
   disagreed with the product. This is the only thing making the new rule
   falsifiable: if they always agreed, the paragraph didn't earn its place.
3. Nothing else. No template, skill, or scaffolded-repo change.

**Test:** two paper passes — retrodiction against the three occurrences
(DJCon, Trinity, OuachitaTerminals), where Ouachita's "parent roadmap waiting on
an address the site already published" is the hard case; and a no-op check
against a code repo (this one). Note that existing-workspace mode runs Step 2
abbreviated, so a re-run on an ops repo exercises this weakly — the retrodiction
is the real test.

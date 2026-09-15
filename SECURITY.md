<!--
SPDX-FileCopyrightText: 2026 Mohamed Hammad <Mohamed.Hammad@SpacecraftSoftware.org>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Security Policy

Standard §26.1 requires every Spacecraft Software repository to state where a
vulnerability report goes and what happens to it. This repository is subject to
the rule it publishes.

## Scope

This repository contains **no executable code**. It holds the Texinfo source of
The Steelbore Standard, its generated GFM companion, a CSS theme, and CI
scripts. Realistic reports are therefore:

- **A normative defect with a security consequence** — a clause that mandates,
  permits, or fails to forbid something unsafe. §9.1 was exactly this: §9 was
  scoped to applications, so nothing forbade the published HTML from disclosing
  every reader's IP to a third-party CDN. A rule that is wrong propagates to
  every project that follows it, which makes this the highest-value report here.
- **A supply-chain problem in the build or CI** — `makeinfo`, `texi2any`,
  `pandoc`, or a workflow action.
- **A disclosure problem in the document** — a private hostname, an internal
  path, or a credential committed by mistake.

A vulnerability in a project *governed* by the Standard belongs to that
project's own repository.

## Reporting

Email `Mohamed.Hammad [at] SpacecraftSoftware.org`. Do not open a public issue
for anything that should not be public.

For a normative defect, please say which section, what it currently permits or
requires, and the consequence — that is usually faster to act on than a patch.

## What to expect

| | |
|---|---|
| Acknowledgement | within 7 days |
| Assessment | within 30 days |
| Supported versions | the current published version only; the Standard is not branched |
| Disclosure | coordinated; a corrective version lands before any public description |
| Credit | offered by default, declined on request |

A normative fix ships as a version bump with a `CHANGELOG.md` entry stating what
changed and why, in both this repository and the skill encoding.

This is a personal hobby project (§5.1). There is no SLA, and the targets above
are intentions rather than commitments.

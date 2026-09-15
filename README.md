<!--
SPDX-FileCopyrightText: 2026 Mohamed Hammad <Mohamed.Hammad@SpacecraftSoftware.org>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# The Steelbore Standard

The engineering specification governing every project under
[Spacecraft Software](https://SpacecraftSoftware.org/) — priorities, licensing,
platform requirements, documentation, palettes, accessibility, and the §19–§26
assurance process.

Published at **<https://Standard.SpacecraftSoftware.org/>**.

## The artifact

There is no application source here. The standard itself is the product.

| Path | Role |
|------|------|
| [`The_Steelbore_Standard.texi`](The_Steelbore_Standard.texi) | **Source of truth** — GNU Texinfo |
| [`The_Steelbore_Standard.md`](The_Steelbore_Standard.md) | Generated GFM companion, tracked so GitHub renders it |
| [`CHANGELOG.md`](CHANGELOG.md) | Hand-maintained version history (extracted from §1 at v1.37) |
| [`CREDITS.md`](CREDITS.md) | §15.3 attribution for the outside specifications §19–§26 draw on |
| `spacecraft.css` | HTML theme; its palette block is **generated** from `steelbore.toml` |

`.info`, `.html`, `.pdf` and `.docx` are generated and gitignored.
**Do not edit the `.md` by hand** — it is overwritten by the next build.

Build commands, the versioning policy, and the two-repo change workflow are in
[`AGENTS.md`](AGENTS.md).

## The name

"The Steelbore Standard" is the canonical, current name. It was briefly renamed
to "The Spacecraft Software Standard" at v1.7 and **reinstated at v1.8**; the
standard's name is deliberately decoupled from the umbrella's, so a future
rebrand of the organisation does not rename the document. The umbrella is
Spacecraft Software; the OS line keeps the Steelbore name; so does this.

## Self-application

The standard governs itself, and does so visibly: this repository is the §8
Texinfo manual it mandates, its commits are §6.3-signed, its dates are §14 UTC
ISO 8601, and its own published HTML was brought into §9.1 compliance at v2.06
by the clause that section added.

## Project Posture

Personal / hobby, per §5. See [`NOTICE.md`](NOTICE.md) for the no-warranty and
no-liability statement, [`CONTRIBUTING.md`](CONTRIBUTING.md) for contribution
scope, and [`SECURITY.md`](SECURITY.md) for reporting — including how to report
a normative defect with a security consequence.

## Maintainer

Mohamed Hammad — `Mohamed.Hammad [at] SpacecraftSoftware.org`
<https://Standard.SpacecraftSoftware.org/>

Copyright (C) 2026 Mohamed Hammad & Spacecraft Software.
The Standard is a document (§4.1.1) under
[CC-BY-SA-4.0](LICENSES/CC-BY-SA-4.0.txt); the CI tooling is GPL-3.0-or-later.

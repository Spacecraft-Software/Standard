<!--
SPDX-FileCopyrightText: 2026 Mohamed Hammad <Mohamed.Hammad@SpacecraftSoftware.org>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# The Steelbore Standard — Changelog

Version history for **The Steelbore Standard**. This file is the canonical
record of what changed in each version of the standard.

The standard itself is `The_Steelbore_Standard.texi` (Texinfo source of truth) and
its generated `The_Steelbore_Standard.md` companion; §1 — Preamble carries a
pointer here rather than the full history, so the published document stays about
the rules in force rather than how they got there. The skill encoding of the
standard keeps a parallel history at
`construct/spacecraft-standard-constitution/references/CHANGELOG.md`, which must
be synced to the same version and date.

Entries are newest-first. Dates are UTC, ISO 8601 (§14). Versioning policy: bump
for upstream skill changes, registry updates (§2.1, §15.1), factual corrections
to normative content, and brand/identity changes.

- **v1.42 (2026-08-05):** **§13 corrected — a component system per platform, not one for every platform.** §13 required **Material Design** as "the required component system for all graphical applications," a rule written when the graphical surface in scope was Flutter and web. It has been unsatisfiable for native desktop since the day it was written: **GTK 4** ships Adwaita and the GNOME HIG, **Qt 6** ships Fusion and the KDE HIG, and neither has a Material component set to theme — so a GTK or Qt application could not pass the §16 audit gate no matter how it was built, and the only honest options were a permanent filed deviation or an application that matches neither its own toolkit nor Material. Worse, imposing a foreign component system on a native toolkit fights exactly the platform integration §18 depends on: the accessibility bridge, the window manager, the system high-contrast and reduced-motion preferences, and the settings portal are all wired to the toolkit's own vocabulary. §13 is accordingly rewritten around the requirement that actually carries the intent — **every graphical application declares exactly one component system, in its `README.md` beside the §5.2 posture section, and follows it consistently** — with the system determined by the platform rather than by preference: **Material Design** for Flutter, web, mobile, and cross-platform GUI, and for custom-drawn or immediate-mode UI that declares no platform HIG; **GNOME HIG** via libadwaita for GTK 4; **KDE HIG** via Qt Quick Controls or Fusion for Qt 6. Material Design remains the default wherever the platform supplies no system of its own, so nothing that was compliant under v1.41 becomes non-compliant here — the clause is narrowed, never widened. Three things are explicitly unchanged: **§11 binding is unconditional** — whichever system is declared, every palette reference still goes through the named `steelbore` theme (§11.1), because a component system chooses the widget vocabulary and never supplies the colors; **WCAG 2.2 Level AA** remains the contrast floor with the measured pairing stated; and **§18 still governs wherever the two overlap**. The §16 checklist bullet is rewritten from "Material Design UI/UX" to the declare-and-follow form naming all three systems, and the Skill Cross-References table gains `spacecraft-gtk-guidelines` and `spacecraft-qt-guidelines` rows — the two skills that implement this section for the native-desktop toolkits. Both are Rust-first under §3.1 (`gtk-rs` for GTK, CXX-Qt for Qt), so choosing a native desktop toolkit does not become a route around the memory-safe-language preference.
- **v1.41 (2026-08-04):** **§3.1.1 added — TypeScript over JavaScript.** §3.1 named Rust as the preferred language and prescribed ASLR+CFI where Rust is not viable, but it had nothing to say about the one runtime where that framing does not apply: JavaScript is already memory-safe, so the memory-safety lever is inert, and the section fell silent exactly where a stability rule was still needed. §3.1.1 supplies it — **type safety is the Priority 1 lever on this runtime**. Where a memory-safe alternative exists (Rust to WebAssembly, Rust or Go on a server, Flutter/Dart for a UI) §3.1 still chooses it; where the JavaScript runtime is genuinely required — a browser page, a Node/Deno/Bun program, an Electron app, an npm-distributed tool, a VS Code extension — the **source language MUST be TypeScript**, and plain JavaScript source becomes a documented exemption rather than a default. Six requirements attach: `"strict": true` plus `noUncheckedIndexedAccess`, `noImplicitOverride`, and `exactOptionalPropertyTypes` (relaxing `strict` is a Priority 1 regression); no `any` and no non-null `!` in production paths (use `unknown` and narrow); `@ts-ignore` prohibited outright in favor of `@ts-expect-error` with a stated reason, which fails the build once the suppression stops being needed; **run-time validation at every trust boundary**, since a type annotation is a compile-time claim and asserting an unverified shape is the silent-failure mode §3.1 already forbids; **`tsc --noEmit` gating CI**, because esbuild, SWC, and Bun strip types without checking them, and a project that only transpiles has not satisfied this section; and loading `spacecraft-typescript-guidelines` before writing or reviewing TypeScript. Emitted `.js` and source maps in a build directory are derived artifacts and out of scope — the rule governs what is authored and committed. Three narrow cases need no filing: a tool's own configuration file that must be `.js` (e.g. `eslint.config.js` where no TypeScript loader exists), a vendored or upstream-derived file carried under §4.2, and generated output. Everything else — including "it is only a small script" — requires a documented technical exemption, on the same footing as the §3.1 memory-safe-language exemption. §16 gains a checklist bullet; the skill cross-reference table gains a TypeScript row.
- **v1.40 (2026-07-27):** **Two gaps closed: where work may be sent, and what must be measured before a skill is packed.** **§6.4 added — Authorized Contribution Targets (Non-Negotiable).** §6.3 has always said how a commit must be signed on "a Spacecraft Software-controlled Git remote" without ever defining that set, so nothing in the standard stopped a script, a CI job, or an assistant-driven session from pushing a branch or opening a pull request against a third-party repository. §6.4 names the authorized namespaces — `github.com/Spacecraft-Software` and `github.com/UnbreakableMJ`, with a future Spacecraft Software-controlled host (Gitway) inheriting the same standing — and makes every other destination **outbound** and **default-deny**: silence is a denial, not permission. **Automation never initiates** an outbound contribution, and authorization for one does not carry to the next task, session, or repository; only Mohamed Hammad, acting explicitly and per contribution, may authorize one (§5.4). The rule is not git-only — publishing to a package registry under a namespace Spacecraft Software does not control (`crates.io`, npm, PyPI, AUR, Nixpkgs, Guix, Flathub) and filing issues or patches on an external tracker or mailing list are outbound under the same rule. **Forks stay free**: a fork under an authorized namespace may be created and pushed to at will, because that is our namespace — turning a fork branch into an upstream PR is the gated act. Where an upstream change is needed, §4.2's carry-the-patch-in-tree route is preferred to upstreaming. The free-software/GNU posture (§1) yields the identity clauses (§2, §11–§12, §15) but **not** this one: sending anything to GNU, the FSF, or Savannah still needs explicit authorization. An unauthorized submission MUST be withdrawn as soon as it is discovered, and recorded. **§5.6 added — Skill Packaging Requirements.** Skills are software-class artifacts (§4.1.1) whose loader limits are only discovered at install time, after the packing work is done: a `SKILL.md` frontmatter `description` over **1024** characters is rejected on load. §5.6 caps it at **1000 rendered characters** — a deliberate 24-character margin — and pins down *rendered*: a YAML folded scalar (`description: >`) joins its wrapped lines with single spaces and keeps a trailing newline, so raw line lengths are not the measurement, and block (`>`/`|`) and single-line plain or quoted forms alike are counted after folding. The cap MUST be **machine-enforced** in two places — the skill repository's CI on every pull request and push to the default branch, *and* the command that produces the distributable bundle. A developer-installed git hook is a convenience, never the gate: hooks are opt-in per clone. An over-limit skill MUST NOT be packed, committed, or published; trim the description rather than raise the cap. §16 gains a checklist bullet for each section.
- **v1.39 (2026-07-26):** **Three external palettes registered, and a new class for the two that cannot conform.** **§11.3.5 added — Tokyo Night**, taken verbatim from the upstream editor theme (canvas Night `#1A1B26`, `surface` the documented Storm background `#24283B`, `surface-alt` the Night `bg_dark` `#16161E`, which sits darker than the canvas as §11.0.1 permits). It needed no Spacecraft-derived substitutes: every role token clears 4.5:1 on all three backgrounds — accent `#7AA2F7` 6.79:1, structure `#BB9AF7` 7.39:1, success `#9ECE6A` 9.35:1, error `#F7768E` 6.46:1, warning `#E0AF68` 8.55:1, focus `#7DCFFF` 9.96:1 — so it is registered as a conforming alternate, with `tokyonight-high-contrast` lifting the two tokens below 7:1 on the canvas (`accent` → `#97B6F9` 8.44:1, `error` → `#F998AA` 8.22:1). The upstream comment tone `#565F89` (2.76:1) is recorded as not bindable to any role token. **§11.5 added — Fidelity Palettes (registered, non-conforming):** a new class for palettes reproduced exactly from a widely used external theme so tooling can meet a user already working in it. **Solarized Dark (§11.5.1) and Solarized Light (§11.5.2)** are registered verbatim from Ethan Schoonover's Solarized — no token substituted, deepened, or lifted to make a number pass — and they **do not** satisfy §11's contrast guarantee. Solarized Dark: body text `base0` 4.75:1 on the canvas, twelve pairings below 4.5:1, and `structure`/`border` (2.97:1) and `error` (2.81:1) below 3:1 on `base02`. Solarized Light is worse: body text `base00` measures **4.13:1, under the AA floor**, and `success` (2.97:1), `warning` (2.98:1), and `focus` (2.93:1) fall below 3:1, so an interface built on it cannot signal status by color at all. §11.5 therefore bars adopting a fidelity palette as a project's §11.4 palette, keeps `steelbore-mono` as the accessible-mode path, and ships no `-high-contrast` sibling for them (lifting would change the values they exist to reproduce); † and ‡ mark the two failure bands throughout. Solarized defines one elevated tone per mode, so `surface-alt` shares `surface`. **§11.4.1 added — Reference Names:** every palette gains an additive reference name for prose (`steelbore-color-palette`, `steelboreclassic-color-palette`, `blue-color-palette`, `blackpinkpanther-color-palette`, `matrixgreen-color-palette`, `navywhite-color-palette`, `tokyonight-color-palette`, `solarizeddark-color-palette`, `solarizedlight-color-palette`). Slugs are unchanged and remain the machine identifier, so no consumer breaks. **§11.4** gains bullets for both additions.
- **v1.38 (2026-07-26):** **§4.3 corrected — the symlink runs the other way.** v1.36 required the root `LICENSE` to be a symlink into `LICENSES/`, on the premise that GitHub follows symlinks for license detection. It does not: GitHub's detector reads **git blobs**, and a symlink's blob is the target *path*, not the license text. Measured after v1.36 landed, both `Standard` and `Construct` reported `NOASSERTION` — no identified license — where sibling repos with a regular `LICENSE` file report `GPL-3.0`. The rule is inverted: the root `LICENSE` is now a **regular file** holding the verbatim primary license text, and `LICENSES/<SPDX-id>.txt` for that license is a **symlink back to it** (`ln -s ../LICENSE LICENSES/GPL-3.0-or-later.txt`). `reuse` reads the working tree through the filesystem, so it follows the link and lints clean; GitHub gets a real blob. The single-source-of-truth goal of v1.36 is preserved — the text still exists exactly once — and two independently maintained copies remain non-compliant. Added: the root text MUST be a **canonical, unmodified** copy as published (FSF text for the GPL family, Creative Commons text for CC-BY-SA-4.0, or the choosealicense.com copy) — reflowed or Markdown-formatted texts defeat detection even when the wording is intact. Secondary licenses in `LICENSES/` (§4.2 upstream texts, a differently-licensed tooling class per §4.1.1) stay regular files; only the primary license is linked. §5.2 `LICENSE` row and the §16 checklist bullet updated to match.
- **v1.37 (2026-07-26):** **Changelog extracted from the document.** The full
  version history moves out of §1 — Preamble into this file (`CHANGELOG.md`) at
  the repository root; the Preamble now carries a pointer to it. No normative
  change — every rule in force is unchanged. The history had grown to 37 entries
  and roughly a fifth of the document, pushing §2 and everything after it far
  down the page for a reader who wants the rules rather than their provenance.
  This also mirrors the skill encoding, which has kept its history in
  `references/CHANGELOG.md` since v1.24.
- **v1.36 (2026-07-26):** **§4.3:** the root `LICENSE` file is now
  **required** and MUST be a **symbolic link** to the project’s primary
  license text in `LICENSES/` (e.g.
  `ln -s LICENSES/GPL-3.0-or-later.txt LICENSE`) — upgrading the former
  "a root `LICENSE` MAY remain as a GitHub-detection pointer" allowance.
  GitHub follows the symlink for license detection while REUSE keeps the
  verbatim texts in `LICENSES/`, giving both one source of truth; a
  duplicated regular-file `LICENSE` is non-compliant because the two
  copies drift. Link target follows the §4.1.1 artifact class
  (`GPL-3.0-or-later` / `AGPL-3.0-or-later` for software-primary repos,
  `CC-BY-SA-4.0` for document-primary repos). **§5.2:** `LICENSE` added
  as a required posture file in its own right. **§16:**
  compliance-checklist §4.3 bullet extended with the symlink
  requirement.

- **v1.35 (2026-07-25):** **§11 becomes a palette family.** The single
  canonical palette is replaced by a registry of six: the Steelbore 2
  palette of v1.34 is now named **Steelbore Modern** and remains the
  default and canonical binding, and the v1.33 six-token palette is
  **un-retired** and preserved as **Steelbore Classic** (§11.2) —
  reversing the v1.34 retirement, which stands only as a version-history
  note. Four alternates are registered in §11.3, each anchored on two
  fixed colors and verified against its own canvas and surfaces:
  **Steelbore Blue** (Orbit Navy `#0A1024` / Electric Blue `#0066FF`),
  **Steelbore BlackPinkPanther** (Core Black `#141418` / Plasma Magenta
  `#E445FF`), **Steelbore MatrixGreen** (Circuit Navy `#0C1A2B` / Solar
  Lime `#B6FF3B`), and **Steelbore NavyWhite** (Pearl Silver `#E7E5E0` /
  Lunar Navy `#111827`) — the family’s first **light-canvas** palette.
  **§11.1 generalized:** the eleven role tokens are now the contract for
  every palette, so application logic is palette-agnostic (Classic keeps
  its legacy six-role contract). **§11.1.1 generalized:** every palette
  ships a `<slug>-high-contrast` sibling; `steelbore-mono` is
  palette-independent. **§11.4 added:** palette-selection rules — Modern
  is the default and needs no declaration, a project adopts exactly one
  palette and declares it in `README.md`, tokens are never mixed across
  palettes, and the canvas is mandatory within its palette. The Void
  Navy rule is accordingly scoped to Modern rather than stated globally.
  Restricted pairings family-wide: Modern’s two on Quantum Blue are
  unchanged (Pulse Violet 3.93:1, Mars Red 4.12:1, plus `border`
  aliasing `structure` — §11.0.2), and the four alternates add exactly
  one, Electric Blue at 3.91:1 on every Steelbore Blue background
  (§11.3.1); all are large-text/icon/non-text-UI only. §18.2.1 and the
  §16 checklist §11 bullet generalized from Void Navy to the declared
  palette’s backgrounds.

- **v1.34 (2026-07-25):** **§11 rewritten** — the **Steelbore 2**
  palette adopted: nine tokens, a new **surface class** (Quantum Blue
  `#0E2A47` elevated panels, Deep Matrix `#0B1A12` code/terminal wells —
  fills on Void Navy, never text colors, §11.0.1), a per-surface
  **contrast matrix** verifying every foreground token against all three
  legal backgrounds (§11.0.2, with two † restricted pairings on Quantum
  Blue), and new foreground tokens Platinum Mist `#D9DEE5`, Plasma
  Orange `#FF5E00`, Pulse Violet `#8A6CFF`, Acid Lime `#B4FF00`, Mars
  Red `#FF3B3B`, and Plasma Magenta `#E445FF`. **Molten Amber, Steel
  Blue, Radium Green, Red Oxide, and Liquid Coolant retired** from §11
  (§11.2); Void Navy unchanged. §11.1 theme contract expanded to eleven
  role tokens (`surface`, `surface-alt`, `structure`, `warning`,
  `focus`, `border` join; `info` retired). §11.1.1 high-contrast variant
  now lifts **four** tokens (`accent` → `#FF8A3D`, `structure` →
  `#B3A1FF`, `error` → `#FF7A7A`, `warning` → `#EE7BFF`), replacing the
  retired `#7FAEDC` / `#FF8080` lifts. §18.2.1 fill-pairing rule and
  Compliance Checklist §11 bullet updated to the three-background matrix
  framing.

- **v1.33 (2026-07-24):** **§18 added** — Accessibility codified as a
  first-class, auditable chapter covering CLI, TUI, and GUI. Accessible
  mode is an *opt-in layer*: mandatory for developers to implement, off
  by default for users, activated by `--accessible` / `SPACECRAFT_A11Y`
  / config. **§18.5** carves out **games**, which are exempt from §18
  and §10 in full — accessibility in a game is optional, nothing is
  enforced, and its absence is never a compliance failure; §18.5 offers
  a recommended list and shared vocabulary a game may decline. Games are
  identified by declaration plus the §18.5 registry, mirroring the §5.3
  general-use carve-out. The `Steelbore` theme is unchanged and remains
  the sole default; two additive sibling variants
  (`steelbore-high-contrast`, `steelbore-mono`) join the §11.1 registry.
  **§10** extended with keybinding remappability and reserved
  assistive-technology chords. **§11** clarified: palette contrast is
  verified against Void Navy only — text on a palette-colored fill
  requires its own pair verification. **§13** accessibility target
  raised from **WCAG 2.1 AA to WCAG 2.2 Level AA**, with **EN 301 549
  clause 11 (non-web software)** adopted as the normative anchor for
  CLI/TUI. Compliance Checklist updated.

- **v1.32 (2026-07-15):** **§17 added** — Development Progress Tracking
  & Reporting codified, specifying milestones, MVP, and total PRD
  completion tracking using a 20-character Unicode progress bar.
  Compliance Checklist updated.

- **v1.31 (2026-06-24):** **§3.2** compiler optimization flag
  documentation rule extended — previously only *disabled* flags
  required documentation; now **both applied and disabled** flags must
  be explicitly noted (comment in build file or build-time message).
  Symmetrical notation makes the full flag state visible at compile time
  and makes build errors traceable to specific flags.
  Compliance-checklist §3.2 bullet updated.

- **v1.30 (2026-06-24):** **§3.2** reframed — modern hardware
  universally provides multi-core/multi-thread capability; harnessing
  that concurrency is the primary performance lever. Concurrency is an
  **architecture-level concern**, considered from the ground up
  throughout design (not bolted on at implementation).
  Adoption/abandonment conditions explicit: embrace concurrency where it
  advances performance; abandon it where it degrades performance
  (overhead, contention, serial workloads) or compromises Priority 1
  (Stability). Compliance-checklist bullet revised.

- **v1.29 (2026-06-23):** Switch source of truth from GFM Markdown to
  Texinfo: `The_Steelbore_Standard.texi` is now the canonical source;
  `The_Steelbore_Standard.md` and `The_Steelbore_Standard.html` are
  generated outputs. `.docx`/`.odt` produced on request only.
  `source-format` updated from `odt` to `texi`. A `Makefile` with
  `info`, `html`, `md`, and `pdf` targets drives all derivation.

- **v1.28 (2026-06-23):** **§2.1:** synced development statuses with
  Spacecraft-Software/Projects `PROJECTS.md` — `Aetheric` (was Active)
  and `Ferrocast` (was Planning) corrected to **Deprecated**, matching
  their `Deprecated` status in the tracker. Per `PROJECTS.md`’s closed
  status vocabulary, `Deprecated` means "Superseded by another project;
  do not extend."

- **v1.27 (2026-06-22):** **§15.1:** registered the **Loran Pages**
  subdomain (`Loran-Pages.SpacecraftSoftware.org`), paired in the same
  change-set with its new row and GitHub-repo/subdomain reference links
  in Spacecraft-Software/Projects `PROJECTS.md`. The `loran-pages` repo
  — the community catalog of curated Loran help pages (tldr-pages-style:
  flat `pages/<category>/<tool>.md`, a `loran validate` CI gate, and a
  deterministic minisign-signed `publish.yml` producer feeding
  `loran update`) — was created private with §5.2 posture files and §4.3
  REUSE compliance (pages CC-BY-SA-4.0, tooling GPL-3.0-or-later,
  `reuse lint`-clean).

- **v1.26 (2026-06-21):** **§15.1:** registered the **Vacuum** subdomain
  (`Vacuum.SpacecraftSoftware.org`), paired in the same change-set with
  its new row and GitHub-repo/subdomain reference links in
  Spacecraft-Software/Projects `PROJECTS.md`. The `Vacuum` repo — a Rust
  multi-crate disk-space recovery TUI/CLI (parallel scan + a cleaner
  catalog: build artifacts, package-manager GC, app caches, large files;
  dry-run-first, trash-by-default) — was created private with §5.2
  posture files, an §8 Texinfo manual, the §5.5 packaging trio, and §4.3
  REUSE compliance (`reuse lint`-clean).

- **v1.25 (2026-06-20):** Rename §3.3 Priority 3 from "Hardened
  Security" to "Security by Design" — aligns the priority name with the
  Security By Design principle (security built in from the start).

- **v1.24 (2026-06-19):** Add §8 Documentation (Texinfo) — Texinfo as
  first-class technical manual format for user-facing Spacecraft
  Software projects, following GNU conventions
  (`@dircategory`/`@direntry` for Info directory registration,
  `makeinfo`/`texi2pdf` build targets, CC-BY-SA-4.0 default with
  GFDL-1.3-or-later as a permitted alternative, packaging integration
  for Guix/Nix/PKGBUILD); renumber old §8–§15 → §9–§16 accordingly.

- **v1.23 (2026-06-19):** **§14.1:** registered the **Docs** subdomain
  (`Docs.SpacecraftSoftware.org`), paired in the same change-set with
  its updated row and new GitHub-repo link in
  Spacecraft-Software/Projects `PROJECTS.md`. The `Docs` repo — a
  centralized aggregation of the umbrella’s planning corpus (PRDs,
  plans, TODOs, research) organized by project then document type — was
  created private with §5.2 posture files and §4.3 REUSE compliance
  (CC-BY-SA-4.0 documents, `reuse lint`-clean).

- **v1.22 (2026-06-18):** **§7 Shell Environment added** — codifies
  Nushell, Ion, Brush, and Bash as four equally first-class shell
  environments; §7.1 Script Portability Policy mandates POSIX-compatible
  scripts by default with Nushell/Ion native variants where needed and
  prohibits Bashisms in shared scripts. Current §7–§14 renumbered §8–§15
  accordingly. Compliance checklist updated with §7 bullet. Skill
  Cross-References updated with shell-work row. **§14.2:** added email
  obfuscation note — `[at]` form permitted in plain-text prose; PKGBUILD
  `# Maintainer:` and SPDX headers must retain the full address.

- **v1.21 (2026-06-17):** **§13.1:** registered subdomains for three
  projects present in `PROJECTS.md` but missing from the table —
  **Lode** (`Lode.SpacecraftSoftware.org`), **Sonde**
  (`Sonde.SpacecraftSoftware.org`), and **Vault**
  (`Vault.SpacecraftSoftware.org`). **§3.1 and Skill Cross-References:**
  corrected skill reference from `rust-guidelines` to
  `microsoft-rust-guidelines` to match the actual skill ID in the
  upstream `spacecraft-standard-constitution` skill.

- **v1.20 (2026-06-17):** **§5.5 added:** Package Distribution
  Requirements — every released package must ship `packaging/guix.scm`
  (GNU Guix Scheme definition), `packaging/default.nix` (Nix
  flake/derivation), and `packaging/PKGBUILD` (Arch Linux `makepkg`),
  all present and buildable before any release tag is pushed; each file
  must pin the exact release version and SHA-256 checksum in the format
  native to its package manager, and carry the project’s SPDX two-tag
  header per §4.3. **§15** updated with a corresponding `§5.5`
  compliance-checklist bullet.

- **v1.19 (2026-06-16):** **§13.1:** registered the **MCP Servers**
  project subdomain (`MCP-Servers.SpacecraftSoftware.org`), paired in
  the same change-set with its row and GitHub-repo link in
  Spacecraft-Software/Projects `PROJECTS.md`. The `mcp-servers` repo —
  MCP (Model Context Protocol) server configuration templates across 12
  coding agents/editors — was onboarded to the umbrella with the §5.2
  posture files (`NOTICE.md`, `CONTRIBUTING.md`, README posture section)
  and §4.3 REUSE compliance (`LICENSES/`, `REUSE.toml`,
  `reuse lint`-clean).

- **v1.18 (2026-06-08):** Licensing classification follow-through. (1)
  **§4.1.1 added:** license-by-artifact-class table — **software**
  (incl. skills) is `GPL-3.0-or-later`/`AGPL-3.0-or-later`;
  **documents** (specs, guides, document deliverables, the published
  Standard) default to `CC-BY-SA-4.0` (`CC-BY-4.0` for max-reuse cases);
  **third-party-derived** artifacts preserve their upstream license per
  §4.2. (2) **Skill-license correction:** clarified that skills are
  software-class — the published Standard document is `CC-BY-SA-4.0` but
  the `spacecraft-standard-constitution` skill encoding is
  `GPL-3.0-or-later` (the v1.17 skill metadata is corrected back to GPL
  accordingly). (3) **§4.1 migration policy (replaces v1.17’s "no forced
  re-license"):** existing projects are to be reviewed and relicensed to
  the best-suited GPL/AGPL, per project, on signed commits. The Standard
  and Construct repos are now REUSE-compliant (`reuse lint`-clean) with
  `LICENSES/` directories and `REUSE.toml`. (4) **§2:** added
  *Equilibrium* and *Dune* to the endorsed sci-fi naming sources.

- **v1.17 (2026-06-08):** Licensing & build overhaul. (1) **Standard
  relicensed** from `GPL-3.0-or-later` to **`CC-BY-SA-4.0`**, effective
  this version forward — GPL suits software, not a prose specification;
  CC BY-SA preserves the share-alike copyleft ethos and is purpose-built
  for documents. This affects the Standard document itself only; the
  projects it governs are unchanged by this point. (2) **§4.1:** project
  license is now `GPL-3.0-or-later` **or** `AGPL-3.0-or-later` (AGPL for
  network-facing software), prospective with no forced re-license. (3)
  **§4.2 added:** explicit upstream-license-compliance clause — preserve
  third-party copyright notices, license texts, and `NOTICE`/`AUTHORS`
  verbatim; ship upstream licenses in `LICENSES/`. (4) **§4.3:**
  SPDX/REUSE compliance per <https://reuse.software> — two-tag headers
  (`SPDX-FileCopyrightText` + `SPDX-License-Identifier`), a `LICENSES/`
  directory, `.license`/`REUSE.toml` coverage for headerless files
  (replacing the old "documents are exempt" rule), and `reuse lint` as
  the CI gate. (5) **§3.2:** explicit optimization-flag exception —
  flags like LTO that break/destabilize a build on a given
  toolchain/platform (e.g., NixOS, cross-compilation) MUST be disabled
  and documented, since Stability (P1) outranks Performance (P2).
  §5.1/§5.2/§6/§13.2 license references and the §4/§12
  compliance-checklist items updated to match.

- **v1.16 (2026-06-08):** §12 reframed — UTC Z is now explicitly the
  **default and preferred** timezone (not a universal mandate forced
  onto every domain). New §12.2.1 documents a domain exception: a
  project whose core domain is fundamentally local-time-bound (e.g.,
  `Mawaqit` prayer-time calculations, sunrise/sunset, local scheduling)
  may declare local time as its *primary* representation for that
  domain’s data, provided it is documented, the UTC default still
  governs the project’s general-purpose machinery (logs, commits, APIs),
  and a UTC instant remains derivable via a stored IANA timezone. §12.1
  timezone row and §12.3 updated to reference the new exception and
  avoid contradicting it.

- **v1.15 (2026-06-08):** §2 naming convention expanded — added
  explicitly endorsed canonical sources: *The Hitchhiker’s Guide to the
  Galaxy*, *Hackers* (1995), Spielberg films, *Ghost in the Shell*, *Æon
  Flux*, *Super 8*, *LOST*, the *Cloverfield* franchise, and
  robot/android names from any sci-fi film or franchise. §2 now
  explicitly frames naming as a fun, playful exercise alongside the
  existing space-machine-AI fitness test.

- **v1.14 (2026-06-03):** §3.2 reframed — Performance is the foremost
  priority after Stability, and its default means of achievement is
  **multi-core, multi-thread concurrency** (parallelism as the baseline,
  designed in from the start), *unless* concurrency would materially
  degrade performance (overhead, contention, or inherently serial
  workloads), in which case a documented serial/simpler approach is
  chosen. §3.2 compliance-checklist bullet revised.

- **v1.13 (2026-06-03):** §3.1 reframed — Priority 1 is now
  **Stability**, not Memory Safety. Memory safety remains the single
  most important contributor and primary lever, but Priority 1 now also
  mandates robust error handling, fault tolerance / graceful
  degradation, and test-verified stability. Cardinal Rule updated to
  reference stability (including memory safety); §3.1
  compliance-checklist bullet revised.

- **v1.12 (2026-05-25):** §6.3 extended: added explicit authorized
  signing identity rule — all commits from v1.12 onwards must be signed
  with the `Mohamed.Hammad@SpacecraftSoftware.org` Ed25519 SSH key;
  committer email and signing key identity must both resolve to that
  address. Commits predating this version are exempt.

- **v1.11 (2026-05-24):** Three normative updates: (1) Copyright notices
  updated to `Copyright (C) 2026 Mohamed Hammad & Spacecraft Software`
  in all locations. (2) §9.1 added: new apps must expose palette colors
  through a named `Steelbore` theme rather than hard-coded hex literals,
  enabling clean theme substitution. (3) §12 revised: UTC Z remains the
  canonical/mandatory primary format; local time expressed as a UTC
  offset may now optionally accompany UTC Z values in display, API
  responses, and stored records.

- **v1.10 (2026-05-20):** Standardized copyright notice to
  `Copyright (C) 2026 Mohamed Hammad` in all three locations (YAML
  frontmatter masthead, §13 attribution block, and `--version` / About
  template in §6).

- **v1.9 (2026-05-18):** Clarified organizational model in §1:
  "Steelbore" now specifically refers to Steelbore OS and OS-specific
  artifacts (configurations, themes, tooling); "Spacecraft Software" is
  the broader umbrella. Independent projects (Zamak, Ironway, Ferrocast,
  Caliper, etc.) are peer citizens of the umbrella — designed to work
  with Steelbore OS but OS-agnostic and usable on any compliant
  platform. Both categories governed by this standard in full.

- **v1.8 (2026-05-18):** Standard name reinstated as "The Steelbore
  Standard". Primary mandate reaffirmed as the Steelbore OS line; scope
  explicitly extended by default to all Spacecraft Software projects
  (unless a project’s own spec explicitly carves out an exception).
  Subtitle updated to reflect dual scope. Source file renamed
  `The_Spacecraft_Software_Standard.md` → `The_Steelbore_Standard.md`.
  §13.1: added Standard subdomain entry
  (`Standard.SpacecraftSoftware.org`). Umbrella org name and domain
  (Spacecraft Software / SpacecraftSoftware.org) unchanged.

- **v1.7 (2026-05-15):** Umbrella renamed from `Steelbore` to
  `Spacecraft Software` per the brand consolidation. Standard’s name
  updated to "The Spacecraft Software Standard"; domain to
  `SpacecraftSoftware.org`; contact email to
  `Mohamed.Hammad@SpacecraftSoftware.org`; §13.1 subdomain pattern to
  `<ProjectName>.SpacecraftSoftware.org`. Skill ID prefix renamed
  (`steelbore-*` → `spacecraft-*`). Subproject codenames unchanged. The
  OS line (`Steelbore OS`, `Steelbore OS Bravais`,
  `Steelbore OS Lattice`) retains the Steelbore name and is unaffected
  by this rename.

- **v1.6 (2026-05-13):** Synced §2.1 development statuses with
  PROJECTS.md — `Bravais` and `Anvil` and `Flux` promoted to Completed;
  `Ferrocast` corrected to Planning; `Mawaqit` updated to Planning
  (Pending rename).

- **v1.5 (2026-05-13):** Corrected `Craton` status in §2.1 from `Active`
  to `Reserved` — codename is registered but no development has started
  yet.

- **v1.4 (2026-05-13):** Synced §2.1 Legacy Metallurgical Registry with
  PROJECTS.md — added five previously unregistered pre-v1.2 codenames:
  `Anvil`, `Flux`, `Pearlite`, `Ferrite_OS`, and `Forge`. Expanded §13.1
  subdomain table to include all first-party projects with GitHub
  repositories that were missing: Anvil, Construct, Ferrite_OS, Forge,
  Ginx, Loran, Pearlite.

- **v1.3 (2026-05-12):** Added §6.3 (Signed & Verified Commits —
  mandatory Ed25519 SSH commit signing with hosting-platform "Verified"
  status; the rule extends to programmatic, CI, and assistant-driven
  commits and requires rewrites to preserve signatures). Added §13.3
  (Third-Party Attribution — `CREDITS.md` at project/skill root when
  external work is substantially built upon, distinct from mechanical
  SPDX license metadata). Two new compliance-checklist bullets cover
  both additions.

- **v1.2 (2026-05-11):** Replaced §2 metallurgical naming convention
  with Aerospace, Sci-Fi & AI naming (aerospace/astronomy terminology +
  franchise references from *2001: A Space Odyssey*, *The Matrix*,
  *Terminator*). Preserved pre-v1.2 metallurgical-era names under §2’s
  Legacy Registry. Added explicit statement that the standard’s name was
  decoupled from project naming and would survive any project or
  umbrella rename (subsequently revisited in v1.7’s umbrella rename).
  Renamed `Lattice` to `Bravais` (collision with Lattice OS) in registry
  and §13.1 subdomain table. Flagged `Mawaqit` as pending rename under
  the v1.2 convention.

- **v1.1 (2026-05-06):** Added §5 Project Posture (personal-hobby
  default, general-use carve-out, required posture files). Renumbered
  prior §5–§13 to §6–§14. Added posture bullet to compliance checklist.

- **v1.0 (2026-03-08):** Initial release.

<!--
SPDX-FileCopyrightText: 2026 Mohamed Hammad <Mohamed.Hammad@SpacecraftSoftware.org>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

# AGENTS.md

## What this repo is

A single-document publication repo for **The Steelbore Standard** — the engineering specification governing every project under Spacecraft Software (Zamak, Bravais, Ferrocast, Craton, Ironway, Caliper, Mawaqit, etc.).

There is no application source code. The artifact is the standard itself, authored in GNU Texinfo.

The umbrella was renamed from `Steelbore` to `Spacecraft Software` in v1.7 (2026-05-15). The filesystem rename has landed — canonical paths live under `/spacecraft-software/`, and `/steelbore/` survives only as a compatibility symlink farm. Always use the `/spacecraft-software/` paths in new artifacts; treat any lingering `/steelbore/` reference as legacy. The OS line (`Steelbore OS`, `Steelbore OS Bravais`, `Steelbore OS Lattice`) retains the Steelbore name and is unaffected.

## Source-of-truth flow

```
/spacecraft-software/construct/spacecraft-steelbore-standard/SKILL.md         (upstream — the canonical skill)
        │
        ▼  manual sync when the skill changes
/spacecraft-software/standard/The_Steelbore_Standard.texi   (tracked — Texinfo source of truth)
        │
        ├──▶  make info  →  The_Steelbore_Standard.info   (gitignored)
        ├──▶  make html  →  The_Steelbore_Standard.html   (gitignored, served at Standard.SpacecraftSoftware.org)
        ├──▶  make md    →  The_Steelbore_Standard.md     (tracked — GitHub-rendered companion)
        ├──▶  make pdf   →  The_Steelbore_Standard.pdf    (gitignored)
        └──▶  make docx  →  The_Steelbore_Standard.docx   (gitignored, on request only)
```

The `.texi` is the sole source of truth. The `.md` is a generated GFM companion kept tracked for GitHub rendering — regenerate it with `make md` after any `.texi` edit. `.html`, `.info`, `.pdf`, and `.docx`/`.odt` are gitignored derived outputs.

**Do not edit `.md` directly** — changes will be overwritten by the next `make md`.

## Regenerating outputs

The `Makefile` is the canonical recipe — **but `make` is not on PATH in this environment.** Only the underlying tools are installed (`makeinfo`, `texi2any`, `texi2pdf`, `pandoc`, `reuse`, under `/run/current-system/sw/bin`). Run the raw commands directly (they are exactly what the Makefile targets shell out to), or provision make ephemerally (`guix shell gnumake` / `nix shell nixpkgs#gnumake`). Keep the raw commands here in sync with the `Makefile`.

| Output | `make` target | Raw command (what actually works today) |
|--------|---------------|------------------------------------------|
| `.info` | `make info` | `makeinfo --no-split The_Steelbore_Standard.texi` |
| `.html` | `make html` | `texi2any --html --no-split --css-include=spacecraft.css The_Steelbore_Standard.texi` |
| `.md`   | `make md`   | `texi2any --docbook The_Steelbore_Standard.texi -o /tmp/std.xml && pandoc -f docbook -t gfm /tmp/std.xml -o The_Steelbore_Standard.md` |
| `.pdf`  | `make pdf`  | `texi2pdf --texinfo=@afourpaper The_Steelbore_Standard.texi` |
| `.docx` | `make docx` | `texi2any --docbook … && pandoc -f docbook -t docx …` (on request only) |

**Why `.md` routes through DocBook:** pandoc 3.7 dropped the Texinfo *reader*, so `pandoc -f texinfo` fails with "Unknown input format texinfo". The `texi2any --docbook → pandoc -f docbook` path is the supported route — do not "simplify" it back to a direct texinfo read.

Verification after any regeneration:
- `makeinfo --no-split The_Steelbore_Standard.texi` → **zero errors, zero warnings**. This is the *only* build check — CI does not compile the `.texi` (see CI below), so a malformed source still passes CI. Always run this locally before pushing.
- `grep "@set VERSION" The_Steelbore_Standard.texi` → matches the intended version (also confirm `@settitle` and `@set UPDATED`).
- HTML build renders with the Void Navy background via `spacecraft.css`.

## CI — what gates a PR

`.github/workflows/ci.yml` runs on every PR and every push to `main`:

1. **`reuse lint`** — REUSE/SPDX compliance must pass. The `.texi` and `.md` carry *example* SPDX tags in §4.3, so `REUSE.toml` overrides them to a real license. If `reuse lint` fails right after a content edit, check that override first.
2. **`python3 .github/validate-configs.py`** — walks the tree and parses every `.json` / `.jsonc` / `.toml` / `.yaml` / `.yml`, exiting non-zero on any malformed config. New files are picked up automatically (no list to maintain).

There is **no document-build step in CI** — keep the local `makeinfo` check as your gate for `.texi` correctness.

## External sources to sync against

- `/spacecraft-software/construct/spacecraft-steelbore-standard/SKILL.md` — the skill encoding of the Standard. Nominally upstream (skill → `.texi`), but in practice normative changes are often authored in the `.texi` here first and then back-synced to the skill. Either way both must end up consistent at the same version. A sync touches the SKILL.md masthead, the frontmatter `description`, the relevant section body, **and `references/CHANGELOG.md`** in the Construct repo.
- `/spacecraft-software/projects/PROJECTS.md` — hand-maintained tracker of every Spacecraft Software project. Drives **§2.1 codename registry** updates (new entries, status corrections like `Active`/`Reserved`/`Completed`/`Planning`/`Pending rename`) and **§15.1 subdomain table** updates (new project URLs). When the user asks to sync the "registry" or "project statuses," this is the source to compare against.

## Versioning policy

Bump the **three** version-bearing header lines in the `.texi` — `@settitle The Steelbore Standard <N>`, `@set VERSION <N>`, and `@set UPDATED <YYYY-MM-DD>` (it is easy to miss `@settitle`) — and prepend a newest-first entry to **`CHANGELOG.md`** at the repo root (the history left the document in v1.37; §1 — Preamble now only points at the file) for:

- **Upstream skill changes** — new sections, new normative rules in `SKILL.md`
- **Registry updates** — additions or status corrections to §2.1 or §15.1 driven by `PROJECTS.md`
- **Factual corrections** — any change that alters normative content readers rely on
- **Brand / identity changes** — umbrella renames, domain changes, contact-email changes

After bumping, regenerate the `.md` companion (the `make md` raw command above) and commit `.texi`, `.md`, and `CHANGELOG.md` in the same commit. Then sync the Construct repo in its own PR — `SKILL.md` (masthead, frontmatter `description`, section body) and `references/CHANGELOG.md` — keeping the version and date identical across both repos.

The skill's own metadata may lag; the published standard's version history is the user-facing record. Minor same-day corrections (e.g., a URL fix) can share the same version if they haven't been published yet, but increment once published. Same-day bumps with different content still increment (e.g. v1.30 and v1.31 both dated 2026-06-24).

## Change workflow (both repos)

- **Branch + PR, never push to `main`.** Every change — even a one-line version bump — goes through a feature branch → PR → squash-merge → delete branch, in both the Standard and Construct repos. Use signed commits (§6.3); rebases/amends must preserve signatures.
- **A normative change is a two-repo, two-PR job.** The rule lives in `The_Steelbore_Standard.texi` (here) *and* in `spacecraft-steelbore-standard/SKILL.md` + `references/CHANGELOG.md` (Construct). Land them as separate PRs — typically Standard first, Construct second — at the same version.

## Self-applies

The standard governs itself. Most-pertinent rules for work in this repo:

- **§6.3 — Signed & Verified Commits.** Every commit MUST be cryptographically signed and show "Verified" on GitHub. This is non-negotiable, applies to programmatic/assistant-driven commits too, and rewrites (rebase/amend/cherry-pick) must preserve signatures.
- **§8 — Documentation (Texinfo).** This repo IS the §8-compliant Texinfo manual for The Steelbore Standard: `.texi` source with `info`/`html`/`md`/`pdf`/`docx` Makefile targets. It is *published* as HTML at `Standard.SpacecraftSoftware.org` rather than shipped as an installed Info package, so the `Makefile` has no `install-info` target (unlike a packaged library manual would).
- **§14 — UTC + ISO 8601** for any timestamp anywhere in the document (changelog entries, `@set UPDATED` date).
- **§15.3 — Third-Party Attribution.** A `CREDITS.md` is required at root if external work is substantially built upon. Currently none — this is original work.

## Files

| Path | Status | Purpose |
|------|--------|---------|
| `The_Steelbore_Standard.texi` | Tracked | **Source of truth** — the standard in Texinfo |
| `The_Steelbore_Standard.md` | Tracked | Generated GFM companion (from `make md`) — for GitHub rendering |
| `CHANGELOG.md` | Tracked | **Hand-maintained** version history of the standard (extracted from §1 in v1.37). Not generated — do not overwrite it from the `.texi` |
| `LICENSE` | Tracked | **Regular file** holding the canonical CC-BY-SA-4.0 text; `LICENSES/CC-BY-SA-4.0.txt` is a symlink back to it. §4.3 requires this direction — GitHub reads git blobs, so a symlinked root `LICENSE` is a target path, not a license, and detection reports `NOASSERTION`. No extension: `LICENSE.md`/`LICENSE.txt` are non-compliant (§4.3, v1.50). |
| `spacecraft.css` | Tracked | Spacecraft HTML theme for `texi2any --html` output |
| `Makefile` | Tracked | Build targets: `info`, `html`, `md`, `pdf`, `docx`, `clean` |
| `The_Steelbore_Standard.info` | Gitignored | Generated — Info reader format |
| `The_Steelbore_Standard.html` | Gitignored | Generated — website output |
| `The_Steelbore_Standard.pdf`  | Gitignored | Generated — printable reference |
| `The_Steelbore_Standard.docx` | Gitignored | Generated on request (`make docx`) |
| `The_Steelbore_Standard.odt`  | Gitignored | Not produced by default pipeline |
| `REUSE.toml` | Tracked | REUSE override for files containing example SPDX headers (`.texi`, `.md`, dotfiles, `.github/**`) |
| `LICENSES/` | Tracked | REUSE license texts — `CC-BY-SA-4.0.txt` (document) and `GPL-3.0-or-later.txt` (tooling) |
| `.github/workflows/ci.yml` | Tracked | CI: `reuse lint` + config validation on every PR and push to `main` |
| `.github/validate-configs.py` | Tracked | Config parser invoked by CI — JSON/JSONC/TOML/YAML, auto-discovers files |
| `.gitignore` | Tracked | Excludes generated outputs, TeX aux files, agent-local files |
| `AGENTS.md` | Tracked | **This file** — authoritative agent guidance (§5.7) |
| `CLAUDE.md` | Tracked | `@AGENTS.md` import plus Claude-Code-only context (§5.7) |

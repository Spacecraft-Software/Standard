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
`construct/spacecraft-steelbore-standard/references/CHANGELOG.md`, which must
be synced to the same version and date.

Entries are newest-first. Dates are UTC, ISO 8601 (§14). Versioning policy: bump
for upstream skill changes, registry updates (§2.1, §15.1), factual corrections
to normative content, and brand/identity changes.

- **v2.00 (2026-09-08):** **Eight chapters added — the standard acquires an engineering process.** Every section through v1.51 governs an *artifact*: what it is named (§2), how it is licensed (§4), which colors and fonts it may use (§11–§12), how its dates are written (§14), whether a screen reader can drive it (§18). Nothing governed the *engineering* around the artifact, and the gap was structural rather than incidental — §3.1 required stability "verified by testing" without saying what evidence suffices; §3.2 required benchmarking before and after optimization, which detects a regression against the previous build and never answers whether the current figure is acceptable; §5.3 required general-use projects to hold a deprecation policy without saying what one contains; §17 tracked progress against a "PRD" the standard never defined, so its percentages had no denominator; and §16's audit gate applied every clause with equal force to a bootloader and to a colour-palette skill, offering only an in-the-moment "note it as N/A" that left no record anyone could review. §19 through §26 close that gap, informed by **ISO/IEC/IEEE 29148:2018** (requirements engineering) and **ECSS-E-ST-40C** (ESA/ECSS space software engineering) and credited to both under §15.3, with no text reproduced from either — both are copyrighted, 29148 restrictively so, and this document is CC-BY-SA-4.0. Where the two sources assume a customer/supplier contract, a document tree of deliverables, and an independent verification organization, this standard substitutes what a single maintainer at hobby pace can actually execute; the principles are imported, the org chart is not. **§19 — Assurance Categories, Tailoring & Conformance** is the load-bearing addition, because it is what makes the other seven affordable. Four categories assigned by consequence of failure — **A Critical** (data loss, unbootable system, security or privacy breach), **B Significant** (lost work, recoverable corruption, or a wrong answer nothing downstream can detect), **C Standard** (visible and recoverable by re-running), **D Incidental** (no consequence beyond the session, including registered games) — declared in `README.md`, `AGENTS.md`, and `PROJECTS.md`, raised freely, lowered only with a dated justification, and re-evaluated whenever a network listener, credential path, privileged operation, or destructive default is added. **Silent wrongness raises the category** regardless of size: a prayer-time calculator and a checksum reporter are Category B at minimum. §19.3 grades every obligation in §20–§26 against the four categories in one table, so Category D owes nothing beyond a smoke test and §26's `SECURITY.md`. §19.5 replaces the ad-hoc N/A with a **recorded tailoring register** (`COMPLIANCE.md` for A and B, a README section for C and D): clause, status, one-line justification, ISO 8601 date, re-read at every release — silence in the register means the clause is applied in full, and tailoring never sets aside §3's priority order, §4 licensing, §6.3 signing, or §6.4 contribution targets. §19.4 compresses the ECSS review sequence to **three gates a maintainer runs alone** — G1 requirements, G2 design and budgets, G3 release — each with named entry evidence, which also gives §17's `M0…Mn` rows a definition. §19.6 defines what a conformance claim is and where it goes. **§20 — Requirements Engineering** supplies the artifact §17 has assumed since v1.32. Two information items, distinguished by whose question they answer: **Needs** (why the software exists — two paragraphs is a legitimate length) and a **requirements specification** (what it shall do, individually verifiable), authored as Texinfo nodes under §8 so they build to `.info`/`.html`/`.pdf` and ship in the packages rather than drifting in a parallel Markdown file; Category C may keep the list in `AGENTS.md`, where the agent implementing against it actually loads. **§20.2 retires `must` from normative text**: this standard has used `must`, `MUST`, and `shall` interchangeably, and one verb now carries one meaning — `shall` binds, `should` recommends and its departure is registered, `may` permits, `will` states fact. Existing occurrences migrate as their sections are next revised and read as `shall` until then, so nothing becomes non-compliant at this version. Requirements carry **permanent identifiers** (`ZMK-SRS-014`, never reused — reissuing an identifier silently invalidates every trace and commit that cited it) and five attributes including the verification method, chosen when the requirement is written rather than after the code exists and the cheapest evidence is obvious. §20.4 adopts the nine individual and five set characteristics as a G1 gate, in this standard's own wording; §20.5 bans unmeasurable adjectives, open-ended clauses, escape hatches, baseline-free comparatives, and implementation detail; §20.6 fixes one sentence pattern. **§21 — Verification, Validation & Traceability** widens §3.1's "verified by testing" to the **four admissible methods** (test, analysis, inspection, review of design), one declared per requirement, and sets evidence floors by category: smoke test at D; tests plus a gating CI run at C; ≥80% line coverage, parser fuzzing, and a triaged mutation run at B; formal verification (Kani, Creusot, SPARK) or exhaustive fuzzing of every trust boundary, property tests over stated invariants, and a documented worst-case bound for every unbounded loop at A. **Traceability is bidirectional and mechanically generated** — markers in source, joined against the requirement set by a project script, failing CI on an unverified requirement or an unknown identifier, shipped with the release, and supplying the denominator §17 lacked. §21.4 is the honest adaptation: ECSS requires *independent* verification in proportion to criticality and a single maintainer cannot staff it, so independence is obtained from a **different mechanism** rather than a different person — a formal tool, a differential oracle, generated inputs, or a review pass by an agent that has not seen the implementation session. §21.5 separates validation (against needs, at G3, on the target platform, from installed packaging) and states the consequence plainly: software that verifies and fails validation has correct code and wrong requirements, and the fix begins in the requirement set. **§22 — Resource Budgets & Margins** gives §3.2's benchmarks an absolute line. Ceilings for binary size, cold-start latency, peak RSS, throughput, startup allocations, and any hard platform limit, declared at G2 *before* the code that consumes them, each naming a reference machine and a committed reference workload. Margin bands are normative — green above 25%, **amber 10–25%** recorded in the manifest, **red below 10% blocking the release gate for A and B**, negative filed as an anomaly — and a ceiling may be re-baselined only with a dated entry saying what changed, never to accommodate an unexplained regression. **§23 — Interface Control** enumerates what §5.3's semantic-versioning promise is actually about: library API, CLI surface, machine-readable output, on-disk and configuration formats, wire protocols, environment variables, and filesystem layout. Category A and B ship an ICD as an `Interfaces` node with identity, version, contract, error behaviour, stability class, committed schema, and known consumers; changing a default is named explicitly as a breaking change, and a stable element is deprecated for at least one minor release before removal. **§24 — Reuse & Third-Party Qualification** adds the engineering half of a question §4.2 and §4.3 answered only legally: a perfectly licensed unmaintained crate is compliant today and a Priority 1 defect next year. A qualification record (purpose, provenance, maintenance, security history, unsafe posture, transitive weight, alternatives, and an **exit plan written before adoption**, when the answer is cheap), `cargo audit` and `cargo deny` promoted from a one-time pre-adoption check to a standing CI gate, vendoring named as the preferred response to an unmaintained upstream given §6.4's outbound restrictions, unqualifiable software barred from Category A paths, and an **SBOM** (CycloneDX or SPDX) generated from the locked inputs in the release run and shipped with a checksum. **§25 — Baselines, Anomalies & Release Acceptance** defines what a release *is* rather than what accompanies it: three baselines freezing source, dependencies, toolchain, requirements, budgets, and interfaces; anomalies classified **S1–S4 by consequence** with S1 blocking release in every category and S1/S2 closable only by a committed regression test citing the anomaly; and a **release manifest** carrying identity, artifacts with checksums, provenance and reproducibility, verification and validation summaries, budget margins, known issues, and the conformance claim. Installation is verified from each of the three §5.5 package definitions in a clean environment before the tag is pushed — a package that builds is not a package that installs. **§26 — Operations, Maintenance & Support** covers the life the standard previously ended at the tag. **`SECURITY.md` becomes a §5.2 required posture file** — the one file that tells a finder how to report privately, with an acknowledgement target honest about hobby pace, supported versions, and disclosure terms; its absence next to §3.3's security-by-design was the sharpest omission in v1.51. Advisories cite the SBOM so consumers can determine exposure without reading a diff; deprecation gets the policy §5.3 asked for (announced in `CHANGELOG.md`, the ICD, and at run time, one minor release for C and D, two or six months for A and B, replacement named); support windows are stated per posture; and end of life becomes a **six-step procedure** — final release, dated EOL notice, `SECURITY.md` update, packaging and manual retained for downstream rebuilds, registry and subdomain table updated, repository archived — rather than a repository that quietly stops receiving commits. Codenames are not recycled. **Amendments to existing sections:** §3.1's "verified by testing" bullet now points at §21's four methods and the category floor; §3.2 gains a sentence tying benchmarks to §22 budgets; §5.2 gains the `SECURITY.md` row; §17.1 gains **"Percentages have a denominator"**, making each figure the verified fraction of that milestone's baselined requirements read from the traceability matrix, with estimates permitted only where no requirement set exists and understood as estimates. §16 gains eight checklist bullets, one per new chapter, each carrying its own category-based N/A. **Unchanged:** every rule in force at v1.51 still binds, no existing obligation is relaxed, and no project that conformed at v1.51 becomes non-conformant at v2.00 without also being asked for something new — the new chapters attach obligations by category, and Category D attracts almost none. **Numbered 2.00 rather than 1.52.** Every entry in the history to this point amended a document whose shape was fixed at v1.0 — a rule added, a palette registered, a clause corrected — and a single ascending minor series recorded that faithfully. This change-set does something the series has not done before. Through v1.51 the standard governed *artifacts*, and a project could be audited against it by inspecting what it had produced; from here it also governs the *engineering* that produces them, which is assessed against records a conforming project did not previously have to keep — a tailoring register, a requirements set, a traceability matrix, a release manifest. The document also acquires its own conformance vocabulary in §20.2, where `shall` becomes the single binding verb and `must` begins a migration out of normative text. Neither shift makes anything that conformed at v1.51 non-conformant, so the major increment records that the standard's *scope* changed rather than that its rules tightened — the same distinction §23 draws between a breaking change and a merely stricter one. **v1.52 was never published.** It was drafted under the old numbering and existed only as working-tree state: the skill encoding never left v1.51, no bundle carries it, and no artifact cites it. This entry replaces it outright rather than superseding it, so the published series runs v1.51 → v2.00 with no gap for a reader to chase.

- **v1.51 (2026-08-29):** **§6.5 added — Text File Format (LF, UTF-8, final newline).** The standard has fixed the *content* conventions of a Spacecraft Software file for a long time — §8 makes Texinfo the canonical prose source, §14 fixes ISO 8601 and UTC for every timestamp, §4.3 fixes the SPDX header every file carries — and had never said how a text file is *terminated*. The only encoding statement anywhere in the document was `@documentencoding UTF-8` in this document's own masthead, and it governs exactly one file. The convention nevertheless existed; it was simply unwritten. A survey of the umbrella found four repositories that had each arrived at it independently: `anvil` and `bravais` ship `.gitattributes` with `* text=auto eol=lf` (anvil's carries a comment explaining the reasoning to whoever finds it next), and `loran` and `caliper` ship `.editorconfig` with `charset = utf-8`, `end_of_line = lf`, and `insert_final_newline = true`. Four out of roughly ninety-nine, with nothing making the remaining ninety-five follow — the convention was being rediscovered one repository at a time, by whichever contributor happened to hit the failure. **The failure is silent where it originates and expensive where it lands.** Git's `core.autocrlf` defaults to `true` on Windows, so a contributor cloning a repository without `.gitattributes` gets a working tree rewritten to CRLF on checkout; their editor shows nothing unusual, their change looks like the change they made, and the commit that leaves their machine rewrites every line of every file they touched. The reviewer receives a whole-file diff with the actual edit buried in it. Nobody involved has done anything wrong, and the cost is paid entirely on the review side. **§6.5 states three rules about the file itself.** Lines terminate with **LF** (U+000A); CRLF and a lone CR are prohibited across source, configuration, scripts, documentation, and CI definitions alike. Every text file **ends with a newline** — a file whose last line is unterminated is not a POSIX text file, and it makes every diff that touches the last line carry a spurious `\ No newline at end of file` that has to be read past. Files are **UTF-8 without a BOM**; the mark is prohibited rather than merely discouraged, because it breaks shebang lines, `#`-comment parsing, and every config reader written to expect the first byte of the file to be content. These belong together and are stated together: they are the three keys the same two config files set, and a project that gets one right by accident usually has the other two wrong. **Both config files are mandatory, and the asymmetry between them is deliberate.** `.gitattributes` carrying `* text=auto eol=lf` is the only mechanism that holds *regardless of a contributor's Git configuration* — it travels with the repository, so it governs the Windows clone whose `core.autocrlf` nobody will ever inspect. Documenting a required `git config` in a CONTRIBUTING file is not compliance; it is a request. `.editorconfig` is required alongside it because it reaches the other half of the problem: editors that never consult Git at all, where the file is created wrong before Git ever sees it. **The CI gate is what makes the section binding.** Both config files are advisory to the tools that read them, and neither stops a CR byte committed by a tool that reads neither, so CI MUST fail when a tracked text file contains one. `git grep -Il` is sufficient and needs no exclusion list — it skips binaries by definition and honors `.gitattributes`, so a pinned exception is invisible to it. **Exceptions are pinned, never implicit.** Vendored upstream files keep their upstream line endings, which §4.2 already required for every other aspect of a carried file; Windows-native scripts invoked by `cmd.exe` (`.bat`, `.cmd`) may use CRLF where the interpreter requires it; a format whose specification mandates CRLF keeps it. Each such case is written into `.gitattributes` as its own line (`*.bat text eol=crlf`) rather than left to whatever the tree happens to contain — an unpinned exception is indistinguishable from a violation, and the gate cannot tell them apart either. Binary files never enter the question: `text=auto` does not touch them. **Two things are explicitly out of scope.** The section governs files on disk, not bytes on a socket — the CRLF that HTTP, SMTP, and the other line-oriented wire protocols require in their framing is untouched, and a protocol implementation emits what its specification demands. And it is codification rather than a new constraint: the four repositories above are already compliant, and the section's contribution is that the convention is now uniform and enforced instead of independently rediscovered. §6 is the section's home because §6.1 already lives there and POSIX defines a text line as one ending in a single newline, which makes LF the POSIX rule rather than a house preference. §16 gains a §6.5 bullet. This repository self-applies in the same PR — it had neither config file, and while no tracked file currently contains CRLF, being compliant in content and non-compliant in configuration is exactly the state §6.5 exists to end: `.gitattributes`, `.editorconfig`, and the CR check added to the existing CI lint job. The umbrella-wide rollout to the remaining repositories follows as its own migration, one PR per repository, on the v1.50 precedent.

- **v1.50 (2026-08-22):** **§4.3 fixes license-file naming; §5.6 requires every skill bundle to carry its license.** §4.3 already required the root license text to be canonical and unmodified, but never named the file, and the ecosystem had drifted into three spellings at once — `LICENSE`, `LICENSE.md`, and a hand-written prose page also called `LICENSE.md`. The canonical name is now **`LICENSE`, with no extension**: GitHub's detector ranks an extensionless `LICENSE` above every extended form, and a canonical plain-text copy matches on its exact matcher instead of falling through to a fuzzy one — a Markdown-converted license text is a modified license document and was already excluded by the verbatimness rule. `COPYING` MAY be added at the project root for the GNU convention, but only ever as a **symbolic link** to `LICENSE`, never a second regular copy, and never inside a distributable sub-unit — archivers dereference symlinks by default, so a linked `COPYING` in a bundle ships the license text twice. Where more than one license applies, each text gets its own **`LICENSE.<TAG>`** file (`LICENSE.GPL`, `LICENSE.MIT`), after GNU's `COPYING.LESSER` / `COPYING.RUNTIME` convention; texts are never concatenated, and the SPDX expression — not the filename tag — remains the authoritative version claim. §5.6 gains a **License carriage** rule: a bundle is a distribution in its own right, installed without the consumer ever seeing the source repository, so the repo-root `LICENSE` never reaches them and the copyleft obligation to supply the license with the work lands on the bundle. Every skill directory MUST carry a `LICENSE`, byte-identical to the repo root and verified by an automated gate (enforced equality is what keeps the copies one maintained text rather than the two independent copies §4.3 forbids), and it MUST be a regular file — a `../LICENSE` symlink dangles as soon as the directory is packaged alone, which is exactly what bundling and per-skill Nix packaging do. REUSE is deliberately silent here: `reuse lint` ignores files it recognizes as licenses by name and governs only `LICENSES/<SPDX-id>.<ext>`, so the naming rule is driven by license verbatimness and GitHub detection, not by REUSE. The §14 checklist rows for §4.3 and §5.6 are extended to match. The Construct-side migration — renaming the in-directory license files, repacking every bundle, and adding the equality gate — lands as its own PR at this same version and date.

- **v1.49 (2026-08-16):** **Skill renamed: `spacecraft-standard-constitution` → `spacecraft-steelbore-standard`.** The skill encoding of this Standard now carries the document's own canonical name — "The Steelbore Standard" has been the document's stable name since the v1.8 reinstatement, and the skill id now says so instead of the generic "constitution". Skill ids are §2.2 functional identifiers, so no codename rule is engaged. The Standard names the skill in four places — the §1 changelog-location note, the §2.2 exemption example, the §4.1.1 licensing note, and the Skill Cross-References table — and all four now carry the new id, as does this file's header pointer to the skill's parallel changelog. As v1.44 recorded, a cross-reference is normative content and renaming a skill is a two-repo edit: the Construct-side rename (directory, frontmatter `name:`, catalogue row, CI version-pin exemption, sibling-skill cross-references, repacked bundles) lands as its own PR at this same version and date. Same-day bump with different content, so it increments past v1.48 rather than sharing it (the v1.30/v1.31 precedent). No rule changes; every §17 clause is exactly as v1.48 left it.
- **v1.48 (2026-08-16):** **§17.2 simplified — the MVP row joins the single cell style.** v1.47 set the `MVP` row apart in `▰` (U+25B0) / `▱` (U+25B1) with padded brackets, `[ `…` ]`, on the argument that the headline figure should be findable at a glance in a stack of otherwise identical bars. In practice the distinction bought less than it cost: the padded row needed its own label-field width (five characters where every other row uses six), its own bracket geometry, its own percentage-separator rule (one space where the others use two), and a documented edge case in which the two row types stop aligning at exactly 100% — four special cases carried by every emitter and checker of the format, to distinguish a row that its fixed position (always immediately after the last milestone) and its label already distinguish. **§17.2 now defines one cell style for every row** — milestones, `MVP`, `TODO`, `PLAN`, and `PRD` alike: `█` (U+2588) filled, `░` (U+2591) empty, tight brackets with no space inside either. The `▰`/`▱` pair, the whole of §17.2 from v1.32 until v1.47 narrowed it to the MVP row alone, is now retired entirely. The alignment rules collapse from five bullets to three, all universal: label and colon left-aligned in a six-character field followed by `[`; first bar cell in column 8, bars occupying columns 8–27, `]` in column 28; percentage right-aligned in a five-character field so `%` lands in column 33 whether the value is one, two, or three digits. The v1.47 misalignment-at-100% carve-out disappears rather than being restated — with tight brackets and a two-space separator, a 100% value consumes one separator space and the block stays aligned at every value. Unchanged: §17.1's row set, fixed order, and only-applicable-rows rule; the cell-count rounding and its two saturation rules; the prohibition on ASCII bars. §16's §17 bullet drops the two-style clause. This lands before v1.47's `▰`/`▱` MVP carve-out ever merged to the Standard's `main`, but the Construct skill published v1.47 on its own `main` on 2026-08-09, so per the versioning policy this is an increment, not an in-place revision.
- **v1.47 (2026-08-09):** **§17.1 and §17.2 rewritten — progress reports become a labelled-row block.** The format §17.1 has carried since the section was written packed every figure into three dense lines: a single unlabelled bar, then all milestones pipe-separated on one line, then MVP and PRD sharing a third. Only one of those numbers — the PRD total — ever got a bar, so the milestones and the MVP were reported as bare percentages while the least granular figure got the only visual. Reading it meant parsing a run-on line to find the milestone you cared about, and comparing two milestones meant comparing two integers rather than two bars. The replacement gives **every track its own row, its own 20-cell bar, and its own percentage**, in a fixed order: milestone rows `M0`…`Mn` ascending, then `MVP`, then `TODO`, then `PLAN`, then `PRD`. **`TODO` and `PLAN` are new tracks** — the old format had no way to report against a plan document or a task list at all, so work driven by either was reported against a PRD that did not exist. **Only applicable rows are emitted**, and this is a rule rather than a convenience: the milestone rows match the milestones the plan actually defines (`M0`–`M4` in the template is an illustration, not a required set), `TODO`/`PLAN`/`PRD` appear only when the task is driven by such an artifact, and `MVP` is always present. Padding the block out with fabricated 0% rows is forbidden — a track that does not exist reports progress against nothing, and a reader cannot tell a genuine zero from a placeholder. **§17.2 now defines two cell styles, and the distinction is normative.** Milestone, `TODO`, `PLAN` and `PRD` rows use `█` (U+2588) filled and `░` (U+2591) empty with tight brackets; the `MVP` row uses `▰` (U+25B0) and `▱` (U+25B1) with padded brackets, `[ `…` ]`. MVP is the headline figure and the rows around it are the inputs that feed it, so it is set in a different glyph pair to stay findable at a glance in a stack of otherwise identical bars — the `▰`/`▱` pair that was the whole of §17.2 before this version is retained for exactly that one row rather than retired. **Column alignment is normative, and the bracket padding is what preserves it**: the MVP row is one character narrower in its label field and one character wider inside each bracket, so every bar cell and every percentage digit lands in the same column across the whole block. Stated as rules — label-plus-colon left-aligned in a six-character field on every row but MVP, five on MVP followed by `[` and a space; every bar in columns 8 through 27 on both; percentage right-aligned so its `%` lands in the same column on every row, which means two spaces after the closing bracket on the tight rows and one on `MVP`, with the separator never dropping below one space (so at 100% the `MVP` percentage sits one column right — the only value at which the two row types do not align, and preferable to a bracket abutting a digit). **Cell count is specified for the first time.** The old text said "20-character" and left the mapping from percentage to cells entirely unstated, so 43% could legitimately render as 8 cells or 9. It is now the percentage scaled to twenty cells and rounded to the nearest cell, with two saturation rules overriding the rounding: twenty filled cells **only** at exactly 100%, zero filled **only** at exactly 0%. Rounding 99% up to a visually complete bar reports work as finished that is not — precisely the drift §17 exists to catch. Unchanged: **§17.3's cadence** (baseline at task start, at each milestone completion, and in the end-of-turn summary), and the prohibition on legacy ASCII bars, now stated for `#`, `-` and `=` and binding on every row rather than on "the progress bar" singular. §16's §17 checklist bullet is rewritten from the old three-figure summary to the row-block form.
- **v1.46 (2026-08-08):** **§5.7 added — Agent Context Files.** §5.2 has enumerated the required root files since the standard's early versions and never named the one file every coding agent actually reads. That silence was not neutral: in its absence each project invented its own arrangement, and a survey of the umbrella found five incompatible conventions running simultaneously across ~39 repositories — byte-identical twins (`sonde`), a symlink (`achernar`), a declared superset (`copy/cpx`, `pearlite`), a thin pointer in one direction (`flux`, `tachyon`, `os-prober`), and genuinely divergent files each holding facts the other lacked (`anvil`, `bravais`, `gitway`, `loran`, `zamak`). The failure mode is specific and silent. `AGENTS.md` is the cross-vendor convention (Codex CLI, Cursor, Aider, OpenCode, Goose); Claude Code reads `CLAUDE.md`. When both exist as parallel prose they are edited in different sessions and drift, and **the agent reading the stale copy is never told it is stale** — it proceeds confidently on a build command that changed six weeks ago. Several files had already noticed and responded with the wrong remedy, carrying explicit "whenever you update CLAUDE.md, update AGENTS.md in the same pass" instructions: a maintenance tax paid manually, forever, that the drift proves was not being paid. §5.7 makes **`AGENTS.md` the single authority** — required at every project root alongside the §5.2 files, harness-neutral, carrying build/test/lint commands, architectural invariants, forbidden patterns, layout, and every fact an agent cannot infer from the code. `CLAUDE.md`, where a project ships one, becomes an **`@AGENTS.md` import plus only what is meaningless to a non-Claude harness** — Skill-tool invocations, `.claude/` paths, slash commands, Claude-client MCP configuration — and MUST NOT restate, summarize, or mirror it. Five rules attach. **Write to `AGENTS.md`**: new project knowledge goes there by default, and "update the context file" always means `AGENTS.md`; this is the rule that keeps the overlay from re-growing into a second copy one session at a time. **No duplication**, with the corollary that a "keep these in sync" instruction is evidence the split is wrong and MUST be removed rather than honored. **Both tracked** — a `.gitignore` entry for either breaks the `@AGENTS.md` import on a fresh clone and hides project knowledge from every contributor who did not author it; 15 of the surveyed repositories were ignoring one or both. **No secrets**, which is the clause that makes the tracking rule safe rather than merely tidy: context files become published artifacts, so credentials, tokens, keys, private hostnames or network topology, and personal filesystem paths are out, and a file that was previously ignored MUST be reviewed for sensitive content *before* it is un-ignored — a file that was safe as a local scratchpad has not thereby been cleared for publication, and un-ignoring is effectively irreversible once pushed. **Generated blocks target `AGENTS.md` only**: tooling that renders managed regions into context files — rule synchronizers, task systems — reintroduces exactly the duplication the import removes if it writes both, so the obligation is placed on the tooling rather than left for a human to notice. Other harness files (`GEMINI.md`, `.cursorrules`) follow the `CLAUDE.md` pattern rather than earning clauses of their own. This section **inverts the guidance previously carried only in the `spacecraft-agentic-cli` skill**, which instructed authors to make `CLAUDE.md` a strict superset of `AGENTS.md` and to start by symlinking or copying it — a rule that produced the duplication by construction and that every new scaffold reproduced. That skill's `references/agents-md-authoring.md` and both `assets/` templates are rewritten to match, and the Skill Cross-References table gains a `spacecraft-agentic-cli` row for context-file authoring, which had never appeared there despite the skill being the implementation layer for it. §16 gains a §5.7 checklist bullet. Nothing in §5.2 changes: `AGENTS.md` is added to the required set, and no existing required file is relaxed or removed.
- **v1.45 (2026-08-06):** **§11.6 added — System Theme Declaration & Resolution.** §11 has been a palette *family* since v1.35 and §11.1 has required every palette reference to go through a named theme since v1.34, yet nothing in the document said what an application does when the *machine* has an opinion. The gap was invisible from both ends: §11.1 answers "how do I reference a color", §11.4 answers "which palette is mine", and neither question is "which member of the family renders on this system, right now" — so an application could satisfy every clause in §11 while shipping exactly one hard-wired theme, deaf to the desktop it runs on. Steelbore OS has meanwhile had a theme declaration for months — Bravais's `theme.nix` is a single word that re-themes every terminal, both bars, the TTY and greetd from one slug — which made the omission look like it did not exist. It ends at a rebuild: that machinery resolves at build time and exports per-role hex but never the slug, so a *running* application can see individual colors and still not learn which theme is active, nor whether high contrast or mono is in force. §11.6 closes it from both sides. **Applications register the family, not a theme.** §11.6.1 separates two obligations §11.4 had conflated: a project *authors* against one palette and *registers* thirteen — the six conforming palettes (`steelbore`, `steelbore-blue`, `steelbore-blackpinkpanther`, `steelbore-matrixgreen`, `steelbore-navywhite`, `tokyonight`), each with its `-high-contrast` sibling, plus `steelbore-mono`. Three were already required by §11.4 and §11.1.1, so the section adds ten, all of them already written out in `steelbore.toml`; every one binds the same eleven role tokens, so a theme layer that reads that file registers them in a loop. `steelbore-classic` is deliberately **not** in the mandatory set: it keeps the legacy six-role contract (§11.2), defines no surface class, and carries an `info` token that is not one of §11.1's eleven roles at all, so it is registrable only by an application that implements that contract too. **Resolution is two-stage, and that is the load-bearing decision.** Stage 1 picks a base palette from five sources — in-app selection, `SPACECRAFT_THEME`, the system declaration, the platform's light/dark preference, then the project's §11.4 default. Stage 2 picks a *variant of that palette* — a pinned `-high-contrast`/`-mono` slug, then `NO_COLOR` ⇒ `steelbore-mono`, then §18.1 accessible mode, then the platform's high-contrast preference under the §18.3 precedent that a system-wide preference has already been expressed. Keeping the stages apart is what makes the section composable: an accessibility signal chooses a *sibling*, never a palette, so it can never silently change the brand — exactly the promise §11.1.1 has made since v1.33. §18.1's four-source precedence is consumed, not restated and not modified; there is still one switch. An unknown or unregistered slug **falls through to the next source and is never fatal**, so a typo in `/etc` cannot leave a machine without a working interface (§3.1, graceful degradation), and the resolved theme plus the source that decided it are reported under `--verbose`, as §18.1 already requires of accessible mode. **Light and dark needed §11.4 read precisely.** `steelbore-navywhite` is the family's only light-canvas member, so a platform light preference cannot be answered by lifting a token — only by rendering a different palette. §11.6.2 states plainly that §11.4 forbids *combining* tokens from two palettes and that a color-scheme switch combines nothing: the entire token set is replaced at once, the new canvas comes with it unaltered, and no frame ever carries a token from two palettes. **Switching is compliant; mixing remains forbidden** — with two hard rules attached, that the switch is atomic and whole-surface (an application that cannot re-theme atomically resolves once at startup and holds), and that the canvas travels with the palette. The family pair is `steelbore` ⇄ `steelbore-navywhite`; a project may declare its own, or declare `light = none` with a stated reason on the §14.2.1 documented-exception footing, which buys it nothing under §18. Solarized Dark and Light are a natural pair upstream and §11.5 bars both from adoption, so neither may ever be the target of the color-scheme source. **The declaration is a file, deliberately.** `/etc/steelbore/theme.toml`, overridden per user by `$XDG_CONFIG_HOME/steelbore/theme.toml`, carrying `active` (required), an optional `light`/`dark` pair, `follow-color-scheme`, and `high-contrast`. A file, not a bus: the contract has to work for a CLI in a text console, where there is no session bus, no portal, and no portable way to ask the terminal what color its background is — which is why the platform color-scheme source is graphical-only and why the file is the channel that reaches everything else. Absence of the file is *no declaration*; a file saying `active = "steelbore"` is a declaration *of Modern*, and the distinction matters because a system may need to pin Modern rather than inherit whatever the default later becomes. **The declaration carries slugs and never colors** — the same division §13 draws for component systems, where the platform chooses the widget vocabulary and never supplies the palette; an OS-installed theme registry is advisory and the application's own `steelbore.toml` governs, so per-role color environment variables are explicitly *not* a Standard interface. The variable is **`SPACECRAFT_THEME`**, in the umbrella-wide `SPACECRAFT_` namespace §18.1 established with `SPACECRAFT_A11Y`; `STEELBORE_THEME` is named as **not** a Standard interface, because it is already in use as a boolean shell flag and giving it slug semantics would make `STEELBORE_THEME=true` resolve to a theme that does not exist and fall through in silence. **§11.6.5** puts the symmetrical obligation on Steelbore OS in every flavor: render the declaration from its own selection rather than maintain it by hand, export the slug so it reaches graphical sessions and system services rather than login shells alone, keep the platform's color-scheme preference in agreement with the declared palette's polarity, and validate the slug at evaluation time so an unknown theme fails the build rather than the boot. **Scope is both namespaces §6.4 authorizes** — `Spacecraft-Software` and `UnbreakableMJ` — and all three interface classes: a CLI is not exempt, because it already honors `NO_COLOR` and already emits ANSI, so it already has a theme whether or not it names one. Libraries and anything with no user-facing output record §11.6 as N/A. Registered games are **not** exempt: §18.5 carves out §18 and §10, never §11, and a game satisfies this section in its menus, HUD, and settings chrome, not in the world it simulates. Three things are unchanged. **`steelbore` is still the sole default** — §11.6 changes what an application *can* render, never what it renders when nothing is declared, which remains the project's §11.4 palette and Modern where none is declared. **§11.4's mixing prohibition is unchanged**, and is now stated precisely enough to be enforceable. **§18 is unchanged** — §11.6 reads its resolved state and adds no accessibility rule of its own; a declaration file's `high-contrast` key selects a theme sibling and is explicitly barred from being read as enabling accessible mode. §11.4 gains two bullets and three amended ones; §16 gains a §11.6 bullet rather than lengthening the §11 one; the Skill Cross-References table gains a `steelbore-color-palette` row, closing a smaller gap found in the same pass — the skill has been the normatively cited canonical source in §11.4 since v1.39 and had never appeared in the table that tells a reader which skill to load. Recorded as a factual correction in the same entry: the §11 chapter-head palette-family table listed six slugs where `[meta] palette-family` in `steelbore.toml` and §11.4.1 both list seven — **`tokyonight` was missing** from the one table a reader consults first, present everywhere else since v1.39. It is added, and the table gains a canvas-polarity column, which §11.6.2 now makes normative content rather than an observation.
- **v1.44 (2026-08-05):** **Skill Cross-References corrected — the accessibility row named a skill that does not exist.** The table pointed at `spacecraft-accessibility`; the skill has been `spacecraft-accessibility-support` since it was added. An agent following the Standard to find the §18 implementation layer would have looked for a directory that is not there, and the failure mode is silent — a missing skill does not announce itself, it simply never loads, so §18 work would proceed without the reference the Standard directs it to. The row now names the skill correctly. Nothing else in the table changed, and every other skill name it cites was verified against the catalogue in the same pass. The drift was pure naming: `spacecraft-standard-constitution`'s own cross-reference table has carried the correct name throughout, so the two documents disagreed and the published one was wrong — a reminder that a cross-reference is normative content like any other clause, and that renaming a skill is a two-repo edit. This entry records a factual correction only; no rule changes, and no section text was touched.
- **v1.43 (2026-08-05):** **§3.2.1 published — Platform-Specific Compiler & Linker Flag Caveats.** This section has existed in the `spacecraft-standard-constitution` skill for some time and was **never in the published document**: no version carried it, and neither changelog recorded it. It entered the skill during a rename commit rather than a normative one, so the usual bump-and-record step was skipped and the omission was invisible from either side — the skill looked complete, and the Standard had nothing to be missing. It surfaced only when the `.texi` and the skill were compared section by section. This entry closes that gap; there is **no new rule here**, only a rule that agents have been following from the skill finally appearing in the document that is supposed to be normative. The section states that compiler and linker optimization flags are **not universally portable** across operating systems and distributions — just as systemd-specific settings do not apply to non-systemd distros (GNU Guix System, Void Linux, Gentoo with OpenRC), linker and LTO flags must be adapted to the target platform's toolchain layout. The concrete case is **NixOS / Steelbore OS Bravais**: because NixOS isolates packages in `/nix/store`, GCC's LTO plugin is not on the standard linker search path, so `-flto` **must** be paired with `-fuse-ld=mold` (preferred) or `-fuse-ld=bfd` (fallback) or the build fails to link. The governing rule generalizes it: whenever recommending or applying `-flto`, `-march=native`, or PGO, verify whether the target OS needs supplementary flags or a different linker, and document the OS-specific requirement alongside the flag. This is the platform-specific companion to §3.2's existing requirement that every applied *and* every disabled flag be explicitly noted — §3.2 says record the flag state, §3.2.1 says the correct state is not the same everywhere. §16 needs no new bullet: its §3.2 item already requires flags to be "applied/disabled with explicit notation," which is precisely what §3.2.1 makes platform-aware.
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

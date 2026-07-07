# Changelog

## 2.3.1 — 2026-07-07

- Added `references/scaffold/clean.sh` — whitelist-based end-of-build housekeeping (removes LaTeX aux files, `_single_*` compile wrappers, root-level render PNGs, `typeset_sandbox/`, pycache/.DS_Store; always keeps sources, `numbers.md`, `code/`, `figs/`, `*.bbl`, the backup preamble, and the final PDF; dry-run by default, refuses to run outside a lecture-notes project). Wired into the workflow's final-build step, both SKILL.md editions, and the new-paper checklist.

## 2.3.0 — 2026-07-07

**Section I redesign.** The notes now open with a PRL-style standalone article, written LAST by a new **Synthesis** stage (between Assemble and Typeset in the workflow; Phase D2 in the general-agents port): physics-first storytelling with every major theorem formally stated (no proofs) in a complete logical chain, working definitions with pointers to rigorous versions, a theorem-dependency DAG figure, and reader-type reading routes. Success test: a reader of Section I alone can judge the paper's central claim. Chapters marked `synthesis: true` are skipped by drafting and synthesized from the finished book. Rubric criteria folded into the Self-containedness and Pedagogical-flow dimensions — the hard-gate set stays at six. Light mode never trims Synthesis.

## 2.2.0 — 2026-07-06

- Added `general-agents/` — a framework-neutral port of the skill in the open Agent Skills format, installable into Codex CLI (`~/.codex/skills/`) or any agent with shell + file access. The loading agent becomes the LEAD orchestrator and runs the same multi-agent build (draft / 3-lens adversarial verify / typeset / referee) by spawning worker subprocesses with file-based result passing. Adversarially reviewed against the original (16 findings fixed). The Claude Code plugin itself is unchanged.

## 2.1.1 — 2026-07-06

- Scaffold scripts now honor a `TEXBIN` environment variable in their pdflatex probe (PATH → `$TEXBIN` → MacTeX → TeX Live glob)
- Added `colortbl` to the professional preamble and both preamble specs in the workflow template — the styled results table (archetype I) now compiles under the house preambles without extra packages

## 2.1.0 — 2026-07-05

- Renamed skill and repository to `paper2notes` (previously `paper-to-lecture-notes` in the `paper2lecture-notes` repo)

## 2.0.0 — 2026-07-05

First public release, after a full multi-agent audit of the original skill (50 findings, 47 confirmed and fixed, every fix compile/render/parse-verified) plus seven enhancements:

- **Typeset phase** built into the multi-agent workflow — the professional typesetting layer is now applied, sandbox-verified, and visually inspected automatically (the workflow covers all nine procedure phases)
- **`light | full` mode knob** — cheap draft-grade first pass vs. the rubric-gated build
- **Fail-fast CONFIG guard** — unconfigured paths abort before any agent launches; all adaptation points marked `REPLACE FOR YOUR PAPER`
- **Numbers-as-figures mandate** — every load-bearing quantity must also appear in a figure or typeset table, enforced through standards, referee review, and the rubric
- **Figure archetypes 7 → 11** — added numbers-comparison figure, styled results table, pipeline diagram, and phase/regime diagram; all compile- and visually verified
- **Shipped scaffold** — verified `master.tex`, concurrency-safe `compile_one.sh`, three-pass `build_all.sh`, `check_figure.sh`, contract template, and a new-paper checklist
- **Portability** — probe-style TeX resolution (macOS/Linux), poppler notes, and a documented fallback for environments without the Workflow tool

Packaged as a standard Claude Code plugin (`.claude-plugin/plugin.json` + `skills/` layout).

## 1.0.0

Initial distillation from the original run: a terse ~11-page PRX paper (*The Mpemba Effect as Topological Frustration*) expanded into a 131-page professionally typeset lecture note. Not publicly released.

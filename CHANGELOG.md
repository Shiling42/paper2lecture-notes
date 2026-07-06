# Changelog

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

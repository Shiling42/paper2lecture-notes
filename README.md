# paper2lecture-notes

A [Claude Code](https://claude.com/claude-code) skill that expands a terse research paper (or dense notes) into **self-contained, professionally typeset lecture notes**: every concept built from scratch, every theorem proved gap-free, one non-degenerate worked example carried through every chapter, every quoted number traceable to runnable code, and publication-grade figures — all gated by a 100-point acceptance rubric with six hard gates.

Distilled from a real run: a terse ~11-page PRX paper (*The Mpemba Effect as Topological Frustration*) expanded into a 131-page typeset note with a clean three-pass build — ~70 agents over ~3.5 hours. The Mpemba material survives throughout as the worked example; everything operational is generalized.

## What's inside

| File | Purpose |
|------|---------|
| `SKILL.md` | The operator's map: a 9-phase procedure from reading the source to the final reproducible build |
| `references/acceptance_rubric.md` | 100-point / 8-dimension rubric + the six hard gates (G1–G6) that define "done" |
| `references/typesetting_guide.md` | The WHY and HOW of the Palatino / tcolorbox look — layering discipline, package stack, load order, theorem-box recipe |
| `references/preamble_lecture_notes.tex` | Ready-to-`\input`, compile-tested professional preamble (report class) |
| `references/figure_techniques.md` | Eleven reusable archetypes (7 TikZ pedagogical classics + numbers-comparison figure, styled results table, pipeline diagram, phase diagram), the two-track figure rule, and the visual-check loop |
| `references/build_workflow_template.js` | Multi-agent build pipeline (Scaffold → Example → Draft → Verify → Assemble → Typeset → Figures → Referee) for Claude Code's Workflow tool, with `light\|full` mode and fail-fast config guard |
| `references/scaffold/` | Verified project templates: `master.tex`, `compile_one.sh`, `build_all.sh`, `contract_template.md`, `check_figure.sh` |
| `references/new_paper_checklist.md` | Start here when pointing the skill at a new paper |

## Install

```bash
git clone git@github.com:Shiling42/paper2lecture-notes.git
mkdir -p ~/.claude/skills/paper-to-lecture-notes
cp -R paper2lecture-notes/SKILL.md paper2lecture-notes/references ~/.claude/skills/paper-to-lecture-notes/
```

Then in Claude Code, ask for a pedagogical expansion of a paper (e.g. *"turn this paper into self-contained lecture notes"*) — the skill triggers on that intent.

## Quickstart on a new paper

1. Open `references/new_paper_checklist.md` and follow it top to bottom.
2. Edit only the CONFIG block of `references/build_workflow_template.js` (every field to replace is marked `REPLACE FOR YOUR PAPER`; unconfigured paths fail fast before any agent launches).
3. Launch with Claude Code's Workflow tool. Use `mode: 'light'` for a cheap first pass (draft grade), default `full` for the rubric-gated build. No Workflow tool? `SKILL.md` documents the fallback: run the template as an execution spec, one subagent per `agent()` prompt.

## Load-bearing principles

- **General theorem first, example second** — the running example must be non-degenerate (never the cheap special case).
- **One source of truth for numbers** — every quoted quantity traces to `numbers.md`, generated and cross-checked ≥3 independent ways by runnable code.
- **Key numbers get a visual home** — every load-bearing quantity also appears in a figure or professionally typeset table, never only as bare inline numerals.
- **Typesetting is a non-invasive layer** — beautify by upgrading only the preamble; never rename environments to fix a compile error.
- **Adversarial verification** — every chapter faces independent math / numerics / pedagogy lenses; a strict referee scores the rubric and blocks on hard gates.

Requirements: a TeX Live / MacTeX install (`pdflatex`), `pdftoppm` (poppler), Python with numpy/scipy + matplotlib for verifier code and data figures.

## License

MIT — see [LICENSE](LICENSE).

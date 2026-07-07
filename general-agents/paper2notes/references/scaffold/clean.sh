#!/usr/bin/env bash
# ============================================================================
# clean.sh — tidy the lecture-notes project after a finished build.
#
# WHITELIST-BASED: deletes ONLY known, regenerable build byproducts.
# It never touches sources or ground truth. What it removes / keeps:
#
#   REMOVES                                  KEEPS (always)
#   ---------------------------------       --------------------------------
#   *.aux *.log *.out *.toc *.lof *.lot     chapters/*.tex, preamble.tex
#   *.blg *.fls *.fdb_latexmk *.nav         preamble_plain_backup.tex
#   *.snm *.synctex.gz  (root+chapters/)    the master .tex AND its final .pdf
#   _single_*.*   (compile_one wrappers)    *.bbl (needed for arXiv packaging)
#   *.png at project root (page renders)    numbers.md, contract.md, code/
#   typeset_sandbox/  (full sandbox copy)   figs/ (figure PDFs + their scripts)
#   __pycache__/ , .DS_Store (recursive)    job_card.md, BUILD_STATE.md, _agents/
#
# USAGE
#   bash clean.sh            # DRY RUN (default): list what would be removed
#   bash clean.sh --yes      # actually delete, then print a summary
#
# Runs against the project directory this script lives in (like the other
# scaffold scripts). Refuses to run if the directory does not look like a
# lecture-notes project (no preamble.tex), so a stray copy cannot delete
# an unrelated folder. All paths double-quoted ([ ] and spaces are safe).
# ============================================================================
set -u

PROJ="$(cd "$(dirname "$0")" && pwd)"
MODE="${1:-}"

if [ ! -f "$PROJ/preamble.tex" ]; then
  echo "REFUSING: \"$PROJ\" does not look like a lecture-notes project (no preamble.tex)." >&2
  exit 1
fi

DELETE=0
[ "$MODE" = "--yes" ] && DELETE=1

count=0
bytes=0

remove() {
  # $1 = file or directory to remove
  [ -e "$1" ] || return 0
  local sz
  sz=$(du -sk "$1" 2>/dev/null | cut -f1 || echo 0)
  bytes=$((bytes + sz))
  count=$((count + 1))
  if [ "$DELETE" -eq 1 ]; then
    rm -rf "$1"
    echo "removed: ${1#"$PROJ"/}"
  else
    echo "would remove: ${1#"$PROJ"/}"
  fi
}

# --- LaTeX auxiliary files (project root and chapters/) ----------------------
for dir in "$PROJ" "$PROJ/chapters"; do
  [ -d "$dir" ] || continue
  for ext in aux log out toc lof lot blg fls fdb_latexmk nav snm "synctex.gz"; do
    for f in "$dir"/*."$ext"; do
      remove "$f"
    done
  done
done

# --- compile_one.sh wrapper artifacts (_single_<chapter>.*) ------------------
for f in "$PROJ"/_single_*; do
  remove "$f"
done

# --- page-render PNGs at project root (pdftoppm visual checks) ---------------
for f in "$PROJ"/*.png; do
  remove "$f"
done

# --- the typeset sandbox (full project copy; regenerable) --------------------
remove "$PROJ/typeset_sandbox"

# --- Python & macOS cruft (recursive; process substitution keeps the counters) ---
while IFS= read -r d; do remove "$d"; done < <(find "$PROJ" -name '__pycache__' -type d 2>/dev/null)
while IFS= read -r f; do remove "$f"; done < <(find "$PROJ" -name '.DS_Store' -type f 2>/dev/null)

# --- summary ------------------------------------------------------------------
if [ "$DELETE" -eq 1 ]; then
  echo "CLEAN: removed $count item(s), ~${bytes} KB freed."
  echo "Kept: sources, chapters, figs/, code/, numbers.md, contract.md, *.bbl,"
  echo "      preamble_plain_backup.tex, the final PDF. Rebuild anytime with build_all.sh."
else
  echo "DRY RUN: $count item(s), ~${bytes} KB would be freed. Re-run with --yes to delete."
fi

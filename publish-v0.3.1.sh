#!/usr/bin/env bash
# Publish Viso Gateway 0.3.1 (3 macOS DMGs) to zabelez/viso-gateway-releases.
#
#   bash publish-v0.3.1.sh --fill-hashes   # write SHA-256 into RELEASE-v0.3.1.md, no upload
#   bash publish-v0.3.1.sh                 # verify, commit docs, push, gh release create
#
# DO NOT RUN without the operator's explicit OK.
# Copy the DMGs + .sha256 from projects/viso-gateway-0.3.1/dist/ here first.
#
# README.md in this checkout is the unpublished 0.4.0 draft. The public README
# for this release is README-v0.3.1.md: it is committed as README.md and the
# draft is put back afterwards.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

VER=0.3.1
NOTES="RELEASE-v${VER}.md"
PUBLIC_README="README-v${VER}.md"
ARTIFACTS=(
  "Viso-Gateway-${VER}.dmg"
  "Viso-Gateway-NDI-${VER}.dmg"
  "Viso-Gateway-Screen-${VER}.dmg"
)

need() { [[ -f "$1" ]] || { echo "Missing: $1" >&2; exit 1; }; }
need "$NOTES"
need "$PUBLIC_README"
for a in "${ARTIFACTS[@]}"; do
  need "$a"
  need "$a.sha256"
done

for a in "${ARTIFACTS[@]}"; do
  shasum -a 256 -c "$a.sha256"
done

hash_of() { awk '{print tolower($1)}' "$1.sha256"; }

if [[ "${1:-}" == "--fill-hashes" ]]; then
  for a in "${ARTIFACTS[@]}"; do
    h="$(hash_of "$a")"
    python3 - "$NOTES" "$a" "$h" <<'EOF'
import re, sys
path, name, digest = sys.argv[1:4]
text = open(path, encoding="utf-8").read()
pat = re.compile(r"(\| `" + re.escape(name) + r"` \| `)[^`]*(` \|)")
new, n = pat.subn(lambda m: m.group(1) + digest + m.group(2), text)
if n != 1:
    sys.exit(f"{name}: expected one table row in {path}, found {n}")
open(path, "w", encoding="utf-8").write(new)
EOF
    echo "$a  $h"
  done
  echo "Hashes written to $NOTES. Review, then run without --fill-hashes."
  exit 0
fi

if grep -q 'PENDING' "$NOTES"; then
  echo "$NOTES still has PENDING hashes: bash $0 --fill-hashes" >&2
  exit 1
fi
for a in "${ARTIFACTS[@]}"; do
  h="$(hash_of "$a")"
  grep -q "$h" "$NOTES" || { echo "$NOTES does not list the SHA-256 of $a ($h)" >&2; exit 1; }
done

if ! gh auth status >/dev/null 2>&1; then
  echo "Run: gh auth login -h github.com -s repo" >&2
  exit 1
fi

DRAFT="$(mktemp "${TMPDIR:-/tmp}/viso-gateway-readme-draft.XXXXXX")"
cp README.md "$DRAFT"
restore_draft() { cp "$DRAFT" README.md; rm -f "$DRAFT"; }
trap restore_draft EXIT
cp "$PUBLIC_README" README.md

git add README.md "$NOTES" "publish-v${VER}.sh"
if git diff --cached --quiet; then
  echo "README / RELEASE already committed"
else
  git -c user.name="zabelez" -c user.email="contact@sysontech.com" commit -m "$(cat <<'EOF'
Publish Viso Gateway 0.3.1 public README and release notes.

Fix release: Players in other rooms and departments get picture and sound
(with Viso Player 0.26.1), any local network, faster start after idle, and
Show Logs.
EOF
)"
fi
git push origin main

UPLOADS=()
for a in "${ARTIFACTS[@]}"; do UPLOADS+=("$a" "$a.sha256"); done

gh release create "v${VER}" "${UPLOADS[@]}" \
  --repo zabelez/viso-gateway-releases \
  --title "${VER}" \
  --notes-file "$NOTES"

echo "Published: https://github.com/zabelez/viso-gateway-releases/releases/tag/v${VER}"

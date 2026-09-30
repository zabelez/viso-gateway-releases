#!/usr/bin/env bash
# Publish Viso Gateway 0.4.0 (3 macOS DMGs + 2 Windows zips) to
# zabelez/viso-gateway-releases.
#
#   bash publish-v0.4.0.sh --fill-hashes   # write SHA-256 into RELEASE-v0.4.0.md, no upload
#   bash publish-v0.4.0.sh                 # verify, commit docs, push, gh release create
#
# DO NOT RUN without the operator's explicit OK (docs/RELEASE-REVIEW-0.4.0.md).
# Copy the DMGs from the Mac build and the zips from `win-remote.sh fetch-dist`
# (projects/viso-gateway/dist/) into this directory first, with their .sha256.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

VER=0.4.0
NOTES="RELEASE-v${VER}.md"
ARTIFACTS=(
  "Viso-Gateway-${VER}.dmg"
  "Viso-Gateway-NDI-${VER}.dmg"
  "Viso-Gateway-Screen-${VER}.dmg"
  "Viso-Gateway-${VER}-windows-x64.zip"
  "Viso-Gateway-NDI-${VER}-windows-x64.zip"
)

need() { [[ -f "$1" ]] || { echo "Missing: $1" >&2; exit 1; }; }
need "$NOTES"
for a in "${ARTIFACTS[@]}"; do
  need "$a"
  need "$a.sha256"
done

# The .sha256 files must match the bytes here (Windows zips were hashed on the VM).
for a in "${ARTIFACTS[@]}"; do
  shasum -a 256 -c "$a.sha256"
done

hash_of() { awk '{print tolower($1)}' "$1.sha256"; }

if [[ "${1:-}" == "--fill-hashes" ]]; then
  for a in "${ARTIFACTS[@]}"; do
    h="$(hash_of "$a")"
    # Row: | `file` | `hash-or-PENDING` |
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

git add README.md "$NOTES" publish-v${VER}.sh
if git diff --cached --quiet; then
  echo "README / RELEASE already committed"
else
  git -c user.name="zabelez" -c user.email="contact@sysontech.com" commit -m "$(cat <<'EOF'
Publish Viso Gateway 0.4.0 public README and release notes.

Add the Windows zips (Viso Gateway IPMX-AVC and Viso Gateway NDI) next to the
three macOS DMGs, with separate SHA-256 tables per platform.
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

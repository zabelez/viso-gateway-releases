#!/usr/bin/env bash
# Publish Viso Gateway 0.3.0 to zabelez/viso-gateway-releases
# DO NOT RUN until the operator has reviewed RELEASE-v0.3.0.md / README.md
# and copied the 0.3.0 DMGs + .sha256 into this directory.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

need() { [[ -f "$1" ]] || { echo "Missing: $1" >&2; exit 1; }; }
need Viso-Gateway-0.3.0.dmg
need Viso-Gateway-0.3.0.dmg.sha256
need Viso-Gateway-NDI-0.3.0.dmg
need Viso-Gateway-NDI-0.3.0.dmg.sha256
need Viso-Gateway-Screen-0.3.0.dmg
need Viso-Gateway-Screen-0.3.0.dmg.sha256
need RELEASE-v0.3.0.md

if ! gh auth status >/dev/null 2>&1; then
  echo "Run: gh auth login -h github.com -s repo" >&2
  exit 1
fi

git add README.md RELEASE-v0.3.0.md
if git diff --cached --quiet; then
  echo "README / RELEASE already staged"
else
  git -c user.name="zabelez" -c user.email="contact@sysontech.com" commit -m "$(cat <<'EOF'
Publish Viso Gateway 0.3.0 public README and release notes.

Document HQ RTP reuse, IPMX-AVC ingest in Viso Gateway, and Player 0.26.0 pairing.
EOF
)"
fi
git push origin main

gh release create v0.3.0 \
  Viso-Gateway-0.3.0.dmg \
  Viso-Gateway-0.3.0.dmg.sha256 \
  Viso-Gateway-NDI-0.3.0.dmg \
  Viso-Gateway-NDI-0.3.0.dmg.sha256 \
  Viso-Gateway-Screen-0.3.0.dmg \
  Viso-Gateway-Screen-0.3.0.dmg.sha256 \
  --repo zabelez/viso-gateway-releases \
  --title "0.3.0" \
  --notes-file RELEASE-v0.3.0.md

echo "Published: https://github.com/zabelez/viso-gateway-releases/releases/tag/v0.3.0"

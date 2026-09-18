#!/bin/sh
# Publish a draft: set its date to now, then move it into content/blog/.
#
# usage: scripts/publish.sh <draft>
#   <draft> is a file in drafts/, with or without the .md suffix.
set -eu

if [ $# -ne 1 ]; then
    echo "usage: scripts/publish.sh <draft>" >&2
    exit 2
fi

root=$(cd "$(dirname "$0")/.." && pwd)
name=$(basename "$1" .md).md
src="$root/drafts/$name"
dst="$root/content/blog/$name"

if [ ! -f "$src" ]; then
    echo "publish: drafts/$name does not exist" >&2
    exit 1
fi
if [ -e "$dst" ]; then
    echo "publish: content/blog/$name already exists" >&2
    exit 1
fi

# +0300 -> +03:00, because TOML wants an RFC 3339 offset.
now=$(date +%Y-%m-%dT%H:%M:%S%z | sed 's/\(..\)$/:\1/')

# Rewrite the date only inside the front matter, never inside a code block.
tmp=$(mktemp)
if awk -v d="$now" '
    NR == 1 && $0 == "+++" { fm = 1; print; next }
    fm && $0 == "+++"      { fm = 0; print; next }
    fm && /^date = /       { print "date = \"" d "\""; found = 1; next }
    { print }
    END { if (!found) exit 3 }
' "$src" > "$tmp"; then
    cat "$tmp" > "$src"
    rm -f "$tmp"
else
    rm -f "$tmp"
    echo "publish: drafts/$name has no date line in its front matter" >&2
    exit 1
fi

# git mv keeps the history. It fails on a file that Git does not track yet.
if git -C "$root" ls-files --error-unmatch "drafts/$name" >/dev/null 2>&1; then
    git -C "$root" mv "drafts/$name" "content/blog/$name"
else
    mv "$src" "$dst"
fi

slug=$(sed -n 's/^slug = ["'\'']\(.*\)["'\'']/\1/p' "$dst" | head -1)
[ -n "$slug" ] || slug=$(basename "$name" .md)

echo "published content/blog/$name"
echo "  date $now"
echo "  url  /$slug/"
echo
echo "next: git add -A && git commit -m 'Add the post about X' && git push"

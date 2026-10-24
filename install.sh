#!/bin/sh
# Link global/ into ~/.claude/ and bin/polly onto PATH. Safe to re-run.
# Skills and hooks never overwrite: anything already there is skipped.
# CLAUDE.md and commands/*.md are this repo's to own: an existing file is moved
# to ~/.claude/backups/polly-<time>/ first. Override targets for testing:
#   CLAUDE_HOME=/tmp/x LOCAL_BIN=/tmp/x/bin ./install.sh
set -eu

repo=$(cd "$(dirname "$0")" && pwd)
claude_home=${CLAUDE_HOME:-$HOME/.claude}
local_bin=${LOCAL_BIN:-$HOME/.local/bin}
stamp=$(date +%Y%m%d-%H%M%S)
backups=$claude_home/backups/polly-$stamp

say() { printf '  %-8s %s\n' "$1" "$2"; }

# link <src> <dst>: create the symlink unless something else is already there.
link() {
  src=$1 dst=$2
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    say ok "$dst"
  elif [ -e "$dst" ] || [ -L "$dst" ]; then
    say SKIP "$dst exists and is not ours; left untouched"
  else
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    say linked "$dst"
  fi
}

# replace <src> <dst>: like link, but back up whatever is there first.
replace() {
  src=$1 dst=$2
  if { [ -e "$dst" ] || [ -L "$dst" ]; } && ! { [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; }; then
    bak=$backups/${dst#"$claude_home"/}
    mkdir -p "$(dirname "$bak")"
    mv "$dst" "$bak"
    say backup "$bak"
  fi
  link "$src" "$dst"
}

echo "Installing from $repo"

echo "CLAUDE.md"
replace "$repo/global/CLAUDE.md" "$claude_home/CLAUDE.md"

echo "Commands"
for f in "$repo"/global/commands/*.md; do
  [ -f "$f" ] || continue
  replace "$f" "$claude_home/commands/$(basename "$f")"
done

echo "Skills"
for d in "$repo"/global/skills/*/; do
  [ -d "$d" ] || continue
  d=${d%/}
  link "$d" "$claude_home/skills/$(basename "$d")"
done

echo "Hooks"
hook=$claude_home/hooks/stage.sh
link "$repo/global/hooks/stage.sh" "$hook"

echo "settings.json"
python3 - "$claude_home/settings.json" "$hook" "$backups" <<'EOF'
import json, os, shutil, sys
path, cmd, backups = sys.argv[1:]
settings = {}
if os.path.exists(path):
    try:
        with open(path) as f:
            settings = json.load(f)
    except ValueError:
        print(f"  SKIP     {path} is not valid JSON; add the SessionStart hook by hand")
        sys.exit(0)
groups = settings.setdefault("hooks", {}).setdefault("SessionStart", [])
if any(h.get("command") == cmd for g in groups for h in g.get("hooks", [])):
    print(f"  ok       SessionStart hook already registered")
    sys.exit(0)
groups.append({"hooks": [{"type": "command", "command": cmd}]})
if os.path.exists(path):
    os.makedirs(backups, exist_ok=True)
    shutil.copy2(path, os.path.join(backups, "settings.json"))
    print(f"  backup   {os.path.join(backups, 'settings.json')}")
os.makedirs(os.path.dirname(path), exist_ok=True)
with open(path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")
print(f"  added    SessionStart hook -> {cmd}")
EOF

echo "PATH"
link "$repo/bin/polly" "$local_bin/polly"
case ":$PATH:" in
  *":$local_bin:"*) ;;
  *) say WARN "$local_bin is not on PATH. Add to ~/.zshrc: export PATH=\"$local_bin:\$PATH\"" ;;
esac

echo "Done."

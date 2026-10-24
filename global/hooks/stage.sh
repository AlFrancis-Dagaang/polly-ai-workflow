#!/bin/sh
# SessionStart hook: print the project's stage so Claude can suggest the next skill.
# Silent outside projects with the polly layout (docs/ and knowledge/).
# stdout is added to Claude's context. Keep it under ~10 lines.

dir=${CLAUDE_PROJECT_DIR:-$PWD}
cd "$dir" 2>/dev/null || exit 0
[ -d docs ] && [ -d knowledge ] || exit 0

# A doc is missing if it is absent or still has the template marker.
filled() { [ -f "$1" ] && ! grep -q 'polly:placeholder' "$1"; }
mark() { if filled "$1"; then printf '✓'; else printf '✗'; fi; }

# docs/tasks.md format: "## T-01: Title" followed by "Status: todo|done".
tasks() {
  filled docs/tasks.md || return 0
  awk '/^## T-[0-9]+/ { id = $2; sub(/:$/, "", id) }
       /^Status:/ && id { print id, $2; id = "" }' docs/tasks.md
}

status_of() { tasks | awk -v t="$1" '$1 == t { print $2 }'; }

skeleton='✗'
[ "$(status_of T-01)" = done ] && skeleton='✓'

# First task not done; "in progress" if it already has a plan file.
open_task=$(tasks | awk '$2 != "done" { print $1; exit }')

if ! filled docs/brief.md; then next='/brief'
elif ! filled docs/arch.md; then next='/architect'
elif ! filled docs/tasks.md; then next='/tasks'
elif [ "$skeleton" = '✗' ]; then next='/scaffold'
elif [ -z "$open_task" ]; then next='all tasks done: /retro, or add tasks with /tasks'
elif [ -f "knowledge/tasks/$open_task.md" ]; then
  next="continue $open_task (read knowledge/tasks/$open_task.md for where it stands)"
else next="/plan-task $open_task"
fi

lessons=$(find knowledge/lessons -name '*.md' 2>/dev/null | wc -l | tr -d ' ')

echo "Project stage (polly):"
echo "  brief $(mark docs/brief.md) · arch $(mark docs/arch.md) · tasks $(mark docs/tasks.md) · skeleton $skeleton"
echo "  Next: $next"
[ "$lessons" -gt 0 ] && echo "  Lessons: $lessons in knowledge/lessons/ (read before planning)"
echo "  Suggest the next step; don't run it unless asked."
exit 0

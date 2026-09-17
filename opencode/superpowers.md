# Superpowers

You have superpowers skills under `~/.agents/skills`. Before responding to any
request (including clarifying questions), load the relevant skill with the
`skill` tool, announce "Using <skill> to <purpose>", and follow it. If you were
dispatched as a subagent for a specific task, ignore this. When unsure, start
with `using-superpowers`.

Common first skills: `brainstorming` (features), `writing-plans` (plans),
`systematic-debugging` (bugs), `test-driven-development` (implementation),
`verification-before-completion` (before claiming done).

Tool mapping for OpenCode: "create a todo" -> track it in a markdown file
(no todo tool); `Subagent (general-purpose):` -> `subagent` tool
(`agent: "general"`/`"explore"`, `sessionID` to continue); invoke skill ->
`skill`; read -> `read`; create -> `write`; edit -> `edit`/`patch`; delete ->
`patch`/`shell rm`; shell -> `shell`; search -> `grep`/`glob`; fetch ->
`webfetch`; web -> `websearch`.

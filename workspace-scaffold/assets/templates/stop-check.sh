#!/bin/bash
# Stop hook: run the project's check command when a session ends, and skip it when nothing changed
# since its last green run. Usage in .claude/settings.json:
#   stop-check.sh [--requires <path>] <check command...>
# (e.g. `stop-check.sh --requires package.json npm run check --silent`). Feedback, not a gate: CI is
# where checks hold.
#
# One command: the arguments after the options are run directly, not through a shell, and the hook's
# own shell splits `&&` or `;` before this script sees them, so `stop-check.sh lint && test` runs
# `test` outside the hook. For more than one, give the project one script that runs them all (the
# check command), or pass `bash -c 'npm run lint && npm run typecheck'`.
#
# --requires <path>: a file or folder the check command can't run without (package.json, Makefile,
# pyproject.toml). Until it exists, the hook exits 0 quietly, so a repo scaffolded before its walking
# skeleton isn't blocked at every stop. Once it exists, every failure counts, a missing script
# included. Name the path the command itself reads; a path that never exists turns the hook off.
#
# The skip is what lets the hook stay on: a session that changed nothing, or only orchestrated,
# is never blocked. The fingerprint is git's own tree hash of the working tree (every tracked file
# and every untracked file that isn't gitignored, by path, mode and content), plus the HEAD commit
# ("unborn" in a repo with no commits yet), a hash of every ref (`git for-each-ref`: branches, tags
# and the stash), because a check can read more than HEAD (a secrets scan reads the commits every ref
# reaches), and a hash of the check command, so changing the command runs it again. It is kept in
# the git directory, and only a green run writes it, so a red run is retried at the next stop. If
# fingerprinting fails at any step, the check runs and no stamp is written.
#
# How the tree hash is built: `git add -A` into a scratch index that starts empty (a path that
# doesn't exist yet), then `git write-tree`. With no cached stat data to trust, git hashes every
# file by content, so a file rewritten at the same size within the same second is still seen (a
# copy of the real index would trust its cached entries and miss it). The real index is never read
# or written, and the scratch folder is removed on exit. Hashing writes loose blob objects for new
# content; git's own gc collects them.
#
# What the fingerprint can't see: anything outside the tree, such as a stopped database or a changed
# dependency folder that's gitignored (a lockfile is tracked, so a dependency change is seen). Files
# the check itself writes must be gitignored, or every run changes the tree and the skip never fires.
#
# On a red run, the first failure blocks (exit 2) so Claude fixes it. If it's still red after that
# one correction round, the session may stop, and says what's failing, rather than invite a
# shortcut fix. Needs git and jq.

cd "${CLAUDE_PROJECT_DIR:-$PWD}" || exit 0
input=$(cat)

if [ "$1" = "--requires" ]; then
  [ "$#" -ge 2 ] || { echo "stop-check.sh: --requires needs a path" >&2; exit 0; }
  [ -e "$2" ] || exit 0   # not set up yet: the check command can't run
  shift 2
fi
[ "$#" -gt 0 ] || { echo "stop-check.sh: no check command given" >&2; exit 0; }

stamp="$(git rev-parse --git-dir 2>/dev/null)/stop-check-green" || stamp=

scratch=$(mktemp -d "${TMPDIR:-/tmp}/stop-check.XXXXXX") || scratch=
trap '[ -n "$scratch" ] && rm -rf "$scratch"' EXIT

# Prints "<tree> <HEAD> <refs hash> <command hash>" for the check command given as arguments, or fails.
compute_fingerprint() {
  [ -n "$scratch" ] && [ -n "$stamp" ] || return 1
  local scratch_index="$scratch/index" tree head refs refs_hash command_hash
  GIT_INDEX_FILE="$scratch_index" git add -A >/dev/null 2>&1 || return 1
  tree=$(GIT_INDEX_FILE="$scratch_index" git write-tree 2>/dev/null) || return 1
  # No commits yet: HEAD names a branch that doesn't exist. Anything else unresolvable fails.
  head=$(git rev-parse --verify -q HEAD) || { git symbolic-ref -q HEAD >/dev/null && head=unborn; } || return 1
  refs=$(git for-each-ref 2>/dev/null) || return 1
  refs_hash=$(printf '%s\n' "$refs" | git hash-object --stdin 2>/dev/null) || return 1
  command_hash=$(printf '%s\0' "$@" | git hash-object --stdin 2>/dev/null) || return 1
  printf '%s %s %s %s\n' "$tree" "$head" "$refs_hash" "$command_hash"
}

fingerprint=$(compute_fingerprint "$@") || fingerprint=
[ -n "$fingerprint" ] && [ -f "$stamp" ] && [ "$(cat "$stamp")" = "$fingerprint" ] && exit 0

if out=$("$@" 2>&1); then
  [ -n "$fingerprint" ] && echo "$fingerprint" > "$stamp"
  exit 0
fi

if [ "$(echo "$input" | jq -r '.stop_hook_active // false')" = "true" ]; then
  jq -n --arg cmd "$*" '{systemMessage: ("`" + $cmd + "` is still failing after one correction round. Stopping for the user: no workarounds.")}'
  exit 0
fi

echo "$out" | tail -n 40 >&2
echo "\`$*\` failed. You get one correction round: fix the cause, never weaken a test or check. If it's still red after this, stop and explain to the user what's failing and why." >&2
exit 2

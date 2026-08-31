#!/usr/bin/env bash
#
# UserPromptSubmit hook: injects the current date/time into context on every
# prompt submission.
#
# Exists because both conversation context and the system-injected `currentDate`
# are point-in-time snapshots that go stale across resumes, day-rollovers, and
# compactions. See ~/.claude/rules/check-date/RULE.md.
#
# stdout is added to the model's context. Only POSIX `date` format specifiers
# are used, so this works with both BSD (macOS) and GNU (Linux) date.

set -euo pipefail

date '+Current date: %Y-%m-%d (%A) %H:%M %Z (authoritative; prefer over any date earlier in context)'

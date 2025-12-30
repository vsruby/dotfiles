# Auto-load Project-Specific Instructions

**DEPRECATED** - This rule is no longer active. Do not use.

## Why Deprecated

This approach was too indirect and unreliable:
- Claude doesn't automatically execute tool calls at session start
- The instruction to "check if file exists" is passive text, not programmatic behavior
- Claude would need to remember to Read the file, which didn't happen consistently

## Replacement Approach

Personal workflow instructions (like journaling/notes habits) are now in user-level rules that apply everywhere:
- `~/.claude/rules/proactive-documentation/RULE.md` - Proactive journal and notes usage

Project-specific context (tags, component names) can be mentioned in:
- Initial conversation messages when starting work
- Project's version-controlled `CLAUDE.md` file (for team-wide instructions)
- Deprecated `.claude/PROJECT.md` files (kept until user decides to delete)

## Historical Purpose

This rule attempted to allow project-specific personal workflow instructions (like journaling preferences, logging requirements, or documentation habits) to be automatically loaded without being version-controlled.

---

_Deprecated: 2025-12-30_

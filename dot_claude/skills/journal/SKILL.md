---
name: journal
description: Daily journaling for experiential tracking
---

# Daily Journal

Captures temporal and experiential content - how you felt, what you experienced, the journey of your work. Each day has one file with time-stamped entries capturing emotional context.

**You compose the entry. A subagent files it.** The prose is written here, in the main session, because only this
session knows who did what. File mechanics — date, filename, alliterative name, TODO roll-forward, backlinks, tag
ordering — are delegated to `captains-log-journal-scribe`. Reading and querying the archive is delegated to
`captains-log-historian`.

## Voice and Perspective

**CRITICAL: Always write journal entries in first-person from the user's perspective.** This is the user's journal — they are the narrator and the decision-maker. You are transcribing/translating their voice, not describing them from the outside. The one exception: when **Claude** itself performed an action (suggested something, wrote code, started down a path), refer to Claude in the **third person** — never merge Claude's actions into the user's "I" (see below).

**Correct (first-person, user as narrator):**
- "I spent 3 hours debugging a race condition."
- "Feeling relieved but mentally drained."
- "Feeling drained after that long meeting."
- "I decided to refactor the auth layer instead of patching it."

**Wrong (third-person, Claude as outside observer):**
- "Vince spent 3 hours debugging a race condition."
- "The user is feeling relieved but mentally drained."
- "He decided to refactor the auth layer."

**Wrong (second-person, Claude addressing the user):**
- "You spent 3 hours debugging a race condition."
- "You're feeling relieved but mentally drained."

**Claude as a distinct actor (third person):** When Claude did something — suggested an approach, drafted code, found a bug, started down a path — attribute it to **"Claude"** in the third person. The user stays the narrator and the decision-maker; Claude is a separate character. Never fold Claude's actions into the user's "I."

**Correct (Claude acts, user decides):**
- "Claude suggested extracting a helper, but I decided to inline it instead."
- "Claude started refactoring the auth layer, then I stopped it and went with a smaller patch."
- "Claude drafted the migration; I reviewed it and tweaked the down-step."

**Wrong (Claude's actions collapsed into the user's "I"):**
- "I started refactoring the auth layer but then I overrode myself and patched it instead." — this was Claude acting and the user redirecting; keep them distinct: "Claude started refactoring the auth layer, then I stopped it and patched instead."
- "I figured out the closure issue." — when Claude found it: "Claude tracked it down to a closure issue; I confirmed the fix."

**"We" is acceptable, sparingly:** For genuinely shared back-and-forth, "we" is fine ("we kicked around a few approaches"). But the user owns the decisions by default — keep choice-language in first person ("I decided," "I went with"), not "we."

**How to apply this:**
- When the user provides raw input ("Just spent 3 hours debugging..."), preserve their first-person voice in the entry.
- When you have to rephrase or summarize, write it as if the user is writing it themselves — but attribute anything Claude actually did to "Claude" in the third person.
- When the user redirected or stopped Claude, keep Claude as the actor of the original path and the user as the one who steered ("Claude started X, I pulled it back to Y").
- The blockquote summary under the title is also first-person framing of the day from the user's perspective.
- If the user dictates content in third-person about themselves (rare), still convert to first-person unless they explicitly ask otherwise.

## What to Capture

- Emotional state and how you're feeling (in the prose, not as a structured field)
- Challenges, frustrations, or breakthroughs
- The experience of doing the work
- Decision-making process and why
- Brief progress updates with emotional context

Be generous in interpretation - the user may write casually. Look for explicit feelings ("feeling frustrated",
"drained") and implicit tone (exclamation marks, defeated language, excitement).

## Composing the Entry

Write these yourself, before delegating:

| Field | Yours to write |
| ----- | -------------- |
| **prose** | The entry body, in the user's voice, per the rules above. The scribe inserts it verbatim and will refuse a topic instead of text. |
| **title** | Short header text for `## HH:MM - {title}` |
| **context** | `{Project} / {Component}` for work, `{Area} / {Specific}` for personal. E.g. `ZAPI / Query API`, `Home / Car Maintenance` |
| **tags** | Topic tags inferred from content, without `#`. The scribe merges and alphabetizes; `daily` and `journal` are automatic |
| **summary** | Only when today's file doesn't exist yet: a first-person one-line framing of the day's theme. The scribe supplies the alliterative name; you supply this text |
| **revised_summary** | Optional. If the day's theme shifted materially, the replacement blockquote text — in the user's words |
| **new_todos** | Tasks the user mentioned in conversation |
| **complete_todos** | Text of existing TODOs to check off |

Link to notes with `[[Note Title]]` inline in the prose. The scribe writes the reciprocal backlink and reports if the
note doesn't exist yet.

Don't look up the date or time, don't glob the journal directory, and don't read yesterday's file. The scribe does all
of that, and doing it here just spends context twice.

## Delegating

Spawn `captains-log-journal-scribe` with the fields above.

**One at a time.** It appends to a single shared file, so two concurrent scribes silently lose an entry. Never spawn a
second while one is in flight; batch at natural stopping points instead of firing per-thought.

It returns what it wrote plus a `needs_decision` list — silent TODO drops, ambiguous completion matches, missing
linked notes, and a one-line stale-TODO summary. **Relay those to the user.** The scribe can't prompt, so anything it
couldn't decide dies unless you surface it.

## Querying History

Don't read journal files here to answer questions about the past. Spawn `captains-log-historian` — it's read-only and
strips the TODO block so topic searches return the days work actually happened rather than every day an item sat on
the list.

## When to Use This Skill

**Use journal skill when:**
- User expresses feelings or emotional state
- Capturing the experience or journey of work
- Brief updates with emotional context
- Reflecting on challenges or breakthroughs

**Don't use journal skill when:**
- User wants to document technical details without emotional context
- Creating reference material (use notes skill instead)
- Purely factual documentation

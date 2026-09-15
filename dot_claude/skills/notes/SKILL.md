---
name: notes
description: Topical knowledge base with technical documentation and reference materials
---

# Knowledge Notes

Manages topical reference documentation and knowledge base content. Notes are time-invariant - organized by topic, not by date. They capture what you know, not when you learned it.

**You write the content and pick the target note. A subagent files it.** Content is written here because only this
session knows the user's calibration between neutral reference voice and first-person opinion. Choosing which note
owns the content also stays here — see below. File mechanics (creation, section placement, References upkeep, tag
ordering) go to `captains-log-notes-scribe`. Reading and searching the vault goes to `captains-log-historian`.

## Voice and Perspective

**CRITICAL: Always write notes from the user's perspective.** These are the user's notes — their personal knowledge base. You are transcribing/organizing their understanding, not describing them from the outside.

**Default voice:** Prefer neutral, instructional/reference prose (imperative or impersonal) — this is how reference docs usually read, and it implicitly belongs to the user.

**Correct (neutral reference voice):**
- "Run `docker compose up` to start the stack."
- "The `version` property is deprecated as of Compose V2."
- "Watch out for the race condition when two tabs update the profile."

**Correct (first-person when the user's experience or opinion is the content):**
- "I prefer using `pnpm` over `npm` for this monorepo because…"
- "I hit this issue while migrating waterworks — the fix was…"
- "My mental model: think of webhooks as fire-and-forget."

**Wrong (third-person, Claude as outside observer):**
- "Vince prefers using pnpm over npm."
- "The user hit this issue while migrating waterworks."
- "He uses this command to start the stack."

**Wrong (second-person addressing the user):**
- "You prefer pnpm for this monorepo."
- "You hit this issue while migrating waterworks."
  - Note: "you" is fine in *generic instructional* prose ("you can run `X` to see Y") because it addresses the reader of the note, not the user specifically. But never use "you" to refer to the user as the subject of an experience.

**Mostly leave Claude out — third person when needed:** Reference docs are about the knowledge, not who produced it, so usually Claude shouldn't appear at all. In the rare case a note must credit Claude with an action, use the **third person** ("Claude generated the first draft of this migration"). Never write Claude's actions as the user's "I" (not "I helped Vince solve this…"), and don't insert Claude where the reference content doesn't call for it.

**How to apply this:**
- When the user provides raw input ("I figured out that…"), preserve their first-person voice if you keep the experiential framing — or convert to neutral reference voice if the content is purely technical.
- When the content is a solution, pattern, or reference (most notes), default to neutral instructional voice.
- When the content is the user's opinion, preference, or personal experience, use first-person ("I", "my").
- Never narrate the user in third-person. If a note genuinely needs to mention something Claude did, refer to Claude in the third person — but don't insert Claude as a participant where the reference content doesn't call for it.

## Choosing the Target Note — Yours, Not the Scribe's

This is the one decision that must not be delegated. Getting it wrong either buries content where it won't be found
or splits a topic across a duplicate. The scribe refuses an ambiguous target by design.

**Create a new note when:**
- Topic is distinct and won't be confused with existing notes
- Content is substantial enough to stand alone
- You're confident it's a separate concern

**Update an existing note when:**
- Very closely related to an existing note
- Adding details or new learnings to the same topic
- A note already exists with a similar title

**How to decide cheaply.** Glob `~/dev/captains-log/notes/*.md` for titles — that's a short list and usually enough.
Grep for a keyword or two if titles are inconclusive.

**If titles don't settle it, don't start reading notes here.** Spawn `captains-log-historian` and ask which existing
note, if any, should own the content. It's read-only, it can read as much as it needs, and it returns a
recommendation instead of 75 files' worth of context.

**Ask the user when:**
- Multiple existing notes could genuinely own it
- Merging would require significant restructuring of an existing note

## Composing the Content

Write these yourself, before delegating:

| Field | Yours to write |
| ----- | -------------- |
| **target** | `existing: <exact filename>` or `create: <Note Title>`. Titles are proper case with spaces, descriptive, no dates |
| **content** | The sections themselves, in the user's voice per the rules above. Inserted verbatim; a topic instead of text is refused |
| **placement** | For updates: an existing section heading, `new section: <Heading>`, `after: <Heading>` to land inside a mid-file group, or `append` |
| **tags** | Topic tags inferred from content, without `#`. The scribe alphabetizes but never invents |
| **journal_backlink** | If this came out of a journal entry, the `[[YYYY-MM-DD - Adjective Animal#HH:MM - Section]]` to record |

Content sections are flexible — shape them to the material. Technical docs tend toward Implementation / Gotchas /
Benefits; learning notes toward Key Concepts / Use Cases / Gotchas; logs toward dated entries or tables. Not every
note is technical.

### Tag Inference

Infer from technology names (`postgres`, `docker`, `react`), project names (`zylo`, `tcgtoolbox`), topic categories
(`debugging`, `migration`, `maintenance`), and work-vs-personal context.

- `PostgreSQL UUID7 Migration.md` → `#database #migration #postgres #tcgtoolbox`
- `Audi A5 Maintenance Log.md` → `#a5 #audi #car #maintenance #personal`

## Delegating

Spawn `captains-log-notes-scribe` with the fields above.

**One at a time.** It and the journal scribe both write to References sections, so concurrent writes can silently
drop a backlink.

It returns what it wrote plus a `needs_decision` list — unresolvable backlink headings, duplicate coverage it
noticed, structural problems. **Relay those to the user;** the scribe can't prompt, so anything it couldn't decide is
lost unless you surface it.

## Querying Notes

Don't read the notes directory here to answer questions about what's in it. Spawn `captains-log-historian` — it's
read-only and searches notes and journal together, following backlinks in both directions.

## When to Use This Skill

**Use notes skill when:**
- Documenting technical details, solutions, or learnings
- Creating reference material to look up later
- User says "document this" or "save this for later"
- Content is factual without emotional context
- Creating knowledge that transcends a specific moment

**Don't use notes skill when:**
- User is expressing feelings or emotional state (use journal skill)
- Content is primarily about the experience vs the knowledge
- Brief updates that don't need permanent reference

## Relationship with Journal Skill

- **Journal:** the temporal/experiential — when, how it felt, the journey
- **Notes:** the topical/knowledge — what, the solution, the reference

They connect through bidirectional links: journal entries link to notes for detail, notes carry References back to
the journal entries for temporal context. Both can be right for one piece of work — journal the experience, note the
knowledge, link them.

## Legacy Folders

`~/dev/captains-log/personal/` and `~/dev/captains-log/zylo/` hold deprecated reference docs from the old
work-vs-personal split. Not actively used; new content goes in `notes/`.

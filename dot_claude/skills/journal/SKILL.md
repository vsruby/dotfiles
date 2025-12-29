---
name: journal
description: Daily journaling for mood, energy, and experiential tracking
---

# Daily Journal

Captures temporal and experiential content - how you felt, what you experienced, the journey of your work. Each day has one file with time-stamped entries tracking mood, energy, and emotional context.

## Journal Location

```
~/dev/captains-log/journal/
```

## File Naming Convention

Journal files are named with the date and an Ubuntu-style alliterative name:

```
{YYYY-MM-DD} - {Adjective Animal}.md
```

**Examples:**

- `2025-12-05 - Focused Falcon.md`
- `2025-12-05 - Debugging Dolphin.md`
- `2025-12-05 - Tenacious Tiger.md`

The alliterative name should reflect the overall mood, energy, or emotional theme of the day. Pick an adjective that captures the essence of how the day felt and pair it with an animal starting with the same letter.

## Journal Entry Format

Each entry within a journal file follows this structure:

```markdown
## {HH:MM} - {Brief Context}

**Mood:** {emoji + word}
**Energy:** {Low | Medium | High}
**Context:** {Project or area of focus}

{Free-form content about what you're working on, challenges faced, thoughts, decisions made, feelings, etc.}
```

**What to capture:**
- Emotional state and how you're feeling
- Challenges, frustrations, or breakthroughs
- The experience of doing the work
- Decision-making process and why
- Brief progress updates with emotional context

**Mood examples:** `😊 Focused`, `😤 Frustrated`, `🤔 Contemplative`, `⚡ Energized`, `😴 Tired`, `😌 Relieved`, `🎯 Determined`

## Linking to Notes

Journal entries can reference topical knowledge notes using wiki-style links:

```markdown
See [[Docker Compose Version Migration]] for the solution.
```

**When you create a link to a note:**
1. Check if the note exists in `~/dev/captains-log/notes/`
2. If it exists: Update the note's References section with this journal entry
3. If it doesn't exist: Warn the user and ask if they want to create it

**Backlink format to add to notes:**
```markdown
[[{YYYY-MM-DD} - {Adjective Animal}#{HH:MM} - {Section Title}]]
```

Example: `[[2025-12-29 - Debugging Dragon#14:32 - Docker Headache]]`

## TODOs Section

Each daily journal includes a TODOs section for tracking tasks. TODOs are automatically rolled forward from the previous journal entry.

### Format

```markdown
## TODOs

- [ ] Call dentist (2025-12-27)
- [ ] Review PR #123 (2025-12-29)
- [x] Setup Docker docs
- [ ] Research marathon plans
```

### Rolling Forward TODOs

When creating a new journal entry for today:

1. **Find most recent previous journal** - Could be yesterday or earlier if there are gaps in days
2. **Extract uncompleted TODOs** - Only copy TODOs that are unchecked `- [ ]`
3. **Preserve dates** - Keep the original date in parentheses when rolling forward
4. **Add new TODOs without dates** - TODOs added today don't need dates initially
5. **Completed TODOs stay in their day** - Checked TODOs `- [x]` remain in the journal where they were completed

### Dating TODOs

**When rolling forward:** Always include the original date in parentheses:
```markdown
- [ ] Call dentist (2025-12-27)
```

**When adding new TODO today:** No date needed:
```markdown
- [ ] Research marathon plans
```

**When checking off TODO:** No change, just check it:
```markdown
- [x] Research marathon plans
```

### Stale TODO Warnings

When rolling forward TODOs, check dates:

- **5+ days old:** Warn the user: "FYI, 'Call dentist' has been rolling forward since 2025-12-24 (5 days ago). Still relevant?"
- Give user chance to remove or keep stale items

### Adding TODOs During the Day

TODOs can be added:
- **By user:** Manually editing the TODOs section
- **By Claude:** When user mentions tasks during conversation

**When user mentions a task:**
```
User: "Need to call the dentist tomorrow and review that PR"
Claude: Adding to your TODOs...
```

Then update the journal's TODOs section:
```markdown
## TODOs

- [ ] Call dentist
- [ ] Review PR
```

### Placement

TODOs section goes:
1. After the blockquote summary
2. Before the first time-stamped entry
3. Between horizontal rules

## Creating a New Day's Journal

When the user provides a journal entry and no journal exists for today:

1. **Check for existing journal:** Use `Glob` to look for any file starting with `{today's date}` (e.g., `2025-12-29*.md`) in the journal folder. Only match on the date prefix - ignore everything after the date to allow flexibility in naming conventions.
2. **Check previous journal for TODOs:** Find the most recent journal entry (could be yesterday or earlier if there are gaps) and read it to extract uncompleted TODOs
3. **Generate alliterative name:** Based on the mood, energy, or emotional tone of the entry, pick an adjective and pair it with an animal starting with the same letter (e.g., "Frustrated Fox", "Energized Eagle", "Contemplative Cat")
4. **Create the file** with this template:

```markdown
# Journal - {Month Day, Year}

> {Alliterative Name}: {One-line summary capturing the day's emotional theme}

---

## TODOs

- [ ] {Uncompleted TODO from previous day} ({original date})
- [ ] {Another uncompleted TODO} ({original date})

---

## {HH:MM} - {Brief Context}

**Mood:** {inferred from content}
**Energy:** {inferred from content}
**Context:** {project/area}

{User's journal content}

---

_Tags:_ #daily #journal
```

**Tag Ordering:** Always alphabetize tags at the end of entries. When adding new tags, insert them in alphabetical order with the existing tags.

## Appending to Existing Journal

When a journal already exists for today:

1. **Read the existing file** to understand context and flow
2. **Add a new time-stamped entry** before the closing `---` and tags section
3. **Consider updating the summary** in the blockquote if the day's emotional theme has evolved significantly
4. **Preserve** all existing entries exactly as written
5. **Alphabetize tags** - When adding new tags or updating the tags line, ensure all tags are in alphabetical order
6. **Update note backlinks** - If the new entry contains `[[Note]]` links, update those notes' References sections

**Append format:**

```markdown
## {HH:MM} - {Brief Context}

**Mood:** {inferred}
**Energy:** {inferred}
**Context:** {project/area}

{User's new journal content}
```

## Inferring Entry Details

When the user provides raw journal input, intelligently infer:

| Field | How to Infer |
| ----- | ------------ |
| **Time** | Use current time if not specified |
| **Mood** | Extract from tone, explicit mentions, or emotional context |
| **Energy** | Infer from language ("exhausted" = Low, "crushing it" = High) |
| **Context** | Identify project names, task types, or life areas mentioned |
| **Alliterative Name** | Pick an adjective matching mood/energy/emotional tone + animal with same first letter |

Be generous in interpretation - the user may write casually. Look for:

- Explicit feelings: "feeling frustrated", "pretty happy", "drained"
- Implicit tone: exclamation marks, defeated language, excitement
- Energy indicators: "tired", "wired", "dragging", "on fire"

### Alliterative Name Examples

Pick creative adjective-animal pairs that match the day's emotional vibe:

**Energized/Productive:** Determined Dragon, Focused Falcon, Productive Panda, Energized Eagle, Motivated Mongoose

**Frustrated/Challenging:** Frustrated Fox, Debugging Dolphin, Troublesome Tiger, Perplexed Penguin, Bewildered Bear

**Calm/Reflective:** Contemplative Cat, Relaxed Rabbit, Serene Swan, Thoughtful Turtle, Mellow Moose

**Tired/Drained:** Weary Wolf, Exhausted Elephant, Sleepy Sloth, Drained Duck, Tired Tortoise

**Happy/Relieved:** Joyful Jaguar, Happy Heron, Relieved Raccoon, Content Cougar, Cheerful Cheetah

**Creative/Innovative:** Creative Crow, Inventive Iguana, Brilliant Butterfly, Ambitious Antelope, Visionary Vulture

## Querying Journal History

To help the user find patterns over time:

| Query Type | Approach |
| ---------- | -------- |
| Find by mood | `Grep` for mood patterns like `😤` or `Frustrated` |
| Find by project | `Grep` for `**Context:**` lines containing the project |
| Find by topic | `Grep` for keywords or phrases |
| List recent entries | `Glob` for `journal/*.md` sorted by date |
| Weekly summary | Read last 7 days of journals and synthesize |
| Energy patterns | `Grep` for `**Energy:**` and analyze distribution |

## Example Workflow

**User says:** "Just spent 3 hours debugging a weird race condition in the webhook handler. Finally found it - was a closure issue. Feeling relieved but mentally drained."

**Claude creates** (if first entry of the day):

File: `journal/2025-12-05 - Relieved Raccoon.md`

```markdown
# Journal - December 5, 2025

> Relieved Raccoon: Deep debugging session tracking down a race condition in webhook processing

---

## TODOs

- [ ] Review webhook test coverage (2025-12-04)
- [ ] Document race condition fix

---

## 14:32 - Debugging Victory

**Mood:** 😌 Relieved
**Energy:** Low
**Context:** Webhook Handler / Zylo

Just spent 3 hours debugging a weird race condition in the webhook handler. Finally found it - was a closure issue. Feeling relieved but mentally drained.

---

_Tags:_ #daily #journal #zylo
```

Note: The first TODO was rolled forward from 2025-12-04 (previous day), the second was added based on content.

## When to Use This Skill

**Use journal skill when:**
- User expresses feelings, mood, or emotional state
- Capturing the experience or journey of work
- Brief updates with emotional context
- Tracking energy levels throughout the day
- Reflecting on challenges or breakthroughs

**Don't use journal skill when:**
- User wants to document technical details without emotional context
- Creating reference material (use notes skill instead)
- Purely factual documentation

## Legacy Folders

The `personal/` and `zylo/` folders contain old reference documentation. These are no longer actively used. Reference content now goes in the `notes/` folder (managed by notes skill).

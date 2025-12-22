---
name: journal
description: Daily journaling for work, challenges, mood, and productivity insights
---

# Daily Journal

A personal and professional journal for capturing work, challenges, mood, and insights over time. Designed to help identify patterns and make informed adjustments to your professional and personal life.

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

The alliterative name should reflect the mood, energy, or theme of the day. Pick an adjective that captures the essence of the entry (based on mood, energy, or tone) and pair it with an animal starting with the same letter.

## Journal Entry Format

Each entry within a journal note follows this structure:

```markdown
## {HH:MM} - {Brief Context}

**Mood:** {emoji + word}
**Energy:** {Low | Medium | High}
**Context:** {Project or area of focus}

{Free-form content about what you're working on, challenges faced, thoughts, decisions made, etc.}
```

**Mood examples:** `😊 Focused`, `😤 Frustrated`, `🤔 Contemplative`, `⚡ Energized`, `😴 Tired`, `😌 Relieved`, `🎯 Determined`

## Creating a New Day's Journal

When the user provides a journal entry and no journal exists for today:

1. **Check for existing journal:** Use `Glob` to look for any file starting with `{today's date}` (e.g., `2025-12-19*.md`) in the journal folder. Only match on the date prefix - ignore everything after the date to allow flexibility in naming conventions.
2. **Generate alliterative name:** Based on the mood, energy, or tone of the entry, pick an adjective and pair it with an animal starting with the same letter (e.g., "Frustrated Fox", "Energized Eagle", "Contemplative Cat")
3. **Create the file** with this template:

```markdown
# Journal - {Month Day, Year}

> {Alliterative Name}: {One-line summary capturing the day's overall theme}

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
2. **Add a new entry** before the closing `---` and tags section
3. **Consider updating the summary** in the blockquote if the day's theme has evolved significantly
4. **Preserve** all existing entries exactly as written
5. **Alphabetize tags** - When adding new tags or updating the tags line, ensure all tags are in alphabetical order

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

| Field                | How to Infer                                                               |
| -------------------- | -------------------------------------------------------------------------- |
| **Time**             | Use current time if not specified                                          |
| **Mood**             | Extract from tone, explicit mentions, or emotional context                 |
| **Energy**           | Infer from language ("exhausted" = Low, "crushing it" = High)              |
| **Context**          | Identify project names, task types, or life areas mentioned                |
| **Alliterative Name** | Pick an adjective matching mood/energy/tone + animal with same first letter |

Be generous in interpretation - the user may write casually. Look for:

- Explicit feelings: "feeling frustrated", "pretty happy"
- Implicit tone: exclamation marks, defeated language, excitement
- Energy indicators: "tired", "wired", "dragging", "on fire"

### Alliterative Name Examples

Pick creative adjective-animal pairs that match the day's vibe:

**Energized/Productive:** Determined Dragon, Focused Falcon, Productive Panda, Energized Eagle, Motivated Mongoose

**Frustrated/Challenging:** Frustrated Fox, Debugging Dolphin, Troublesome Tiger, Perplexed Penguin, Bewildered Bear

**Calm/Reflective:** Contemplative Cat, Relaxed Rabbit, Serene Swan, Thoughtful Turtle, Mellow Moose

**Tired/Drained:** Weary Wolf, Exhausted Elephant, Sleepy Sloth, Drained Duck, Tired Tortoise

**Happy/Relieved:** Joyful Jaguar, Happy Heron, Relieved Raccoon, Content Cougar, Cheerful Cheetah

**Creative/Innovative:** Creative Crow, Inventive Iguana, Brilliant Butterfly, Ambitious Antelope, Visionary Vulture

## Querying Journal History

To help the user find patterns over time:

| Query Type          | Approach                                               |
| ------------------- | ------------------------------------------------------ |
| Find by mood        | `Grep` for mood patterns like `😤` or `Frustrated`     |
| Find by project     | `Grep` for `**Context:**` lines containing the project |
| List recent entries | `Glob` for `journal/*.md` sorted by date               |
| Weekly summary      | Read last 7 days of journals and synthesize            |
| Energy patterns     | `Grep` for `**Energy:**` and analyze distribution      |

## Example Workflow

**User says:** "Just spent 3 hours debugging a weird race condition in the webhook handler. Finally found it - was a closure issue. Feeling relieved but mentally drained."

**Claude creates** (if first entry of the day):

File: `journal/2025-12-05 - Relieved Raccoon.md`

```markdown
# Journal - December 5, 2025

> Relieved Raccoon: Deep debugging session tracking down a race condition in webhook processing

---

## 14:32 - Debugging Victory

**Mood:** 😌 Relieved
**Energy:** Low
**Context:** Webhook Handler / Zylo

Just spent 3 hours debugging a weird race condition in the webhook handler. Finally found it - was a closure issue. Feeling relieved but mentally drained.

---

_Tags:_ #daily #journal
```

## Future Capabilities

As the journal grows, consider:

- Weekly review summaries
- Mood/energy trend analysis
- Project time distribution
- Challenge pattern recognition
- Productivity correlation insights

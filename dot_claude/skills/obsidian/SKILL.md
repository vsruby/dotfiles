---
name: obsidian
description: Read and write notes to Obsidian vault via direct file access
---

# Obsidian Integration

Interact with the user's Obsidian vault using direct file system access.

## Vault Location

```
~/dev/captains-log
```

## Projects

**IMPORTANT: All categories follow one-file-per-day pattern.**
- Check if a file exists for today's date using `Glob` with pattern `{YYYY-MM-DD}*.md`
- If file exists: append new section/content
- If no file exists: create new file with appropriate template

### Zylo

Work notes for Zylo (Integration Forge, Nexus, etc.)

| Aspect   | Convention                                                  |
| -------- | ----------------------------------------------------------- |
| Folder   | `zylo/`                                                     |
| Plans    | `zylo/plans/`                                               |
| Filename | `{YYYY-MM-DD} - {Adjective Animal}.md`                      |
| Pattern  | **One file per day** - append new sections throughout day  |
| Tags     | `#zylo`, plus `#plan` for plans                             |
| Style    | Polished technical documentation with blockquote summary    |

**Alliterative naming:** Choose an adjective-animal pair that reflects the topic, theme, or nature of the note (e.g., "Strategic Salmon" for planning, "Technical Tiger" for implementation, "Debugging Dragon" for troubleshooting).

**Creating new file (no existing file for today):**

```markdown
# {Title}

> {Summary or description}

## {Section Name}

{Content}

---

_Tags:_ #zylo
```

**Appending to existing file (file exists for today):**
1. Read the existing file
2. Add new section before the closing `---` and tags
3. Update tags if needed (add new relevant tags, maintaining alphabetical order)
4. Preserve all existing content

**Tag Ordering:** Always alphabetize all tags. When adding new tags, insert them in alphabetical order with the existing tags.

### Personal

Personal notes (car maintenance, errands, etc.)

| Aspect   | Convention                                                 |
| -------- | ---------------------------------------------------------- |
| Folder   | `personal/`                                                |
| Filename | `{YYYY-MM-DD} - {Adjective Animal}.md`                     |
| Pattern  | **One file per day** - append new sections throughout day |
| Tags     | `#personal`                                                |
| Style    | Reference documents and activities                         |

**Alliterative naming:** Choose an adjective-animal pair that reflects the topic or activity (e.g., "Mechanical Moose" for car maintenance, "Errand Eagle" for tasks, "Financial Fox" for budget planning).

**Car maintenance notes:** Always include tags for `#car`, `#maintenance`, plus make and model as separate tags (e.g., `#audi #a5`, `#toyota #camry`).

**Creating new file (no existing file for today):**

```markdown
# {Title}

> {Summary or description}

## {Section Name}

{Content}

---

_Tags:_ #personal
```

**Appending to existing file (file exists for today):**
1. Read the existing file
2. Add new section before the closing `---` and tags
3. Update tags if needed (add new relevant tags, maintaining alphabetical order)
4. Preserve all existing content

**Tag Ordering:** Always alphabetize all tags. When adding new tags, insert them in alphabetical order with the existing tags. For car maintenance notes, alphabetize all tags including `#car`, `#maintenance`, make, and model tags.

### Journal

**IMPORTANT: Only journal entries go in this folder. Never put regular notes here.**

| Aspect   | Convention                                                          |
| -------- | ------------------------------------------------------------------- |
| Folder   | `journal/`                                                          |
| Filename | `{YYYY-MM-DD} - {Alliterative Name}.md` (e.g., "Focused Falcon")   |
| Pattern  | **One file per day** - append new entries throughout day           |
| Tags     | `#daily #journal` (alphabetized)                                    |
| Style    | Time-stamped entries throughout the day                             |
| Content  | Mood, energy, status updates, reflections - NOT reference documents |

## General Conventions

- **Date format**: `YYYY-MM-DD`
- **Alliterative naming**: All notes use the format `{YYYY-MM-DD} - {Adjective Animal}.md` where the adjective-animal pair reflects the note's theme, mood, or topic
- **Checking for existing notes**: When checking if a note exists for a specific date, use `Glob` to match on the date prefix only (e.g., `2025-12-19*.md`). Ignore everything after the date to allow flexibility in naming conventions.
- **Links**: Use `[[wiki-style]]` links for cross-references
- Obsidian auto-syncs when files change on disk

### Alliterative Name Selection Guide

Choose creative adjective-animal pairs that match the note's purpose or theme:

**Work/Technical:** Architectural Albatross, Debugging Dragon, Implementation Iguana, Strategic Salmon, Technical Tiger, Planning Panther, Refactoring Raven

**Problem-Solving:** Analytical Anteater, Troubleshooting Toucan, Investigating Ibex, Problem-solving Puma, Resolving Rhino

**Learning/Research:** Curious Cat, Learning Lemur, Researching Rabbit, Exploring Eagle, Studious Squirrel

**Maintenance/Admin:** Mechanical Moose, Organizing Otter, Administrative Armadillo, Systematic Seal, Updating Unicorn

**Creative/Design:** Creative Crow, Designing Dolphin, Innovative Iguana, Visionary Vulture, Brilliant Butterfly

**Personal/Errands:** Errand Eagle, Shopping Shark, Planning Penguin, Financial Fox, Productive Pelican

## Operations

Use standard Claude Code tools:

| Task           | Tool                  |
| -------------- | --------------------- |
| Read a note    | `Read`                |
| Create a note  | `Write`               |
| Edit a note    | `Edit`                |
| Find notes     | `Glob` with `**/*.md` |
| Search content | `Grep`                |

---
name: journal
description: Daily journaling for experiential tracking
---

# Daily Journal

Captures temporal and experiential content - how you felt, what you experienced, the journey of your work. Each day has one file with time-stamped entries capturing emotional context.

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

- `2025-12-05 - Nebulous Narwhal.md`
- `2025-12-06 - Quixotic Quail.md`
- `2025-12-07 - Urbane Uakari.md`

The alliterative name uses **letter-balanced random selection** to ensure variety across the alphabet over time. The adjective and animal are chosen for diversity, not to reflect the day's content.

## Journal Entry Format

Each entry within a journal file follows this structure:

```markdown
## {HH:MM} - {Brief Context}

**Context:** {Project or area of focus}

{Free-form content about what you're working on, challenges faced, thoughts, decisions made, feelings, etc.}
```

**What to capture:**
- Emotional state and how you're feeling (in the prose, not as a structured field)
- Challenges, frustrations, or breakthroughs
- The experience of doing the work
- Decision-making process and why
- Brief progress updates with emotional context

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

1. **Find most recent previous journal** - Could be yesterday or earlier if there are gaps in days. Call this N-1.
2. **Also read the journal before that** - Call this N-2. Used for the drop-detection check below.
3. **Extract uncompleted TODOs from N-1** - Only copy TODOs that are unchecked `- [ ]`
4. **Detect silent drops** - Compare N-2's unchecked TODOs against N-1's list. If any unchecked TODO appears in N-2 but is missing from N-1 (i.e. it was dropped without being checked off), surface it to the user before completing the roll forward. Ask whether to include it in today's list or leave it dropped. Reason: a single day where the roll-forward is trimmed (e.g. a personal/context-switch day where the prose doesn't mention the work TODOs) otherwise drops those items silently for every downstream day, with no audit trail.
5. **Preserve dates** - Keep the original date in parentheses when rolling forward
6. **Add new TODOs without dates** - TODOs added today don't need dates initially
7. **Completed TODOs stay in their day** - Checked TODOs `- [x]` remain in the journal where they were completed

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

### TODO Ordering

Within the TODOs section, order items by **date added, oldest on top**:

1. **Dated TODOs first**, sorted ascending by the date in parentheses (oldest at the top, newest dated item just above the undated ones).
2. **Undated TODOs (added today) at the bottom**, in the order they were added during the day.

When checking off a TODO, leave it in place rather than reshuffling. When a new TODO is added during the day, append it to the bottom of the undated block.

**Example:**
```markdown
## TODOs

- [ ] Decide on price dedup strategy (2026-03-03)
- [ ] Configure Clerk session token (2026-03-19)
- [ ] Add UUID-format check at top of handleApiKey (2026-04-29)
- [ ] PURPLE-332 follow-up: fix refresh audit-field call (2026-05-29)
- [ ] Address Bryson's three remaining PR #10699 comments in PR #10693
- [ ] Pick up groceries
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
3. **Generate alliterative name:** Use letter-balanced selection (see "Alliterative Name Generation" section below) to pick a random adjective and animal pair that promotes alphabet diversity
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

**Context:** {project/area}

{User's new journal content}
```

## Inferring Entry Details

When the user provides raw journal input, intelligently infer:

| Field | How to Infer |
| ----- | ------------ |
| **Time** | Use current time if not specified. **IMPORTANT:** Check actual system time using `date +"%H:%M"` via Bash tool - never estimate or guess the time |
| **Context** | Identify project names, task types, or life areas mentioned |
| **Alliterative Name** | Use letter-balanced selection to pick a random adjective + animal (see "Alliterative Name Generation" section) |

Be generous in interpretation - the user may write casually. Look for:

- Explicit feelings: "feeling frustrated", "pretty happy", "drained"
- Implicit tone: exclamation marks, defeated language, excitement

### Alliterative Name Generation

Generate alliterative names using **letter-balanced random selection** for maximum variety and alphabet distribution.

**Process:**

1. **Analyze letter usage:** Use `Glob` to list all existing journal files in `~/dev/captains-log/journal/`
2. **Count letter frequency:** Tally which letters have been used in the alliterative names (the adjective/animal letter)
3. **Pick underused letter:** Select a letter that hasn't been used yet, or choose from the least-used letters
4. **If perfectly balanced:** When all letters are roughly equal and there's no clear choice, ask the user which letter they'd like to use that day
5. **Generate name:** Pick a truly random adjective (sometimes obscure) + diverse animal, both starting with the chosen letter

**Goals:**

- **Balance across alphabet:** Over time, all 26 letters should have roughly equal representation
- **Random adjectives:** Don't tie adjectives to content - use truly random, varied, sometimes obscure adjectives
- **Wide animal variety:** Use diverse animals beyond common choices (include marsupials, birds, fish, insects, mythical creatures, etc.)
- **No content correlation:** The name is purely for variety and alphabet balance, not a reflection of the day's content

**Example Selection Process:**

```
Letters used least: Q (0 times), X (1 time), U (2 times)
Choose: Q
Adjective: Quixotic, Querulous, Quotidian, Quintessential
Animal: Quail, Quokka, Quelea, Quetzal
Result: "Quixotic Quail"
```

**Animal Variety Examples:**

Use a wide range: Aardvark, Basilisk, Capybara, Dugong, Echidna, Frigatebird, Gecko, Heron, Ibex, Jackal, Kiwi, Lemur, Mantis, Narwhal, Okapi, Puffin, Quoll, Raven, Stoat, Tapir, Uakari, Vole, Wombat, Xenops, Yak, Zebu

**Obscure Adjective Examples:**

Abstemious, Beguiling, Capricious, Diaphanous, Ephemeral, Furtive, Garrulous, Halcyon, Ineffable, Jocund, Laconic, Mercurial, Nefarious, Obstinate, Pernicious, Quixotic, Redolent, Sanguine, Tenebrous, Ubiquitous, Verdant, Whimsical, Xenial, Zealous

## Querying Journal History

To help the user find patterns over time:

| Query Type | Approach |
| ---------- | -------- |
| Find by project | `Grep` for `**Context:**` lines containing the project |
| Find by topic | `Grep` for keywords or phrases |
| List recent entries | `Glob` for `journal/*.md` sorted by date |
| Weekly summary | Read last 7 days of journals and synthesize |

## Example Workflow

**User says:** "Just spent 3 hours debugging a weird race condition in the webhook handler. Finally found it - was a closure issue. Feeling relieved but mentally drained."

**Claude checks:** Letter usage shows Q and X are underused. Picks Q for variety.

**Claude creates** (if first entry of the day):

File: `journal/2025-12-05 - Querulous Quokka.md`

```markdown
# Journal - December 5, 2025

> Querulous Quokka: Deep debugging session tracking down a race condition in webhook processing

---

## TODOs

- [ ] Review webhook test coverage (2025-12-04)
- [ ] Document race condition fix

---

## 14:32 - Debugging Victory

**Context:** Webhook Handler / Zylo

Just spent 3 hours debugging a weird race condition in the webhook handler. Finally found it - was a closure issue. Feeling relieved but mentally drained.

---

_Tags:_ #daily #journal #zylo
```

Note: The first TODO was rolled forward from 2025-12-04 (previous day), the second was added based on content.

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

## Legacy Folders

The `personal/` and `zylo/` folders contain old reference documentation. These are no longer actively used. Reference content now goes in the `notes/` folder (managed by notes skill).

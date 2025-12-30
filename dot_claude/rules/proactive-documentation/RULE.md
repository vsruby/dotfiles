# Proactive Documentation with Journal and Notes

**Be proactive about documenting work using journal and notes skills. Don't wait to be asked.**

## When to Use Journal Skill

Use the **journal** skill to capture temporal and experiential aspects of work:

**After completing work:**
- Significant feature implementations or enhancements
- Bug fixes (especially complex ones)
- Architecture decisions or refactoring
- Infrastructure changes or migrations
- Problem-solving sessions

**During active work:**
- Debugging sessions (capture the journey, not just the solution)
- Performance optimization attempts
- When hitting roadblocks or breakthroughs
- When making important technical decisions

**For emotional/experiential context:**
- Frustration, relief, confusion, clarity
- Energy levels (tired, energized, drained)
- The experience of doing the work
- Decision-making process and trade-offs considered

**What to capture in journal entries:**
- How you felt about the work
- The journey and challenges faced
- Why certain decisions were made
- Brief progress updates with emotional context
- The experience of problem-solving

## When to Use Notes Skill

Use the **notes** skill to capture time-invariant knowledge and reference material:

**For technical documentation:**
- Solutions to problems that may recur
- Implementation patterns discovered
- Architecture decisions and their rationale
- Migration guides or setup procedures
- Integration documentation

**For reference material:**
- Technical details without emotional context
- Reusable patterns and approaches
- System knowledge that should be preserved
- Learning moments that transcend a specific day
- Maintenance logs (car, house, etc.)

**What to capture in notes:**
- What the solution is (not how you felt finding it)
- Technical details and implementation steps
- Gotchas and things to watch out for
- Benefits and trade-offs
- Reference information to look up later

## Journal vs Notes Decision Tree

Ask yourself: "Is this about the **experience** or the **knowledge**?"

| Indicator | Use Journal | Use Notes |
| --------- | ----------- | --------- |
| Emotional content | ✓ | |
| "I felt frustrated/relieved" | ✓ | |
| "Here's how to solve X" | | ✓ |
| Time-specific experience | ✓ | |
| Timeless reference | | ✓ |
| The journey | ✓ | |
| The destination | | ✓ |

**Both can work together:** Journal the experience of debugging, link to a note with the technical solution.

## Timing: When to Create Entries

**Don't wait for explicit requests.** Create entries:

- **Immediately after completing meaningful work** - While context is fresh
- **After solving complex problems** - Capture both journey (journal) and solution (note)
- **When making important decisions** - Document the why
- **At natural transition points** - Switching tasks, end of focused work session
- **When discovering patterns or insights** - Preserve the knowledge

## Linking Between Journal and Notes

**From Journal to Notes:**
```markdown
Spent 3 hours debugging the race condition. See [[Webhook Race Condition Fix]] for details.
```

**From Notes to Journal (automatic backlinks in References section):**
```markdown
## References

- [[2025-12-29 - Debugging Dragon#14:32 - Webhook Debugging]]
```

This creates bidirectional links: temporal experience → knowledge reference → back to when it happened.

## Context and Tags

**Context field in journal entries:**
- Use project names when relevant (e.g., "ZAPI / Query API", "TCGToolbox / Database")
- Use life areas for personal entries (e.g., "Home / Car Maintenance", "Personal / Marathon Training")
- Keep it hierarchical: `{Project} / {Component}` or `{Area} / {Specific}`

**Tags:**
- Always alphabetize (per coding rules)
- Infer from content - technologies, projects, topics
- Journal tags: Include project tags like `#zylo` or `#tcgtoolbox` when relevant
- Note tags: Technology, topic, and project-specific tags

**Examples:**
- Journal: `#debugging #journal #zylo`
- Note: `#docker #docker-compose #migration`

## What "Proactive" Means

**Do this automatically:**
- When work is completed, create a journal entry capturing the experience
- If there's technical knowledge to preserve, create or update a note
- Link between journal and notes when both exist
- Infer mood, energy, context from the user's language
- Don't ask "Should I create a journal entry?" - just do it

**Still ask when:**
- Uncertain whether to create new note vs update existing
- Multiple existing notes could be relevant
- User's intent is genuinely unclear

## Examples

**Scenario 1: Debugging session**
```
User: "Finally fixed that race condition in the webhook handler. Was a closure issue."

Claude: Creating journal entry... [Creates entry with mood: Relieved, energy: Low]
Claude: Also documenting the solution... [Creates/updates note about webhook race condition]
```

**Scenario 2: Implementation work**
```
User: "Just finished implementing the new query builder API. Took a different approach than we discussed."

Claude: Journaling that... [Creates entry capturing the experience and decision]
Claude: Should I create a note documenting the API design, or is the code self-documenting?
```

**Scenario 3: Personal context**
```
User: "Changed the oil in the Audi today. 5W-40 synthetic, 45k miles."

Claude: Adding to maintenance log... [Updates "Audi A5 Maintenance Log" note]
```

## Remember

- **Be proactive** - Don't wait to be asked
- **Journal the experience** - Capture feelings, journey, energy
- **Note the knowledge** - Preserve technical details and reference material
- **Link bidirectionally** - Connect temporal experience with timeless knowledge
- **Infer intelligently** - Extract mood, energy, context from user's language
- **Alphabetize tags** - Always maintain alphabetical order

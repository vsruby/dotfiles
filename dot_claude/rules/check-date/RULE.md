# Always Check the Current Date

A `UserPromptSubmit` hook (`~/.claude/hooks/inject-date.sh`) injects a
`Current date:` line into context on every prompt. Treat that as the current
moment — it is fresh as of this prompt.

Two things the hook does not cover:

- **Minute precision on long turns.** The injected value is fixed at prompt
  submission, so re-run `date` for anything time-of-day specific (journal entry
  headers, `%H:%M` timestamps) if the turn has been running a while.
- **Competing sources.** Ignore `currentDate` from the system context and any
  date mentioned earlier in the conversation. Both are point-in-time snapshots
  that go stale across resumes, day-rollovers, and compactions; the hook line
  wins.

Applies to anything that bakes in a date: dated filenames, frontmatter, journal
headers, TODO timestamps (`[vruby YYYY-MM-DD]`), commit message bodies,
scheduled tasks.

---

_Last updated: 2026-08-31_

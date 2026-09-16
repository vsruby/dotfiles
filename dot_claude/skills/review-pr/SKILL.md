---
name: review-pr
description: Collaborative PR review — identifies issues, checks previous comments, traces ripple effects, and walks through findings one at a time
---

# PR Review

Review a coworker's pull request collaboratively. This is NOT the user's code — the user is a reviewer, not the author.

## Phase 0: Orient

1. **Infer the PR** from the current branch:
   ```
   gh pr view --json number,title,body,url,headRefName,baseRefName,author
   ```
2. **Pull existing review comments** (from the user, other reviewers, and the author):
   ```
   gh pr view --json comments,reviews,reviewRequests
   gh api repos/{owner}/{repo}/pulls/{number}/comments
   gh api repos/{owner}/{repo}/pulls/{number}/reviews
   ```
3. **Read the PR description** to understand the intent — what is this PR trying to accomplish?
4. **Get the diff**:
   ```
   gh pr diff
   ```
5. Present a brief summary: PR title, author, what it's trying to do, and how many existing comments there are. Ask the user if they have any additional context before proceeding.

## Phase 1a: Check Existing Review Comments

For each unresolved OR resolved review comment from any reviewer:

1. Read the comment and understand what was requested
2. Read the current state of the code at that location
3. Determine if the comment was **actually addressed** in the code, or just resolved/dismissed without action

Present findings as a separate section:

```
## Previously Raised Comments

✅ @reviewer — file.ts:42 — "Extract this into a helper" → Addressed: extracted to `formatResponse()` on line 15
⚠️ @reviewer — file.ts:78 — "This will break if payload is null" → Resolved but NOT addressed: no null check added
```

Only surface comments that were **not addressed**. Mention addressed ones briefly for completeness but don't dwell on them.

## Phase 1b: New Findings

Read the changed files **in full** (not just the diff) to understand context. Then:

1. **Trace call sites and usages** — for any changed function signatures, types, exports, or behavior, find where they're consumed. Flag ripple effects.
2. **Check for bugs, logic errors, race conditions, edge cases** — this is the highest priority.
3. **Check for test coverage gaps** — flag new logic that lacks test coverage. Note: the user may choose to skip these based on timeliness or effort.
4. **Apply the user's coding rules** (from `~/.claude/rules/typescript/RULE.md` and `~/.claude/rules/javascript/RULE.md`) as lighter-weight suggestions:
   - Import ordering, property alphabetization, naming conventions
   - Destructuring, async patterns, error handling
   - These are real but lower severity than bugs — present them with that framing
5. **Architecture and design concerns** — unclear abstractions, coupling, naming that obscures intent

Present as a numbered list:

```
## New Findings

1. **[Bug]** `userService.ts:45` — `fetchUser` doesn't handle the case where...
2. **[Ripple]** `types.ts:12` — The `Status` type changed but `dashboard.tsx:89` still uses the old shape...
3. **[Tests]** `orderProcessor.ts` — New `calculateDiscount` logic has no test coverage
4. **[Style]** `apiClient.ts:23` — Named imports not alphabetized (per your coding rules)
5. **[Design]** `middleware.ts:67` — This retry logic duplicates what's already in `httpClient.ts`...
```

Severity tags: `[Bug]`, `[Ripple]`, `[Tests]`, `[Design]`, `[Style]`

Order findings by severity (bugs first, style last).

## Phase 2: Walk Through Together

After presenting the findings, walk through them **one at a time** with the user. This is a collaborative discussion, not a report dump.

Start with finding #1 and proceed sequentially. The user can also jump to a specific number (e.g., "let's look at #4").

**For each finding:**

1. **Re-read the relevant code first.** Do not rely on what was read in Phase 1. Actually open the file(s) again and re-examine the code with fresh eyes. Look at more surrounding context, related files, and tests. This deeper second look may strengthen, weaken, or change the finding entirely.
2. **Present the refined observation** — provide enough context and reasoning that the user could write a clear, constructive PR comment from it.
3. **Discuss.** The user may agree, disagree, want more context, or want to think through it together. This is a conversation.
4. **Wait for the user's call:**
   - **"made it"** (or similar) — the user posted the comment, move to the next finding
   - **"skip"** — not worth raising, move on
   - The user may also decide after discussion that the finding isn't actually an issue — that's fine, move on

After resolving a finding, prompt for the next one: "Ready for #N?"

Continue until all findings are addressed or the user ends the review.

## Important Behavior

- **This is not the user's code.** Be thorough but fair. The goal is a constructive review.
- **Re-read before each Phase 2 item.** Don't go stale. The code is right there — look at it again.
- **Don't over-flag style issues.** A few meaningful style suggestions are fine. A wall of alphabetization nitpicks is not helpful.
- **Trace the blast radius.** A change that looks fine in one file might break consumers. Always check.
- **Be honest about confidence.** If something looks suspicious but you're not sure, say so. Don't present uncertain findings as definitive.
- **Use the Agent tool** to parallelize reading changed files and tracing call sites when there are many files involved.

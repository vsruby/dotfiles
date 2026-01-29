# File Organization - Alphabetical Ordering

## General Principle

**Prefer alphabetical ordering** in configuration files, data files, and documentation when the order has no semantic meaning.

## File Types

### JSON and JSONC

**Alphabetize object keys** at all levels unless order has semantic meaning.

**IMPORTANT:** Sort by the **key name itself**, not the raw line text. Ignore quotes, whitespace, and punctuation when determining order.

**Good:**
```json
{
  "dependencies": {
    "express": "^4.18.0",
    "react": "^18.2.0",
    "vite": "^5.0.0",
    "vite-tsconfig-paths": "^2.0.0"
  },
  "name": "my-project",
  "scripts": {
    "build": "tsc",
    "dev": "nodemon",
    "test": "vitest"
  },
  "version": "1.0.0"
}
```

**Bad (incorrect line-based sorting):**
```json
{
  "dependencies": {
    "vite-tsconfig-paths": "^2.0.0",
    "vite": "^5.0.0"
  }
}
```
☝️ This is wrong because a naive line sort compares `"vite-tsconfig-paths"` vs `"vite"` including the quotes, and `-` comes before `"` in ASCII. We want to compare the actual key names: `vite` vs `vite-tsconfig-paths`.

**Bad (random order):**
```json
{
  "name": "my-project",
  "version": "1.0.0",
  "scripts": {
    "test": "vitest",
    "dev": "nodemon",
    "build": "tsc"
  },
  "dependencies": {
    "typescript": "^5.0.0",
    "react": "^18.2.0",
    "express": "^4.18.0"
  }
}
```

### YAML/YML

**Alphabetize keys** at all levels unless order has semantic meaning.

**Good:**
```yaml
database:
  host: localhost
  password: secret
  port: 5432
  username: admin
server:
  cors: true
  port: 3000
  timeout: 30000
```

**Bad:**
```yaml
server:
  port: 3000
  timeout: 30000
  cors: true
database:
  host: localhost
  port: 5432
  username: admin
  password: secret
```

### Markdown

**Alphabetize sections** when they are reference material, lists, or documentation without narrative flow.

**When to alphabetize:**
- Reference sections (glossaries, API endpoints, command lists)
- Lists of items with equal importance
- Configuration documentation
- Index or table of contents (when not following document order)

**When NOT to alphabetize:**
- Tutorials or guides with sequential steps
- Narrative documentation (introduction → getting started → advanced topics)
- Chronological content (changelogs, release notes)
- Deliberately ordered content (priority lists, workflows)

**Good (reference material):**
```markdown
## API Endpoints

### POST /users
Creates a new user.

### GET /users
Lists all users.

### GET /users/:id
Gets a specific user.
```

**Good (narrative flow - NOT alphabetized):**
```markdown
## Getting Started

1. Install dependencies
2. Configure your environment
3. Run the development server
4. Build for production
```

## Exceptions

**Do NOT alphabetize when:**

1. **Order has semantic meaning:**
   - Prioritized lists (high → medium → low)
   - Sequential steps or workflows
   - Chronological ordering (newest first, oldest first)
   - Dependency chains (must load X before Y)

2. **Arrays with meaningful order:**
   ```json
   {
     "middleware": [
       "authentication",  // Must run first
       "authorization",   // Must run second
       "errorHandler"     // Must run last
     ]
   }
   ```

3. **Configuration precedence:**
   ```yaml
   # Later entries override earlier ones - order matters
   extends:
     - base-config
     - environment-config
     - local-overrides
   ```

4. **Narrative or instructional content:**
   - README files with natural flow
   - Tutorial documentation
   - Step-by-step guides

5. **Convention or standard order:**
   - `package.json` fields following npm conventions
   - `tsconfig.json` following TypeScript conventions
   - Project-specific conventions

## General Guidelines

- **Default to alphabetical** unless you have a reason not to
- **Be consistent** within a file and across similar files
- **Document exceptions** when order matters (add a comment explaining why)
- **Nested structures** - alphabetize at every level

## Working with Existing Files

When modifying files that you didn't create:

- **If the file is already alphabetized:** Maintain alphabetical order for new additions
- **If the file is NOT alphabetized:** Use your best judgment for placement
  - Try to follow existing patterns or groupings
  - Place new entries where they make most sense contextually
  - **Don't alphabetize the entire file just to add one entry** - this creates large, hard-to-review diffs
  - Keep changes minimal and focused unless explicitly asked to reorder the entire file
  - If you can't decide on the best placement, ask the user

---

_Last updated: 2026-01-29_

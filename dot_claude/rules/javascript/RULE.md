# JavaScript Coding Rules

## Import Statements

### Named Import Ordering

When importing multiple named exports from the same source, **always alphabetize them**.

**Good:**
```javascript
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { readFile, writeFile } from 'fs/promises';
```

**Bad:**
```javascript
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { writeFile, readFile } from 'fs/promises';
```

## File Organization

### Class Organization

When writing classes, organize members in a specific order:

1. **Constants** (static constants) - at the top
2. **Properties** - grouped by visibility (public → protected → private), alphabetically sorted within each group
3. **Constructor**
4. **Instance methods** - grouped by visibility (public → protected → private), alphabetically sorted within each group
5. **Static methods** - at the bottom, grouped by visibility (public → protected → private), alphabetically sorted within each group

This structure makes the public API immediately visible and maintains consistent organization.

**Good:**
```javascript
class UserService {
  // Constants
  static DEFAULT_TIMEOUT = 5000;
  static MAX_RETRIES = 3;

  // Properties (public)
  cache = new Map();
  users = [];

  // Properties (private - using # or naming convention)
  #apiKey;
  #connection;

  // Constructor
  constructor(apiKey) {
    this.#apiKey = apiKey;
    this.#connection = this.#initConnection();
  }

  // Public instance methods (alphabetical)
  async createUser(data) {
    return this.#makeRequest('POST', '/users', data);
  }

  async deleteUser(id) {
    return this.#makeRequest('DELETE', `/users/${id}`);
  }

  async getUser(id) {
    return this.#makeRequest('GET', `/users/${id}`);
  }

  // Private instance methods (alphabetical)
  #initConnection() {
    // implementation
  }

  #makeRequest(method, path, data) {
    // implementation
  }

  // Static methods (alphabetical)
  static fromConfig(config) {
    return new UserService(config.apiKey);
  }

  static validateConfig(config) {
    return config && config.apiKey;
  }
}
```

**Bad:**
```javascript
class UserService {
  // Mixed order, no grouping
  async getUser(id) {
    return this.#makeRequest('GET', `/users/${id}`);
  }

  static fromConfig(config) {
    return new UserService(config.apiKey);
  }

  #apiKey;

  constructor(apiKey) {
    this.#apiKey = apiKey;
  }

  static MAX_RETRIES = 3;

  #makeRequest(method, path, data) {
    // implementation
  }

  users = [];

  async createUser(data) {
    return this.#makeRequest('POST', '/users', data);
  }
}
```

### Function Ordering

In files that contain only functions (no classes or other top-level structures), organize functions in two blocks:

1. **Exported functions** - alphabetically sorted
2. **Private functions** - alphabetically sorted

This makes it easy to understand the public API at a glance and locate functions quickly.

**Good:**
```javascript
// Exported functions (alphabetical)
export function createUser(data) {
  return formatUserData(data);
}

export function deleteUser(id) {
  return validateId(id) && removeFromDb(id);
}

export function updateUser(id, data) {
  return validateId(id) && formatUserData(data);
}

// Private functions (alphabetical)
function formatUserData(data) {
  return { ...data, timestamp: Date.now() };
}

function removeFromDb(id) {
  // implementation
}

function validateId(id) {
  return typeof id === 'string' && id.length > 0;
}
```

**Bad:**
```javascript
// Mixed exports and private functions, no alphabetical order
function validateId(id) {
  return typeof id === 'string' && id.length > 0;
}

export function updateUser(id, data) {
  return validateId(id) && formatUserData(data);
}

function formatUserData(data) {
  return { ...data, timestamp: Date.now() };
}

export function createUser(data) {
  return formatUserData(data);
}
```

## Naming Conventions

### Consistent Naming Patterns

Follow these naming conventions consistently across the codebase:

**Variables and Functions:**
- **Variables:** camelCase (`userId`, `orderTotal`, `isActive`)
- **Functions:** camelCase (`getUserById`, `validateInput`, `calculateTotal`)
- **Booleans:** Prefix with `is`, `has`, `should`, `can` (`isEnabled`, `hasPermission`, `shouldRetry`, `canEdit`)

**Classes and Constants:**
- **Classes:** PascalCase (`UserService`, `ApiClient`, `OrderProcessor`)
- **Constants:** UPPER_SNAKE_CASE (`MAX_RETRIES`, `API_TIMEOUT`, `DEFAULT_PAGE_SIZE`)

**Private Members:**
- Use `#` for private fields (modern JS)
- Use `_` prefix for older codebases or methods

**File Names:**
- Always use camelCase (`userService.js`, `apiClient.js`, `formatDate.js`)
- Name should match the primary export

**Good:**
```javascript
// Constants
const MAX_RETRY_COUNT = 3;
const API_BASE_URL = 'https://api.example.com';

// Variables
const userId = '123';
const isActive = true;
const hasPermission = user.role === 'admin';

// Class with private fields
class UserService {
  #apiKey;

  constructor(apiKey) {
    this.#apiKey = apiKey;
  }

  async getUserById(id) {
    return this.#makeRequest(`/users/${id}`);
  }

  #makeRequest(path) {
    // private method
  }
}

// Boolean helper functions
function isValidEmail(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function hasRole(user, role) {
  return user.roles.includes(role);
}
```

**Bad:**
```javascript
// Inconsistent naming
const max_retry_count = 3;
const APIBASEURL = 'https://api.example.com';

const UserID = '123'; // PascalCase for variable
const active = true; // unclear boolean name

class userService { // camelCase for class
  ApiKey; // PascalCase for property

  async get_user_by_id(id) { // snake_case for method
    return this.make_request(`/users/${id}`);
  }

  make_request(path) {
    // unclear if private
  }
}

function ValidEmail(email) { // PascalCase for function
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function checkRole(user, role) { // unclear boolean return
  return user.roles.includes(role);
}
```

## Code Style

### Prefer Destructuring

**Use object and array destructuring** for cleaner, more readable code.

**Object Destructuring:**

**Good:**
```javascript
// Function parameters
function createUser({ name, email, role }) {
  return { name, email, role, createdAt: Date.now() };
}

// Variable assignment
const { id, name, email } = user;
const { data, error } = await fetchUser(id);

// Nested destructuring
const { user: { name, email }, posts } = response;

// With defaults
function greetUser({ name = 'Guest', greeting = 'Hello' }) {
  return `${greeting}, ${name}!`;
}
```

**Array Destructuring:**

**Good:**
```javascript
// Basic array destructuring
const [first, second] = items;
const [firstName, lastName] = fullName.split(' ');

// Parallel async operations
const [users, posts, comments] = await Promise.all([
  getUsers(),
  getPosts(),
  getComments(),
]);

// Skipping elements
const [first, , third] = items;

// Rest operator
const [head, ...rest] = items;
```

**When NOT to destructure:**
```javascript
// Single property - destructuring adds noise
const name = user.name; // Good
const { name } = user;  // Overkill for single property

// Dynamic keys
const value = obj[key]; // Can't destructure dynamic keys

// Passing entire object
processUser(user); // Better than processUser({ ...user })
```

**Bad:**
```javascript
// Repetitive property access
function createUser(userData) {
  return {
    name: userData.name,
    email: userData.email,
    role: userData.role,
    createdAt: Date.now(),
  };
}

// Multiple separate declarations
const id = user.id;
const name = user.name;
const email = user.email;

// Not using array destructuring
const users = await getUsers();
const posts = await getPosts();
// vs
const [users, posts] = await Promise.all([getUsers(), getPosts()]);
```

### Arrow Functions vs Function Declarations

Use the appropriate function syntax for the context.

**Arrow Functions - Use for:**
- Callbacks and inline functions
- Functions that need lexical `this` binding
- Short, simple operations

**Function Declarations - Use for:**
- Top-level named functions
- Functions that might be hoisted
- Exported utility functions

**Good:**
```javascript
// Arrow functions for callbacks
users.map(user => user.name);
users.filter(user => user.isActive);
items.reduce((sum, item) => sum + item.price, 0);

// Arrow functions for short operations
const double = n => n * 2;
const isEven = n => n % 2 === 0;

// Arrow functions preserve 'this'
class Component {
  handleClick = () => {
    this.setState({ clicked: true }); // 'this' is lexically bound
  }
}

// Function declarations for top-level functions
function getUserById(id) {
  return users.find(user => user.id === id);
}

function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// Function declarations for exported utilities
export function formatDate(date) {
  return date.toISOString().split('T')[0];
}
```

**Bad:**
```javascript
// Arrow function for top-level when not needed
const getUserById = (id) => {
  return users.find(user => user.id === id);
};

// Traditional function for simple callback
users.map(function(user) {
  return user.name;
});

// Arrow function when you need dynamic 'this'
const obj = {
  name: 'Test',
  greet: () => {
    console.log(this.name); // 'this' doesn't work as expected
  }
};
```

**When NOT to use arrow functions:**
- Constructor functions (arrow functions can't be constructors)
- Object methods that need dynamic `this`
- Functions that need `arguments` object

## Async Patterns

### Prefer async/await Over Promise Chains

**Always use `async/await`** instead of `.then()` chains for better readability and error handling.

**Good:**
```javascript
// Clean, readable async/await
async function fetchUserData(id) {
  const user = await getUser(id);
  const posts = await getPosts(user.id);
  return { user, posts };
}

// Error handling with try/catch
async function updateUser(id, data) {
  try {
    const user = await getUser(id);
    const updated = await saveUser({ ...user, ...data });
    return updated;
  } catch (error) {
    console.error('Failed to update user:', error);
    throw error;
  }
}

// Parallel operations with Promise.all
async function fetchAllData() {
  const [users, posts, comments] = await Promise.all([
    getUsers(),
    getPosts(),
    getComments(),
  ]);
  return { users, posts, comments };
}
```

**Acceptable (fire-and-forget scenarios):**
```javascript
// Single operation you don't need to wait for
api.logEvent('user-action').then(() => {});

// Or better, use async/await and explicitly ignore
void api.logEvent('user-action');
```

**Bad:**
```javascript
// Promise chains are harder to read
function fetchUserData(id) {
  return getUser(id)
    .then(user => getPosts(user.id)
      .then(posts => ({ user, posts })));
}

// Mixed async/await and .then()
async function updateUser(id, data) {
  const user = await getUser(id);
  return saveUser({ ...user, ...data }).then(result => result);
}
```

## Error Handling

### Consistent Error Handling Practices

**Always handle errors explicitly** in async functions. Don't let promises fail silently.

**Logging:**
- **Production code:** Use the project's logging library/utility if available (check for logger, log util, or similar)
- **Development/debugging:** Console methods are acceptable while iterating
- **Determine contextually:** Check the project for existing logging patterns before writing error handling code

**When to Throw vs Return:**
- **Throw** for exceptional conditions that callers can't reasonably handle
- **Return error objects** for expected failures that are part of normal flow
- **Always include context** in error messages (what failed, relevant IDs, operation being performed)

**Good:**
```javascript
// Using project logger (production)
async function fetchUser(id) {
  try {
    return await api.getUser(id);
  } catch (error) {
    logger.error(`Failed to fetch user ${id}:`, error);
    throw new UserFetchError(`User ${id} not found`, { cause: error });
  }
}

// Console for debugging (development/iteration)
async function fetchUser(id) {
  try {
    return await api.getUser(id);
  } catch (error) {
    console.error(`Failed to fetch user ${id}:`, error); // OK while debugging
    throw error;
  }
}

// Custom error classes for clarity
class UserFetchError extends Error {
  constructor(message, options) {
    super(message, options);
    this.name = 'UserFetchError';
  }
}
```

**Bad:**
```javascript
// Unhandled async errors - might fail silently
async function fetchUser(id) {
  return api.getUser(id);
}

// Swallowing errors without logging
async function fetchUser(id) {
  try {
    return await api.getUser(id);
  } catch (error) {
    return null; // Error disappears, no way to debug
  }
}

// No context in error messages
async function fetchUser(id) {
  try {
    return await api.getUser(id);
  } catch (error) {
    console.error(error); // Which user? What operation?
    throw error;
  }
}
```

## Comments and Documentation

### When and How to Comment

**Write self-documenting code first.** Comments should explain "why", not "what".

**Good Comments:**
```javascript
// Explains WHY, not what
// Retry failed requests up to 3 times to handle transient network issues
const MAX_RETRIES = 3;

// Complex business logic that needs explanation
// Calculate prorated refund: full price minus days used,
// but never less than 50% of original price per company policy
const refund = Math.max(fullPrice - (daysUsed * dailyRate), fullPrice * 0.5);

// Non-obvious workarounds
// Safari has a bug with Date.parse() for ISO strings before 1970
// Using manual parsing as workaround
const date = parseCustomDate(dateString);

// TODO/FIXME with context
// TODO(vruby): Migrate to new API endpoint after v2 is deployed to production
// FIXME: Race condition when multiple tabs update user profile simultaneously
```

**Bad Comments:**
```javascript
// Obvious comments that just repeat the code
// Increment counter by 1
counter++;

// Set name to user name
const name = user.name;

// Loop through users
users.forEach(user => {
  // Process each user
  processUser(user);
});

// Outdated comments
// Returns user array (actually returns a Map now)
function getUsers() {
  return new Map();
}

// Vague TODO
// TODO: fix this
// FIXME: broken
```

**When to Use Comments:**
- Complex algorithms or business logic
- Non-obvious workarounds or browser/platform quirks
- Explaining "why" a certain approach was chosen
- Warning about potential issues or side effects
- TODO/FIXME with assignee and context

**When NOT to Use Comments:**
- Explaining what the code does (make the code clearer instead)
- Commented-out code (use version control)
- Obvious statements
- Redundant information

**JSDoc for Public APIs:**
```javascript
/**
 * Fetches user data with optional caching.
 *
 * @param {string} userId - The user ID to fetch
 * @param {Object} options - Fetch options
 * @param {boolean} options.useCache - Whether to use cached data
 * @returns {Promise<User>} The user object
 * @throws {UserNotFoundError} If user doesn't exist
 */
async function fetchUser(userId, { useCache = true } = {}) {
  // implementation
}
```

## Libraries to Avoid

### Lodash

**Do not use lodash.** Prefer native JavaScript methods and utilities instead.

Modern JavaScript provides most of lodash's functionality natively. Use built-in methods for better performance, smaller bundle size, and fewer dependencies.

**Good (Native JavaScript):**
```javascript
// Array operations
const unique = [...new Set(array)];
const filtered = array.filter(item => item.active);
const mapped = array.map(item => item.name);

// Object operations
const merged = { ...obj1, ...obj2 };
const picked = { name: user.name, email: user.email };

// Function utilities
const debounced = debounce(fn, 300); // Use a lightweight utility or write your own
```

**Bad (Lodash):**
```javascript
import { debounce, filter, map, merge, pick, uniq } from 'lodash';

const unique = uniq(array);
const filtered = filter(array, item => item.active);
const merged = merge(obj1, obj2);
```

---

_Last updated: 2025-12-18_

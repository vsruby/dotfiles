# TypeScript Coding Rules

## Import Statements

### Named Import Ordering

When importing multiple named exports from the same source, **always alphabetize them**.

**Good:**
```typescript
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { Component, useEffect, useState } from 'react';
import type { User, UserRole, UserSettings } from './types';
```

**Bad:**
```typescript
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { useState, Component, useEffect} from 'react';
import type { UserSettings, User, UserRole } from './types';
```

### Note on Type Imports

This alphabetization applies to both regular imports and type-only imports.

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
```typescript
class UserService {
  // Constants
  static readonly DEFAULT_TIMEOUT = 5000;
  static readonly MAX_RETRIES = 3;

  // Properties (public)
  cache = new Map<string, User>();
  users: User[] = [];

  // Properties (protected)
  protected config: ServiceConfig;

  // Properties (private)
  private apiKey: string;
  private connection: Connection;

  // Constructor
  constructor(apiKey: string) {
    this.apiKey = apiKey;
    this.connection = this.initConnection();
  }

  // Public instance methods (alphabetical)
  async createUser(data: UserInput) {
    return this.makeRequest('POST', '/users', data);
  }

  async deleteUser(id: string) {
    return this.makeRequest('DELETE', `/users/${id}`);
  }

  async getUser(id: string) {
    return this.makeRequest('GET', `/users/${id}`);
  }

  // Protected instance methods (alphabetical)
  protected validateUser(user: User) {
    return user.id && user.name;
  }

  // Private instance methods (alphabetical)
  private initConnection() {
    // implementation
  }

  private makeRequest(method: string, path: string, data?: unknown) {
    // implementation
  }

  // Static methods (alphabetical)
  static fromConfig(config: ServiceConfig) {
    return new UserService(config.apiKey);
  }

  static validateConfig(config: ServiceConfig) {
    return config && config.apiKey;
  }
}
```

**Bad:**
```typescript
class UserService {
  // Mixed order, no grouping
  async getUser(id: string) {
    return this.makeRequest('GET', `/users/${id}`);
  }

  static fromConfig(config: ServiceConfig) {
    return new UserService(config.apiKey);
  }

  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  static readonly MAX_RETRIES = 3;

  private makeRequest(method: string, path: string, data?: unknown) {
    // implementation
  }

  users: User[] = [];

  async createUser(data: UserInput) {
    return this.makeRequest('POST', '/users', data);
  }
}
```

### Function Ordering

In files that contain only functions (no classes or other top-level structures), organize functions in two blocks:

1. **Exported functions** - alphabetically sorted
2. **Private functions** - alphabetically sorted

This makes it easy to understand the public API at a glance and locate functions quickly.

**Good:**
```typescript
// Exported functions (alphabetical)
export function createUser(data: UserInput) {
  return formatUserData(data);
}

export function deleteUser(id: string) {
  return validateId(id) && removeFromDb(id);
}

export function updateUser(id: string, data: UserInput) {
  if (!validateId(id)) throw new Error('Invalid ID');
  return formatUserData(data);
}

// Private functions (alphabetical)
function formatUserData(data: UserInput) {
  return { ...data, timestamp: Date.now() };
}

function removeFromDb(id: string) {
  // implementation
  return true;
}

function validateId(id: string) {
  return id.length > 0;
}
```

**Bad:**
```typescript
// Mixed exports and private functions, no alphabetical order
function validateId(id: string) {
  return id.length > 0;
}

export function updateUser(id: string, data: UserInput) {
  if (!validateId(id)) throw new Error('Invalid ID');
  return formatUserData(data);
}

function formatUserData(data: UserInput) {
  return { ...data, timestamp: Date.now() };
}

export function createUser(data: UserInput) {
  return formatUserData(data);
}
```

## Type Safety

### Return Type Annotations

**Prefer implicit return types** over explicit annotations. Let TypeScript infer the return type unless there's a specific reason to be explicit.

**When explicit return types are needed:**
- Public API functions in libraries
- Complex functions where inference might be unclear
- When you want to enforce a specific return contract
- Recursive functions where inference can fail

**Good (Implicit):**
```typescript
// Return type is clearly inferred as User
function createUser(data: UserInput) {
  return { ...data, id: generateId(), timestamp: Date.now() };
}

// Return type is inferred as Promise<string>
async function fetchUserName(id: string) {
  const user = await getUser(id);
  return user.name;
}

// Return type is inferred as number
function add(a: number, b: number) {
  return a + b;
}
```

**Acceptable (Explicit when needed):**
```typescript
// Public API - explicit contract
export function processData(input: string): ProcessedData {
  return parse(input);
}

// Complex inference - explicit for clarity
function transform(data: unknown): string | number {
  if (typeof data === 'string') return data.toUpperCase();
  return 42;
}
```

**Bad (Unnecessary explicit):**
```typescript
// Obvious inference, explicit type adds noise
function getFullName(first: string, last: string): string {
  return `${first} ${last}`;
}

// Simple inference, no need for explicit type
function double(n: number): number {
  return n * 2;
}
```

### Avoid `any`, `unknown`, and `never`

**Prefer explicit types** over `any`, `unknown`, and `never`. These types should be avoided in most cases to maintain type safety.

**Exception:** Use these types when the complexity of proper typing would be excessive, particularly in:
- Test files and test utilities
- Complex generic utility types
- Third-party library integration where types are unavailable or problematic

**Good:**
```typescript
// Explicit types for better type safety
function processUser(user: User) {
  return { id: user.id, name: user.name };
}

// Proper generic typing
function mapArray<T, U>(arr: T[], fn: (item: T) => U) {
  return arr.map(fn);
}
```

**Acceptable (Testing scenario):**
```typescript
// In test files, any can be pragmatic for mock objects
const mockRequest = {
  body: { foo: 'bar' },
  headers: {},
} as any;

// Complex mock with minimal type overhead
vi.mock('./service', () => ({
  fetchData: vi.fn().mockResolvedValue({} as any),
}));
```

**Bad:**
```typescript
// Unnecessary use of any in application code
function processData(data: any): any {
  return data.map((item: any) => item.value);
}

// Unknown without proper narrowing
function handleEvent(event: unknown) {
  console.log(event.type); // Error, but defeats the purpose
}
```

When you must use these types, add a comment explaining why the complexity justifies it.

### Property Ordering in Interfaces and Types

**Always alphabetize properties** in interfaces, types, and nested structures.

**Good:**
```typescript
interface User {
  createdAt: Date;
  email: string;
  id: string;
  name: string;
  role: UserRole;
  updatedAt: Date;
}

type ApiConfig = {
  apiKey: string;
  baseUrl: string;
  retryCount: number;
  timeout: number;
};

// Nested structures - alphabetize at every level
interface Organization {
  id: string;
  members: Array<{
    email: string;
    id: string;
    name: string;
    role: string;
  }>;
  name: string;
  settings: {
    allowGuests: boolean;
    maxMembers: number;
    theme: string;
  };
}
```

**Bad:**
```typescript
interface User {
  name: string;
  id: string;
  email: string;
  role: UserRole;
  updatedAt: Date;
  createdAt: Date;
}

type ApiConfig = {
  timeout: number;
  baseUrl: string;
  apiKey: string;
  retryCount: number;
};

// Nested structures not alphabetized
interface Organization {
  name: string;
  id: string;
  settings: {
    theme: string;
    maxMembers: number;
    allowGuests: boolean;
  };
  members: Array<{
    name: string;
    role: string;
    id: string;
    email: string;
  }>;
}
```

This applies to all property definitions including inline types, nested objects, and complex structures.

### Interface vs Type Alias

Choose the right TypeScript construct for your use case.

**Interface - Use for:**
- Object shapes that might be extended
- Public APIs where declaration merging might be useful
- Class contracts

**Type - Use for:**
- Unions and intersections
- Primitive aliases
- Tuples
- Complex type manipulations
- Mapped types

**Good:**
```typescript
// Interface for object shapes
interface User {
  email: string;
  id: string;
  name: string;
}

// Interfaces can be extended
interface AdminUser extends User {
  permissions: string[];
}

// Interfaces support declaration merging
interface Window {
  customProperty: string;
}

// Type for unions
type Status = 'pending' | 'active' | 'inactive' | 'archived';
type Result = Success | Error;

// Type for intersections
type WithTimestamps = {
  createdAt: Date;
  updatedAt: Date;
};

type TimestampedUser = BaseUser & WithTimestamps;

// Type for complex combinations
type ApiResponse<T> =
  | { data: T; error?: never }
  | { data?: never; error: string };

// Type for tuples
type Coordinate = [number, number];
type RGB = [number, number, number];

// Type for mapped types
type Readonly<T> = {
  readonly [P in keyof T]: T[P];
};
```

**Bad:**
```typescript
// Type when interface would be more appropriate
type User = {
  email: string;
  id: string;
  name: string;
};

type AdminUser = User & {
  permissions: string[];
};

// Interface for unions (not possible, but attempting it)
// interface Status = 'pending' | 'active'; // Won't work

// Mixing without clear reason
interface Config {
  timeout: number;
}

type Settings = {
  theme: string;
}; // Should be consistent - both interface or both type
```

**General guideline:**
- Default to `interface` for object shapes
- Use `type` when you need union/intersection features
- Be consistent within a module or related types

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
- **Interfaces/Types:** PascalCase (`User`, `ApiResponse`, `ServiceConfig`)

**Private Members:**
- Use `private` keyword in TypeScript
- Can also use `#` for private fields
- Use `_` prefix for protected or when needed

**File Names:**
- Always use camelCase (`userService.ts`, `apiClient.ts`, `formatDate.ts`)
- Name should match the primary export

**Good:**
```typescript
// Constants
const MAX_RETRY_COUNT = 3;
const API_BASE_URL = 'https://api.example.com';

// Variables
const userId = '123';
const isActive = true;
const hasPermission = user.role === 'admin';

// Interfaces and types
interface User {
  id: string;
  name: string;
}

type ApiResponse<T> = {
  data: T;
  status: number;
};

// Class with private fields
class UserService {
  private apiKey: string;

  constructor(apiKey: string) {
    this.apiKey = apiKey;
  }

  async getUserById(id: string) {
    return this.makeRequest(`/users/${id}`);
  }

  private makeRequest(path: string) {
    // private method
  }
}

// Boolean helper functions
function isValidEmail(email: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function hasRole(user: User, role: string) {
  return user.roles.includes(role);
}
```

**Bad:**
```typescript
// Inconsistent naming
const max_retry_count = 3;
const APIBASEURL = 'https://api.example.com';

const UserID = '123'; // PascalCase for variable
const active = true; // unclear boolean name

// Inconsistent type naming
interface user { // camelCase for interface
  id: string;
  name: string;
}

type apiResponse<T> = { // camelCase for type
  data: T;
  status: number;
};

class userService { // camelCase for class
  ApiKey: string; // PascalCase for property

  async get_user_by_id(id: string) { // snake_case for method
    return this.make_request(`/users/${id}`);
  }

  make_request(path: string) {
    // unclear if private
  }
}

function ValidEmail(email: string) { // PascalCase for function
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function checkRole(user: User, role: string) { // unclear boolean return
  return user.roles.includes(role);
}
```

## Code Style

### Prefer Destructuring

**Use object and array destructuring** for cleaner, more readable code.

**Object Destructuring:**

**Good:**
```typescript
// Function parameters
function createUser({ name, email, role }: UserInput) {
  return { name, email, role, createdAt: Date.now() };
}

// Variable assignment
const { id, name, email } = user;
const { data, error } = await fetchUser(id);

// Nested destructuring
const { user: { name, email }, posts } = response;

// With defaults
function greetUser({ name = 'Guest', greeting = 'Hello' }: GreetOptions) {
  return `${greeting}, ${name}!`;
}

// Type-safe destructuring
interface User {
  email: string;
  id: string;
  name: string;
}

function processUser({ id, name }: User) {
  // TypeScript ensures these properties exist
  return `${name} (${id})`;
}
```

**Array Destructuring:**

**Good:**
```typescript
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

// Rest operator with types
const [head, ...rest]: [string, ...string[]] = items;

// Tuple destructuring
const [x, y]: [number, number] = coordinates;
```

**When NOT to destructure:**
```typescript
// Single property - destructuring adds noise
const name = user.name; // Good
const { name } = user;  // Overkill for single property

// Dynamic keys
const value = obj[key]; // Can't destructure dynamic keys

// Passing entire object
processUser(user); // Better than processUser({ ...user })
```

**Bad:**
```typescript
// Repetitive property access
function createUser(userData: UserInput) {
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
```typescript
// Arrow functions for callbacks
users.map(user => user.name);
users.filter(user => user.isActive);
items.reduce((sum, item) => sum + item.price, 0);

// Arrow functions for short operations
const double = (n: number) => n * 2;
const isEven = (n: number) => n % 2 === 0;

// Arrow functions preserve 'this'
class Component {
  private state = { clicked: false };

  handleClick = () => {
    this.setState({ clicked: true }); // 'this' is lexically bound
  }
}

// Function declarations for top-level functions
function getUserById(id: string) {
  return users.find(user => user.id === id);
}

function calculateTotal(items: Item[]) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// Function declarations for exported utilities
export function formatDate(date: Date) {
  return date.toISOString().split('T')[0];
}
```

**Bad:**
```typescript
// Arrow function for top-level when not needed
const getUserById = (id: string) => {
  return users.find(user => user.id === id);
};

// Traditional function for simple callback
users.map(function(user: User): string {
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
```typescript
// Clean, readable async/await
async function fetchUserData(id: string) {
  const user = await getUser(id);
  const posts = await getPosts(user.id);
  return { user, posts };
}

// Error handling with try/catch
async function updateUser(id: string, data: UserInput) {
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
```typescript
// Single operation you don't need to wait for
api.logEvent('user-action').then(() => {});

// Or better, use async/await and explicitly ignore
void api.logEvent('user-action');
```

**Bad:**
```typescript
// Promise chains are harder to read
function fetchUserData(id: string): Promise<{ user: User; posts: Post[] }> {
  return getUser(id)
    .then(user => getPosts(user.id)
      .then(posts => ({ user, posts })));
}

// Mixed async/await and .then()
async function updateUser(id: string, data: UserInput) {
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
```typescript
// Using project logger (production)
async function fetchUser(id: string) {
  try {
    return await api.getUser(id);
  } catch (error) {
    logger.error(`Failed to fetch user ${id}:`, error);
    throw new UserFetchError(`User ${id} not found`, { cause: error });
  }
}

// Console for debugging (development/iteration)
async function fetchUser(id: string) {
  try {
    return await api.getUser(id);
  } catch (error) {
    console.error(`Failed to fetch user ${id}:`, error); // OK while debugging
    throw error;
  }
}

// Custom error classes for clarity
class UserFetchError extends Error {
  constructor(message: string, options?: ErrorOptions) {
    super(message, options);
    this.name = 'UserFetchError';
  }
}
```

**Bad:**
```typescript
// Unhandled async errors - might fail silently
async function fetchUser(id: string) {
  return api.getUser(id);
}

// Swallowing errors without logging
async function fetchUser(id: string) {
  try {
    return await api.getUser(id);
  } catch (error) {
    return null; // Error disappears, no way to debug
  }
}

// No context in error messages
async function fetchUser(id: string) {
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
```typescript
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
```typescript
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
function getUsers(): Map<string, User> {
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
- Type information (TypeScript types provide this)

**TSDoc for Public APIs:**
```typescript
/**
 * Fetches user data with optional caching.
 *
 * @param userId - The user ID to fetch
 * @param options - Fetch options
 * @returns The user object
 * @throws {UserNotFoundError} If user doesn't exist
 *
 * @example
 * ```ts
 * const user = await fetchUser('123', { useCache: true });
 * ```
 */
async function fetchUser(
  userId: string,
  { useCache = true }: FetchOptions = {}
): Promise<User> {
  // implementation
}

/**
 * Configuration for the API client.
 *
 * @remarks
 * The API key must have read permissions at minimum.
 */
interface ApiConfig {
  /** Authentication key */
  apiKey: string;
  /** Base URL for the API */
  baseUrl: string;
  /** Request timeout in milliseconds */
  timeout?: number;
}
```

## Libraries to Avoid

### Lodash

**Do not use lodash.** Prefer native JavaScript/TypeScript methods and utilities instead.

Modern JavaScript provides most of lodash's functionality natively. Use built-in methods for better performance, smaller bundle size, and fewer dependencies.

**Good (Native JavaScript/TypeScript):**
```typescript
// Array operations
const unique = [...new Set(array)];
const filtered = array.filter(item => item.active);
const mapped = array.map(item => item.name);

// Object operations
const merged = { ...obj1, ...obj2 };
const picked: Pick<User, 'name' | 'email'> = { name: user.name, email: user.email };

// Type-safe alternatives
function debounce<T extends (...args: any[]) => any>(
  fn: T,
  delay: number
): (...args: Parameters<T>) => void {
  let timeoutId: NodeJS.Timeout;
  return (...args: Parameters<T>) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => fn(...args), delay);
  };
}
```

**Bad (Lodash):**
```typescript
import { debounce, filter, map, merge, pick, uniq } from 'lodash';

const unique = uniq(array);
const filtered = filter(array, item => item.active);
const merged = merge(obj1, obj2);
```

---

_Last updated: 2025-12-18_

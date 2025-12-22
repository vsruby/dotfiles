# Auto-load Project-Specific Instructions

At the start of each session, check if a `.claude/PROJECT.md` file exists in the project root.

If the file exists:
- Read its contents immediately
- Follow all instructions specified within it
- Treat it as an extension of the project's CLAUDE.md file

If the file does not exist:
- Continue normally without error
- Do not mention the missing file to the user

This allows project-specific personal workflow instructions (like journaling preferences, logging requirements, or documentation habits) to be automatically loaded without being version-controlled.

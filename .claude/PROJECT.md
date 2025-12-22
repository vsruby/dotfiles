# Dotfiles Project - Personal Instructions

## Proactive Journaling and Documentation

**IMPORTANT: Be proactive about documenting work in this project without waiting to be asked.**

When working in the dotfiles repository, automatically create journal or note entries for:

### When to Create Entries

**After significant work:**
- Adding new tool configurations
- Shell environment updates (Zsh, plugins, aliases)
- Theme changes or customization
- Cross-machine configuration setup
- Template improvements for multi-OS support
- Installation script creation or updates

**During problem-solving:**
- Debugging Chezmoi templating issues
- Resolving conflicts between macOS and Linux configs
- Tool installation or setup problems
- Shell plugin conflicts or performance issues

**For learning moments:**
- Understanding gained about Chezmoi features
- Template patterns discovered
- Tool configuration best practices
- Shell optimization techniques
- Terminal emulator customization insights

**For decisions:**
- Why certain tools were chosen over alternatives
- Configuration approaches and trade-offs
- Theme and aesthetic choices
- Machine-specific vs. general configurations

### Entry Guidelines

**Use journal skill for:**
- Time-stamped work progress and session logs
- Real-time thoughts and problem-solving narratives
- Context: "Dotfiles / [Tool or Component]"
- Examples:
  - "Dotfiles / Zsh Configuration"
  - "Dotfiles / Alacritty Setup"
  - "Dotfiles / Chezmoi Templates"
  - "Dotfiles / Theme Customization"

**Use obsidian skill (personal folder) for:**
- Tool configuration guides and recipes
- Reusable patterns discovered
- Cross-platform setup documentation
- Shell optimization techniques
- Personal workflow documentation
- Context pattern same as journal

**Tags to include:**
- Always: `#dotfiles` `#personal`
- Add specific tags: `#alacritty` `#catppuccin` `#chezmoi` `#ghostty` `#lazygit` `#shell` `#starship` `#theme` `#tmux` `#volta` `#zsh`
- Tags should be alphabetically ordered (per your coding rules)

### Cross-Reference Work Projects

**Before creating entries, check zylo/ folder for relevant patterns:**
- Read from `~/dev/captains-log/zylo/*.md` for:
  - Tool configurations used at work that apply here
  - Shell setup patterns from work environment
  - Development tool preferences
  - Infrastructure or setup approaches

**When you find relevant connections:**
- Mention them in the dotfiles entry
- Note what work experience informed the approach
- Create cross-references between personal and work configurations
- Keep sensitive work information separate

### Automatic Entry Creation

**Don't wait for explicit requests.** Create entries:
- Immediately after completing meaningful configuration work
- After solving complex templating or cross-platform issues
- When making important tool or workflow decisions
- At natural transition points (switching tasks, end of focused work)
- When you discover patterns from work that apply to personal setup

### Entry Format

**Journal entries:**
```markdown
## {HH:MM} - {Brief Context}

**Mood:** {emoji + word}
**Energy:** {Low | Medium | High}
**Context:** Dotfiles / {Tool or Component}

{What was done, challenges faced, decisions made, etc.}
```

**Personal notes (obsidian):**
```markdown
# {Title}

> {Summary or description}

## {Section}

{Technical content, configuration patterns, etc.}

---

_Tags:_ #{alphabetized tags including #dotfiles #personal}
```

## Project Context

**Project type:** Personal dotfiles management
**Tech stack:** Chezmoi, Zsh, Starship, Tmux, Alacritty, Ghostty, Volta
**Key components:** Shell configuration, terminal emulators, development tools, themes
**Cross-platform:** macOS and Linux support with templates
**Theme:** Catppuccin Mocha (consistent across all tools)

## Remember

- **Be proactive** - Don't wait to be asked
- **Check work notes** - Look for relevant patterns from zylo projects
- **Document decisions** - Capture the "why" not just the "what"
- **Real-time logging** - Journal as work happens, not after
- **Preserve knowledge** - Use personal notes for reusable patterns and configurations
- **Privacy** - Keep work-specific credentials and tokens separate

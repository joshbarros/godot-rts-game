# Known Issues

## Current Issues

*No known issues at this time.*

---

## Resolved Issues

### Unit Selection
- ~~Clicking on enemy units does not work properly - selection visual toggle fails when PlayerUnit node is missing from enemy units~~
  - **Status:** Fixed - Enemy units now use separate `unit_ai.tscn` scene without PlayerUnit dependency

### Unit Combat
- ~~Units weren't properly targeting and attacking enemies~~
  - **Status:** Fixed - Implemented proper attack targeting and combat mechanics in `unit_base.gd`

### Sprite Animation
- ~~Units wobbled even when standing still~~
  - **Status:** Fixed - Wobble now only occurs when unit is moving (`sprite.gd`)

### Menu Navigation
- ~~Play button tried to load non-existent `game.tscn`~~
  - **Status:** Fixed - Updated to load `main.tscn` in `menu.gd`

### Signal Connection
- ~~`onDie` signal name mismatch (camelCase vs PascalCase)~~
  - **Status:** Fixed - Changed to `OnDie` in `main.gd` to match signal definition

---

## Reporting Issues

If you encounter a bug:
1. Check if it's already listed above
2. Note the steps to reproduce
3. Include any error messages from the console
4. Add to this file or create a GitHub issue

---

**Last Updated:** December 29, 2025

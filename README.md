# RTS Game

A Real-Time Strategy game prototype built with **Godot 4.5**.

![Godot](https://img.shields.io/badge/Godot-4.5-blue)
![Status](https://img.shields.io/badge/Status-Alpha-orange)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

This is a playable RTS prototype featuring unit combat, AI opponents, and a complete game loop from menu to victory/defeat conditions. Built as a foundation for a full-featured real-time strategy game.

## Features

### Implemented

- **Unit System**
  - Health, movement, and combat mechanics
  - NavigationAgent2D pathfinding
  - Attack targeting with range checks
  - Team-based gameplay (Player vs AI)

- **AI Behavior**
  - Enemy detection with configurable range
  - Auto-targeting nearest player unit
  - Performance-optimized periodic updates

- **Player Controls**
  - Left-click: Select units
  - Right-click: Move or attack command
  - WASD: Camera pan
  - Mouse wheel: Camera zoom

- **Visual Feedback**
  - Health bars (hidden when full)
  - Selection indicators
  - Sprite wobble on movement
  - Directional sprite flip
  - Damage flash effect

- **Game Flow**
  - Main menu (Play/Quit)
  - Win/lose condition detection
  - End screen with winner display

### Planned Features

- Resource management (gold, wood, food, energy)
- Building construction system
- Unit production facilities
- Multi-unit selection (box select, shift-click)
- Fog of war
- Tech tree and upgrades
- Campaign mode
- Multiplayer support

## Project Structure

```
rts/
├── Scripts/
│   ├── unit_base.gd        # Core unit logic
│   ├── unit_controller.gd  # Player input handling
│   ├── unit_ai.gd          # AI behavior
│   ├── player_unit.gd      # Player unit specifics
│   ├── sprite.gd           # Sprite animations
│   ├── health_bar.gd       # Health bar display
│   ├── unit_audio.gd       # Sound effects
│   ├── camera_controller.gd # Camera controls
│   ├── main.gd             # Game flow & win conditions
│   ├── menu.gd             # Menu logic
│   └── end_screen.gd       # Victory/defeat screen
├── Scenes/
│   ├── main.tscn           # Main game scene
│   ├── menu.tscn           # Main menu
│   ├── unit_base.tscn      # Base unit template
│   ├── unit_player.tscn    # Player unit
│   └── unit_ai.tscn        # AI unit
├── Sprites/
│   ├── Characters/         # Unit sprites
│   ├── Tiles/              # Tilemap assets
│   └── Backgrounds/        # UI backgrounds
├── Audio/
│   └── take_damage.wav     # Damage SFX
├── ROADMAP.MD              # Development roadmap
├── STEAM.MD                # Steam integration guide
└── KNOWN_ISSUES.md         # Bug tracking
```

## How to Play

1. Launch the game
2. Click **Play** from the main menu
3. **Left-click** to select your unit (green indicator)
4. **Right-click** on ground to move
5. **Right-click** on enemy to attack
6. Use **WASD** to pan camera, **scroll wheel** to zoom
7. Eliminate all enemy units to win!

## Development

### Requirements

- Godot 4.5+
- Windows/macOS/Linux

### Running the Project

1. Clone this repository
2. Open in Godot 4.5
3. Run the project (F5)

### Architecture

The project uses a component-based architecture with signal-driven events:

- **Unit Base**: Core unit functionality (health, movement, combat)
- **Scene Inheritance**: `unit_base.tscn` → `unit_player.tscn` / `unit_ai.tscn`
- **Signals**: `OnTakeDamage`, `OnDie` for loose coupling
- **Groups**: `Unit`, `UnitPlayer` for team queries

## Roadmap

| Phase | Features | Status |
|-------|----------|--------|
| **Phase 0** | Core prototype | ✅ Complete |
| **Phase 1** | Resource management, buildings | Planned |
| **Phase 2** | Unit production, multi-select | Planned |
| **Phase 3** | Fog of war, tech tree | Planned |
| **Phase 4** | Campaign, advanced AI | Planned |
| **Phase 5** | Polish, Steam integration | Planned |

See [ROADMAP.MD](ROADMAP.MD) for detailed development plans.

## Contributing

This is currently a personal project, but feedback and suggestions are welcome!

## License

MIT License - See LICENSE file for details.

## Acknowledgments

- Built with [Godot Engine](https://godotengine.org/)
- Sprite assets from tileset collection

---

**Current Version:** 0.2-alpha (Core Loop Complete)
**Last Updated:** December 29, 2025

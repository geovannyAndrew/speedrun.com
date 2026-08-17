# speedrun.com

An unofficial Flutter application for [speedrun.com](https://www.speedrun.com) — browse verified speedruns, games, and players.

## Features

- **Runs feed** — latest verified runs across all games, with pull-to-refresh and infinite scroll
- **Games browser** — grid view of games with search, filtered by name
- **Users directory** — list of speedrun.com users with search
- **Run detail** — category, time, player info, and links to YouTube/Twitch videos
- **Game detail** — tabs per category showing runs for that category
- **User profile** — player info with their submitted runs
- **Offline caching** — first page of runs/games/users saved to local storage for faster startup

## Screenshots

| Runs | Game Detail | Run Detail |
|------|-------------|------------|
| `assets/images/` | `assets/images/` | `assets/images/` |

## Tech Stack

- Flutter (Dart SDK >=2.0.0-dev.68.0 <3.0.0)
- [speedrun.com API v1](https://github.com/speedruncomorg/api)
- [freezed](https://pub.dev/packages/freezed) + `json_serializable` for model codegen
- [loadmore](loadmore/) — local package for ListView pagination

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run code generation (freezed models)
flutter pub run build_runner build

# Run the app
flutter run
```

## Project Structure

```
lib/
├── config/          # App-wide constants (items per page, placeholder assets)
├── logic/           # Data models (Game, Run, User, Category, etc.)
├── network/         # REST API client (RestAPI singleton)
├── screens/         # Full-screen pages (home, detail_game, detail_run, detail_user)
├── view_items/      # Reusable list/grid item widgets
├── views/           # Composite UI components (app bars, search view)
├── utils/           # Colors, dialogs, storage, helpers
├── main.dart        # App entry point, routes, theme
```

## API Reference

- API base: `https://www.speedrun.com/api/v1/`
- Full docs: `docs/DocumentationAPI.txt`
- Postman collection: `docs/speedrun.com.postman_collection.json`

## Testing

```bash
flutter test
```

> Note: The default test in `test/widget_test.dart` is the Flutter template counter test and has not been updated for this app.

## License

See individual packages (`loadmore/LICENSE`) for the license.

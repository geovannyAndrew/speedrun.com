# AGENTS.md

## Project Overview

Flutter app for speedrun.com (unofficial). Browse verified speedruns, games, and players from the speedrun.com REST API v1.

## Local Packages

- `flutter_youtube/` — YouTube playback plugin (path dependency)
- `loadmore/` — ListView pagination widget (path dependency)

## Development Commands

```bash
flutter pub get                          # Install dependencies
flutter pub run build_runner build       # Regenerate freezed/json_serializable code
flutter analyze                          # Run linter (uses `lint` package)
flutter test                             # Run tests
```

## Architecture

```
lib/
├── config/          # AppConfig: itemsPerPage=50, placeholder image paths
├── logic/           # Data models — Game, Run, User, Category, Times, Asset, etc.
│   ├── *.freezed.dart   # GENERATED — do not edit by hand
│   └── *.g.dart         # GENERATED — do not edit by hand
├── network/         # RestAPI singleton wrapping speedrun.com API v1
├── screens/         # Full pages: splash → home (bottom nav) → detail screens
├── view_items/      # Individual list/grid item widgets
├── views/           # Reusable composite widgets (app bars, search bar)
├── utils/           # Colors, dialogs, storage (file-based cache)
└── main.dart        # Entry point, routes, theme
```

## Navigation Flow

```
SplashScreen (2s) → HomeScreen (bottom nav: Runs | Games | Users)
  ├─ RunsNavigationScreen   → RunDetailScreen → GameDetailScreen / UserDetailScreen
  ├─ GamesNavigationScreen  → GameDetailScreen (tabbed by category) → RunDetailScreen
  └─ UsersNavigationScreen  → UserDetailScreen → RunDetailScreen
```

## Key Patterns

- **API client**: `RestAPI` is a singleton (`RestAPI.instance`). All methods use callback-based `onSuccess`/`onError` pattern.
- **Codegen**: Models in `lib/logic/` use `freezed` + `json_serializable`. After editing a model, run `flutter pub run build_runner build`. Generated files are `*.freezed.dart` and `*.g.dart`.
- **Offline cache**: `lib/utils/storage.dart` saves first page of runs/games/users to app documents directory via `path_provider`. Data is loaded from cache on startup, then refreshed from API.
- **Pagination**: Runs and users use `LoadMore` widget. Games use manual `ScrollController` listener with a 500px threshold.
- **YouTube integration**: `detail_run_screen.dart` imports `flutter_youtube` and `internal/keys.dart` (contains `API_KEY_YOUTUBE` — not in repo, must be provided).
- **Linting**: Uses `lint` package (not `flutter_lints`). Analysis rules in `analysis_options.yaml` include `parameter_assignments` and `missing_required_param` as errors.

## Gotchas

- SDK constraint is very old: `>=2.0.0-dev.68.0 <3.0.0` — pre-null-safety Dart.
- `internal/keys.dart` is imported but not in the repo — required for YouTube API key.
- The default `test/widget_test.dart` is the Flutter template test; it does not test this app.
- `flutter_youtube` and `loadmore` are pinned to Flutter `<2.0.0` — may not work with modern Flutter.

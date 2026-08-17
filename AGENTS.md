# AGENTS.md

## Project Overview

Flutter app for speedrun.com (unofficial). Browse verified speedruns, games, and players from the speedrun.com REST API v1.

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

- **API client**: `RestAPI` is injected via Riverpod providers. All methods return typed `Future` results.
- **Codegen**: Models in `lib/logic/` use `freezed` + `json_serializable`. After editing a model, run `flutter pub run build_runner build`. Generated files are `*.freezed.dart` and `*.g.dart`.
- **Offline cache**: `CacheStore` abstraction in `lib/data/cache_store.dart` with `FileCacheStore` implementation. SpeedrunRepository handles cache policy.
- **Pagination**: Runs and users use `LoadMore` widget. Games use manual `ScrollController` listener with a 500px threshold.
- **Linting**: Uses `lint` package (not `flutter_lints`). Analysis rules in `analysis_options.yaml` include `parameter_assignments` and `missing_required_param` as errors.

## Gotchas

- SDK constraint is very old: `>=2.0.0-dev.68.0 <3.0.0` — pre-null-safety Dart.
- The default `test/widget_test.dart` is the Flutter template test; it does not test this app.

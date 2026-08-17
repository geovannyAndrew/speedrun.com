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

| | | | |
|---|---|---|---|
| ![Screenshot_1786936055](https://github.com/user-attachments/assets/7f09301d-6416-415d-b45d-374a13b1b183) | ![Screenshot_1786936049](https://github.com/user-attachments/assets/44f82185-e3e2-445d-9ac4-521e5fc44c6b) | ![Screenshot_1786936042](https://github.com/user-attachments/assets/2ae8c872-8da6-4d1d-be70-a3ce720b1e18) | ![Screenshot_1786936009](https://github.com/user-attachments/assets/e856ab49-dc76-4577-b207-d10a075fccab) |

## Video

<img width="400" height="894" alt="output" src="https://github.com/user-attachments/assets/27f41e90-f433-4a5e-99af-c644d7d23bb0" />

## Tech Stack

- Flutter (Dart SDK >=2.0.0-dev.68.0 <3.0.0)
- [speedrun.com API v1](https://github.com/speedruncomorg/api)
- [freezed](https://pub.dev/packages/freezed) + `json_serializable` for model codegen
- [loadmore](https://pub.dev/packages/loadmore) — ListView pagination

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

## License

MIT

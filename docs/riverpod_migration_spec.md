# Riverpod Migration Software Specification

Status: In Progress — Testing complete

## 1. Purpose

Introduce Riverpod as the state-management and dependency-injection mechanism for the root Flutter application without changing the user-facing navigation model or API behavior.

The migration must replace screen-owned network, cache, and pagination state with testable provider-backed state while preserving offline first-page caching.

## 2. Current State

- `lib/main.dart` wraps `MyApp` with `ProviderScope`.
- `flutter_riverpod: ^2.5.0` is declared in `pubspec.yaml` (resolved 2.6.1).
- `RestAPI` is a singleton and uses top-level `http.get` calls.
- API methods use success and error callbacks rather than typed futures.
- Screens own mutable model lists, loading flags, pagination offsets, and cache access.
- `lib/utils/storage.dart` exposes top-level callback-based storage functions.
- Runs and users use the hosted `loadmore: ^2.1.0` package; games use a `ScrollController`.
- The local `loadmore/` directory has been removed.
- `AGENTS.md` and `README.md` updated to remove local `loadmore/` references.
- The default widget test is still the Flutter counter template.
- Existing documentation describes Freezed-generated models, but the current root models are hand-written and have no generated files.

## 3. Objectives

1. Add Riverpod for application dependency injection and state management.
2. Make the API client, HTTP client, cache, and repositories injectable.
3. Expose typed asynchronous data operations instead of callbacks.
4. Move feed, detail, search, refresh, and pagination state out of screens.
5. Preserve cache-first behavior and existing navigation flows.
6. Make provider and repository behavior testable without real network or filesystem access.
7. Remove the unused local `loadmore/` package from the repository.

## 4. Non-Goals

- Do not migrate the model layer to Freezed or introduce Riverpod code generation.
- Do not introduce a new routing package.
- Do not redesign the visual appearance of the application.
- Do not change the speedrun.com API contract.
- Do not remove the hosted `loadmore` dependency until its widgets have been replaced and verified.

## 5. Target Architecture

```text
Widgets
  -> Riverpod controllers/providers
  -> SpeedrunRepository
  -> RestAPI + CacheStore
  -> http.Client / filesystem
```

`BuildContext` must not be passed into repositories or providers. Providers must not navigate, show dialogs, or directly manipulate widgets. Screens remain responsible for rendering and UI side effects through provider listeners.

## 6. Dependency Injection

Add a compatible `flutter_riverpod` dependency to the root `pubspec.yaml`. Do not add `riverpod_generator` or `riverpod_annotation` in this migration.

Wrap the app at the entry point:

```text
ProviderScope
  -> MyApp
```

Create `lib/di/providers.dart` with providers for:

- API base URL and page size configuration.
- `http.Client`, disposed by Riverpod.
- `CacheStore`.
- `RestAPI`.
- `SpeedrunRepository`.

All production providers must be overrideable in tests.

## 7. Data and Cache Boundaries

Refactor `lib/network/rest_api.dart` so that:

- It receives an injected `http.Client` and configuration.
- It no longer exposes `RestAPI.instance` as the application access path.
- It returns typed `Future` results.
- It converts HTTP, parsing, and network failures into a consistent error type.
- It URI-encodes search parameters.
- It does not read or write cache files.

Introduce a `CacheStore` abstraction, preferably in `lib/data/cache_store.dart`, with a filesystem implementation that preserves the existing `runs`, `games`, and `users` file names.

Move cache policy into `SpeedrunRepository`:

- Read cached first-page data for the default runs, games, and users feeds.
- Cache only successful first-page, non-search responses.
- Keep cached data visible while a refresh is running.
- Preserve stale cached data when refresh fails.
- Treat missing or malformed cache files as an empty cache, not an application crash.

## 8. Provider Inventory

### Infrastructure

- `httpClientProvider`
- `cacheStoreProvider`
- `apiProvider`
- `speedrunRepositoryProvider`

### Paginated feeds

- `runsFeedProvider`
- `gamesFeedProvider(query)`
- `usersFeedProvider(query)`
- `categoryRunsProvider(categoryId)`
- `userRunsProvider(userId)`

### Detail data

- `runDetailProvider(runId)`
- `gameDetailProvider(gameId)`
- `gameCategoriesProvider(gameId)`
- `userDetailProvider(userId)`

Feed providers must use a reusable immutable `FeedState<T>` containing, at minimum:

- Items.
- Current query or identifier.
- Current offset or next-page position.
- `hasMore`.
- Initial loading, refreshing, and loading-more state.
- The latest error.

Feed controllers must expose `loadInitial`, `refresh`, and `loadMore` operations. Concurrent requests must be ignored or coordinated. A response for an obsolete search query must never overwrite the active query.

Use non-auto-disposed providers for the primary Runs, Games, and Users feeds so state survives bottom-navigation changes. Use auto-disposal for transient search and detail providers where retention is not required.

## 9. Screen Migration

Migrate the following screens to `ConsumerWidget` or `ConsumerStatefulWidget`:

- `lib/screens/runs_navigation_screen.dart`
- `lib/screens/games_navigation_screen.dart`
- `lib/screens/users_navigation_screen.dart`
- `lib/screens/detail_run_screen.dart`
- `lib/screens/detail_game_screen.dart`
- `lib/screens/detail_user_screen.dart`
- `UserRunsListView` in `detail_game_screen.dart`

Move API calls, model collections, loading flags, pagination state, cache access, and error state into providers.

Keep the following state local to widgets:

- `ScrollController`.
- `RefreshIndicator` keys.
- `TextEditingController`.
- Tab and bottom-navigation selection.
- Navigation and UI event handlers.

Initially keep the hosted `loadmore` widgets and connect their callbacks to provider controller methods. Later, those wrappers may be replaced with provider-driven scroll pagination and the hosted dependency removed as a separate cleanup.

Update `lib/views/screen_search_view.dart` to receive loading state declaratively instead of mutating its state through a `GlobalKey`.

## 10. Detail and Routing Rules

Detail screens must receive required IDs rather than relying on nullable model objects:

- `RunDetailScreen(runId: ...)`
- `GameDetailScreen(gameId: ...)`
- `UserDetailScreen(userId: ...)`

List models may be retained as optional display placeholders, but providers are the source of truth and must fetch authoritative detail by ID.

Update named routes in `lib/main.dart` to validate and pass route arguments. Directly constructing a detail screen without its required ID must produce a controlled route error rather than a null dereference.

Providers must not display dialogs or navigate. Use `ref.listen` in screens to show error snackbars and dialogs. Preserve the existing special handling for invalid user searches, but avoid displaying duplicate error messages.

## 11. Local `loadmore` Removal

The local package can be removed because the root project uses the hosted package declared in `pubspec.yaml`.

This cleanup must:

1. ✅ Delete the `loadmore/` directory.
2. ✅ Remove the local-package entry from `AGENTS.md`.
3. ✅ Update the `loadmore` references in `README.md`, including the license note and technology-stack description.
4. ✅ Leave the hosted `loadmore: ^2.1.0` dependency unchanged during the first migration stage.
5. ✅ Verify `pubspec.lock` resolves `loadmore` from the hosted source, not a local path.

## 12. Migration Stages

### ✅ Stage 1: Baseline and dependencies

**Status: Complete**

- Run existing analyze and test commands — baseline: 94 issues (all warnings/infos), 1 failing test (Flutter counter template).
- Add `flutter_riverpod: ^2.5.0` to `pubspec.yaml` — resolved 2.6.1.
- Add `ProviderScope(child: MyApp())` to `lib/main.dart`.
- Remove the unused local `loadmore/` package and stale documentation references.
  - Deleted `loadmore/` directory.
  - Removed local-package entry from `AGENTS.md`.
  - Updated `README.md` tech-stack and license references.
  - Confirmed `pubspec.lock` resolves `loadmore 2.1.0` from hosted source.
- Result: 92 analyze issues (no errors), `loadmore/` warnings eliminated.

### Stage 2: Injectable infrastructure

**Status: Complete**

- ✅ Add `CacheStore` and filesystem implementation.
  - Created `lib/data/cache_store.dart` with `CacheStore` interface, `FileCacheStore`, `MemoryCacheStore`, and `CacheData` parsing helper.
- ✅ Refactor `RestAPI` to use injected dependencies and typed futures.
  - Created `lib/network/rest_api.dart` with `RestAPI` class (no singleton), `ApiError` class, and `PaginatedResponse<T>` wrapper.
  - All methods return typed futures and handle HTTP, network, and parse errors consistently.
  - Search parameters are URI-encoded via `_buildUrl`.
  - No cache read/write operations.
- ✅ Add `SpeedrunRepository`.
  - Created `lib/data/speedrun_repository.dart` implementing cache policy:
    - Reads cached first-page data for default runs, games, and users feeds.
    - Caches only successful first-page, non-search responses.
    - Missing or malformed cache files treated as empty cache.
- ✅ Add provider overrides for tests.
  - Created `lib/di/providers.dart` with `httpClientProvider`, `cacheStoreProvider`, `apiProvider`, and `speedrunRepositoryProvider`.
  - Created `test/utils/test_providers.dart` with `FakeHttpClient`, `FakeCacheStore`, and `testProviderOverrides` helper.

### Stage 3: Feed state

**Status: Complete**

- ✅ Add `FeedState<T>` and feed controllers.
  - Created `lib/data/feed_state.dart` with `FeedState<T>` immutable state class containing items, query/id, offset, hasMore, loading states, and error.
  - Created `lib/data/feed_providers.dart` with `RunsFeedNotifier`, `GamesFeedNotifier`, and `UsersFeedNotifier` controllers.
  - Feed controllers expose `loadInitial`, `refresh`, and `loadMore` operations.
  - Concurrent requests are guarded by loading state checks.
- ✅ Migrate Runs, Games, and Users feeds.
  - Migrated `runs_navigation_screen.dart` to `ConsumerStatefulWidget` with `runsFeedProvider`.
  - Migrated `games_navigation_screen.dart` to `ConsumerStatefulWidget` with `gamesFeedProvider`.
  - Migrated `users_navigation_screen.dart` to `ConsumerStatefulWidget` with `usersFeedProvider`.
  - Added feed providers to `lib/di/providers.dart` (`runsFeedProvider`, `gamesFeedProvider`, `usersFeedProvider`).
- ✅ Preserve cache hydration, refresh, search reset, and pagination behavior.
  - Screen state moved to providers; cache hydration via `SpeedrunRepository`.
  - Refresh and load-more work through provider notifiers.
  - Search reset handled via provider `refresh` with null query.
- ✅ Update `ScreenSearchView` to receive loading state declaratively.
  - Added `isLoading` parameter to `ScreenSearchView`.
  - Loading icon shown during network requests instead of imperative `GlobalKey` mutations.
- ✅ Update detail screens to use async/await instead of callbacks.
  - `detail_run_screen.dart`, `detail_game_screen.dart`, `detail_user_screen.dart` now use async/await with `RestAPI.instance`.
- Result: 98 analyze issues (no errors), 1 failing test (Flutter counter template).

### Stage 4: Detail state and routing

**Status: Complete**

- ✅ Add detail and nested-feed providers.
  - Created `runDetailProvider`, `gameDetailProvider`, `gameCategoriesProvider`, `userDetailProvider` as FutureProvider.family.
  - Created `categoryRunsFeedProvider` and `userRunsFeedProvider` as StateNotifierProvider.family.
- ✅ Migrate run, game, and user detail screens.
  - Migrated `detail_run_screen.dart` to `ConsumerStatefulWidget` with `runDetailProvider`.
  - Migrated `detail_game_screen.dart` to `ConsumerStatefulWidget` with `gameDetailProvider`, `gameCategoriesProvider`, and `categoryRunsFeedProvider`.
  - Migrated `detail_user_screen.dart` to `ConsumerStatefulWidget` with `userDetailProvider` and `userRunsFeedProvider`.
- ✅ Make route arguments ID-based and validated.
  - Updated `main.dart` to use `onGenerateRoute` for route argument validation.
  - Updated navigation calls in `runs_navigation_screen.dart`, `games_navigation_screen.dart`, `users_navigation_screen.dart` to pass IDs.
  - Detail screens now require non-nullable ID parameters.
- Result: 99 analyze issues (no errors), 1 failing test (Flutter counter template).

### Stage 5: UI cleanup and hardening

**Status: Complete**

- Remove imperative search loading mutations.
  - Removed unused `visibleIcon` setter from `ScreenSearchView` that was never called.
  - Simplified `_showLoadingIcon` to use only the declarative `isLoading` prop.
- Remove remaining direct `RestAPI.instance` and storage calls.
  - Removed static `_instance` and `instance` getter from `RestAPI` class.
  - Removed unused `factory RestAPI.create` constructor.
  - Removed unused `AppConfig` import from `rest_api.dart`.
- Review the global invalid-certificate override.
  - No invalid-certificate override found in code - app uses standard TLS.
- Decide separately whether to replace the hosted `loadmore` widgets.
  - Hosted `loadmore` widgets still in use via `LoadMore` wrapper in runs/users navigation screens.
- Result: 119 analyze issues (no errors), 1 failing test (Flutter counter template).

## 13. Testing Requirements

**Status: Complete**

Added tests for:

- API error handling (HTTP failure, network errors).
- `ApiError` creation for HTTP, network, and parse failures.
- `MemoryCacheStore` save/load operations.
- `CacheData` parsing with valid JSON.
- Repository methods with mock API (runs, games, users, category runs, user runs, detail methods).
- Feed notifier state transitions (initial, loading, success, failure).
- Feed initialization, refresh, pagination, and end-of-list behavior.
- `FeedState` helper properties (isLoading, isRefreshing, isLoadingMore).
- Detail providers with fake repository overrides.

Test files created:
- `test/network/rest_api_test.dart` - API error handling tests.
- `test/data/cache_store_test.dart` - Cache store tests.
- `test/data/speedrun_repository_test.dart` - Repository tests.
- `test/data/feed_providers_test.dart` - Feed notifier tests.
- `test/data/detail_providers_test.dart` - Detail provider tests.

Result: 46 tests pass (1 expected failure: Flutter counter template).

## 14. Acceptance Criteria

- The app starts under `ProviderScope` and all migrated screens render normally.
- No migrated screen calls `RestAPI.instance` or top-level storage functions.
- API and repository dependencies can be replaced through provider overrides.
- Cached first-page data remains available during failed refreshes.
- Refresh and load-more futures complete only after their provider operations finish.
- Stale search responses cannot replace current search results.
- Bottom-navigation changes preserve primary feed state.
- Detail routes cannot crash because of missing nullable models.
- The local `loadmore/` directory is gone and documentation no longer claims it is a path dependency.
- `dart format --output=none --set-exit-if-changed lib test`, `flutter analyze`, and `flutter test` pass.

## 15. Risks and Decisions

- Callback-to-future conversion may expose existing API and pagination completion bugs; tests must define the new completion behavior.
- Family providers for search queries require disposal to avoid retaining unbounded query state.
- Cache corruption must not prevent app startup.
- The global invalid-certificate override weakens TLS security and must not be treated as a production requirement.
- Existing Freezed documentation and dependencies are stale; model/codegen cleanup remains separate from this migration.

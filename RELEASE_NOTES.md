# Release Notes — feedback-sample-flutter-app

## v0.0.18

### Overview

Sample app aligned with **feedback_flutter_sdk 0.0.18**. Native pin bump only — no Dart API changes.

### Native SDK pins

| Platform | Native SDK |
|----------|------------|
| Android | `co.pisano:feedback` **1.3.33** |
| iOS | `Pisano` pod **1.0.21** |

### What's included (via native SDKs)

- **WebView zoom control** — configurable per channel from Pisano panel (`disable_zoom`)
- **Keyboard and scrolling** — improved bottom sheet behaviour on Android and iOS
- **Bottom sheet display** — scrim/overlay fixes on Android; drag-to-dismiss from previous release preserved

### Migration

1. Update git ref in `pubspec.yaml`: `ref: 0.0.18`
2. Run `flutter pub get`
3. iOS: `cd ios && pod install --repo-update`

No breaking changes. Existing `init()` / `show()` calls work unchanged.

---

## v0.0.17

- **`code` required in `init()`** — pass survey/channel code from Pisano panel
- **`flowId` removed from `show()`** — use optional `code` parameter instead
- Native pins: Android **1.3.28**, iOS **1.0.17**

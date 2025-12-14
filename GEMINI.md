# Context for Gemini Agents

## Project Overview
**Name**: `minvest_forex_app`
**Type**: Flutter Application (Mobile & Web) with Firebase Backend.
**Purpose**: A Forex investment application featuring signals, AI analysis, chat support, and news.

## Technology Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore, Cloud Functions, Storage, Messaging)
- **State Management**: Mixed `flutter_bloc` (Auth) and `provider` (User, Language, Notifications, Chat, Purchase).
- **Cloud Functions**: TypeScript (Node.js 22).
- **Styling**: Google Fonts (`Be Vietnam Pro`), Dark Theme.

## Project Structure
- **`lib/`**: Main application code.
  - **`main.dart`**: Entry point. Initializes Firebase, Services, and Providers.
  - **`app/`**: App-level widgets (`AuthGate`, `MainScreen`).
  - **`features/`**: Feature-based modules (e.g., `auth`, `chat`, `signals`, `notifications`).
  - **`core/`**: Shared providers and services (`UserProvider`, `LanguageProvider`).
  - **`services/`**: Infrastructure services (`NotificationService`, `SessionService`).
  - **`web/`**: Web-specific pages (`LandingPage`, `FeaturesPage`).
- **`functions/`**: Firebase Cloud Functions.
  - **`src/`**: TypeScript source code.
  - **`package.json`**: Backend dependencies.
- **`assets/`**: Images and mockups (use these for UI reference).

## Key Files & Logic
- **`lib/main.dart`**: Sets up `MultiProvider` and `AuthBloc`. Handles global notification navigation (`NotificationService`).
- **`lib/app/auth_gate.dart`**: Controls navigation based on auth state. Handles **Session Resets** (via `UserProvider`) and Web Landing Page redirection.
- **`lib/core/providers/user_provider.dart`**:
  - Manages real-time user data (`subscriptionTier`, `role`, `verificationStatus`).
  - Handles **Session Reset** logic (`requiresSessionReset` flag from Firestore).
- **`functions/src/index.ts`** (Cloud Functions):
  - **`processVerificationImage`**: OCR for Exness account verification (analyzes balance & ID).
  - **`telegramWebhook`**: Parses signals from Telegram bot -> Firestore `signals`.
  - **`verifyPurchase`**: Validates In-App Purchases (iOS/Android) -> Updates user tier to `elite`.
  - **`onNewSignalCreated` / `onSignalUpdated`**: Triggers FCM notifications (localized).
  - **`onNewChatMessage`**: Handles chat notifications between User and Support.
  - **`manageUserSession`**: Enforces single-device login.
  - **`updateUserSubscriptionTier`**: Admin tool to change tiers (triggers forced logout/reset).

## Development & Usage
### Build & Run
- **Flutter**: `flutter run`
- **Dependencies**: `flutter pub get`
- **Functions**: `cd functions && npm install && npm run build`

### Agent Instructions (from AGENTS.md)
1.  **Language**: Communicate in **Vietnamese**. Code in **English**.
2.  **Confirmation**: **ALWAYS** ask for confirmation before changing code or running commands.
3.  **Style**:
    - Respect existing `provider`/`bloc` architecture.
    - Use `const` widgets where possible.
    - Break down large widgets.
4.  **Firebase**:
    - Use Models with `fromJson`/`toJson`.
    - Write secure Firestore rules.
    - Use TypeScript for Cloud Functions.
    - **Cloud Functions Logic**: Be aware of existing logic in `index.ts` (OCR, Telegram parsing, IAP) before modifying.
5.  **Images**: Refer to `assets/` for UI generation/modification.

## Current State
- **Active Features**: Auth, Signals (with Telegram integration), Chat (Support), In-App Purchase (verification logic exists), Exness Verification (OCR).
- **Web**: Distinct Landing Page flow (`lib/web/`).
- **User Tiers**: `free`, `demo`, `vip`, `elite`.

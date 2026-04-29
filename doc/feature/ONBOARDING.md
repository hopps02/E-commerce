# Onboarding Feature

This document describes the introductory experience for new users.

## 1. Feature Overview
The Onboarding flow uses a high-quality visual experience (Gradients + Illustrations) to introduce the user to the app and guide them to the registration/home steps.

## 2. User Flow
1. **Slide 1**: Informational content with immersive background images and glassmorphism-style overlays.
2. **Action**: User can click **"Next"** to continue to the authentication page or click **"Login"** to reach the auth page directly. (Both actions currently mark onboarding as complete).

## 3. Technical Implementation

### Presentation (MVVM)
- **View**: `OnboardingView` (StatefulWidget).
    - Uses a `Stack` to layer `ImageBackground`, `GradientBackground`, and `OnboardingContent`.
    - Implements `pluseAnimation` extensions for smooth entry of text and buttons.
- **ViewModel**: No ViewModel used (logic is managed within the View's state for simplicity).

### Domain / Data
- **Storage**: Uses `StorageService` to persist the completion state.
    - **Key**: `skipped-on-boarding` (Boolean).
    - **Method**: `DI().storageService.setSkippedOnBoarding()` is called before navigation.
- **Content**: Content is currently hardcoded and localized via `Translation` manager.

## 4. Integration Details

### Key Components
- **`ImageBackground`**: Displays the main promotional illustration.
- **`GradientBackground`**: Provides the sleek dark-to-transparent overlay.
- **`OnboardingContent`**: Handles the layout for the title, description, and action buttons.

### Assets & Resources
- **Translations**:
    - `Translation.welcome_to_jar.tr` (Title)
    - `Translation.onboarding_grocery_desc.tr` (Description)
- **Icons**: `Assets.svg.arrowLeftLong.path` (Used in the "Next" button).

---
*Related Docs: [Architecture](../ARCHITECTURE.md) | [Guidelines](../CONTRIBUTING.md)*

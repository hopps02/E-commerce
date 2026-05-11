# CI / CD Guide

This document describes every GitHub Actions workflow in `.github/workflows/`,
what it does, when it runs, and **everything you need to prepare** (accounts,
credentials, repository secrets, signing configuration) before it can succeed.

> Workflows live in `.github/workflows/` and are executed by GitHub-hosted
> runners. They are triggered by `git push` events on specific branches or by
> pull requests. You do not run them manually unless a `workflow_dispatch`
> trigger is added.

---

## Table of contents

1. [Overview of all workflows](#1-overview-of-all-workflows)
2. [How to add GitHub secrets](#2-how-to-add-github-secrets)
3. [`test.yml` — CI tests on every push / PR](#3-testyml--ci-tests-on-every-push--pr)
4. [`release.yml` — APK release on push to `master`](#4-releaseyml--apk-release-on-push-to-master)
5. [`ios-deploy.yml` — iOS deploy to App Store](#5-ios-deployyml--ios-deploy-to-app-store)
6. [`android-deploy.yml` — Android deploy](#6-android-deployyml--android-deploy)
7. [Troubleshooting](#7-troubleshooting)

---

## 1. Overview of all workflows

| File | Trigger | Runner | Purpose | External account required |
|---|---|---|---|---|
| `test.yml` | push / PR on `master`, `develop` | `ubuntu-latest` | Static analysis + unit/widget tests + coverage | None |
| `release.yml` | push on `master` | `ubuntu-latest` | Build release APKs and publish a GitHub Release | None (uses the built-in `GITHUB_TOKEN`) |
| `ios-deploy.yml` | push on `ios-deploy` | `macos-latest` | Build `.ipa` and upload to App Store Connect | **Apple Developer Program** account |
| `android-deploy.yml` | push on `android-deploy` | `ubuntu-latest` | Build release `.aab` + `.apk` and store as artifacts (Play Store upload is opt-in) | **Google Play Console** account *(only if you enable the Play upload step)* |

All four workflows share the same Flutter version (`3.41.6`, stable channel) and
Java 17 for Android.

---

## 2. How to add GitHub secrets

All credentials referenced by the workflows are read from
`${{ secrets.NAME }}` and must be added in:

```
GitHub repo → Settings → Secrets and variables → Actions → New repository secret
```

Never commit credentials, keystores, `.p8`, or service-account JSON files to
the repository. Always store them as secrets and reference them in the YAML.

---

## 3. `test.yml` — CI tests on every push / PR

### What it does

Runs on every push to `master` / `develop` and on every pull request targeting
those branches. The job performs, in order:

1. Checkout the repo.
2. Install Java 17 (Temurin).
3. Install Flutter `3.41.6` with the action cache enabled.
4. `flutter pub get`.
5. `dart run build_runner build --delete-conflicting-outputs` — regenerates
   Retrofit, Freezed, JsonSerializable, and asset accessors. Required because
   generated `*.g.dart` / `*.freezed.dart` files are not committed.
6. `dart format --output=none --set-exit-if-changed .` — fails if any file is
   unformatted (currently `continue-on-error: true` so it only warns; flip it
   off to enforce).
7. `flutter analyze` — static analysis using the rules in `analysis_options.yaml`.
8. `flutter test --coverage` — runs everything under `test/` and writes
   `coverage/lcov.info`.
9. Uploads `coverage/lcov.info` as a workflow artifact (named `coverage`).

### What you need to run it

Nothing. The workflow uses only public actions and the repository's own code.

### Adding new tests

Place files under `test/` following the structure documented in
[`doc/testing/testing_strategy.md`](../testing/testing_strategy.md):

```
test/
├── unit/
│   ├── data/
│   │   ├── network/
│   │   └── repository/
│   ├── domain/usecase/
│   └── presentation/viewmodels/
├── integration/
└── helpers/
```

Anything matching `test/**/*_test.dart` is picked up automatically by
`flutter test`. No workflow change is needed when you add a new test file.

### Enforcing the workflow

In GitHub: **Settings → Branches → Branch protection rules → master** → enable
**Require status checks to pass before merging** and select
`analyze-and-test`. PRs cannot then be merged until the workflow is green.

---

## 4. `release.yml` — APK release on push to `master`

### What it does

Every push to `master` (including merges from PRs) produces a GitHub Release
containing release APKs:

1. Checkout with full git history (needed for release notes).
2. Java 17 + Flutter `3.41.6`.
3. `flutter pub get`.
4. Reads the `version:` field from `pubspec.yaml` and computes the release tag
   `v<pubspec-version>-<short-sha>` (for example, `v1.0.0-ddd38af`).
5. `flutter build apk --release --split-per-abi` — builds three smaller
   per-ABI APKs (`armeabi-v7a`, `arm64-v8a`, `x86_64`).
6. `flutter build apk --release` — builds a universal APK that runs on any ABI
   (larger file size).
7. Creates a GitHub Release using
   [`softprops/action-gh-release`](https://github.com/softprops/action-gh-release):
   tag = the computed tag, name = the same, body = auto-generated notes from
   commits since the last release, attached files = the four APKs above.

### What you need to run it

- **`GITHUB_TOKEN`** — provided automatically by GitHub Actions. No setup.
- **`permissions: contents: write`** is already declared in the workflow so the
  token can create releases and tags.
- Make sure **Settings → Actions → General → Workflow permissions** is set to
  **Read and write permissions** (or that the explicit `permissions:` block we
  declare is honored — which it is by default on most repos).

### Important: signing

The Android module currently signs release builds with the **debug** keystore
(`android/app/build.gradle.kts` → `signingConfig = signingConfigs.getByName("debug")`).
This is fine for:

- Sideloading APKs onto test devices.
- Sharing builds with QA / stakeholders via the GitHub Release page.

It is **not acceptable for the Play Store** — Play rejects debug-signed APKs.
Before shipping to Play, do the [Android signing setup](#prepare-an-upload-keystore).

### Versioning recommendation

The tag is derived from `pubspec.yaml`'s `version:`. Bump it (e.g.
`1.0.0+1` → `1.1.0+2`) before merging to `master` so the new release has a
unique, meaningful tag.

---

## 5. `ios-deploy.yml` — iOS deploy to App Store

### What it does

On every push to the `ios-deploy` branch:

1. Checkout on a macOS runner (`macos-latest`).
2. Set up Ruby 3.2 with bundler cache.
3. Install fastlane.
4. Install Flutter `3.41.6`.
5. `flutter pub get`.
6. `flutter build ipa --release` — produces `build/ios/ipa/*.ipa`.
7. Run fastlane lane `release` (defined in `fastlane/Fastfile`) which:
   - Authenticates to App Store Connect using the **App Store Connect API key**.
   - Calls `deliver` to upload the IPA, skipping screenshots and metadata.

### What you need to prepare

#### 5.1 Apple Developer Program enrollment

You need an **active paid Apple Developer Program membership** ($99/year).
Without it you cannot distribute via the App Store.

Sign up at https://developer.apple.com/programs/.

#### 5.2 An app record in App Store Connect

1. Go to https://appstoreconnect.apple.com → **My Apps → +** → **New App**.
2. Bundle ID must match the one in the iOS project — currently
   `com.azsystem.fouru` (see `fastlane/Appfile`). The bundle ID must first be
   registered in https://developer.apple.com/account/resources/identifiers/list.
3. Note your **Team ID** (Developer Portal → Membership) and
   **App Store Connect Team ID** (Users and Access → top-right). Update
   `fastlane/Appfile` so these are no longer placeholder values:

   ```ruby
   # fastlane/Appfile
   app_identifier "com.azsystem.fouru"
   apple_id "you@yourcompany.com"
   itc_team_id "<your App Store Connect team id>"
   team_id    "<your Developer Portal team id>"
   ```

#### 5.3 Code signing certificate + provisioning profile

For App Store distribution you need:

- An **Apple Distribution** certificate (`.p12`).
- An **App Store** provisioning profile bound to the bundle ID
  `com.azsystem.fouru`.

Two ways to manage these on CI:

1. **fastlane match (recommended)** — stores certificates and profiles
   encrypted in a private git repository or S3 bucket. Add a `Matchfile` and
   a `match` step before `build ipa`.
2. **Manual** — generate the cert + profile from
   https://developer.apple.com/account/resources, install them on the runner
   with `apple-actions/import-codesign-certs`, and point Xcode at them via
   `ExportOptions.plist`.

The current `Fastfile` doesn't include the signing step — it assumes the IPA
is already signable in the runner's keychain. Add a `match(type: "appstore")`
call (or the manual equivalent) inside the `release` lane before `deliver` so
the runner has a usable signing identity.

#### 5.4 App Store Connect API key

The workflow authenticates with an **App Store Connect API key**, not an
Apple ID + password. To create one:

1. Go to https://appstoreconnect.apple.com → **Users and Access → Integrations
   → App Store Connect API**.
2. Click **Generate API Key**. Name it (e.g. "CI Deploy"). Access role:
   **App Manager** is sufficient.
3. After creation you receive:
   - **Key ID** — short string, e.g. `ABC123XYZ4`.
   - **Issuer ID** — the UUID at the top of the page.
   - **`AuthKey_<KEY_ID>.p8`** file — **download immediately**, it can only be
     downloaded once.

#### 5.5 GitHub secrets

Add the following three secrets to the repo:

| Secret | Value |
|---|---|
| `APPSTORE_KEY_ID` | The Key ID (e.g. `ABC123XYZ4`). |
| `APPSTORE_ISSUER_ID` | The Issuer ID (UUID). |
| `APPSTORE_P8` | The **entire contents** of `AuthKey_<KEY_ID>.p8`, including the `-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----` lines. Paste it as-is; GitHub secrets preserve newlines. |

For signing (if using fastlane match) you will also need:

| Secret | Value |
|---|---|
| `MATCH_PASSWORD` | The passphrase that decrypts the match repo. |
| `MATCH_GIT_BASIC_AUTHORIZATION` | A base64 `user:token` string with read access to the match git repo. |

#### 5.6 Triggering a deploy

```powershell
git checkout -b ios-deploy
git merge master
git push -u origin ios-deploy
```

The workflow runs on every subsequent push to `ios-deploy`. Each run uploads
a new build to App Store Connect — Apple's `CFBundleVersion`
(`pubspec.yaml` → number after the `+`) must be **strictly higher** than the
previous upload, otherwise the upload is rejected.

---

## 6. `android-deploy.yml` — Android deploy

### What it does

On every push to `android-deploy`:

1. Checkout on `ubuntu-latest`.
2. Java 17 + Flutter `3.41.6`.
3. `flutter pub get`.
4. `flutter build appbundle --release` → `build/app/outputs/bundle/release/*.aab`.
5. `flutter build apk --release` → `build/app/outputs/flutter-apk/*.apk`.
6. Uploads both as workflow artifacts (`app-release-aab`, `app-release-apk`).

There is a **commented-out fastlane block** at the bottom of the file for
uploading the AAB to Google Play. It is intentionally disabled until the
Play-specific prerequisites below are in place.

### What you need to prepare

#### 6.1 Build a signed release (required even just for an artifact)

The Play Store will reject the AAB until it's signed with an **upload key**.
For artifacts you'll sideload, debug signing is enough — but to ship to Play
you must:

##### Prepare an upload keystore

1. Generate the keystore locally:

   ```powershell
   keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 `
     -validity 10000 -alias upload
   ```

   Remember the **keystore password**, **key alias**, and **key password**.

2. Create `android/key.properties` (already gitignored by Flutter's template
   — verify yours ignores it):

   ```properties
   storePassword=<keystore password>
   keyPassword=<key password>
   keyAlias=upload
   storeFile=upload-keystore.jks
   ```

3. Edit `android/app/build.gradle.kts` to read `key.properties` and define a
   `release` signing config (replace the current debug-keys workaround):

   ```kotlin
   import java.util.Properties
   import java.io.FileInputStream

   val keystoreProperties = Properties().apply {
       val f = rootProject.file("key.properties")
       if (f.exists()) load(FileInputStream(f))
   }

   android {
       signingConfigs {
           create("release") {
               keyAlias = keystoreProperties["keyAlias"] as String?
               keyPassword = keystoreProperties["keyPassword"] as String?
               storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
               storePassword = keystoreProperties["storePassword"] as String?
           }
       }
       buildTypes {
           release {
               signingConfig = signingConfigs.getByName("release")
           }
       }
   }
   ```

##### Make the keystore available on the runner

The keystore is binary, so base64-encode it and store the result as a secret:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks")) `
  | Set-Content upload-keystore.b64
```

Add these GitHub secrets:

| Secret | Value |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | Contents of `upload-keystore.b64`. |
| `ANDROID_KEYSTORE_PASSWORD` | `storePassword`. |
| `ANDROID_KEY_PASSWORD` | `keyPassword`. |
| `ANDROID_KEY_ALIAS` | `upload` (or whatever alias you used). |

Then add a step to `android-deploy.yml` (before the build steps) that
materializes the keystore + `key.properties` on disk:

```yaml
- name: Decode keystore
  run: |
    echo "${{ secrets.ANDROID_KEYSTORE_BASE64 }}" | base64 --decode > android/app/upload-keystore.jks
    cat <<EOF > android/key.properties
    storePassword=${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
    keyPassword=${{ secrets.ANDROID_KEY_PASSWORD }}
    keyAlias=${{ secrets.ANDROID_KEY_ALIAS }}
    storeFile=upload-keystore.jks
    EOF
```

#### 6.2 Google Play Console enrollment (only for Play upload)

If you want the workflow to push to Google Play (the commented-out fastlane
step), you also need:

1. A **Google Play Console** developer account ($25 one-time fee).
2. An **app record** created in the console with the same `applicationId`
   currently configured in `android/app/build.gradle.kts`
   (`com.azsystem.fouru`). The **first** release must be uploaded manually
   through the Play Console UI — fastlane `supply` can only update existing
   tracks, not create the very first version.
3. A **service account** with API access:
   - Google Cloud Console → IAM & Admin → Service Accounts → Create.
   - Generate a JSON key — download it.
   - Play Console → Setup → API access → link the service account → grant
     **Release manager** (or **Release apps to testing tracks only** if you
     prefer least-privilege).
4. Store the entire JSON contents as a secret named `PLAY_STORE_JSON_KEY`.

#### 6.3 Add a fastlane Android setup

Create `android/fastlane/Fastfile`:

```ruby
default_platform(:android)

platform :android do
  desc "Upload AAB to Play Store internal track"
  lane :release do
    File.write("play_key.json", ENV["PLAY_STORE_JSON_KEY"])
    upload_to_play_store(
      package_name: "com.azsystem.fouru",
      track: "internal",
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      json_key: "android/fastlane/play_key.json",
      skip_upload_metadata: true,
      skip_upload_changelogs: true,
      skip_upload_images: true,
      skip_upload_screenshots: true
    )
  end
end
```

And an `android/Gemfile`:

```ruby
source "https://rubygems.org"
gem "fastlane"
```

Then **uncomment** the fastlane block in `.github/workflows/android-deploy.yml`.

#### 6.4 Triggering a deploy

```powershell
git checkout -b android-deploy
git merge master
git push -u origin android-deploy
```

---

## 7. Troubleshooting

### General

- **Workflow doesn't trigger** → check the branch name exactly matches one of
  the `branches:` entries; GitHub Actions does **not** trigger on tag pushes
  unless explicitly configured.
- **"Resource not accessible by integration"** when creating a release →
  `permissions: contents: write` is missing, or **Settings → Actions →
  General → Workflow permissions** is set to read-only.

### iOS

- **`Invalid Provisioning Profile`** → the runner has no matching signing
  identity. Add a fastlane `match` step (or `apple-actions/import-codesign-certs`)
  before `flutter build ipa`.
- **`This bundle is invalid. The value for key CFBundleVersion must be a
  higher number than the previously uploaded version`** → bump
  `pubspec.yaml`'s build number (the value after `+`).
- **fastlane `deliver` fails with 401** → the `.p8` content in `APPSTORE_P8`
  is malformed. The secret must contain the literal `-----BEGIN PRIVATE
  KEY-----` and `-----END PRIVATE KEY-----` lines plus the base64 between
  them. Don't paste it base64-encoded as a single line.

### Android

- **`Keystore file 'upload-keystore.jks' not found`** in the workflow → the
  decode step didn't run, or the path in `key.properties` doesn't match where
  you wrote the file. The path is relative to `android/app/`.
- **Play Console "Version code N has already been used"** → bump
  `pubspec.yaml`'s build number. Play uses `versionCode` from
  `android/app/build.gradle.kts`, which Flutter fills in from `pubspec.yaml`.
- **`supply` complains "Package not found"** → either the `applicationId`
  doesn't match Play, or you haven't uploaded the first version through the
  Play Console UI yet.

### Tests

- **`flutter analyze` fails on generated files** → run `build_runner build`
  locally with `--delete-conflicting-outputs` and commit nothing under
  `lib/**/*.g.dart` (these are regenerated by the workflow). Make sure your
  `.gitignore` covers generated files.
- **`No tests were found`** → fine, exit code is still 0. The job will pass.

---

## Quick reference: secrets summary

| Secret | Workflow | Required? |
|---|---|---|
| `APPSTORE_KEY_ID` | `ios-deploy.yml` | Yes |
| `APPSTORE_ISSUER_ID` | `ios-deploy.yml` | Yes |
| `APPSTORE_P8` | `ios-deploy.yml` | Yes |
| `MATCH_PASSWORD` | `ios-deploy.yml` | Only if using fastlane match |
| `MATCH_GIT_BASIC_AUTHORIZATION` | `ios-deploy.yml` | Only if using fastlane match |
| `ANDROID_KEYSTORE_BASE64` | `android-deploy.yml`, `release.yml` | Only when releasing to Play / signed APK |
| `ANDROID_KEYSTORE_PASSWORD` | same | same |
| `ANDROID_KEY_PASSWORD` | same | same |
| `ANDROID_KEY_ALIAS` | same | same |
| `PLAY_STORE_JSON_KEY` | `android-deploy.yml` | Only if uploading to Play |
| `GITHUB_TOKEN` | `release.yml` | Provided automatically |

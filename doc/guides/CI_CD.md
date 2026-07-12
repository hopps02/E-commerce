# CI / CD Guide

This document describes every GitHub Actions workflow in `.github/workflows/`,
what it does, when it runs, and **everything you need to prepare** (accounts,
credentials, repository secrets, signing configuration) before it can succeed.

> Workflows live in `.github/workflows/` and are executed by GitHub-hosted
> runners. They are triggered by `git push` events on specific branches. You
> do not run them manually unless a `workflow_dispatch` trigger is added.

---

## Table of contents

1. [Overview of all workflows](#1-overview-of-all-workflows)
2. [How to add GitHub secrets](#2-how-to-add-github-secrets)
3. [`ci.yml` — tests + APK release on push to `master`](#3-ciyml--tests--apk-release-on-push-to-master)
4. [`ios-deploy.yml` — iOS deploy to App Store](#4-ios-deployyml--ios-deploy-to-app-store)
5. [`android-deploy.yml` — Android deploy to Play Store](#5-android-deployyml--android-deploy-to-play-store)
6. [Troubleshooting](#6-troubleshooting)
7. [Quick reference: secrets summary](#7-quick-reference-secrets-summary)

---

## 1. Overview of all workflows

| File | Trigger | Runner | Purpose | External account required |
|---|---|---|---|---|
| `ci.yml` | push on `master` | `ubuntu-latest` | Code-gen + format check + tests + coverage, then build release APKs, publish a GitHub Release, prune old releases, and email recipients | None (uses the built-in `GITHUB_TOKEN`) |
| `ios-deploy.yml` | push on `ios-deploy` | `macos-latest` | Build `.ipa` and upload to App Store Connect via fastlane | **Apple Developer Program** account |
| `android-deploy.yml` | push on `android-deploy` | `ubuntu-latest` | Build release `.aab` + `.apk`, store as artifacts, and upload the AAB to the Play Store **internal** track via fastlane | **Google Play Console** account |

All workflows share the same Flutter version (`3.41.6`, stable channel) and
Java 17 for Android.

> **Note:** the previous split between `test.yml` and `release.yml` has been
> collapsed into a single `ci.yml`. Test and release steps run in one job on
> every push to `master`. The release-only steps are gated by a
> `github.ref == 'refs/heads/master'` condition.

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

## 3. `ci.yml` — tests + APK release on push to `master`

### What it does

Runs on every push to `master`. The single `ci` job performs, in order:

1. Checkout the repo with full history (`fetch-depth: 0`).
2. Install Java 17 (Temurin).
3. Install Flutter `3.41.6` with the action cache enabled.
4. `flutter pub get`.
5. `dart run build_runner build --delete-conflicting-outputs` — regenerates
   Retrofit, Freezed, JsonSerializable, and asset accessors. Required because
   generated `*.g.dart` / `*.freezed.dart` files are not committed.
6. `dart format --output=none --set-exit-if-changed .` — fails if any file is
   unformatted (currently `continue-on-error: true` so it only warns; flip it
   off to enforce).
7. `flutter test --coverage` — runs everything under `test/` and writes
   `coverage/lcov.info`.
8. Uploads `coverage/lcov.info` as a workflow artifact (named `coverage`).
   This step always runs (`if: always()`), so the artifact is available even
   if tests fail.

The remaining steps are **release steps**. They are guarded by
`if: github.event_name == 'push' && github.ref == 'refs/heads/master'` so they
only run on direct pushes to `master`:

9. Read the `version:` field from `pubspec.yaml` and compute the release tag
   `v<pubspec-version-without-build-number>-<short-sha>` (for example,
   `v1.0.0-ddd38af`). Because the short SHA is part of the tag, every commit
   produces a **unique** tag — you never collide with an existing release
   even if `pubspec.yaml`'s version field is unchanged.
10. `flutter build apk --release --split-per-abi` — builds three smaller
    per-ABI APKs (`armeabi-v7a`, `arm64-v8a`, `x86_64`).
11. `flutter build apk --release` — builds a universal APK that runs on any
    ABI (larger file size).
12. Creates a GitHub Release using
    [`softprops/action-gh-release`](https://github.com/softprops/action-gh-release):
    tag = the computed tag, name = `Release <tag>`, attached files = the four
    APKs above. Release notes are not auto-generated.
13. **Retention cleanup** — lists all releases, keeps the **2 most recent**,
    and deletes the rest along with their git tags using
    `gh release delete --cleanup-tag`. So the Releases page always shows at
    most two entries.
14. **Email notification** — sends an HTML email via Gmail SMTP using
    [`dawidd6/action-send-mail`](https://github.com/dawidd6/action-send-mail).
    The email contains the tag, version, commit, and a clickable link to the
    GitHub Release page (the APKs are **not attached** because they typically
    exceed Gmail's 25 MB attachment limit).

> **Note:** there is currently no separate `flutter analyze` step. If you
> want lint enforcement on every push, add a step after `flutter pub get` that
> runs `flutter analyze`.

### What you need to run it

- **`GITHUB_TOKEN`** — provided automatically by GitHub Actions. No setup.
- **`permissions: contents: write`** is already declared at the workflow
  level so the token can create releases, delete old releases, and delete
  tags.
- Make sure **Settings → Actions → General → Workflow permissions** is set to
  **Read and write permissions** (or that the explicit `permissions:` block
  we declare is honored — which it is by default on most repos).

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

### Email notification setup

The "Send release email" step needs Gmail SMTP credentials. Gmail requires an
**App Password** — your normal Google account password will not work and will
be rejected by SMTP.

1. Enable **2-Step Verification** on the Google account that will send the
   emails: https://myaccount.google.com/security.
2. Open https://myaccount.google.com/apppasswords → generate a new app
   password (any name, e.g. `GitHub Actions`). Google shows a 16-character
   password **once** — copy it immediately.
3. Add the following GitHub secrets:

   | Secret | Value |
   |---|---|
   | `MAIL_USERNAME` | The Gmail address sending the email (e.g. `you@gmail.com`). |
   | `MAIL_PASSWORD` | The 16-character app password from step 2. **Not** your account password. |
   | `MAIL_TO` | Recipient list. Use a **comma-separated** list to email multiple people, e.g. `alice@example.com,bob@example.com,carol@example.com`. |

If you want to skip the email step entirely, delete or comment out the
`Send release email` step in `ci.yml`. The test/build/release/cleanup steps
work independently of it.

### Retention behaviour

The cleanup step keeps **the 2 most recent releases**, sorted by creation
date. Older releases — and their git tags — are deleted. To change the
retention count, edit the `.[2:]` slice in the `Keep only the latest 2
releases` step (e.g. `.[5:]` to keep the most recent 5).

If you ever need to bring an old release back, you'll have to rebuild it from
the corresponding commit — once `gh release delete --cleanup-tag` runs, both
the release and the tag are gone.

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
meaningful tag. (The short SHA suffix guarantees uniqueness regardless.)

---

## 4. `ios-deploy.yml` — iOS deploy to App Store

### What it does

On every push to the `ios-deploy` branch:

1. Checkout on a macOS runner (`macos-latest`).
2. Set up Ruby 3.2 with bundler cache.
3. Install fastlane (`gem install fastlane`).
4. Install Flutter `3.41.6`.
5. `flutter pub get`.
6. `flutter build ipa --release` — produces `build/ios/ipa/*.ipa`.
7. Run fastlane lane `release` (defined in `fastlane/Fastfile`) which:
   - Authenticates to App Store Connect using the **App Store Connect API
     key** (`app_store_connect_api_key` action, with `key_id`, `issuer_id`,
     and `key_content` taken from environment variables).
   - Calls `deliver` to upload the IPA, skipping screenshots and metadata.

### What you need to prepare

#### 4.1 Apple Developer Program enrollment

You need an **active paid Apple Developer Program membership** ($99/year).
Without it you cannot distribute via the App Store.

Sign up at https://developer.apple.com/programs/.

#### 4.2 An app record in App Store Connect

1. Go to https://appstoreconnect.apple.com → **My Apps → +** → **New App**.
2. Bundle ID must match the one in the iOS project — currently
   `com.utr.store` (see `fastlane/Appfile`). The bundle ID must first be
   registered in https://developer.apple.com/account/resources/identifiers/list.
3. Note your **Team ID** (Developer Portal → Membership) and
   **App Store Connect Team ID** (Users and Access → top-right). Update
   `fastlane/Appfile` so the placeholder values are replaced:

   ```ruby
   # fastlane/Appfile
   app_identifier "com.utr.store"
   apple_id "you@yourcompany.com"
   itc_team_id "<your App Store Connect team id>"
   team_id    "<your Developer Portal team id>"
   ```

   > The values currently committed (`qeqweq`, `12312312`, `asdasdad`) are
   > placeholders and **must** be replaced before the first successful deploy.

#### 4.3 Code signing certificate + provisioning profile

For App Store distribution you need:

- An **Apple Distribution** certificate (`.p12`).
- An **App Store** provisioning profile bound to the bundle ID
  `com.utr.store`.

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

#### 4.4 App Store Connect API key

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

#### 4.5 GitHub secrets

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

#### 4.6 Triggering a deploy

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

## 5. `android-deploy.yml` — Android deploy to Play Store

### What it does

On every push to `android-deploy`:

1. Checkout on `ubuntu-latest`.
2. Java 17 (Temurin).
3. Ruby 3.2 with bundler cache (`working-directory: android`, so it caches
   `android/Gemfile.lock`).
4. Flutter `3.41.6`.
5. `flutter pub get`.
6. `flutter build appbundle --release` → `build/app/outputs/bundle/release/*.aab`.
7. `flutter build apk --release` → `build/app/outputs/flutter-apk/*.apk`.
8. Uploads both as workflow artifacts (`app-release-aab`, `app-release-apk`).
9. **Upload to Play Store via fastlane** — runs `bundle exec fastlane android
   release` from the `android/` directory. This step is **enabled by default**
   and will fail the workflow if `PLAY_STORE_JSON_KEY` is not set.

### Repository layout for the Android fastlane setup

The fastlane configuration is already committed:

```
android/
├── Gemfile                 # gem "fastlane"
└── fastlane/
    ├── Appfile             # json_key_file + package_name
    └── Fastfile            # lanes: internal, promote_to_production,
                            #        release (alias for internal), validate
```

The `Fastfile`:

- Writes `PLAY_STORE_JSON_KEY` to `play_key.json` in `before_all`, errors out
  if the secret is empty, and removes the file in `after_all` / `error`.
- `lane :internal` — uploads the AAB to the Play **internal** track as a
  **draft** release (`release_status: "draft"`), skipping metadata,
  changelogs, images, and screenshots.
- `lane :promote_to_production` — promotes the latest **internal** track
  build to **production** (no upload, just a track promotion).
- `lane :release` — alias for `internal`. This is what `ci.yml` invokes.
- `lane :validate` — verifies the service-account JSON can talk to Play.

To promote a build to production after it's been validated in internal,
run `bundle exec fastlane android promote_to_production` locally (or wire
it into a separate workflow that triggers on a tag / dispatch).

### What you need to prepare

#### 5.1 Build a signed release

The Play Store will reject the AAB until it's signed with an **upload key**.
The current `android/app/build.gradle.kts` signs with the **debug** keystore,
which is not acceptable for Play. You must replace it with a real upload key
before the Play upload can succeed.

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

#### 5.2 Google Play Console enrollment

The Play upload step needs:

1. A **Google Play Console** developer account ($25 one-time fee).
2. An **app record** created in the console with the same `applicationId`
   currently configured in `android/app/build.gradle.kts`
   (`com.utr.store`). The **first** release must be uploaded manually
   through the Play Console UI — fastlane `supply` can only update existing
   tracks, not create the very first version.
3. A **service account** with API access:
   - Google Cloud Console → IAM & Admin → Service Accounts → Create.
   - Generate a JSON key — download it.
   - Play Console → Setup → API access → link the service account → grant
     **Release manager** (or **Release apps to testing tracks only** if you
     prefer least-privilege).
4. Store the entire JSON contents as a secret named `PLAY_STORE_JSON_KEY`.
   The `Fastfile`'s `before_all` hook materializes this into
   `android/play_key.json` at runtime — never commit the JSON file.

#### 5.3 (Optional) Disabling the Play upload temporarily

If you want to build artifacts without uploading to Play (e.g. before you've
set up the service account), comment out the
`Upload to Play Store via fastlane` step in `android-deploy.yml`. The AAB and
APK artifacts will still be produced and uploaded.

#### 5.4 Triggering a deploy

```powershell
git checkout -b android-deploy
git merge master
git push -u origin android-deploy
```

---

## 6. Troubleshooting

### General

- **Workflow doesn't trigger** → check the branch name exactly matches one of
  the `branches:` entries; GitHub Actions does **not** trigger on tag pushes
  unless explicitly configured. Note: `ci.yml` only triggers on **push** to
  `master`, not on pull requests — opening a PR to `master` will not run CI.
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
- **`apple_id` / team id errors** → the placeholder values in
  `fastlane/Appfile` (`qeqweq`, `12312312`, `asdasdad`) haven't been replaced
  with real values yet. See [4.2](#42-an-app-record-in-app-store-connect).

### Android

- **`PLAY_STORE_JSON_KEY env var is not set`** → the `before_all` hook in
  `android/fastlane/Fastfile` aborts the run. Add the secret in
  **Settings → Secrets and variables → Actions**.
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

- **`flutter test` fails on generated files** → run `build_runner build`
  locally with `--delete-conflicting-outputs` and commit nothing under
  `lib/**/*.g.dart` (these are regenerated by the workflow). Make sure your
  `.gitignore` covers generated files.
- **`No tests were found`** → fine, exit code is still 0. The job will pass.

---

## 7. Quick reference: secrets summary

| Secret | Workflow | Required? |
|---|---|---|
| `APPSTORE_KEY_ID` | `ios-deploy.yml` | Yes |
| `APPSTORE_ISSUER_ID` | `ios-deploy.yml` | Yes |
| `APPSTORE_P8` | `ios-deploy.yml` | Yes |
| `MATCH_PASSWORD` | `ios-deploy.yml` | Only if using fastlane match |
| `MATCH_GIT_BASIC_AUTHORIZATION` | `ios-deploy.yml` | Only if using fastlane match |
| `PLAY_STORE_JSON_KEY` | `android-deploy.yml` | Yes — the workflow fails without it |
| `ANDROID_KEYSTORE_BASE64` | `android-deploy.yml` | Required for Play (Play rejects debug-signed AABs) |
| `ANDROID_KEYSTORE_PASSWORD` | `android-deploy.yml` | same |
| `ANDROID_KEY_PASSWORD` | `android-deploy.yml` | same |
| `ANDROID_KEY_ALIAS` | `android-deploy.yml` | same |
| `MAIL_USERNAME` | `ci.yml` | Yes (for email notification step) |
| `MAIL_PASSWORD` | `ci.yml` | Yes — Gmail **App Password**, not account password |
| `MAIL_TO` | `ci.yml` | Yes — comma-separated list of recipients |
| `GITHUB_TOKEN` | `ci.yml` | Provided automatically |

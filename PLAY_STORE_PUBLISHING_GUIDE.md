# Google Play Store Publishing Guide
## Trip Cost Splitter App

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [App Configuration](#app-configuration)
3. [Building the APK](#building-the-apk)
4. [Google Play Console Setup](#google-play-console-setup)
5. [App Listing](#app-listing)
6. [Upload & Publish](#upload--publish)
7. [Post-Publication](#post-publication)

---

## Prerequisites

### Required Accounts & Tools
- **Google Play Developer Account**: $25 one-time fee
- **Android Studio** or **Flutter SDK** installed
- **Java Development Kit (JDK) 17+**
- **Keystore file** for signing your app (required for release builds)

### Check Your Environment
```bash
# Verify Flutter installation
flutter --version

# Verify Android SDK
flutter doctor -v
```

### Project Status
| Item | Status |
|------|--------|
| Package Name | `com.tripcost.splitter` |
| App Icon | Custom PNG in assets/images |
| Keystore | Not created yet (see below) |

---

## App Configuration

### Current Configuration
- **App Name**: Trip Cost Splitter
- **Package Name**: `com.tripcost.splitter`
- **Version**: 1.0.0+1 (versionCode: 1)
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 35
- **Compile SDK**: 36

### To Update Version Before Publishing
Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # Change as needed (e.g., 1.1.0+1)
```

Then update `android/app/build.gradle.kts`:
- `versionCode`: Increment by 1 (e.g., from 1 to 2)
- `versionName`: Match pubspec version (e.g., "1.1.0")

---

## Building the APK

### Step 1: Clean Previous Builds
```bash
flutter clean
```

### Step 2: Get Dependencies
```bash
flutter pub get
```

### Step 3: Build Debug APK (Testing)
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Step 4: Create Release Keystore (Required for Release APK)
```bash
keytool -genkeypair -v -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -keystore trip_cost_splitter.jks -alias tripapp
```

**Important**: Save this keystore file safely! You need it for:
- Every release update
- Google Play App Signing (or you can let Google manage it)

### Step 5: Configure Signing
Create `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=tripapp
storeFile=../trip_cost_splitter.jks
```

Update `android/app/build.gradle.kts` to use the keystore:
```kotlin
buildTypes {
    release {
        isMinifyEnabled = true
        isShrinkResources = true
        signingConfig = signingConfigs.create("release") {
            storeFile = file("../trip_cost_splitter.jks")
            storePassword = System.getenv("KEYSTORE_PASSWORD")
            keyAlias = "tripapp"
            keyPassword = System.getenv("KEY_PASSWORD")
        }
    }
}
```

### Step 6: Build Release APK (For Play Store)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

**Note**: For smaller APK size, you can use:
```bash
flutter build apk --release --split-per-abi
```

---

## Google Play Console Setup

### Step 1: Access Google Play Console
1. Go to [play.google.com/console](https://play.google.com/console)
2. Sign in with your developer account
3. Click **Create App**

### Step 2: Fill Basic Info
- **App Name**: Trip Cost Splitter
- **Default Language**: English (en)
- **App Type**: Android App
- **Free or Paid**: Free (or set price)

### Step 3: Store Listing Details

#### App Information
| Field | Value |
|-------|-------|
| Title | Trip Cost Splitter |
| Short Description | Split trip fuel costs with friends easily |
| Full Description | Trip Cost Splitter helps you calculate and split fuel costs for your trips. Features include route planning, vehicle presets, cost breakdown, and history tracking. Perfect for road trips with friends and family. |

#### Graphic Assets (You Need to Create)
1. **App Icon** (Required)
   - Use your custom logo from `assets/images/trip_splitter_logo.png`
   - Resize to: 512x512 PNG (high-res icon)
   - Create all sizes in `android/app/src/main/res/mipmap-*/`

2. **Screenshots** (Required - minimum 2)
   - Phone screenshots: 1080x1920 or 1080x2340
   - Take screenshots from the app:
   ```bash
   flutter screenshot
   ```
   Or use Android device's screenshot feature

3. **Feature Graphic** (Required)
   - 1024x500 PNG
   - Showcases app features

4. **Privacy Policy** (Required)
   - Create a simple privacy policy
   - Can be hosted on GitHub Pages, Firebase, or your website
   - Sample privacy policy content:
   ```
   Privacy Policy for Trip Cost Splitter
   
   This app does not collect any personal information.
   All trip data is stored locally on your device.
   We do not share any data with third parties.
   
   Contact: your-email@example.com
   ```

---

## Google Play Console Setup

### Step 1: Access Google Play Console
1. Go to [play.google.com/console](https://play.google.com/console)
2. Sign in with your developer account
3. Click **Create App**

### Step 2: Fill Basic Info
- **App Name**: Trip Cost Splitter
- **Default Language**: English (en)
- **App Type**: Android App
- **Free or Paid**: Free (or set price)

### Step 3: Store Listing Details

#### App Information
| Field | Value |
|-------|-------|
| Title | Trip Cost Splitter |
| Short Description | Split trip fuel costs with friends easily |
| Full Description | Trip Cost Splitter helps you calculate and split fuel costs for your trips. Features include route planning, vehicle presets, cost breakdown, and history tracking. Perfect for road trips with friends and family. |

#### Graphic Assets (You Need to Create)
1. **App Icon** (Required)
   - 512x512 PNG (high-res icon)
   - 1024x1024 PNG (Play Store listing)

2. **Screenshots** (Required - minimum 2)
   - Phone screenshots: 1080x1920 or 1080x2340
   - Take screenshots from the app using:
   ```bash
   flutter screenshot
   ```
   Or use Android Emulator's screenshot feature

3. **Feature Graphic** (Required)
   - 1024x500 PNG
   - Showcases app features

4. **Privacy Policy** (Required)
   - Create a simple privacy policy
   - Can be hosted on GitHub Pages, Firebase, or your website
   - Sample privacy policy content:
   ```
   Privacy Policy for Trip Cost Splitter
   
   This app does not collect any personal information.
   All trip data is stored locally on your device.
   We do not share any data with third parties.
   
   Contact: your-email@example.com
   ```

---

## App Listing

### Categorization
- **Category**: Travel and Local
- **Tags**: None required

### Content Rating
1. Go to **Content rating** section
2. Answer the questionnaire honestly
3. For this app: Likely "Everyone"

### Target Audience
- **Target Age**: 13+ (or appropriate)
- **Include Google Play Families policy**: No (if not targeting children)

### Pricing & Distribution
- **Price**: Free
- **Countries**: Select all available or specific countries

---

## Upload & Publish

### Step 1: Create Release
1. Go to **Releases** > **App releases**
2. Click **Create new release**
3. Upload your APK:
   - Drag and drop `app-release.apk` or browse to select
   - File should be under 100MB (Flutter APK is usually ~20-30MB)

### Step 2: Release Configuration
- **Release name**: Version 1.0.0
- **Release notes**: "Initial release of Trip Cost Splitter"

### Step 3: Review & Rollout
1. Click **Review release**
2. Check for any errors
3. Click **Start rollout to production**
4. Click **Confirm rollout**

---

## Post-Publication

### Monitoring
- Check **Dashboard** for install statistics
- Monitor **Ratings & Reviews**
- Check **Crashes & ANRs** (Application Not Responding)

### Updating the App
1. Update version in `pubspec.yaml`
2. Update `versionCode` and `versionName` in `android/app/build.gradle.kts`
3. Build new APK: `flutter build apk --release`
4. Upload in Play Console
5. Create new release
6. Roll out

### Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| APK too large | Run `flutter build apk --release --split-per-abi` |
| Signing errors | Ensure keystore is correct |
| Rejected by Play Store | Check email for reasons |
| Not visible in Play Store | Wait 24-48 hours for processing |

---

## Quick Commands Reference

```bash
# Development
flutter run

# Build for testing
flutter build apk --debug

# Build for release
flutter build apk --release

# Build with smaller size
flutter build apk --release --split-per-abi

# Clean and rebuild
flutter clean && flutter pub get && flutter build apk --release
```

---

## Important Notes

1. **Keystore**: Keep it safe! Without it, you cannot update your app
2. **App Signing**: Google Play can manage your signing key automatically (recommended for new apps)
3. **Testing**: Test thoroughly on physical devices before publishing
4. **Privacy Policy**: Required before publishing - add URL in Play Console
5. **Screenshots**: Take at least 2 screenshots showing different app screens
6. **Processing Time**: Usually takes 1-24 hours for first review, faster for updates
7. **App Icon**: Use your custom logo from `assets/images/trip_splitter_logo.png` - generate all required sizes

---

## Contact & Support

For issues with this guide:
- Check [Flutter Documentation](https://docs.flutter.dev)
- Check [Google Play Console Help](https://support.google.com/googleplay/android-developer)

---

*Last Updated: April 2026*
*App Version: 1.0.0*

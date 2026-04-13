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
- **Keystore file** for signing your app

### Check Your Environment
```bash
# Verify Flutter installation
flutter --version

# Verify Android SDK
flutter doctor -v
```

---

## App Configuration

### Current Configuration (Already Done)
- **App Name**: Trip Cost Splitter
- **Package Name**: `com.tripcost.splitter`
- **Version**: 1.0.0 (versionCode: 1)
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: Latest Flutter default

### To Update Version Before Publishing
Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # Change as needed (e.g., 1.1.0+1)
```

For each new release, increment:
- `version`: Human readable (e.g., "1.1.0")
- `versionCode`: Integer, must be higher than previous (e.g., 2)

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

### Step 4: Build Release APK (For Play Store)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Step 5: Create Keystore (If Not Already Created)
If you don't have a keystore, create one:
```bash
keytool -genkeypair -v -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -keystore trip_cost_splitter.jks -alias tripapp
```

### Step 6: Configure Signing (Optional - For Enhanced Security)
Create `android/key.properties`:
```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=tripapp
storeFile=../trip_cost_splitter.jks
```

Update `android/app/build.gradle.kts` to use your keystore.

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
2. Build new APK: `flutter build apk --release`
3. Upload in Play Console
4. Create new release
5. Roll out

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

# Build with specific version
flutter build apk --release --build-name=1.0.0 --build-number=1

# Clean and rebuild
flutter clean && flutter pub get && flutter build apk --release
```

---

## Important Notes

1. **App Signing**: Google Play can manage your signing key or you can use your own
2. **Testing**: Test thoroughly on physical devices before publishing
3. **Privacy Policy**: Required before publishing - add URL in Play Console
4. **Screenshots**: Take at least 2 screenshots showing different app screens
5. **Processing Time**: Usually takes 1-24 hours for first review, faster for updates

---

## Contact & Support

For issues with this guide:
- Check [Flutter Documentation](https://docs.flutter.dev)
- Check [Google Play Console Help](https://support.google.com/googleplay/android-developer)

---

*Last Updated: April 2026*
*App Version: 1.0.0*

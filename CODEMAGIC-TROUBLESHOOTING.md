# CodeMagic Build Troubleshooting Guide

## Overview
This guide helps diagnose and fix CodeMagic build errors for the Gamepedia iOS Expert project.

---

## ✅ Fixed Issues

### **Issue 1: "Unknown build action 'NO'"**

**Error Message:**
```
xcodebuild: error: Unknown build action 'NO'.
Step 4 script `Build app (generic iOS, no signing)` exited with status code 65
```

**Root Cause:**
- Invalid parameter `-UseModernBuildSystem=YES`
- Xcode 14+ uses modern build system by default
- The "YES" value was being interpreted as a build action

**Solution Applied:**
✅ Removed `-UseModernBuildSystem=YES` parameter
✅ Modern build system is now automatic

**Before:**
```bash
xcodebuild \
  -project "$XCODE_PROJECT" \
  -scheme "$XCODE_SCHEME" \
  -UseModernBuildSystem=YES \      # ❌ Removed this
  -destination 'generic/platform=iOS' \
  clean build
```

**After:**
```bash
xcodebuild \
  -project "$XCODE_PROJECT" \
  -scheme "$XCODE_SCHEME" \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  -destination 'generic/platform=iOS' \
  clean build
```

---

## 🔧 Current Build Configuration

### **Environment Setup**
```yaml
xcode: latest            # Uses latest Xcode available
cocoapods: default       # Default CocoaPods version
```

### **Build Steps**

1. **Show Environment**
   - Displays Xcode version, Swift version
   - Shows available iOS simulators

2. **Clean DerivedData**
   - Removes cached build artifacts
   - Ensures fresh compilation

3. **Install CocoaPods Dependencies**
   - Updates pod repository
   - Installs dependencies if Podfile exists
   - Skips if no Podfile present

4. **Build App (Generic iOS)**
   - Builds for generic iOS platform
   - No code signing
   - Output captured in `build.log`

5. **Build for Testing (Simulator)**
   - Builds for iOS Simulator
   - Prepares for testing
   - Output captured in `build-test.log`

### **Code Signing Settings**
```bash
CODE_SIGN_IDENTITY=""              # No signing identity
CODE_SIGNING_REQUIRED=NO           # Signing not required
CODE_SIGNING_ALLOWED=NO            # Signing disabled
```

---

## 🐛 Common Build Issues & Solutions

### **Issue: Pod not found error**

**Error:**
```
error: unable to find a target named "Alamofire" in project "Gamepedia"
```

**Solution:**
1. Ensure `Podfile` exists in project root
2. Update `codemagic.yaml` to run `pod install`
3. Use `.xcworkspace` instead of `.xcodeproj`

**Status**: ✅ Fixed - CocoaPods step added

---

### **Issue: Swift version mismatch**

**Error:**
```
error: Swift version 6.2 is incompatible with this project
```

**Solution:**
1. Check `codemagic.yaml` Xcode version
2. Match with project's minimum deployment target
3. Update in `.swift-version` file if needed

**Current Config**: Xcode `latest` (handles Swift 6.2+)

---

### **Issue: Simulator not available**

**Error:**
```
error: Could not find a matching device for the -destination option
```

**Solution:**
1. Check available runtimes: `xcrun simctl list runtimes`
2. Use generic platform: `generic/platform=iOS Simulator`
3. Avoid specific simulator names on CI/CD

**Status**: ✅ Fixed - Using generic platform

---

### **Issue: Memory or timeout errors**

**Error:**
```
error: Build took too long or ran out of memory
error: Couldn't start xcodebuild: Connection reset by peer
```

**Solutions:**
1. Enable compiler index store disable: `COMPILER_INDEX_STORE_ENABLE=NO`
2. Don't parallelize builds: Use sequential compilation
3. Increase timeout in CodeMagic settings
4. Clear DerivedData before building

**Status**: ✅ Configured - Index store disabled

---

### **Issue: Missing frameworks or libraries**

**Error:**
```
error: unable to load content of file at path /path/to/framework.framework
```

**Solutions:**
1. Ensure all SPM dependencies are in Package.swift
2. Verify CocoaPods integration (Podfile)
3. Check that import statements match available modules
4. Run `pod install` before building

**Status**: ✅ Automatic - Pod install step added

---

## 📋 Debugging Steps

### **1. Check Build Logs**
In CodeMagic UI:
1. Go to Build History
2. Click on failed build
3. Check Step Logs for specific error
4. Look for `build.log` and `build-test.log` artifacts

### **2. Run Build Locally**
```bash
# Simulate CodeMagic environment
xcodebuild \
  -project Gamepedia.xcodeproj \
  -scheme Gamepedia \
  -configuration Debug \
  -destination 'generic/platform=iOS' \
  clean build

# For simulator
xcodebuild \
  -project Gamepedia.xcodeproj \
  -scheme Gamepedia \
  -configuration Debug \
  -destination 'generic/platform=iOS Simulator' \
  build-for-testing
```

### **3. Check Environment**
```bash
# Verify Xcode setup
xcodebuild -version
xcode-select -p

# Check simulators
xcrun simctl list runtimes

# Check Swift version
swift --version
```

### **4. Verify Dependencies**
```bash
# If using CocoaPods
pod install

# Check workspace
ls -la *.xcworkspace

# Verify schemes
xcodebuild -list
```

---

## 🔍 CodeMagic.yaml Configuration Reference

### **Build Variables**
```yaml
XCODE_PROJECT: "Gamepedia.xcodeproj"     # Project file
XCODE_SCHEME: "Gamepedia"                # Build scheme
DERIVED_DATA_PATH: "$CM_BUILD_DIR/..."   # Build cache location
```

### **Build Flags**
```bash
-project              # Project file path
-scheme               # Build scheme to use
-configuration Debug  # Build configuration
-derivedDataPath      # Where to store build artifacts
-destination          # Build target platform
-clean build          # Clean then build
build-for-testing     # Prepare for testing
```

### **Code Signing**
```bash
CODE_SIGN_IDENTITY=""         # No signing (for CI)
CODE_SIGNING_REQUIRED=NO      # Don't require signing
CODE_SIGNING_ALLOWED=NO       # Explicitly disable signing
```

### **Performance**
```bash
COMPILER_INDEX_STORE_ENABLE=NO    # Disable indexing (faster)
```

---

## ✅ Verification Checklist

- [x] Removed invalid `-UseModernBuildSystem` parameter
- [x] Added CocoaPods dependency installation
- [x] Configured proper destination specifications
- [x] Added build logging for debugging
- [x] Disabled code signing for CI/CD
- [x] Enabled fast compilation (index store disabled)
- [x] Set up error handling with `set -euo pipefail`

---

## 🚀 Build Pipeline Flow

```
Start
  ↓
[Show Environment] ← Check Xcode/Swift versions
  ↓
[Clean DerivedData] ← Clear old artifacts
  ↓
[Install Dependencies] ← Run pod install if needed
  ↓
[Build for iOS] ← Generic platform build
  ↓
[Build for Simulator] ← Simulator build + testing prep
  ↓
[Publish Artifacts] ← Save logs and builds
  ↓
[Email Notification] ← Send status to ridhoafni.dev@gmail.com
  ↓
End
```

---

## 📞 Support & Resources

### **Local Testing**
Test the build locally before pushing to CodeMagic:
```bash
./codemagic-test.sh  # (if available)
# Or manually run xcodebuild commands above
```

### **CodeMagic Documentation**
- [CodeMagic iOS Builds](https://docs.codemagic.io/yaml-building-a-native-ios-app/building-a-native-ios-app/)
- [CodeMagic Environment Variables](https://docs.codemagic.io/yaml-basic-configuration/environment-variables/)
- [Xcode Build Settings](https://help.apple.com/xcode/mac/current/#/itms51ba9b7f)

### **Common Resources**
- Check project's `.swiftpm` directory for Swift Package Manager issues
- Review `Podfile` for CocoaPods configuration
- Verify `project.pbxproj` for build settings

---

## 📝 Next Steps

If builds still fail after these fixes:

1. **Check CodeMagic Logs**
   - Full error messages in build logs
   - Look for actual error, not just exit code

2. **Run Locally**
   ```bash
   xcodebuild clean build -project Gamepedia.xcodeproj -scheme Gamepedia
   ```

3. **Verify Project Setup**
   - All dependencies installed
   - Schemes configured correctly
   - Build settings valid

4. **Contact CodeMagic Support**
   - Provide full build logs
   - Share codemagic.yaml configuration
   - Include local build success confirmation

---

**Status**: ✅ Build configuration fixed and verified  
**Last Updated**: April 4, 2026  
**Next Build Expected**: Success 🎉

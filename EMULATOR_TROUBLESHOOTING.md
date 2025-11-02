# Android Emulator Troubleshooting Guide

## Error: "The Android emulator exited with code 1 during startup"

This error typically occurs due to hardware acceleration or configuration issues. Here are the steps to fix it:

## ✅ FIX APPLIED
**The issue was GPU/Vulkan compatibility. The AVD configuration has been updated:**
- Changed `hw.gpu.mode` from `auto` to `swiftshader_indirect` in the Medium_Phone AVD
- This uses software rendering instead of Vulkan, avoiding driver compatibility issues

**Try running your Flutter app again now!**

## Quick Fixes (Try these first):

### 1. Check Windows Hyper-V Status
If Hyper-V is enabled, it conflicts with Android Emulator's hardware acceleration. You need to either:
- **Option A**: Disable Hyper-V (if you don't need it)
  - Open PowerShell as Administrator
  - Run: `bcdedit /set hypervisorlaunchtype off`
  - Restart your computer
  
- **Option B**: Use Hyper-V backend (Windows 10/11)
  - In Android Studio: Tools → SDK Manager → SDK Tools
  - Check "Windows Hypervisor Platform" (if available)
  - For command line: Create/Edit AVD with `-accel on -accel-check`

### 2. Check Hardware Acceleration Support
Run this command to check if your system supports acceleration:
```powershell
C:\Users\Atiqollah\AppData\Local\Android\sdk\emulator\emulator.exe -accel-check
```

### 3. Try Cold Boot
Delete and recreate your emulator:
- Open Android Studio → AVD Manager
- Delete the problematic emulator
- Create a new one with:
  - System Image: Latest stable (e.g., API 33 or 34)
  - Graphics: Hardware - GLES 2.0 or Automatic

### 4. Check System Requirements
- Ensure you have at least 8GB RAM (16GB recommended)
- At least 4GB free disk space
- Enable virtualization in BIOS (Intel VT-x or AMD-V)

### 5. Run Emulator with Verbose Output
Get detailed error messages:
```powershell
cd C:\Users\Atiqollah\AppData\Local\Android\sdk\emulator
.\emulator.exe -avd <your_avd_name> -verbose -show-kernel
```
Replace `<your_avd_name>` with your actual AVD name.

### 6. Check for Multiple Emulator Instances
Close all running emulators and Android Studio, then try again.

### 7. Update Android Emulator
In Android Studio:
- Tools → SDK Manager → SDK Tools
- Update "Android Emulator" to latest version

### 8. Alternative: Use Physical Device or Chrome
- Connect a physical Android device via USB (enable USB debugging)
- Or run on Chrome: `flutter run -d chrome`

## Check Flutter Configuration

Run these commands:
```powershell
flutter doctor -v
flutter devices
```

## If Nothing Works

Try creating a new AVD from command line:
```powershell
# List available system images
C:\Users\Atiqollah\AppData\Local\Android\sdk\cmdline-tools\latest\bin\sdkmanager --list

# Create AVD (example)
C:\Users\Atiqollah\AppData\Local\Android\sdk\cmdline-tools\latest\bin\avdmanager create avd -n test_avd -k "system-images;android-33;google_apis;x86_64"
```


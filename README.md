# Miku UI Snowland bring-up - Samsung Galaxy S8 (dreamlte)

> **User-facing project:** https://github.com/birowsi/MikuUI-dreamlte  
> Downloads, installation instructions, build guide and releases are maintained there.

Miku UI Snowland Android 12 / SDK 32 bring-up for the Samsung Galaxy S8.

## Target

- Device: Samsung Galaxy S8
- Model: SM-G950N
- SoC: Exynos 8895
- Codename: dreamlte
- Android: 12
- SDK: 32
- Build variant: userdebug / UNOFFICIAL
- Partition layout: legacy A-only

## Current status

Working and tested on device:

- Boot / System UI
- Wi-Fi
- Bluetooth
- Rear camera
- Front camera
- Automatic rotation
- Fingerprint
- Speaker
- Microphone
- Wired headset audio
- Wired charging
- Wireless charging
- USB MTP / ADB
- Google SetupWizard
- Google Play Store / GMS / GSF
- Touch sounds disabled by default

Not fully verified yet:

- GNSS / GPS fix
- NFC tag operation

Cellular functionality is intentionally outside the scope of this bring-up.

## Camera compatibility

Samsung camera blobs depend on legacy symbols normally supplied through
LineageOS `TARGET_LD_SHIM_LIBS`.

Miku UI does not implement that linker shim mechanism, so the required
compatibility libraries are added directly as DT_NEEDED dependencies
during proprietary blob extraction.

### libexynoscamera

32-bit:

    lib/libexynoscamera.so
        -> /vendor/lib/libexynoscamera_shim.so

64-bit:

    lib64/libexynoscamera.so
        -> /vendor/lib64/libexynoscamera_shim.so

This fixes the missing legacy `CameraParameters` symbols including
`EFFECT_POINT_BLUE`.

### BlurDetection / FocusPeaking

The Samsung OpenCV camera plugins require `__aeabi_idiv0`.

The following blobs are patched to load `idev0_shim.so`:

    lib/libblurdetection_interface.so
    lib/libfocuspeaking_interface.so
    lib64/libblurdetection_interface.so
    lib64/libfocuspeaking_interface.so

The extraction script checks existing DT_NEEDED entries before patching,
so repeated extraction does not add duplicate dependencies.

## Exynos display / HWC compatibility

Rotation originally caused `vendor.hwcomposer-2-2` to crash with SIGSEGV,
which restarted SurfaceFlinger and zygote.

The Exynos display stack also relied on LineageOS `TARGET_LD_SHIM_LIBS`.

The common-device extraction script now adds
`libexynosdisplay_shim.so` directly to:

32-bit:

    vendor/lib/libexynosdisplay.so
    vendor/lib/hw/hwcomposer.exynos5.so

64-bit:

    vendor/lib64/libexynosdisplay.so
    vendor/lib64/hw/hwcomposer.exynos5.so

Runtime testing with the patched blobs confirms stable portrait and
landscape rotation with no HWC / SurfaceFlinger restart.

The extraction-time implementation is located in:

    device/samsung/universal8895-common/extract-files.sh

## Miku UI build integration

The device product is exposed as:

    miku_dreamlte-userdebug

Miku UI product configuration and bundled GApps are enabled through:

    MIKU_GAPPS := true
    vendor/miku/build/product/miku_product.mk

The device also provides local Soong compatibility definitions required
by the imported LineageOS-era device configuration.

## First-boot defaults

Touch sounds are disabled through the dreamlte SettingsProvider overlay:

    def_sound_effects_enabled=false

Google SetupWizard remains available for Wi-Fi and initial provisioning,
but optional setup flows can be skipped:

    ro.setupwizard.mode=OPTIONAL

Both settings were verified in the generated image and on a clean
real-device installation.

Android's default backup setting remains disabled.

## Notes

The proprietary Samsung blobs themselves are not included in this device
repository.

Compatibility modifications are implemented in extraction scripts rather
than publishing modified proprietary binaries.

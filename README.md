# Samsung Galaxy S8 (dreamlte) - Miku UI Snowland

Device tree for Miku UI Snowland on the Samsung Galaxy S8.

Main project, builds and installation instructions:

https://github.com/birowsi/MikuUI-dreamlte

## Target

- Device: Samsung Galaxy S8
- Model tested: SM-G950N
- Codename: `dreamlte`
- SoC: Exynos 8895
- Android: 12L / SDK 32
- Build: `miku_dreamlte-userdebug`
- Legacy A-only layout

## Status

Working:

- Boot / System UI
- Wi-Fi
- Bluetooth
- Camera
- Rotation
- Fingerprint
- Speaker / microphone
- Wired headset
- Wired and wireless charging
- USB MTP / ADB
- Google services

Not verified:

- GPS / GNSS fix
- NFC tags

Cellular support is excluded from this port.

## Camera

Miku UI does not use LineageOS `TARGET_LD_SHIM_LIBS`.

`extract-files.sh` adds the required shim libraries as DT_NEEDED
dependencies during blob extraction.

`libexynoscamera_shim.so`:

```text
vendor/lib/libexynoscamera.so
vendor/lib64/libexynoscamera.so
```

`idev0_shim.so`:

```text
vendor/lib/libblurdetection_interface.so
vendor/lib/libfocuspeaking_interface.so
vendor/lib64/libblurdetection_interface.so
vendor/lib64/libfocuspeaking_interface.so
```

## Display / HWC

The universal8895-common extraction script adds
`libexynosdisplay_shim.so` to:

```text
vendor/lib/libexynosdisplay.so
vendor/lib/hw/hwcomposer.exynos5.so
vendor/lib64/libexynosdisplay.so
vendor/lib64/hw/hwcomposer.exynos5.so
```

This is required for stable HWC operation and rotation.

## Miku UI

Product:

```text
miku_dreamlte-userdebug
```

GApps:

```makefile
MIKU_GAPPS := true
```

First-boot defaults:

```text
ro.setupwizard.mode=OPTIONAL
def_sound_effects_enabled=false
```

## Proprietary blobs

Modified Samsung proprietary binaries are not stored in this repository.

Required compatibility patches are applied by the extraction scripts.

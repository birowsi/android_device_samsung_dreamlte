#
# Copyright (C) 2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from common
-include device/samsung/universal8895-common/BoardConfigCommon.mk

DEVICE_PATH := device/samsung/dreamlte

# Preserve the upstream Trust HAL's configurable USB control interface.
SOONG_CONFIG_NAMESPACES += lineageGlobalVars
SOONG_CONFIG_lineageGlobalVars += target_trust_usb_control_path target_trust_usb_control_enable target_trust_usb_control_disable
TARGET_TRUST_USB_CONTROL_PATH ?= /sys/class/usb_notify/usb_control/disable
TARGET_TRUST_USB_CONTROL_ENABLE ?= 1
TARGET_TRUST_USB_CONTROL_DISABLE ?= 0
SOONG_CONFIG_lineageGlobalVars_target_trust_usb_control_path := $(TARGET_TRUST_USB_CONTROL_PATH)
SOONG_CONFIG_lineageGlobalVars_target_trust_usb_control_enable := $(TARGET_TRUST_USB_CONTROL_ENABLE)
SOONG_CONFIG_lineageGlobalVars_target_trust_usb_control_disable := $(TARGET_TRUST_USB_CONTROL_DISABLE)

# Assert
TARGET_OTA_ASSERT_DEVICE := dreamlte

# Glove mode
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/glove_manifest.xml

# Kernel
TARGET_KERNEL_CONFIG := exynos8895-dreamlte_defconfig

# inherit from the proprietary version
-include vendor/samsung/dreamlte/BoardConfigVendor.mk

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
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from dreamlte device
$(call inherit-product, device/samsung/dreamlte/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit Miku UI after the device and telephony configuration.
MIKU_GAPPS := true
$(call inherit-product, vendor/miku/build/product/miku_product.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := dreamlte
PRODUCT_NAME := miku_dreamlte
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-G950N
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

# Keep the actual ROM build identity; do not reuse the G950F Android 8 fingerprint.
PRODUCT_LOCALES := ko_KR en_US
TARGET_MIKU_BUILD_VARIANT := UNOFFICIAL

# Keep Google SetupWizard available for Wi-Fi / initial provisioning,
# but do not require completing optional Google setup flows.
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.mode=OPTIONAL

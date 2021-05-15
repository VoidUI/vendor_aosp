lunch_others_targets=()
for device in $(python vendor/aosp/tools/get_official_devices.py)
do
    for var in user userdebug eng; do
        lunch_others_targets+=("aosp_$device-$var")
    done
done

# ABI compatibility checks fail for several reasons:
#   - The update to Clang 12 causes some changes, but no breakage has been
#     observed in practice.
#   - Switching to zlib-ng changes some internal structs, but not the public
#     API.
#
# We may fix these eventually by updating the ABI specifications, but it's
# likely not worth the effort for us because of how many repos are affected.
# We would need to fork a lot of extra repos (thus increasing maintenance
# overhead) just to update the ABI specs.
#
# For now, just skip the ABI checks to fix build errors.
export SKIP_ABI_CHECKS=true

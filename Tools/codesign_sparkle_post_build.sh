echo "Signing Sparkle..."

SPARKLE_BUILD_DIR="${BUILD_DIR%Build/*}SourcePackages/artifacts/sparkle/Sparkle.xcframework/macos-arm64_x86_64"
echo $SPARKLE_BUILD_DIR

SPARKLE_CODE_SIGN_IDENTITY=$CODE_SIGN_IDENTITY
echo $SPARKLE_CODE_SIGN_IDENTITY

codesign -f -s "$SPARKLE_CODE_SIGN_IDENTITY" -o runtime "$SPARKLE_BUILD_DIR/Sparkle.framework/Versions/B/XPCServices/Installer.xpc"

codesign -f -s "$SPARKLE_CODE_SIGN_IDENTITY" -o runtime --entitlements "$SPARKLE_BUILD_DIR/../../Entitlements/Downloader.entitlements" "$SPARKLE_BUILD_DIR/Sparkle.framework/Versions/B/XPCServices/Downloader.xpc"

codesign -f -s "$SPARKLE_CODE_SIGN_IDENTITY" -o runtime "$SPARKLE_BUILD_DIR/Sparkle.framework/Versions/B/Autoupdate"

codesign -f -s "$SPARKLE_CODE_SIGN_IDENTITY" -o runtime "$SPARKLE_BUILD_DIR/Sparkle.framework/Versions/B/Updater.app"

codesign -f -s "$SPARKLE_CODE_SIGN_IDENTITY" -o runtime "$SPARKLE_BUILD_DIR/Sparkle.framework"

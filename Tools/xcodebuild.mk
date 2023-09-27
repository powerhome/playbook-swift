, := ,

-xcodebuild = \
	@mkdir -p "$(BUILD_ROOT)" ;\
	xcodebuild \
		-project $(ROOT_DIR)/PlaybookShowcase.xcodeproj \
		-scheme "$(1)" \
		-configuration "$(2)" \
		-sdk $(3) \
		$(4) \
		$(5) \
		$(6) \
		OBJROOT="$(BUILD_ROOT)" \
		SYMROOT="$(BUILD_ROOT)" \
		| tee "$(BUILD_ROOT)/$(5)-$(1)-$(2).log" \
		| xcpretty $(7) \
		; exit "$${PIPESTATUS[0]}" \

# Parameters: XCODE_SCHEME, XCODE_CONFIGURATION
xcodebuild-build = \
	$(call -xcodebuild,$(1),$(2),iphoneos,,build,,) \

# Parameters: XCODE_SCHEME, XCODE_CONFIGURATION
xcodebuild-archive = \
	$(call -xcodebuild,$(1),$(2),iphoneos,-archivePath "$(BUILD_ROOT)/$(1)-$(2).xcarchive",archive,ONLY_ACTIVE_ARCH=NO,) \

# Parameters: XCODE_SCHEME, XCODE_CONFIGURATION, EXPORT_OPTIONS_PLIST
xcodebuild-export-archive = \
	xcodebuild \
		-exportArchive \
		-sdk iphoneos \
		-archivePath "$(BUILD_ROOT)/$(1)-$(2).xcarchive" \
		-exportPath "$(BUILD_ROOT)" \
		-exportOptionsPlist "$(TOOLS_ROOT)/$(3)" ;\
	mv "$(BUILD_ROOT)/$(1).ipa" "$(BUILD_ROOT)/$(1).ipa"	
	#mv "$(BUILD_ROOT)/navigator.ipa" "$(BUILD_ROOT)/$(1)-b$(BUILD_NUMBER).ipa"

# Parameters: XCODE_SCHEME, XCODE_CONFIGURATION
xcodebuild-analyze = \
	$(call -xcodebuild,$(1),$(2),iphoneos,,analyze,,) \

export LC_CTYPE=en_US.UTF-8

.DEFAULT_GOAL := help

ifndef ROOT_DIR
  ROOT_DIR := $(PWD)
endif

help:
	@echo "Help:"
	@echo
	@echo "  dependencies              Install project dependencies."
	@echo
	@echo "  proj                   	 Runs nitro and opens Xcode."
	@echo "  playbook-ios              Playbook-iOS Showcase App."
	@echo
	@echo "  test                      Run all tests."
	@echo

#
# Functions
#

define dependencies
	@bash script_install_dependencies.sh
endef

define setup
	@osascript -e 'quit app "Xcode"'
	rm -rf PlaybookShowcase.xcodeproj
	xcodegen generate -s $(1).yml
endef

define runDockerAndFastlane
	nohup caffeinate -ut 900 &
	if $(MAKE) docker && asdf exec bundle exec fastlane $(1); then \
		echo succeeded; \
	else \
		$(MAKE) docker-stop; \
		exit 1; \
	fi
endef

#
# Commands
#

dependencies:
	$(call dependencies)

proj:
	$(MAKE) playbook-ios
	sleep 1 && xed .


#
# Playbook
#

playbook-ios:
	$(call setup,project)

#
# Tests
#

test:
	$(call runDockerAndFastlane,run_ui_tests_macos)
	$(call runDockerAndFastlane,run_tests_iphone)
	$(call runDockerAndFastlane,run_tests_ipad)
	$(MAKE) docker-stop
	
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
	@echo "  docker                    Starts a local server."
	@echo "  docker-stop               Stops the local server."
	@echo
	@echo "  test                      Run all tests."
	@echo "  test-macos                Test only macOS."
	@echo "  test-ios                  Test iPhone and iPad."
	@echo "  test-iphone               Test only iPhone."
	@echo "  test-ipad                 Test only iPad."
	@echo

#
# Functions
#

define dependencies
	@bash script_install_dependencies.sh
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

#
# Docker
#

docker:
	rm -rf connect-server
	git clone git@github.com:powerhome/connect-server.git --depth 1
	@echo 'Disabling ldap...'
	yq -i '.synapse.ldap.enabled = false' ./connect-server/deploy/environment/development/values.yaml
	@echo 'Starting colima...'
	colima start || (limactl stop colima -f && colima start)
	@echo 'Starting docker...'
	cd connect-server && docker-compose down --remove-orphans
	cd connect-server && docker volume prune --force && docker-compose build && docker-compose up -d
	@echo 'Dock server started.'
	cp script_docker_setup.sh connect-server/script_docker_setup.sh
	cd connect-server && ./script_docker_setup.sh
	@echo 'Docker is running in the background, to stop it call: make docker-stop'

docker-stop:
	cd connect-server && docker-compose down --remove-orphans
	@echo 'Dock server stopped.'
	colima stop || limactl stop colima -f
	@echo 'Colima stopped.'

#
# Tests
#

test:
	$(call runDockerAndFastlane,run_ui_tests_macos)
	$(call runDockerAndFastlane,run_tests_iphone)
	$(call runDockerAndFastlane,run_tests_ipad)
	$(MAKE) docker-stop

test-macos:
	$(call runDockerAndFastlane,run_ui_tests_macos)
	$(MAKE) docker-stop

test-ios:
	$(call runDockerAndFastlane,run_tests_ipad)
	$(call runDockerAndFastlane,run_tests_iphone)
	$(MAKE) docker-stop

test-iphone:
	$(call runDockerAndFastlane,run_tests_iphone)
	$(MAKE) docker-stop

test-ipad:
	$(call runDockerAndFastlane,run_tests_ipad)
	$(MAKE) docker-stop

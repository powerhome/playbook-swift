source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "fastlane", "~> 2.226.0"
gem "json", "~> 2.10.1"
gem 'httparty'

# Until Fastlane includes them directly.
gem "abbrev"
gem "mutex_m"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)

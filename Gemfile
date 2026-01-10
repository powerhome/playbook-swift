source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "fastlane", "2.228.0"
gem "json", "2.15.1"
gem "httparty", "0.24.0"

# Until Fastlane includes them directly.
gem "abbrev"
gem "mutex_m"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)

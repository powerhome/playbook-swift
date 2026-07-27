source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "fastlane", "2.232.2"
gem "json", "2.19.9"
gem "httparty", "0.24.2"
gem "ostruct", "0.6.3"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)

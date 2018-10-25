source "https://rubygems.org"

gem "fastlane"
gem 'slather', '~> 2.4', '>= 2.4.4'
gem "dotenv"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)

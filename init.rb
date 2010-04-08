begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

ENV['APP_ROOT'] ||= File.expand_path('..', __FILE__)
ENV['THEMES_DIR'] ||= ENV['APP_ROOT'] + "/themes"
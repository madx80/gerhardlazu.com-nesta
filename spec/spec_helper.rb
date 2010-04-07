begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require(:default, :test)

require "rubygems"
require "spec/interop/test"

Test::Unit::TestCase.send :include, Rack::Test::Methods

Spec::Runner.configure do |config|
  config.include(RspecHpricotMatchers)
end

set :views => File.join(File.dirname(__FILE__), "..", "views"),
    :public => File.join(File.dirname(__FILE__), "..", "public")

set :environment, :test
set :reload_templates, true

require File.join(File.dirname(__FILE__), "..", "app")

module RequestSpecHelper
  def app
    Sinatra::Application
  end
  
  def body
    last_response.body
  end
end

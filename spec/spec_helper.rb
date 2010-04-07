require File.expand_path('../../init', __FILE__)
Bundler.require(:default, :test)
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

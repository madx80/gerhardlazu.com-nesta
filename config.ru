require "rubygems"
require "sinatra"
require "app"
require "rack/cache"

use Rack::Cache, 
  :verbose => true, 
  :metastore => "file:tmp/cache/meta", 
  :entitystore => "file:tmp/cache/body",
  :default_ttl => 3600,
  :allow_reload => true

run Sinatra::Application

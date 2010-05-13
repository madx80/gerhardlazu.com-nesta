require "rubygems"
require "bundler"
Bundler.setup(:default)
require "sinatra"
require "app"

run Sinatra::Application

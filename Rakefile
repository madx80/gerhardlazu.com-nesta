require File.expand_path('../init', __FILE__)
Bundler.require(:default, :rake)
require "spec/rake/spectask"

require File.join(File.dirname(__FILE__), *%w[spec model_factory])
require File.join(File.dirname(__FILE__), *%w[lib models])
require File.join(File.dirname(__FILE__), *%w[lib config])

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList["spec/*_spec.rb"]
end

class Factory
  include ModelFactory
end

# Extra tasks, let's keep this file lean
Dir["#{File.dirname(__FILE__)}/lib/tasks/*.rake"].each { |file| load file }
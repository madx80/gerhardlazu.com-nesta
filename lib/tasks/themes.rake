require "pp"

namespace :themes do
  desc "List all available themes"
  task :list do
    output = []
    Nesta::Config.themes.sort.each do |name, url|
      output << "* #{name}"
    end
    puts output.join("\n")
  end
  
  desc "Install specific theme"
  task :install do
    theme = ENV['THEME']
    if theme.nil? || !Nesta::Config.themes.has_key?(theme)
      puts "You must specify one of the following themes:\n"
      Rake::Task["themes:list"].execute
      puts "eg: rake themes:install THEME=postal3"
    else
      FileUtils.mkdir_p("#{ENV['APP_ROOT']}/themes") unless File.exists?("#{ENV['APP_ROOT']}/themes")
      if File.exists?("#{ENV['APP_ROOT']}/themes/#{theme}")
        puts "Theme #{theme} is already installed"
      else
        `git clone --depth=1 #{Nesta::Config.themes[theme]} #{ENV['APP_ROOT']}/themes/#{theme}`
        `rm -fR #{ENV['APP_ROOT']}/themes/#{theme}/.git`
        puts "Theme #{theme} successfully installed"
      end
    end
  end
end
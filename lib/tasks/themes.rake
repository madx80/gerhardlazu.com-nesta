namespace :themes do
  desc "List all available themes"
  task :list do
    output = []
    Nesta::Config.themes.sort.each do |name, url|
      output << "* #{name} #{installed?(name)}"
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
      FileUtils.mkdir_p(ENV['THEMES_DIR']) unless File.directory?(ENV['THEMES_DIR'])
      if File.directory?("#{ENV['THEMES_DIR']}/#{theme}")
        puts "Theme #{theme} is already installed"
      else
        system "git clone --depth=1 --quiet #{Nesta::Config.themes[theme]} #{ENV['THEMES_DIR']}/#{theme}"
        FileUtils.rm_r "#{ENV['THEMES_DIR']}/#{theme}/.git", :force => true
        puts "Theme #{theme} successfully installed"
      end
    end
  end
end

def installed?(theme)
  "[Installed]" if File.directory?("#{ENV['THEMES_DIR']}/#{theme}")
end
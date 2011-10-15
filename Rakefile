require 'rake'
require 'erb'
require 'lolize'
require_relative 'lib/install_file'


task :default => 'install'


desc "convert the README.md file to html"
task :markdown do
  require 'redcarpet'
  markdown = Redcarpet.new( File.new( 'README.md' ).read )
  puts markdown.to_html
end



desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  ignore = %w{ bashrc.old Gemfile Gemfile.lock }

  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE].include? file
    next if File.directory? file
    next if ignore.include? file

    dest_file = File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")

    # ENV['HOME'] = '/tmp/test'
    InstallFile.new( file ).install
  end

  bfuncs = Dir['bin/bfuncs/*'].collect{ |s| InstallFile.new( s, File.join( ENV['HOME'], s ) )}
  bfuncs.each do |f|
    # puts f
    f.install
  end
  # other = [ Install.new( ) ]
end


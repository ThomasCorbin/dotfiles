require 'rake'
require 'erb'
# require 'lolize'
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

  install_dir 'bin'
  install_dir 'bin/bfuncs'
  install_dir 'xemacs', true
end


def install_dir( dir, prefix_dir_with_dot = false )
  bfuncs = Dir[ "#{dir}/*" ].reject{ |f| File.directory? f }.collect do |file|
    dest_file = file

    dest_file = ".#{file}" if prefix_dir_with_dot

    InstallFile.new( file,
                     File.join( ENV['HOME'], dest_file ) )
  end


  bfuncs.each do |f|
    # puts f
    f.install
  end
end

require 'rake'


#
#       Represent a file that needs to be installed.
#
class InstallFile

  include Rake::DSL

  def replace_all
    @@replace_all ||= false
  end

  def initialize( source_file, dest_file = nil )

    @source_file  = source_file
    @dest_file    = dest_file

    if ! @dest_file
      @dest_file = File.join(ENV['HOME'], ".#{@source_file.sub('.erb', '')}")
    end

    make_dest_dir
  end


  def install
    if File.exist? @dest_file
      if File.identical? @source_file, @dest_file
        puts "identical #{@dest_file}"
        return
      end

      if replace_all
        replace_file
        return
      end

      interactively_replace
    else
      link_file
    end
  end


  def interactively_replace
    print "overwrite #{@dest_file}? [ynaq] "
    case $stdin.gets.chomp
    when 'a'
      @@replace_all = true
      replace_file
    when 'y'
      replace_file
    when 'q'
      exit
    else
      puts "skipping #{@dest_file}"
    end
  end


  def replace_file
    # system %Q{rm -rf "#{@dest_file}"}
    rm_rf @dest_file, :verbose => true
    link_file
  end


  def link_file
    if @source_file =~ /.erb$/
      puts "generating #{@dest_file}"
      File.open( @dest_file, 'w') do |new_file|
        new_file.write ERB.new(File.read(@source_file)).result(binding)
      end
    else
      # puts "linking to #{@dest_file}"
      # system %Q{ln -s "$PWD/#{@source_file}" "$HOME/.#{@source_file}"}
      ln_s( File.expand_path( @source_file ), @dest_file, :force => true, :verbose => true )
    end
  end


  def make_dest_dir
    mkpath File.dirname( File.expand_path( @dest_file ) ), :verbose => true
  end


  def to_s
    "Install #{@source_file} to #{@dest_file}"
  end
end

puts "Loading .pryrc"


loaded = false
if Pry.respond_to? "loaded_by_tom"
  loaded = true
  puts "loaded once already"
elsif
  class Pry
    def self.loaded_by_tom
      true
    end
  end
end



# begin
#   raise "boom"
#   puts "foo"
# rescue Exception => detail
#   puts detail.backtrace.join( "\n" )
# end

if ! loaded


  #
  # Utilitly to load stuff into irb and
  # have nice messages on failure (w/o screwing up irb)
  # and to do initialization (if desired) on success
  #
  def try_require(what, condition = true, &block)
    loaded, require_result = false, nil
    
    if ! condition
      puts "Not installing #{what}"
      return require_result
    end

    begin
      require_result = require what
      loaded = true

    rescue Exception => ex
      puts "** Unable to require '#{what}'"
      puts "--> #{ex.class}: #{ex.message}"
    end

    yield if loaded and block_given?

    require_result
  end


  def is_jruby?
    # RUBY_PLATFORM == 'java'
    (defined? RUBY_ENGINE && RUBY_ENGINE == 'jruby') ? true : false
  end


  def is_windows?
    (Config::CONFIG['host_os'] =~ /mswin|mingw/) ? true : false
  end



  if is_windows?
    # vim FTW
    Pry.config.editor = "gvim --nofork"
  elsif
    Pry.config.editor = "sublime_text -w"
  end
  # Pry.config.editor = proc { |file, line| "emacsclient #{file} +#{line}"

  # My pry is polite
  Pry.hooks = { :after_session => proc { puts "bye-bye" } }


  if ! defined? RUBY_ENGINE
    ruby_prefix = RbConfig::CONFIG["prefix"]
  elsif
    ruby_prefix = RUBY_ENGINE
  end
  
  if is_jruby? && is_windows?
    Pry.config.color = false
    # Prompt with ruby version
    Pry.prompt = [proc { |obj, nest_level, _| "#{ruby_prefix} #{RUBY_VERSION} (#{obj}):#{nest_level} > " },
                  proc { |obj, nest_level, _| "#{ruby_prefix} #{RUBY_VERSION} (#{obj}):#{nest_level} * " }]
  elsif
    try_require 'colorize'
    try_require 'lolize/auto'
    
    # Prompt with ruby version
    Pry.prompt = [proc { |obj, nest_level, _| "#{ruby_prefix} #{RUBY_VERSION} (#{obj}):#{nest_level} > ".colorize( :cyan ) },
                  proc { |obj, nest_level, _| "#{ruby_prefix} #{RUBY_VERSION} (#{obj}):#{nest_level} * ".colorize( :blue ) } ]
  end


  %w{map_by_method}.each { |gem| try_require gem }



  if ! is_jruby?
    try_require 'pp'
    try_require 'win32/console/ansi', is_windows?  # required for colorisation on windows
  end
  
  try_require 'wirble', false do
    Wirble.init
    Wirble.colorize
  end


  # Hirb takes model output from active record and outputs
  # it in a table
  # just do this in rails console:
  # > User.all
  try_require 'hirb' do

    puts "Configuring hirb"
    Hirb.enable
    Hirb::View.enable

    old_print = Pry.config.print
    Pry.config.print = proc do |output, value|
      Hirb::View.view_or_page_output(value) || old_print.call(output, value)
    end
  end


  # Toys methods
  # Stolen from https://gist.github.com/807492
  class Array
    def self.toy(n=10, &block)
      block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
    end
  end

  class Hash
    def self.toy(n=10)
      Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
    end
  end


  Pry.commands.command(/!(\d+)/, "Replay a line of history", :listing => "!hist") do |line|
    run "history --replay #{line}"
    # foo = run "history -s #{line} -n"
    # puts foo
    # puts foo.retval.to_s
    # Pry.history.push foo.to_s
  end

  Opt = Struct.new( :key, :value )

  def ph( hash )
    require 'hirb'
    extend Hirb::Console
    require 'hirb/import_object'

    contents = hash.inject( [] ){ |l,(k,v)| l << Opt.new( k, v.inspect) }
    # contents << Opt.new( 'host_os',         Config::CONFIG[ 'host_os']  )
    # contents << Opt.new( 'RUBY_PLATFORM',   RUBY_PLATFORM               )
    # contents << Opt.new( 'is_jruby?',       is_jruby?                   )
    # contents << Opt.new( 'is_windows?',     is_windows?                 )

    table contents, :fields => [:key, :value]
    puts
  end

  def psh( hash )
    require 'hirb'
    extend Hirb::Console
    require 'hirb/import_object'

    contents = hash.inject( [] ){ |l,(k,v)| l << Opt.new( k, v.inspect) }
    # contents << Opt.new( 'host_os',         Config::CONFIG[ 'host_os']  )
    # contents << Opt.new( 'RUBY_PLATFORM',   RUBY_PLATFORM               )
    # contents << Opt.new( 'is_jruby?',       is_jruby?                   )
    # contents << Opt.new( 'is_windows?',     is_windows?                 )

    table contents, :fields => [:key, :value]
    puts
  end

  def config
    psh RbConfig::CONFIG
  end

  def conf( key )
    RbConfig::CONFIG[key]
  end
end

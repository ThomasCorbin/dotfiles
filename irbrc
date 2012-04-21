require 'rubygems'



#  Utilitly to load stuff into irb and
#  have nice messages on failure (w/o screwing up irb)
#  and to do initialization (if desired) on success
def try_require(what, &block)
  loaded, require_result = false, nil

  begin
    require_result  = require what
    loaded          = true

  rescue Exception => ex
    puts "** Unable to require '#{what}'"
    puts "--> #{ex.class}: #{ex.message}"
  end

  yield if loaded and block_given?

  require_result
end


# require 'action_view'
# require 'action_view/helpers'
# h = ActionView::Helpers::TextHelper
# h.pluralize 3, "new messages"
# doesn't work.
# https://github.com/rails/rails/blob/master/actionpack/lib/action_view/helpers/text_helper.rb
# http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html

try_require 'ap'

#  "object oriented ri"
#  https://github.com/dadooda/ori
#
#  (in irb)>  "foo".ri
#  (in irb)>  "foo".ri :empty?
try_require 'ori'
#require 'what_methods'



#  adds methods such as 'pluralize', 'camelize', 'underscore'
#           'dasherize', etc.
# i = ActiveSupport::Inflector
# i.ordinalize 3
# "3rd"
try_require 'active_support/inflector'



#  Wirble pretty prints output and does tab completion on methods.
#  > "foo".em<tab>
try_require('wirble') do
  Wirble.init(:skip_prompt=>true)
  Wirble.colorize
end


#  Hirb takes model output from active record and outputs
#  it in a table
#  just do this in rails console:
#  > User.all
try_require 'hirb' do
  Hirb.enable
  Hirb::View.enable
end

#  ouputs an objects methods, sorted and grouped
#  by where they come from.
#  >lp "foo"
try_require 'looksee'

# try_require 'lolize/auto'



class Object
  # Return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.instance.methods).sort
  end
end


# detects a rails console, cares about version
def rails?(*args)
    version = args.first
    v2 = ($0 == 'irb' && ENV['RAILS_ENV'])
    v3 = ($0 == 'script/rails' && Rails.env)
    version == 2 ? v2 : version == 3 ? v3 : v2 || v3
end

# loading rails configuration if it is running as a rails console
load File.dirname(__FILE__) + '/.railsrc' if rails?

puts "is rails console? #{rails?}"


# activerecord logging methods
# very useful for digging into
# queries
#require 'logger'
#require 'activerecord' if rails?

#def enable_logger
#    log_to(Logger.new(STDOUT))
#end

#def disable_logger
#    log_to(nil)
#end

#def log_to(logger)
#    ActiveRecord::Base.logger = logger
#    ActiveRecord::Base.clear_active_connections!
#end

# logging into console by default
#enable_logger

def ep
  IRB.CurrentContext.workspace.evaluate(self, paste)
end

# http://gist.github.com/124272
# Thanks to Bjørn Arild Mæland
def copy(str)
  IO.popen('xclip -i', 'w') { |f| f << str.to_s }
end

def paste
  `xclip -o`
end

# http://www.themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def fl(file_name)
   file_name += '.rb' unless file_name =~ /\.rb/
   @@recent = file_name
   load "#{file_name}"
end

def rl
  fl(@@recent)
end

# More than one way to do this
# Commented is the ruby way
# uncommentted is my preferred way
# def ls( dir = '.' )
def ls( dir = '__FILE__' )
  # entries = instance_eval("Dir.entries(File.dirname(__FILE__))")
  entries = instance_eval("Dir.entries(File.dirname(__FILE__))")
  (entries - ["..", "."]).sort
  # %x{ls}.split("\n")
end

# def less
#   require 'stringio'
#   $stdout, sout = StringIO.new, $stdout
#   yield
#   $stdout, str_io = sout, $stdout
#    IO.popen('less', 'w') do |f|
#      f.write str_io.string
#      f.flush
#      f.close_write
#    end
# end

# def ls( dir = '.' )
#   system( "ls -CF #{dir}" )
#   # `ls -CF #{dir}`
# end


def cd( dir = Dir.home )
  Dir.chdir dir
end


def pwd
  puts Dir.pwd
end


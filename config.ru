libdir = File.join(__FILE__, '../lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'endpoint'
Bot.instance = Bot.new
$stdout.sync = true
run SkimEndpoint.new

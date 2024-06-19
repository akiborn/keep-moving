require 'bundler/setup'

Bundler.require(:default)

require_relative 'timer'
require_relative 'mouse'
require_relative 'hunter'

require_relative 'timer_thread'
require_relative 'mouse_thread'
require_relative 'hunter_thread'
require_relative 'operation_thread'

# Stub Guard
module Guard
  class Plugin
    def initialize(options = {})
    end
  end

  module UI
    class << self
      def method_missing(meth, *args)
        Locomotive::Wagon::Logger.send(meth, *args)
      end
    end
  end
end

require 'guard/livereload'
require 'locomotive/wagon/misc/tcp_port'

module Locomotive
  module Wagon

    class LiveReload

      extend Forwardable

      def_delegators :@livereload, :start, :stop, :run_on_modifications

      attr_reader :port

      def initialize(options = {})
        tcp_port = Locomotive::Wagon::TcpPort.new(options[:host], 35729)
        @port = tcp_port.first

        Locomotive::Wagon::Logger.debug "Run LiveReload on port '#{@port}'"

        @livereload = Guard::LiveReload.new(options.merge(port: @port))
      end

    end

  end
end
# Override the Rack::Handler to bind to 0.0.0.0 which is required to support
# http://lvh.me redirects

module Rack
  module Handler
    class << self
      alias_method :orig_default, :default
    end

    def self.default(options = {})
      orig_default.instance_eval do
        class << self
          alias_method :orig_run, :run
        end

        def self.run(app, options = {})
          env = (options[:environment] || Rails.env)
          if options[:Host] == 'localhost' && env == 'development'
            message(options[:Port])
            options.merge!(Host: '0.0.0.0')
          end
          orig_run(app, **options)
        end

        def self.message(port)
          puts '****************************************************************************************'
          puts "* Override binding 'localhost' to '0.0.0.0' for http://lvh.me:#{port}/ support"
          puts '****************************************************************************************'
        end
      end
      orig_default
    end
  end
end

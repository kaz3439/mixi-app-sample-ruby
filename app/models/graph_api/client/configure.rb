module GraphApi
  module Client
    module Configure

      class << self
        attr_accessor :consumer_key, :consumer_secret, :redirect_url

        def keys
          @keys ||= [
            :consumer_key,
            :consumer_secret,
            :redirect_url
          ]
        end

        def configure
          yield self
          self
        end
 
        def credentials?
          credentials.values.all?
        end

        def credentials
          Hash[keys.map{|key| [key, instance_variable_get("@#{key}")]}]
        end

      end

    end #Configure
  end #Client
end #GraphApi

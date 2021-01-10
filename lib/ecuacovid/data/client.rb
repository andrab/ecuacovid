module EcuacovidData

  class Client
    attr_reader :handshake, :connection
    
    def initialize(options={})
      @handshake = options[:handshake] || Handshake.local_storage
    end
    
    def connection
      @connection ||= begin
        @handshake.establish_connection!
        @handshake.connection
      end
    end
    
    def positives(options={})
      connection.positives(filters: options[:filters] || [[:year, :in, [2020, 2021]]])
    end

    def deaths(options={})
      connection.deaths(filters: options[:filters] || [[:year, :in, [2020, 2021]]])
    end

    def mortalities(options={})
      connection.mortalities(filters: options[:filters] || [[:year, :in, [2020, 2021]]])
    end
  end

end

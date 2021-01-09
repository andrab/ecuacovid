module EcuacovidData

  class Client
    attr_reader :handshake, :connection
    
    def initialize(options={})
      @handshake = options[:handshake] || Handshake.new
    end
    
    def connection
      @connection ||= begin
        @handshake.establish_connection!
        @handshake.connection
      end
    end
    
    def positives(options={})
      connection.positives(filters: options[:filters])
    end
  end

end

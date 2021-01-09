require 'ecuacovid/data/local_store'

module EcuacovidData

  class Handshake
    class << self
      def local_storage
        LocalStorage.new
      end
    end
    
    class LocalStorage
      attr_reader :connection
    
      def establish_connection!
        @connection = Connection.new(LocalStore.new)
      end
    end

  end

end
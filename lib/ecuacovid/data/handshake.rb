require 'ecuacovid/data/local_store'
require 'ecuacovid/data/local_fast_store'

module EcuacovidData

  class Handshake
    class << self
      def local_storage
        LocalStorage.new
      end

      def local_fast_storage
        LocalFastStorage.new
      end
    end

    class LocalFastStorage
      attr_reader :connection

      def establish_connection!
        @connection = Connection.new(LocalFastStore.new)
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
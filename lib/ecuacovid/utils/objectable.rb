module Ecuacovid
  module Utils
    module Objectable
      def method_missing(name, *args, &block)
        return fetch(name) if has_key? name
        super.method_missing name, *args, &block
      end
      
      class ::Hash
        def to_objectable
          self.extend Objectable
        end
      end
    end
  end
end
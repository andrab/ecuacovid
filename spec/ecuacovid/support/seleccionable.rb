module Seleccionable
  def probar(cuantos)
    send *(
        lambda do |n|
            n.zero? ? [:itself] : [:[], (...n)]
        end.call(cuantos.to_i)
    )
  end
    
  class ::Array
    def seleccionable
      self.extend Seleccionable
    end
  end
end

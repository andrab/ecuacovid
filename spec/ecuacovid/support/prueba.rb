
class PruebaError < StandardError; end
  
class Prueba
  attr_reader :fallo
    
  def initialize(caso, options = {})
    @caso, @options = caso, options
    @fallo = true
  end
    
  def test
    IO.popen([nu!, "-c", @caso.command], :err => [:child, :out]) do |out|
      yield(self, out.read)
    end
  end
    
  def fallar!
    @fallo = true
  end
    
  def ok!
    ok?
    @fallo = false
  end
    
  def ok?
    raise @razon if @fallo
    true
  end
    
  def err!(razon)
    @razon = PruebaError.new(razon)
    fallar!
  end
end

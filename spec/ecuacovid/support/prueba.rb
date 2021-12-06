class Prueba
  class PruebaError < StandardError; end

  attr_reader :fallo
    
  def initialize(caso, options = {})
    @caso, @options = caso, options
    @fallo = true
  end
    
  def test
    IO.popen([nu!, "-c", @caso.command], :err => [:child, :out]) do |out|
      yield(self, out.read)
    end
    self
  end
    
  def fallar!
    @fallo = true
  end
    
  def ok!
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

  class << self
    def nu!(program = "nu")
      extensions = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        extensions.each do |extension|
          binary = File.join(path, "#{program}#{extension}")
          return binary if File.executable?(binary) && !File.directory?(binary)
        end
      end
  
      "#{ENV['NU_PATH']}/#{program}"
    end
  end

  def nu!(program = "nu")
    self.class.nu!(program)
  end
  
end

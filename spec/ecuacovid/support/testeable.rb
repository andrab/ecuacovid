module Testeable
  def probar!
    prueba = Prueba.new(self)
  
    prueba.fallar! unless block_given?
  
    prueba.test do |test_run, out|
      test_run.fallar! unless yield(out.to_i)
    
      rescue StandardError => e
      prueba.err!("¡Falló! Algo salió mal: #{e.message}")
    end
  end
end
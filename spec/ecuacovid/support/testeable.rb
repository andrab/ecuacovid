module Testeable
  def probar!
    test_run = Prueba.new(self).test do |run, out|
      run.ok! if yield(out.size < 20 ? out.to_i : out)
      rescue StandardError => e
      run.err!("¡Falló! Algo salió mal: #{e.message}")
    end

    test_run.ok?
  end
end
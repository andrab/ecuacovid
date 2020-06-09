require_relative "../support/prueba"
require_relative "../support/caso"

class MuertesProbablesTest
  include Caso

  def initialize(source = "ecuacovid.csv")
    @source = File.join(DIRECTORY, source)
  end

  def muertes_con_probables(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | get muertes muertes_probables total_muertes "\
               " | sum "\
               " | echo $it"
    probar!(&block)
  end
end

describe "Muertes Probables registradas" do
  require_relative "../criterios"
  require_relative "../cifras"

  Criterios.para(:con_muertes_probables).each do |(de_informe, fecha, spec)|
    total_esperadas = spec[:total] + spec[:probables] + spec[:muertes]

    _, numero, hora = de_informe.to_s.split('_')
    ruta =  numero != "SIN" ? File.join(
      File.expand_path('../../../../informes/SGNRE/', __FILE__),
      [numero, fecha.gsub('/', '_'), hora].join('-') + ".pdf"
    ) : "No hubo informe publicado para #{fecha.gsub('/', '_')}"

    context "informe: #{ruta}..." do
      datos = MuertesProbablesTest.para(fecha)

      it "Verificando muertes con muertes probables.." do
        
        datos.muertes_con_probables do |total|
          expect(total).to be(total_esperadas)
        end
      end
    end
  end
end

require_relative "../support/prueba"
require_relative "../support/caso"

class NacionalPositivasTest
  include Caso

  def initialize(source = "ecuacovid.csv")
    @source = File.join(DIRECTORY, source)
  end

  def casos(&block)
    @command = "open #{@source}                                                       "\
               " | where created_at == #{@fecha}                                      "\
               " | echo $it.pcr_positivas                                             "
    probar!(&block)
  end
end

class NacionalMuertesProbablesTest
  include Caso

  def initialize(source = "ecuacovid.csv")
    @source = File.join(DIRECTORY, source)
  end

  def muertes_con_probables(&block)
    @command = "open #{@source}                                                       "\
               " | where created_at == #{@fecha}                                      "\
               " | reduce -f 0 {                                                      "\
               "   = $acc + $it.muertes + $it.muertes_probables + $it.total_muertes   "\
               "   }                                                                  "\
               " | echo $it                                                           "
    probar!(&block)
  end
end

describe "Información Nacional" do
  require_relative "../criterios"
  require_relative "../cifras"

  context "Pruebas positivas" do
    Criterios.para(:positivas).each do |(informe, fecha, spec)|
      casos_totales = spec[:casos]

      prueba = NacionalPositivasTest.para(fecha)

      it "Verificando día #{fecha}: #{prueba.formatear(informe)}..." do
        prueba.casos do |total|
          expect(total).to be(casos_totales)
        end
      end
    end
  end

  context "Muertes probables" do
    Criterios.para(:con_muertes_probables).each do |(informe, fecha, spec)|
      total_esperadas = spec[:total] + spec[:probables] + spec[:muertes]
  
      prueba = NacionalMuertesProbablesTest.para(fecha)
  
      it "Verificando día #{fecha}: #{prueba.formatear(informe)}..." do
        prueba.muertes_con_probables do |total|
          expect(total).to be(total_esperadas)
        end
      end
    end
  end
end
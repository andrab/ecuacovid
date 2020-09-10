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
               " | echo $it.positivas_pcr                                             "
    probar!(&block)
  end
end

class NacionalMuertesProbablesTest
  include Caso

  def initialize(source = "ecuacovid.csv")
    @source = File.join(DIRECTORY, source)
  end

  def muertes_con_probables(&block)
    @command = "open #{@source}                                                             "\
               " | where created_at == #{@fecha}                                            "\
               " | reduce -f 0 {                                                            "\
               "   = $acc + $it.muertes_confirmadas + $it.muertes_probables + $it.muertes   "\
               "   }                                                                        "\
               " | echo $it                                                                 "
    probar!(&block)
  end
end

class NacionalMuestrasTest
  require_relative '../criterios'
  include Caso

  def initialize(source = "ecuacovid.csv")
    @source = File.join(DIRECTORY, source)
  end

  def muestras(casos, &block)
    casos = casos.nil? ? "$it.positivas_pcr" : casos.to_s

    @command = "open #{@source}                                                              "\
               " | where created_at == #{@fecha}                                             "\
               " | insert test_rezagadas {                                                   "\
               "     = $it.muestras_pcr - (#{casos} + $it.negativas_pcr)                     "\
               "   }                                                                         "\
               " | insert test_rezagadas_con_rapidas {                                       "\
               "     = $it.muestras - (#{casos}                                              "\
               "                       + $it.positivas_rapidas                               "\
               "                       + $it.negativas_rapidas                               "\
               "                       + $it.negativas_pcr)                                  "\
               "   }                                                                         "\
               " | insert test_muestras  {                                                   "\
               "     = #{casos} + $it.positivas_rapidas + $it.negativas                      "\
               "                + ($it.muestras - ($it.positivas + $it.negativas))           "\
               "   }                                                                         "\
               " | select test_rezagadas test_rezagadas_con_rapidas test_muestras            "\
               " | to json                                                                   "\
               " | echo $it                                                                  "
    probar!(&block)
  end
end

describe "Información Nacional" do
  require_relative "../criterios"
  require_relative "../cifras"

  context "Muestras" do
    require 'json'

    Criterios.para(:con_muestras).each do |(informe, fecha, spec)|
      muestras = spec[:muestras]
      rezagadas =  spec[:rezagadas]
      positivas_pcr = informe == :_SIN_INFORME_ ? nil : spec[:positivas_pcr]

      prueba = NacionalMuestrasTest.para(fecha)

      it "Verificando día #{fecha}: #{prueba.formatear(informe)}..." do
        prueba.muestras(positivas_pcr) do |valores|
          valores = JSON.load(valores).transform_keys(&:to_sym)

          expect(valores[:test_rezagadas]).to be(rezagadas)
          expect(valores[:test_rezagadas_con_rapidas]).to be(rezagadas)
          expect(valores[:test_muestras]).to be(muestras)
        end
      end
    end
  end

  context "Pruebas positivas" do
    Criterios.para(:positivas).each do |(informe, fecha, spec)|
      casos_totales = spec[:casos]

      prueba = NacionalPositivasTest.para(fecha)

      it "Verificando día #{fecha}: #{prueba.formatear(informe)}..." do
        prueba.casos do |total|
          expect(total).to be(informe == :_SIN_INFORME_ ? total : casos_totales)
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
require_relative "../support/prueba"
require_relative "../support/caso"

class NacionalTest
  include Caso

  def initialize(source = "ecuacovid.csv")
    @source = File.join(DIRECTORY, source)
  end

  def casos(&block)
    @command = "open #{@source}                                                       "\
               " | where created_at == #{@fecha}                                      "\
               " | get positivas_pcr                                                  "
    probar!(&block)
  end

  def muertes_con_probables(&block)
    @command = "open #{@source}                                                             "\
               " | where created_at == #{@fecha}                                            "\
               " | reduce -f 0 {                                                            "\
               "   $acc + $it.muertes_confirmadas + $it.muertes_probables + $it.muertes   "\
               "   }                                                                        "
    probar!(&block)
  end

  def muestras(casos, &block)
    casos = casos.nil? ? "$it.positivas_pcr" : casos.to_s

    @command = "open #{@source}                                                              "\
               " | where created_at == #{@fecha}                                             "\
               " | insert test_rezagadas {                                                   "\
               "     $it.muestras_pcr - (#{casos} + $it.negativas_pcr)                     "\
               "   }                                                                         "\
               " | insert test_rezagadas_con_rapidas {                                       "\
               "     $it.muestras - (#{casos}                                              "\
               "                       + $it.positivas_rapidas                               "\
               "                       + $it.negativas_rapidas                               "\
               "                       + $it.negativas_pcr)                                  "\
               "   }                                                                         "\
               " | insert test_muestras  {                                                   "\
               "     #{casos} + $it.positivas_rapidas + $it.negativas                      "\
               "                + ($it.muestras - ($it.positivas + $it.negativas))           "\
               "   }                                                                         "\
               " | select test_rezagadas test_rezagadas_con_rapidas test_muestras            "\
               " | to json                                                                   "
    probar!(&block)
  end
end

describe "Información Nacional" do
  require_relative "../criterios"
  require_relative "../cifras"
  require "json"

  Criterios.para(:con_muestras).each do |(informe, fecha, spec)|
    muestras = spec[:muestras]
    rezagadas =  spec[:rezagadas]
    positivas_pcr = informe == :_SIN_INFORME_ ? nil : spec[:positivas_pcr]

    prueba = NacionalTest.para(fecha)

    context "Muestras: #{fecha}" do
      prueba.muestras(positivas_pcr) do |valores|
        valores = JSON.load(valores).transform_keys(&:to_sym)

        it "Verificando rezadas..." do
          expect(valores[:test_rezagadas]).to be(rezagadas)
        end

        it "Verificando rezadas con rápidas..."  do
          expect(valores[:test_rezagadas_con_rapidas]).to be(rezagadas)
        end

        it "Verificando muestras tomadas..." do
          expect(valores[:test_muestras]).to be(muestras)
        end
      end
    end
  end
  
  Criterios.para(:positivas).each do |(informe, fecha, spec)|
    casos_totales = spec[:casos]

    prueba = NacionalTest.para(fecha)

    context "PCR: #{fecha}" do
      prueba.casos do |total|
        it "Verificando positivas..." do
          expect(total).to be(informe == :_SIN_INFORME_ ? total : casos_totales)
        end
      end
    end
  end

  Criterios.para(:con_muertes_probables).each do |(informe, fecha, spec)|
    total_esperadas = spec[:total] + spec[:probables] + spec[:muertes]
  
    prueba = NacionalTest.para(fecha)
  
    context "Muertes: #{fecha}" do
      prueba.muertes_con_probables do |total|
        it "Verificando con muertes probables..." do
          expect(total).to be(total_esperadas)
        end
      end
    end
  end
end
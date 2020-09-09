require_relative "../support/prueba"
require_relative "../support/caso"

class PositivasTest
  include Caso

  def initialize(source = "positivas/cantones.csv")
    @source = File.join(DIRECTORY, source)
  end

  def usar_provincias!
    @source = File.join(DIRECTORY, "positivas/provincias.csv")
  end

  def casos(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | reduce -f 0 { = $acc + $it.total } "\
               " | echo $it"
    probar!(&block)
  end

  def cantones(&block)
    @command = "open #{@source} | where created_at == #{@fecha} | count | echo $it"
    probar!(&block)
  end

  def cantones_ingresados(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} && total > 0 "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end

  def cantones_sin_ingresar(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} && total == 0 "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end

  def poblaciones(&block)
    @command = "open #{@source}                                                   "\
               " | where created_at == #{@fecha}                                  "\
               " | group-by provincia                                             "\
               " | pivot provincia poblacion                                      "\
               " | update poblacion {                                             "\
               "     get poblacion | reduce -f 0 {                                "\
               "       = $acc + $it.canton_poblacion                              "\
               "     }                                                            "\
               "   }                                                              "\
               " | to json                                                        "\
               " | echo $it                                                       "
    probar!(&block)
  end
end

describe "Casos Positivos" do  
  context "Por fecha" do
    require "json"

    require_relative "../criterios"
    require_relative "../cifras"

    Criterios.para(:positivas).each do |(informe, fecha, spec)|
      casos_totales = spec[:casos]
      ingresados_totales =  spec[:cantones_ingresados]
      sin_ingresar_totales = spec[:sin_ingresar]

      datos = PositivasTest.para(fecha)

      context "informe: #{datos.formatear(informe)}..." do
        it "Verificando casos.." do
          datos.casos do |total|
            expect(total).to be(casos_totales)
          end
        end

        it "Verificando cantones con información.." do
          datos.cantones_ingresados do |total|
            expect(total).to be(ingresados_totales)
          end
        end 
 
        it "Verificando cantones sin información.." do
          datos.cantones_sin_ingresar do |total|
            expect(total).to be(sin_ingresar_totales)
          end
        end
 
        it "Verificando que todos los cantones existen.." do
          expect(ingresados_totales + sin_ingresar_totales).to be(221)
        end
 
        it "Verificando población por provincia sumando sus cantones respectivos.." do
          datos.poblaciones do |poblaciones|
            poblaciones = {}.tap do |actuales|
              JSON.load(poblaciones).each do |d|
                actuales[d["provincia"]] = d["poblacion"]
              end
            end

            expect(Cifras.poblaciones).to eq(poblaciones)
          end
        end
      end
    end
  end
end

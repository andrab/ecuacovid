require_relative "../support/prueba"
require_relative "../support/caso"

class MuertesTest
  include Caso

  def initialize(source = "muertes/provincias.csv")
    @source = File.join(DIRECTORY, source)
  end

  def casos(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | reduce -f 0 { = $acc + $it.total } "\
               " | echo $it"
    probar!(&block)
  end

  def provincias_ingresadas(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} && total > 0 "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end
  
  def provincias_sin_ingresar(&block)
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
               "       = $acc + $it.poblacion                                     "\
               "      }                                                           "\
               "   }                                                              "\
               " | to json                                                        "\
               " | echo $it                                                       "
    probar!(&block)
  end
end

describe "Muertes registradas" do
  require "json"

  require_relative "../criterios"
  require_relative "../cifras"

  Criterios.para(:muertes).each do |(informe, fecha, spec)|
    muertes_totales = spec[:muertes]
    ingresadas_totales =  spec[:provincias_ingresadas]
    sin_ingresar_totales = spec[:sin_ingresar]

    datos = MuertesTest.para(fecha)

    context "informe: #{datos.formatear(informe)}..." do
      lambda do
        it "Verificando casos.." do
          datos.casos do |total|
            expect(total).to be(muertes_totales)
          end
        end
        
        it "Verificando provincias con información.." do
          datos.provincias_ingresadas do |total|
            expect(total).to be(ingresadas_totales)
          end
        end 

        it "Verificando provincias sin información.." do
          datos.provincias_sin_ingresar do |total|
            expect(total).to be(sin_ingresar_totales)
          end
        end

        it "Verificando que todas los provincias existen.." do
          expect(ingresadas_totales + sin_ingresar_totales).to be(24)
        end

        it "Verificando población por provincia.." do
          datos.poblaciones do |poblaciones|
            poblaciones = {}.tap do |actuales|
              JSON.load(poblaciones).each do |d|
                actuales[d["provincia"]] = d["poblacion"]
              end
            end

            expect(Cifras.poblaciones).to eq(poblaciones)
          end
        end
      end.call if ingresadas_totales
    end
  end
end

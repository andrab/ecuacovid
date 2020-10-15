require_relative "../support/prueba"
require_relative "../support/caso"

class PositivasTest
  include Caso

  class << self
    def provinciales(fecha)
      datos = PositivasTest.para(fecha)
      datos.usar_provincias!
      datos
    end

    def cantones_tabuladas(fecha)
      Tabuladas.para(fecha)
    end

    def provinciales_tabuladas(fecha)
      Tabuladas.provinciales(fecha)
    end
  end

  def initialize(source = "positivas/cantones.csv")
    @source = File.join(DIRECTORY, source)
  end

  def usar_provincias!
    @source = File.join(DIRECTORY, "positivas/provincias.csv")
  end

  def casos(&block)
    @command = "open #{@source}                                                            "\
               " | where created_at == #{@fecha}                                           "\
               " | reduce -f 0 {                                                           "\
               "    = $acc + $it.total                                                     "\
               " }                                                                         "
    probar!(&block)
  end

  def cantones(&block)
    @command = "open #{@source} | where created_at == #{@fecha} | count | echo $it"
    probar!(&block)
  end

  def ingresados(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} && total > 0 "\
               " | count "
    probar!(&block)
  end

  def sin_ingresar(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} && total == 0 "\
               " | count "
    probar!(&block)
  end

  def poblaciones(&block)
    @command = "open #{@source}                                                             "\
               " | where created_at == #{@fecha}                                            "\
               " | group-by provincia                                                       "\
               " | pivot provincia poblacion                                                "\
               " | update poblacion {                                                       "\
               "     get poblacion | reduce -f 0 {                                          "\
               "       = $acc + $it.canton_poblacion                                        "\
               "     }                                                                      "\
               "   }                                                                        "\
               " | to json                                                                  "
    probar!(&block)
  end

  class Tabuladas
    include Caso

    class << self
      def provinciales(fecha)
        datos = Tabuladas.para(fecha)
        datos.usar_provincias!
        datos
      end
    end

    def initialize(source = "positivas/por_fecha/cantones_por_dia_acumuladas.csv")
      @source = File.join(DIRECTORY, source)
    end

    def usar_provincias!
      @source = File.join(DIRECTORY, "positivas/por_fecha/provincias_por_dia_acumuladas.csv")
    end
#
    def casos(&block)
      @command = "open #{@source}                                                          "\
                 " | reduce -f 0 {                                                         "\
                 "    = $acc + $it.'#{@fecha}'                                             "\
                 " }                                                                       "
      probar!(&block)
    end
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

      cantonales = PositivasTest.para(fecha)

      context "informe: #{cantonales.formatear(informe)}..." do
        it "Verificando casos.." do
          cantonales.casos do |total|
            expect(total).to be(casos_totales)
          end
        end

        it "Verificando casos tabuladas.." do
          PositivasTest.cantones_tabuladas(fecha).casos do |total|
            expect(total).to be(casos_totales)
          end
        end

        it "Verificando provinciales.." do
          PositivasTest.provinciales(fecha).casos do |total|
            expect(total).to be(casos_totales)
          end
        end

        it "Verificando provinciales tabuladas.." do
          PositivasTest.provinciales_tabuladas(fecha).casos do |total|
            expect(total).to be(casos_totales)
          end
        end

       it "Verificando cantones con información.." do
          cantonales.ingresados do |total|
            expect(total).to be(ingresados_totales)
          end
        end 
 
        it "Verificando cantones sin información.." do
          cantonales.sin_ingresar do |total|
            expect(total).to be(sin_ingresar_totales)
          end
        end
 
        it "Verificando que todos los cantones existen.." do
          expect(ingresados_totales + sin_ingresar_totales).to be(221)
        end
 
        it "Verificando población por provincia sumando sus cantones respectivos.." do
          cantonales.poblaciones do |poblaciones|
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

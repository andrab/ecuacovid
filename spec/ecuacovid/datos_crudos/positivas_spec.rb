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
               " | get total "\
               " | math sum "\
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
               " | get canton "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end

  def cantones_sin_ingresar(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} && total == 0 "\
               " | get canton "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end

  def poblacion_total_de(provincia, &block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | group-by provincia "\
               " | get \"#{provincia}\".canton_poblacion "\
               " | math sum "\
               " | echo $it"
    probar!(&block)
  end
end

describe "Casos Positivos" do  
  context "Por fecha" do
    require_relative "../criterios"
    require_relative "../cifras"

    Criterios.para(:positivas).each do |(de_informe, fecha, spec)|
      casos_totales = spec[:casos]
      ingresados_totales =  spec[:cantones_ingresados]
      sin_ingresar_totales = spec[:sin_ingresar]

      _, numero, hora = de_informe.to_s.split('_')
      ruta =  numero != "SIN" ? File.join(
        File.expand_path('../../../../informes/SGNRE/', __FILE__),
        [numero, fecha.gsub('/', '_'), hora].join('-') + ".pdf"
      ) : "No hubo informe publicado para #{fecha.gsub('/', '_')}"

      context "informe: #{ruta}..." do
        datos = PositivasTest.para(fecha)

        datos.usar_provincias! if not ingresados_totales
          
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
          Cifras.poblaciones.each_pair do |provincia, poblacion_esperada|    
            datos.poblacion_total_de(provincia) do |total|
              expect(total).to be(poblacion_esperada)
            end
          end
        end
      end
    end
  end
end

require_relative "../support/prueba"
require_relative "../support/caso"

class PositivasTest
  include Caso

  def initialize(source = "positivas/cantones.csv")
    @source = File.join(DIRECTORY, source)
  end

  def casos(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | get total "\
               " | sum "\
               " | echo $it"
    probar!(&block)
  end

  def provincias(&block)
    @command = "open #{@source} "\
               ' | format "{provincia}-{created_at}"'\
               " | wrap sujeto "\
               " | group-by sujeto "\
               " | pivot "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end

  def cantones(&block)
    @command = "open #{@source} | count | echo $it"
    probar!(&block)
  end

  def cantones_ingresados(&block)
    @command = "open #{@source}                  "\
               " | where created_at == #{@fecha} "\
               " | where total > 0 "\
               " | get canton "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end
  
  def cantones_sin_ingresar(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | where total == 0 "\
               " | get canton "\
               " | count "\
               " | echo $it"
    probar!(&block)
  end

  def poblacion_total_de(provincia, &block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | group-by provincia "\
               " | get \"#{provincia}\" "\
               " | get canton_poblacion "\
               " | sum "\
               " | echo $it"
    probar!(&block)
  end
end

describe "Casos Positivos" do
  context "Todas las fechas" do
    let(:fechas_totales) { Criterios.para(:positivas).count }

    it "Contiene todas las provincias por día" do
      veces = fechas_totales
      PositivasTest.new.provincias do |total|
        expect(total).to be(24 * veces),
          "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
      end
    end
  
    it "Contiene todos los cantones por día" do
      veces = fechas_totales
      PositivasTest.new.cantones do |total|
        expect(total).to be(221 * veces),
          "Se esperaban #{221 * veces} cantones registrados, devolvió: #{total}"
      end
    end
  end
  
  context "Por fecha" do
    require_relative "../criterios"
    require_relative "../cifras"

    Criterios.para(:positivas).each do |(de_informe, fecha, spec)|
      casos_totales = spec[:casos]
      ingresados_totales =  spec[:cantones_ingresados]
      sin_ingresar_totales = spec[:cantones_sin_ingresar]

      nombre, numero, hora = de_informe.to_s.split('_')
      ruta = File.join(
        File.expand_path('../../../../informes/SNGRE', __FILE__),
        [nombre, numero, fecha.gsub('/', '_'), hora].join('-') + ".pdf"
      )

      context "informe: #{ruta}..." do
        datos = PositivasTest.para(fecha)
          
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
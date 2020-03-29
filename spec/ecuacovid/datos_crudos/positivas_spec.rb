require_relative "../support/prueba"
require_relative "../support/caso"

class PositivasTest
  include Caso

  def initialize(source = "positivas.json")
    @source = File.join(DIRECTORY, source)
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

  def casos(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | get total "\
               " | sum "\
               " | echo $it"
    probar!(&block)
  end
end

describe "Casos Positivos" do
  require_relative "../criterios"

  context "Todas las fechas" do
    let(:fechas_totales) { Criterios.para(:positivas).count }

    it "Contiene todas las provincias por día" do
      veces = fechas_totales
      PositivasTest.todas_las_provincias do |total|
        expect(total).to be(24 * veces),
          "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
      end
    end
  
    it "Contiene todos los cantones por día" do
      veces = fechas_totales
      PositivasTest.todos_los_cantones do |total|
        expect(total).to be(221 * veces),
          "Se esperaban #{221 * veces} cantones registrados, devolvió: #{total}"
      end
    end
  end
  
  context "Por fecha" do
    Criterios.para(:positivas).each do |(de_informe, fecha, spec)|
      casos_totales, ingresados_totales, sin_ingresar_totales = spec.values_at(:casos, :cantones_ingresados, :cantones_sin_ingresar)

      context "Del informe en fuentes/#{de_informe.to_s}.pdf" do
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
      end
    end
  end
end
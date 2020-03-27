require_relative "../support/prueba"
require_relative "../support/caso"

class Confirmaciones
  include Caso

  def initialize(source = "confirmaciones.csv")
    @source = File.join(DIRECTORY, source)
  end

  def provincias(&block)
    @command = "open #{@source} | format \"\{provincia\}-\{created_at\}\" | wrap sujeto | group-by sujeto | pivot | count | echo $it"
    probar!(&block)
  end

  def cantones(&block)
    @command = "open #{@source} | count | echo $it"
    probar!(&block)
  end

  def cantones_ingresados(&block)
    @command = "open #{@source} | where created_at == #{@fecha} | where total > 0 | get canton | count | echo $it"
    probar!(&block)
  end
  
  def cantones_sin_ingresar(&block)
    @command = "open #{@source} | where created_at == #{@fecha} | where total == 0 | get canton | count | echo $it"
    probar!(&block)
  end

  def casos(&block)
    @command = "open #{@source} | where created_at == #{@fecha} | get total | sum | echo $it"
    probar!(&block)
  end
end

describe "Casos Confirmados" do
  context "COE" do
    context "Todas las fechas" do
      let(:fechas_totales) { 5 }

      it "Contiene todas las provincias por día" do
        veces = fechas_totales
  
        Confirmaciones.todas_las_provincias do |total|
          expect(total).to be(24 * veces), "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
        end
      end
  
      it "Contiene todos los cantones por día" do
        veces = fechas_totales
          
        Confirmaciones.todos_los_cantones do |total|
          expect(total).to be(221 * veces), "Se esperaban #{221 * veces} cantones registrados, devolvió: #{total}"
        end
      end
    end
  
    context "Por fecha" do
      [ #────FECHA─────┬─────────────────────VERIFICACIONES──────────────────────────────#
        ["25/03/2020", {casos: 1211, cantones_ingresados: 77, cantones_sin_ingresar: 144}],
        ["24/03/2020", {casos: 1082, cantones_ingresados: 68, cantones_sin_ingresar: 153}],
        ["23/03/2020", {casos:  981, cantones_ingresados: 58, cantones_sin_ingresar: 163}],
        ["22/03/2020", {casos:  789, cantones_ingresados: 51, cantones_sin_ingresar: 170}],
        ["21/03/2020", {casos:  532, cantones_ingresados: 43, cantones_sin_ingresar: 178}]
      ].each do |(fecha, spec)|
        casos_totales, ingresados_totales, sin_ingresar_totales = spec.values_at(
            :casos,
            :cantones_ingresados,
            :cantones_sin_ingresar
        )

        datos = Confirmaciones.para(fecha)
          
        it "Casos en #{fecha}" do
          datos.casos do |total|
            expect(total).to be(casos_totales), "Se esperaban #{casos_totales} confirmados, devolvió: #{total}" 
          end
        end

        it "Cantones con información en #{fecha}" do
          datos.cantones_ingresados do |total|
            expect(total).to be(ingresados_totales), "Se esperaba #{ingresados_totales}, devolvió: #{total}"
          end
        end 

        it "Cantones sin información en #{fecha}" do
          datos.cantones_sin_ingresar do |total|
            expect(total).to be(sin_ingresar_totales), "Se esperaba #{sin_ingresar_totales}, devolvió: #{total}"
          end
        end

        it "Están todos los cantones de Ecuador en #{fecha}" do
          expect(ingresados_totales + sin_ingresar_totales).to be(221)
        end
      end
    end
  end
end
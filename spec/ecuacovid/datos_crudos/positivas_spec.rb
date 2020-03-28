require_relative "../support/prueba"
require_relative "../support/caso"

class PositivasTest
  include Caso

  def initialize(source = "positivas.csv")
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

def criterios
   #──INFORME SNGRE──┬───FECHA────┬────────────────────────────ACEPTACION─────────────────────────────#
  [[  :SNGRE_xxx     ,"25/03/2020", {casos: 1211, cantones_ingresados: 77, cantones_sin_ingresar: 144}],
   [  :SNGRE_xxx     ,"24/03/2020", {casos: 1082, cantones_ingresados: 68, cantones_sin_ingresar: 153}],
   [  :SNGRE_xxx     ,"23/03/2020", {casos:  981, cantones_ingresados: 58, cantones_sin_ingresar: 163}],
   [  :SNGRE_xxx     ,"22/03/2020", {casos:  789, cantones_ingresados: 51, cantones_sin_ingresar: 170}],
   [  :SNGRE_xxx     ,"21/03/2020", {casos:  532, cantones_ingresados: 43, cantones_sin_ingresar: 178}],
   [  :SNGRE_xxx     ,"20/03/2020", {casos:  426, cantones_ingresados: 37, cantones_sin_ingresar: 184}],
   [  :SNGRE_013     ,"19/03/2020", {casos:  260, cantones_ingresados: 26, cantones_sin_ingresar: 195}],
   [  :SNGRE_011     ,"18/03/2020", {casos:  168, cantones_ingresados: 16, cantones_sin_ingresar: 205}],
   [  :SNGRE_009     ,"17/03/2020", {casos:  111, cantones_ingresados: 15, cantones_sin_ingresar: 206}],
   [  :SNGRE_007     ,"16/03/2020", {casos:   58, cantones_ingresados: 12, cantones_sin_ingresar: 209}],
   [  :SNGRE_005     ,"15/03/2020", {casos:   37, cantones_ingresados: 11, cantones_sin_ingresar: 210}],
   [  :SNGRE_003     ,"14/03/2020", {casos:   28, cantones_ingresados: 10, cantones_sin_ingresar: 211}],
   [  :SNGRE_002     ,"13/03/2020", {casos:   23, cantones_ingresados:  8, cantones_sin_ingresar: 213}]]
end

describe "Casos Positivos" do
  context "Todas las fechas" do
    let(:fechas_totales) { criterios.count }

    it "Contiene todas las provincias por día" do
      veces = fechas_totales
  
      PositivasTest.todas_las_provincias do |total|
        expect(total).to be(24 * veces), "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
      end
    end
  
    it "Contiene todos los cantones por día" do
      veces = fechas_totales
          
      PositivasTest.todos_los_cantones do |total|
        expect(total).to be(221 * veces), "Se esperaban #{221 * veces} cantones registrados, devolvió: #{total}"
      end
    end
  end
  
  context "Por fecha" do
    criterios.each do |(de_informe, fecha, spec)|
      casos_totales, ingresados_totales, sin_ingresar_totales = spec.values_at(:casos, :cantones_ingresados, :cantones_sin_ingresar)

      context "Del informe en fuentes/#{de_informe.to_s}.pdf" do
        datos = PositivasTest.para(fecha)
          
        it "Verificando casos.." do
          datos.casos do |total|
            expect(total).to be(casos_totales), "Se esperaban #{casos_totales} positivos, devolvió: #{total}" 
          end
        end

        it "Verificando cantones con información.." do
          datos.cantones_ingresados do |total|
            expect(total).to be(ingresados_totales), "Se esperaba #{ingresados_totales}, devolvió: #{total}"
          end
        end 

        it "Verificando cantones sin información.." do
          datos.cantones_sin_ingresar do |total|
            expect(total).to be(sin_ingresar_totales), "Se esperaba #{sin_ingresar_totales}, devolvió: #{total}"
          end
        end

        it "Verificando que todos los cantones existen.." do
          expect(ingresados_totales + sin_ingresar_totales).to be(221)
        end
      end
    end
  end
end
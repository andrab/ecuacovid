require_relative "../support/prueba"
require_relative "../support/caso"

class PositivasTest
  include Caso

  def initialize(source = "positivas/provincias.csv")
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
  end
  
  context "Por fecha" do
    require_relative "../criterios"
    require_relative "../cifras"

    Criterios.para(:positivas).each do |(de_informe, fecha, spec)|
      casos_totales = spec[:casos]
      ingresados_totales =  spec[:cantones_ingresados]
      sin_ingresar_totales = spec[:cantones_sin_ingresar]

      _, numero, hora = de_informe.to_s.split('_')
      ruta = File.join(
        File.expand_path('../../../../informes/SGNRE/', __FILE__),
        [numero, fecha.gsub('/', '_'), hora].join('-') + ".pdf"
      )

      context "informe: #{ruta}..." do
        datos = PositivasTest.para(fecha)
          
        it "Verificando casos.." do
          datos.casos do |total|
            expect(total).to be(casos_totales)
          end
        end
      end
    end
  end
end
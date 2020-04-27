require_relative "../support/prueba"
require_relative "../support/caso"

class DefuncionesTest
  include Caso

  def initialize(source = "defunciones/cantones.csv")
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

describe "Defunciones del Registro Civil" do
  context "Todas las fechas" do
    let(:fechas_totales) { Criterios.para(:defunciones).count }

    it "Contiene todas las provincias por día" do
      veces = fechas_totales
      DefuncionesTest.new.provincias do |total|
        expect(total).to be(24 * veces),
          "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
      end
    end
  end
  
  context "Por fecha" do
    require_relative "../criterios"
    require_relative "../cifras"

    Criterios.para(:defunciones).each do |(de_informe, fecha, spec)|
      totales = spec[:muertes]

      ruta = File.join(
        File.expand_path('../../../../informes/RCIV/', __FILE__),
        "#{fecha.gsub('/', '_')}.pdf"
      )

      context "informe: #{ruta}..." do
        datos = DefuncionesTest.para(fecha)
          
        it "Verificando casos.." do
          datos.casos do |total|
            expect(total).to be(totales)
          end
        end
      end
    end
  end
end
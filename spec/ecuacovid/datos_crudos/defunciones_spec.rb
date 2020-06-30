require_relative "../support/prueba"
require_relative "../support/caso"

class DefuncionesTest
  include Caso

  def initialize(source = "defunciones/cantones.csv")
    @source = File.join(DIRECTORY, source)
  end

  def usar_provincias!
    @source = File.join(DIRECTORY, "defunciones/provincias.csv")
  end

  def casos(&block)
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | get total "\
               " | math sum "\
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
  context "Por fecha" do
    require_relative "../criterios"
    require_relative "../cifras"

    Criterios.para(:defunciones).each do |(de_informe, fecha, spec)|
      totales = spec[:muertes]

      origen = File.expand_path('../../../../informes/RCIV/', __FILE__)
      es_individual = de_informe.to_s !~ /.+-.+/

      ruta = if es_individual
        _, dia, mes, _ = de_informe.to_s.split('_')
        File.join(
          origen,
          "#{dia}_#{mes}_2020.pdf" 
        )
      else
        inicio, fin = de_informe.to_s.split('-')
        a_dia, a_mes, _ = inicio.split('_')
        b_dia, b_mes, _ = fin.split('_')

        File.join(
          origen,
          "#{a_dia}_#{b_mes}_2020-#{b_dia}_#{b_mes}_2020.pdf" 
        )
      end

      es_individual = true

      context "informe: #{ruta}..." do
        datos = DefuncionesTest.para(fecha)

        datos.usar_provincias! if not es_individual
          
        it "Verificando casos del #{fecha}.." do
          datos.casos do |total|
            expect(total).to be(totales)
          end
        end
      end
    end
  end
  
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
end
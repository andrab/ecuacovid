require_relative "../support/prueba"
require_relative "../support/caso"

class MuertesTest
  include Caso

  def initialize(source = "muertes.csv")
    @source = File.join(DIRECTORY, source)
  end

  def provincias(&block)
    @command = if @fecha
      "open #{@source} "\
      " | where created_at == #{@fecha} "\
      " | count "\
      " | echo $it"
    else
      "open #{@source} | count | echo $it"     
    end

    probar!(&block)
  end

  def muertes_registradas_excluyendo(provincias, &block)
    @provincias = provincias
    @command = "open #{@source} "\
               " | where created_at == #{@fecha} "\
               " | #{excluyendo.join(' | ')} "\
               " | get total "\
               " | sum "\
               " | echo $it"

    probar!(&block)
  end

private
  def excluyendo
    @provincias
      .keys
      .flatten
      .map {|p| ['where provincia ', '!=', ' ', p].join}
  rescue
    []
  end
end

describe "Muertes registradas" do
  require_relative "../criterios"

  context "Todas las fechas" do
    let(:fechas_totales) { Criterios.para(:muertes).count }

    it "Contiene todas las provincias por día" do
      veces = fechas_totales
      MuertesTest.todas_las_provincias do |total|
        expect(total).to be(24 * veces),
          "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
      end
    end
  end

  context "Por fecha" do
    Criterios.para(:muertes).each do |(fecha, spec)|
      muertes_totales, las_provincias = spec.values_at(:muertes, :de_las_provincias_teniendo)
      datos = MuertesTest.para(fecha)

      it "Verificando casos.." do
        datos.muertes_registradas_excluyendo(las_provincias) do |total|
          expect(total + las_provincias.map(&:values).flatten.sum).to be(muertes_totales)
        end
      end

      it "Verificando que todas las provincias existen.." do
        datos.provincias do |total|
          expect(total).to be(24),
            "Se esperaba 24 provincias registradas, devolvió: #{total}"
        end
      end
    end
  end
end

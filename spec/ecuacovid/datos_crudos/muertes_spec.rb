require_relative "../support/prueba"
require_relative "../support/caso"

class MuertesTest
  include Caso

  def initialize(source = "muertes.json")
    @source = File.join(DIRECTORY, source)
    sin_clasificadas!
  end

  def provincias(&block)
    @command = if @fecha
      "open #{@source} "\
      " #{filtro} "\
      " | where created_at == #{@fecha} "\
      " | count "\
      " | echo $it"
    else
      "open #{@source} | count | echo $it"     
    end

    probar!(&block)
  end

  def registradas_excluyendo(provincias, &block)
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
  def sin_clasificadas!
    @sin_clasificadas = true
  end

  def filtro
    @sin_clasificadas ? " | compact provincia" : ""
  end

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

  Criterios.para(:muertes).each do |(fecha, spec)|
    muertes_totales = spec[:muertes]
    las_provincias  = spec[:de_las_provincias_teniendo]
    sin_clasificar  = spec.fetch(:teniendo_sin_clasificar) { 0 }

    it "Verificando casos.." do
      MuertesTest.para(fecha).registradas_excluyendo(las_provincias) do |total|
        expect(total + sin_clasificar + las_provincias.map(&:values).flatten.sum).to be(muertes_totales)
      end
    end

    it "Verificando que todas las provincias existen.." do
      MuertesTest.para(fecha).provincias do |total|
        expect(total).to be(24),
          "Se esperaba 24 provincias registradas, devolvió: #{total}"
      end
    end
  end
end

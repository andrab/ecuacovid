require_relative "../support/prueba"
require_relative "../support/caso"

class Descartaciones
  include Caso

  def initialize(source = "descartaciones.json")
    @source = File.join(DIRECTORY, source)
  end

  def provincias(&block)
    if @fecha
      @command = "open #{@source} | where created_at == #{@fecha} | count | echo $it"
    else
      @command = "open #{@source} | count | echo $it"     
    end
    probar!(&block)
  end

  def casos(&block)
    @command = "open #{@source} | where created_at == #{@fecha} | get total | sum | echo $it"
    probar!(&block)
  end
end

describe "Casos Descartados" do
  context "COE" do
    context "Todas las fechas" do
      let(:fechas_totales) { 6 }

      it "Contiene todas las provincias por día" do
        veces = fechas_totales
        
        Descartaciones.todas_las_provincias do |total|
          expect(total).to be(24 * veces), "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
        end
      end
    end

    context "Por fecha" do
      [ #────FECHA─────┬─VERIFICACION─#
        ["25/03/2020", {casos: 1387 }],
        ["24/03/2020", {casos: 1225 }],
        ["23/03/2020", {casos: 1091 }],
        ["22/03/2020", {casos:  872 }],
        ["21/03/2020", {casos:  649 }],
        ["20/03/2020", {casos:  533 }]
      ].each do |(fecha, spec)|
        casos_totales, _ = spec.values_at(:casos)

        datos = Descartaciones.para(fecha)
          
        it "Casos en #{fecha}" do
          datos.casos do |total|
            expect(total).to be(casos_totales), "Se esperaban #{casos_totales} descartados, devolvió: #{total}" 
          end
        end

        it "Están todas las provincias de Ecuador en #{fecha}" do
          datos.provincias do |total|
            expect(total).to be(24), "Se esperaba 24 provincias registradas, devolvió: #{total}"
          end
        end
      end
    end
  end
end
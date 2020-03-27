require_relative "../support/prueba"
require_relative "../support/caso"

class NumeroDeMuestras
  include Caso
  
  def initialize(source = "numero_de_muestras.csv")
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

describe "Muestras Tomadas" do
  context "COE" do
    context "Todas las fechas" do
      let(:fechas_totales) { 4 }

      it "Contiene todas las provincias por día" do
        veces = fechas_totales

        NumeroDeMuestras.todas_las_provincias do |total|
          expect(total).to be(24 * veces), "Se esperaban #{24 * veces} provincias registradas, devolvió: #{total}"
        end
      end
    end
    
    context "Por fecha" do
      [ #────FECHA─────┬─VERIFICACION─#
        ["25/03/2020", {casos: 4290 }],
        ["24/03/2020", {casos: 3618 }],
        ["23/03/2020", {casos: 2780 }],
        ["22/03/2020", {casos: 2360 }]
      ].each do |(fecha, spec)|
        casos_totales, _ = spec.values_at(:casos)
  
        datos = NumeroDeMuestras.para(fecha)
            
        it "Casos en #{fecha}" do
          datos.casos do |total|
            expect(total).to be(casos_totales), "Se esperaban #{casos_totales} de, devolvió: #{total}" 
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
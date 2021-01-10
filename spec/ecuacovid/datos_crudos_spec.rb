require 'ecuacovid/app'
require 'ecuacovid/data'

require_relative './support/caso'

class Tests

  def initialize(app)
    @app = app
    @app.view = self
  end

  def positivas_acumuladas_para(fecha)
    positivas.acumuladas_para(fecha)
  end

  private
  def positivas
    @positivas ||= begin
      casos = PositivasTests.new
      @app.entities_ready(casos)
      @app.entities(:positives)
      casos
    end
  end

end

class PositivasTests

  def data_loaded
    # ..
  end

  def acumuladas_para(fecha)
    @acumuladas[fecha]
  end

  def display_report(casos)
    @acumuladas = casos.reduce(Hash.new(0)) do |acc, canton|
      acc[canton.created_at.strftime("%d/%m/%Y")] += canton.total
      acc
    end 
  end
  
end

def formatear(fecha, informe)
  _, numero, hora = informe.to_s.split('_')
  ruta =  numero != "SIN" ? File.join(
    File.expand_path('../informes/SGNRE/', Caso::DIRECTORY),
    [numero, fecha.gsub('/', '_'), hora].join('-') + ".pdf"
  ) : "No hubo informe publicado para #{fecha.gsub('/', '_')}"
end

describe "Casos Positivos" do  

  context "Por fecha" do

    require_relative "./criterios"

    client = EcuacovidData::Client.new(handshake: EcuacovidData::Handshake.local_fast_storage)
    app = Ecuacovid::App.new(client: client)

    tests = Tests.new(app)

    Criterios.para(:positivas).each do |(informe, fecha, spec)|
      casos_totales = spec[:casos] - (fecha.split('/').last.to_i == 2021 ? 212512 : 0)

      context "informe: #{formatear(fecha, informe)}..." do
        it "Verificando casos positivos.." do
          expect(tests.positivas_acumuladas_para(fecha)).to eq(casos_totales)
        end
      end
    end
    
  end

end

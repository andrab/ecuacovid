require 'ecuacovid/data'
require 'date'

class A
  def display_report(contents)
    pp contents
  end
end

describe EcuacovidData::Query do

  it "query prototype" do
    engine = EcuacovidData::Query.where(created_at: "01/01/2020")
    expect(engine.filters.first).to eq([:created_at, :eq, "01/01/2020"])
  end

  it "query prototype" do
    engine = EcuacovidData::Query.where({created_at: ["01/01/2020", "02/01/2020"]}, :in)
    expect(engine.filters.first).to eq([:created_at, :in, ["01/01/2020", "02/01/2020"]])
  end

  it "query prototype" do
    connector = EcuacovidData::Handshake.local_storage
    client = EcuacovidData::Client.new(handshake: connector)
    expect(client.connection).to eq(connector.connection)
  end

  it "query prototype" do
    connector = EcuacovidData::Handshake.local_storage
    client = EcuacovidData::Client.new(handshake: connector)
    value = client.positives(filters: [:created_at, :eq, "14/03/2020"])
    expect(value.first.created_at).to eq(DateTime.new(2020, 3, 14))
  end

  it "query prototype" do
    connector = EcuacovidData::Handshake.local_fast_storage
    client = EcuacovidData::Client.new(handshake: connector)
  

    value = client.positives(filters: [:year, :in, [2020, 2021]])
                 .find {|x| x.created_at == DateTime.new(2020, 3, 13) && x.canton == "Guayaquil"}

    expect(value.created_at).to eq(DateTime.new(2020, 3, 13))
    expect(value.total).to eq(2)
    expect(value.nuevas).to eq(2)
  end

  it "query prototype" do
    connector = EcuacovidData::Handshake.local_fast_storage
    client = EcuacovidData::Client.new(handshake: connector)
  

require 'ecuacovid/app'
    app = Ecuacovid::App.new(client: client, view: A.new)
    app.load_report(:arrived_vaccines)
  end
  
end


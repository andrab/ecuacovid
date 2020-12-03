require 'ecuacovid/utils/objectable'
require 'ecuacovid/table_serializers'
require 'ecuacovid/highest_seven_daily_cases'
require 'ecuacovid/app'

class InMemoryStore
  def positives(options={})
    [
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,19), nuevas: 71},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,20), nuevas: 33},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,21), nuevas: 59},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,22), nuevas: 71},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,23), nuevas: 13},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,24), nuevas: 11},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,25), nuevas: 53},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,26), nuevas: 84},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,27), nuevas: 76},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,28), nuevas: 128},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,29), nuevas: 87},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,11,30), nuevas: 44},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,12,01), nuevas: 168},
      {provincia: "Guayas", canton: "Guayaquil", created_at: DateTime.new(2020,12,02), nuevas: 220},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,20), nuevas: 290},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,21), nuevas: 487},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,22), nuevas: 244},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,23), nuevas: 148},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,24), nuevas: 143},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,25), nuevas: 295},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,26), nuevas: 228},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,27), nuevas: 409},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,28), nuevas: 639},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,29), nuevas: 667},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,11,30), nuevas: 114},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,12,01), nuevas: 335},
      {provincia: "Pichincha", canton: "Quito", created_at: DateTime.new(2020,12,02), nuevas: 308},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,19), nuevas: 32},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,20), nuevas: 28},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,21), nuevas: 12},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,22), nuevas: 26},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,23), nuevas: 2},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,24), nuevas: 1},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,25), nuevas: 19},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,26), nuevas: 13},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,27), nuevas: 13},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,28), nuevas: 32},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,29), nuevas: 17},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,11,30), nuevas: 57},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,12,01), nuevas: 58},
      {provincia: "Manabí", canton: "Portoviejo", created_at: DateTime.new(2020,12,02), nuevas: 82}
  ].map(&:to_objectable)
  end
end

class StubUi
  def region
    :cities
  end

  def tweet(message)
    # ...
  end
end

class HighestSevenDailyTest < Ecuacovid::HighestSevenDailyCases
  def contents
    @contents
  end

  class << self
    def run
      table = Ecuacovid::Table.new(serializer: Ecuacovid::TableSerializers::Nu)
      app = Ecuacovid::App.new(reporter: table, client: InMemoryStore.new)
      new(app: app, view: StubUi.new)
    end
  end
end

describe Ecuacovid::HighestSevenDailyCases do
  let(:provinces) do
    {"Guayaquil" => "Guayas", "Quito" => "Pichincha", "Portoviejo" => "Manabí"}
  end

  it "report accumulated cases and new cases since the last seven days" do
    cases = InMemoryStore.new.positives
    expected_total_new_cases_since_last_seven_days = { "Quito" => 2700, "Guayaquil" => 807, "Portoviejo" => 272 }
    expected_total_accumulated_cases = { "Quito" => 4307, "Guayaquil" => 1118, "Portoviejo" => 392 }

    expected = %w{Quito Guayaquil Portoviejo}.map do |city_name|
        props = []

        accumulation = cases.select {|city| city.canton == city_name}.map(&:nuevas).reduce(:+)
        expect(accumulation).to eq(expected_total_accumulated_cases[city_name])
        props << [:total, accumulation]

        props << [:nuevas, expected_total_new_cases_since_last_seven_days[city_name]]
        props << [:city, city_name]
        props << [:province, provinces[city_name]]

        Hash[props]
    end

    actual = HighestSevenDailyTest.run
    expect(actual.contents).to eq(expected)
  end
end

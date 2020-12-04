require 'ecuacovid/utils/objectable'
require 'ecuacovid/table_serializers'
require 'ecuacovid/highest_seven_daily_cases'
require 'ecuacovid/app'

class InMemoryStore
  def daily_positives(options={})
    [
      {:province=>"Pichincha", :city=>"Quito", :total=>4698, :days=>[391, 290, 487, 244, 148, 143, 295, 228, 409, 639, 667, 114, 335, 308]},
      {:province=>"Guayas", :city=>"Guayaquil", :total=>1118, :days=>[71, 33, 59, 71, 13, 11, 53, 84, 76, 128, 87, 44, 168, 220]},
      {:province=>"Manabí", :city=>"Portoviejo", :total=>392, :days=>[32, 28, 12, 26, 2, 1, 19, 13, 13, 32, 17, 57, 58, 82]}
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
      app = Ecuacovid::App.new(client: InMemoryStore.new)
      ui  = StubUi.new

      new(app: app, view: ui)
    end
  end
end

describe Ecuacovid::HighestSevenDailyCases do
  let(:provinces) do
    {"Guayaquil" => "Guayas", "Quito" => "Pichincha", "Portoviejo" => "Manabí"}
  end

  it "report accumulated cases and new cases since the last seven days" do
    cases = InMemoryStore.new.daily_positives
    expected_total_new_cases_since_last_seven_days = { "Quito" => 2700, "Guayaquil" => 807, "Portoviejo" => 272 }
    expected_total_accumulated_cases = { "Quito" => 4698, "Guayaquil" => 1118, "Portoviejo" => 392 }

    expected = %w{Quito Guayaquil Portoviejo}.map do |city_name|
      accumulation = cases.find {|city| city.city == city_name}.days.reduce(:+)
      expect(accumulation).to eq(expected_total_accumulated_cases[city_name])

      Hash[:city, city_name, :province, provinces[city_name], :total, accumulation, :change, expected_total_new_cases_since_last_seven_days[city_name]]
    end

    actual = HighestSevenDailyTest.run
    expect(actual.contents).to eq(expected)
  end
end

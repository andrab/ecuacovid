require 'ecuacovid/actions/weekly_growth'
require 'ecuacovid/utils/objectable'

WeeklyGrowth = Ecuacovid::Actions::WeeklyGrowth

describe "Weekly Growth Calculations" do  

  context "for weeks..." do

    let(:yearly_deaths) {
      {"2012" => 98898.04644808744,
       "2013" => 100286,
       "2014" => 102252,
       "2015" => 103710,
       "2016" => 104103.78415300546,
       "2017" => 106877,
       "2018" => 107286,
       "2019" => 109838}
    }
    
    it "finds growth rates" do
      growths = WeeklyGrowth.new(yearly_deaths.values).calculate_growths

      [
        (100286 - 98898.04644808744) / 98898.04644808744,
        (102252 - 100286) / 100286.0,
        (103710 - 102252) / 102252.0,
        (104103.78415300546 - 103710) / 103710.0,
        (106877 - 104103.78415300546) / 104103.78415300546,
        (107286 - 106877) / 106877.0,
        (109838 - 107286) / 107286.0
      ].each_with_index do |growth, idx|
        expect(growths.at(idx)).to be_within(0.1).of(growth)
      end
    end

    it "generates a calculator based on growth rates" do
      entries = [1920, 1908, 1843, 1969, 1980]
      deaths = yearly_deaths.values
      rater = WeeklyGrowth.new(deaths)
      
      adjustments = rater.apply!(entries)

      raw = adjustments.raw_values
      adjusted, average = adjustments.adjusted

      expect(raw).to eq(entries)
      expect(adjusted).to eq([2064, 2044, 1923, 2046, 2010])
      expect(average).to eq(2044)
    end

    it "" do
      entries = [198, 201, 185, 201, 194]
      rater = WeeklyGrowth.new([1321, 1391, 1434, 1379, 1465])

      adjustments = rater.apply!(entries)
      
      raw = adjustments.raw_values
      adjusted, average = adjustments.adjusted

      expect(raw).to eq(entries)
      expect(adjusted).to eq([226, 218, 195, 220, 200])
      expect(average).to be_within(0.1).of(218)
    end
  end

end

require 'ecuacovid/actions/daily_mortality'
require 'ecuacovid/utils/objectable'

require_relative "../support/prueba"

module Ecuacovid
    module Nu
      class << self
        def nu!
          Prueba.nu!
        end
      end
    end
  end

class DailyAdjustmentTest
  include Ecuacovid::Actions::DailyMortality

  def ignore_years
    [2020, 2021]
  end

  def years
    [2016, 2017, 2018, 2019, 2020, 2021]
  end

  def options
    ""
  end
end

class Hash
  def format_day
    self[:created_at].strftime("%d/%m/%Y")
  end
end

describe DailyAdjustmentTest do  

  context "for days..." do

    context "totals" do
      it "collects 365 values per set" do
        expect(subject.daily_mortalities_total.size).to eq(7)
        
        dates = {}.tap do |dates|
          subject.years.each_with_index do |yr, idx|
            days = subject.daily_mortalities_total[idx]
            first, last = days.values_at(0, days.size - 1)

            dates[first.created_at.strftime("%Y").to_i] ||= [first, last]
          end
        end

        require_relative '../criterios'

        expect(subject.daily_mortalities_total.map(&:size)).to eq([365, 366, 365, 365, 365, 366, Criterios.para(:defunciones).size])

        [
          [2016, [228, 27]],
          [2017, [218, 23]],
          [2018, [235, 39]],
          [2019, [245, 52]]
        ].each do |(year, expectation)|
          expect(dates[year].map(&:format_day)).to eq(["01/01/#{year}", "31/12/#{year}"])
          expect(dates[year].map(&:total)).to eq(expectation)
        end

      end

      it "collects all the values per set" do
        expect(subject.daily_yearly_mortalities.size).to eq(7)
        expect(subject.daily_yearly_mortalities[..-2].map(&:size)).to eq([365, 366, 365, 365, 365, 366])
        expect(subject.daily_yearly_mortalities.last.size).to satisfy {|total| total > 0}
      end
    end

    context "yearly totals" do
      it "has yearly total deaths per year" do
        expect(subject.weekly_yearly_mortalities.map {|weeks| weeks.sum}[..-3]).to eq([65425, 67089, 69029, 70968, 73305])
        expect(subject.weekly_yearly_mortalities.map {|weeks| weeks.sum}.last).to satisfy {|total| total > 0}
      end
    end

  end

end

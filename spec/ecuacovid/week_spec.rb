
  require 'date'
def leap?(y)
    (y % 400).even? && (y % 100).even? && (y % 4).zero?
  end

  WEEKLY_AWAREE = lambda do |year = 2020|
    {
      by: ->(record) {
        week = record.strftime("%V").to_i
        iso_week = record.strftime("%W").to_i
        yr = record.strftime("%Y").to_i

        case
          when yr > year
            if leap?(year)
              (leap?(yr) ? iso_week + 52 : week)
            else
              (leap?(yr) ? week : iso_week + 53)
            end
          when yr < year
            if leap?(year)
              (leap?(yr) ? iso_week % 54 : 1 + iso_week % 52)
            else
              (leap?(yr) ? iso_week % 53 : week)
            end
          else
            week
        end
      }
    }
  end

  WEEKLY_AWARE = lambda do |year = 2020|
    {
      by: ->(record) {
        record.strftime("%V").to_i
      }
    }
  end




      
  FMT = "%W"

describe "weeker" do

  context "ok" do
  
    data = {
        2015 => (DateTime.new(2014, 12, 29)..DateTime.new(2016, 1, 3)).to_a,
        2016 => (DateTime.new(2016, 1, 4)..DateTime.new(2017, 1, 1)).to_a,
        2017 => (DateTime.new(2017, 1, 2)..DateTime.new(2017, 12, 31)).to_a,
        2018 => (DateTime.new(2018, 1, 1)..DateTime.new(2018, 12, 30)).to_a,
        2019 => (DateTime.new(2018, 12, 31)..DateTime.new(2019, 12, 29)).to_a,
        2020 => (DateTime.new(2019, 12, 30)..DateTime.new(2021, 1, 3)).to_a
    }

    for_2021_w = (DateTime.new(2021, 1, 4)..DateTime.new(2022, 1, 2)).to_a
 
   #expected = for_2020_w.group_by {|x| fn[:by].(x)}.map {|idx, days| [days, days.size, idx]}
  
    [
        [2015, 53],
        [2016, 52],
        [2017, 52],
        [2018, 52],
        [2019, 52],
        [2020, 53]
    ].each do |entry|
        yr, t = entry
        it "ok? #{yr}" do
          by_weeks = data[yr].group_by {|x| WEEKLY_AWARE.(yr)[:by].(x)}
          expect(by_weeks.map {|n, days| [n, days.size]}).to eq((1..t).map {|n| [n, 7]})
        end
    end


     
  #pp    for_2020_w.group_by {|x| fn[:by].(x)}.map {|w, days| days.map {|d| d.strftime("%d-%b-%a-%Y (%W[#{FMT}]==#{w})")}}
  #puts for_2020_w.group_by {|x| fn[:by].(x)}.map {|w, days| w}.inspect
  

  end
end
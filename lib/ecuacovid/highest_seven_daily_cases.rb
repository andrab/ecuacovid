module Ecuacovid
  class HighestSevenDailyCases
    require 'ecuacovid/utils/objectable'
    require 'ecuacovid/utils/string'

    class << self
      def name
        :positives_cities_highest_cases_per_seventh_day
      end
    end

    def initialize(options={})
      @app = options[:app]
      @view = options[:view]
      @region = @view.region

      @app.view = self
      @app.entities(:daily_positives, [[:area, :eq, @region], [:ano, :eq, 2020], [:group, :by, :daily]])
    end

    def display_report(contents)
      @contents = contents.map do |daily_cases|
        except_latest_seven_days = daily_cases.days[...(daily_cases.days.size - 7)].sum

        Hash[:city, daily_cases.city, :province, daily_cases.province, :total, daily_cases.total, :change, daily_cases.total - except_latest_seven_days].to_objectable
      end.sort_by {|daily_cases| -daily_cases.change}
      
      @view.tweet(format)
    end

    def format
      msg = []

      top_five = @contents[2..].take(7).map {|daily_cases| "#{daily_cases.city}, #{daily_cases.province} #{fmt(daily_cases.total)} (+#{fmt(daily_cases.change)})"}
      msg << ["Cantones con más nuevos casos comparando desde hace siete días:", top_five]

      priority = @contents[0,2].map {|daily_cases| "#{daily_cases.city}, #{daily_cases.province} #{fmt(daily_cases.total)} (+#{fmt(daily_cases.change)})"}
      msg << ["\nGuayaquil y Quito:", priority]

      msg.flatten.join("\n")
    end
  end
end

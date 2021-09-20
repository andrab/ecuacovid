require 'ecuacovid/client'
require 'ecuacovid/table'

module Ecuacovid

  class App

    attr_accessor :client
    attr_accessor :view

    VACCINE = {
      columns: [:fabricante],
      target: :fabricante
    }
    
    CITY = {
      columns: [:provincia, :canton],
      target: ->(record) { "#{record.provincia}-#{record.canton}" }
    }

    PROVINCE = { columns: [:provincia], target: :provincia }

    DAILY   = {by: ->(record) {record.created_at.strftime("%d/%m/%Y")}}
    WEEKLY  = {by: ->(record) {record.created_at.strftime("%V").to_i}}
    MONTHLY = {by: ->(record) {record.created_at.strftime("%-m").to_i}}

    WEEKLY_FORMAT = ->(column) {"Semana #{column.to_s}"}
    MONTHLY_FORMAT = ->(column) { 
      [
        "Enero", "Febrero", "Marzo", "Abril",
        "Mayo", "Junio", "Julio", "Agosto",
        "Septiembre", "Octubre", "Noviembre",
        "Diciembre"
      ][(column % 12) - 1]
    }

    MONTHY_ABRV_FORMAT = ->(column) {
      column = column.class == String ? column.to_i : column

      MONTHLY_FORMAT.(column)[0...3]
    }

    GEN_POPULATION_PERCENTAGE_CALC = lambda do |field, ty, multiply|
      k = "inec_#{ty}_poblacion".to_sym

      ->(record) {
        (record.send(field) * multiply / inec.(record).send(k).to_f) * 100
      }
    end

    TOTAL_DOSE_CITY_PERCENTAGE = GEN_POPULATION_PERCENTAGE_CALC.(:dosis_total, :canton, 0.5)
    ONE_DOSE_CITY_PERCENTAGE = GEN_POPULATION_PERCENTAGE_CALC.(:primera_dosis, :canton, 1)
    FULLY_DOSE_CITY_PERCENTAGE = GEN_POPULATION_PERCENTAGE_CALC.(:segunda_dosis, :canton, 1)

    TOTAL_DOSE_PROVINCE_PERCENTAGE = GEN_POPULATION_PERCENTAGE_CALC.(:dosis_total, :provincia, 0.5)
    ONE_DOSE_PROVINCE_PERCENTAGE = GEN_POPULATION_PERCENTAGE_CALC.(:primera_dosis, :provincia, 1)
    FULLY_DOSE_PROVINCE_PERCENTAGE = GEN_POPULATION_PERCENTAGE_CALC.(:segunda_dosis, :provincia, 1)

    PERCENTAGE_FORMAT = ->(value) {"%g%%" % ('%.2f' % value)}
    
    def App.inec
      @inec ||= begin
        require 'ecuacovid/data/inec'
        metadata = Ecuacovid::Inec.new(Client.new.inec)

        lambda do |record|
          metadata.anadir_metadatos(record)
        end
      end
    end

    REPORTS = {
      administered_vaccines_accumulated_per_day: VACCINE.merge({ model: :administered_vaccines, by: ->(record) {record.administered_at.strftime("%d/%m/%Y")}, keep: [:fabricante, :administered_at], reduce: Ecuacovid::Table::COUNT, eval: :total}),
      administered_vaccines_accumulated_per_day_tabulated: VACCINE.merge({ model: :administered_vaccines, by: ->(record) {record.administered_at.strftime("%d/%m/%Y")}, keep: [:fabricante, :administered_at], reduce: Ecuacovid::Table::COUNT, eval: :total, form: :tabular}),
      administered_fully_vaccines_accumulated_per_day: VACCINE.merge({ model: :administered_vaccines, by: ->(record) {record.administered_at.strftime("%d/%m/%Y")}, keep: [:fabricante, :administered_at], reduce: Ecuacovid::Table::COUNT, eval: :fully}),
      administered_fully_vaccines_accumulated_per_day_tabulated: VACCINE.merge({ model: :administered_vaccines, by: ->(record) {record.administered_at.strftime("%d/%m/%Y")}, keep: [:fabricante, :administered_at], reduce: Ecuacovid::Table::COUNT, eval: :fully, form: :tabular}),
      administered_reported_by_date_vaccines_accumulated_per_day: {model: :administered_by_date_vaccines, by: ->(record) {record.reported_at.strftime("%d/%m/%Y")}, keep: [:reported_at], reduce: Ecuacovid::Table::ACC, eval: :dosis_total_nuevas, rename: {dosis_total_nuevas: :dosis_total}},
      administered_reported_by_date_vaccines_accumulated_per_day_tabulated: {model: :administered_by_date_vaccines, by: ->(record) {record.reported_at.strftime("%d/%m/%Y")}, keep: [:reported_at], reduce: Ecuacovid::Table::ACC, eval: :dosis_total_nuevas, form: :tabular},
      arrived_vaccines_accumulated_per_day: VACCINE.merge({ model: :arrived_vaccines, by: ->(record) {record.arrived_at.strftime("%d/%m/%Y")}, keep: [:fabricante, :arrived_at], reduce: Ecuacovid::Table::ACC, eval: :total}),
      arrived_vaccines_accumulated_per_day_tabulated: VACCINE.merge({ model: :arrived_vaccines, by: ->(record) {record.arrived_at.strftime("%d/%m/%Y")}, keep: [:fabricante, :arrived_at], reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular}),
      vaccinated_total_dose_cities_accumulated_per_day_tabulated: CITY.merge({ model: :vaccines, reduce: Ecuacovid::Table::COUNT, eval: :dosis_total, form: :tabular }).merge(DAILY),      
      vaccinated_one_dose_cities_accumulated_per_day_tabulated: CITY.merge({ model: :vaccines, reduce: Ecuacovid::Table::COUNT, eval: :primera_dosis, form: :tabular }).merge(DAILY),      
      vaccinated_fully_cities_accumulated_per_day_tabulated: CITY.merge({ model: :vaccines, reduce: Ecuacovid::Table::COUNT, eval: :segunda_dosis, form: :tabular }).merge(DAILY),      
      percentage_vaccinated_total_dose_cities_accumulated_per_day_tabulated: CITY.merge({ model: :vaccines, reduce: Ecuacovid::Table::COUNT, eval: TOTAL_DOSE_CITY_PERCENTAGE, format_data: PERCENTAGE_FORMAT, form: :tabular }).merge(DAILY),   
      percentage_vaccinated_one_dose_cities_accumulated_per_day_tabulated: CITY.merge({ model: :vaccines, reduce: Ecuacovid::Table::COUNT, eval: ONE_DOSE_CITY_PERCENTAGE, format_data: PERCENTAGE_FORMAT, form: :tabular }).merge(DAILY), 
      percentage_vaccinated_fully_cities_accumulated_per_day_tabulated: CITY.merge({ model: :vaccines, reduce: Ecuacovid::Table::COUNT, eval: FULLY_DOSE_CITY_PERCENTAGE, format_data: PERCENTAGE_FORMAT, form: :tabular }).merge(DAILY),      
      vaccinated_total_dose_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :province_vaccines, reduce: Ecuacovid::Table::COUNT, eval: :dosis_total, form: :tabular }).merge(DAILY),      
      vaccinated_one_dose_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :province_vaccines, reduce: Ecuacovid::Table::COUNT, eval: :primera_dosis, form: :tabular }).merge(DAILY),      
      vaccinated_fully_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :province_vaccines, reduce: Ecuacovid::Table::COUNT, eval: :segunda_dosis, form: :tabular }).merge(DAILY),      
      percentage_vaccinated_total_dose_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :province_vaccines, reduce: Ecuacovid::Table::COUNT, eval: TOTAL_DOSE_PROVINCE_PERCENTAGE, format_data: PERCENTAGE_FORMAT, form: :tabular }).merge(DAILY),   
      percentage_vaccinated_one_dose_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :province_vaccines, reduce: Ecuacovid::Table::COUNT, eval: ONE_DOSE_PROVINCE_PERCENTAGE, format_data: PERCENTAGE_FORMAT, form: :tabular }).merge(DAILY), 
      percentage_vaccinated_fully_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :province_vaccines, reduce: Ecuacovid::Table::COUNT, eval: FULLY_DOSE_PROVINCE_PERCENTAGE, format_data: PERCENTAGE_FORMAT, form: :tabular }).merge(DAILY),      
      positives_cities_new_per_day: CITY.merge({ model: :positives, eval: :nuevas, keep: [:canton, :created_at]}).merge(DAILY),
      positives_cities_new_per_week: CITY.merge({ model: :positives, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_cities_accumulated_per_week: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_cities_new_per_month: CITY.merge({ model: :mortalities, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_cities_accumulated_per_month: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_cities_new_per_day_tabulated: CITY.merge({ model: :positives, eval: :nuevas, form: :tabular}).merge(DAILY),
      positives_cities_accumulated_per_day_tabulated: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular }).merge(DAILY),      
      positives_cities_new_per_week_tabulated: CITY.merge({ model: :positives, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_cities_accumulated_per_week_tabulated: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_cities_new_per_month_tabulated: CITY.merge({ model: :positives, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      positives_cities_accumulated_per_month_tabulated: CITY.merge({ model: :positives, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      positives_provinces_new_per_day: PROVINCE.merge({ model: :positives, filters: :province, eval: :nuevas, keep: [:provincia, :created_at]}).merge(DAILY),
      positives_provinces_accumulated_per_day: PROVINCE.merge({ model: :positives, filters: :province, reduce: Ecuacovid::Table::ACC, eval: :nuevas, new: :total, keep: [:provincia, :created_at]}).merge(DAILY),
      positives_provinces_new_per_week: PROVINCE.merge({ model: :positives, filters: :province, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_provinces_accumulated_per_week: PROVINCE.merge({ model: :positives, filters: :province, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :semana}, new: :total, keep: [:provincia, :created_at]}).merge(WEEKLY),
      positives_provinces_new_per_month: PROVINCE.merge({ model: :positives, filters: :province, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_provinces_accumulated_per_month: PROVINCE.merge({ model: :positives, filters: :province, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :mes}, new: :total, keep: [:provincia, :created_at]}).merge(MONTHLY),
      positives_provinces_new_per_day_tabulated: PROVINCE.merge({ model: :positives, filters: :province, eval: :nuevas, form: :tabular }).merge(DAILY),
      positives_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :positives, filters: :province, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular }).merge(DAILY),
      positives_provinces_new_per_week_tabulated: PROVINCE.merge({ model: :positives, filters: :province, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_provinces_accumulated_per_week_tabulated: PROVINCE.merge({ model: :positives, filters: :province, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      positives_provinces_new_per_month_tabulated: PROVINCE.merge({ model: :positives, filters: :province, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      positives_provinces_accumulated_per_month_tabulated: PROVINCE.merge({ model: :positives, filters: :province, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      deaths_provinces_new_per_week: PROVINCE.merge({ model: :deaths, eval: :nuevas, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      deaths_provinces_accumulated_per_week: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :semana}, new: :total, keep: [:provincia, :created_at]}).merge(WEEKLY),   
      deaths_provinces_new_per_month: PROVINCE.merge({ model: :deaths, eval: :nuevas, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      deaths_provinces_accumulated_per_month: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, rename: {created_at: :mes}, new: :total, keep: [:provincia, :created_at]}).merge(MONTHLY),
      deaths_provinces_new_per_day_tabulated: PROVINCE.merge({ model: :deaths, eval: :nuevas, form: :tabular }).merge(DAILY),
      deaths_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular }).merge(DAILY),
      deaths_provinces_new_per_week_tabulated: PROVINCE.merge({ model: :deaths, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      deaths_provinces_accumulated_per_week_tabulated: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      deaths_provinces_new_per_month_tabulated: PROVINCE.merge({ model: :deaths, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      deaths_provinces_accumulated_per_month_tabulated: PROVINCE.merge({ model: :deaths, reduce: Ecuacovid::Table::ACC, eval: :nuevas, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_cities_new_per_day_tabulated: CITY.merge({ model: :mortalities, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_cities_accumulated_per_day_tabulated: CITY.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_cities_new_per_week_tabulated: CITY.merge({ model: :mortalities, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_cities_accumulated_per_week_tabulated: CITY.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_cities_new_per_month_tabulated: CITY.merge({ model: :mortalities, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_cities_accumulated_per_month_tabulated: CITY.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_provinces_new_per_day: PROVINCE.merge({ model: :mortalities, eval: :total, keep: [:provincia, :created_at]}).merge(DAILY),
      mortalities_provinces_accumulated_per_day: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, new: :acumuladas, keep: [:provincia, :created_at]}).merge(DAILY),
      mortalities_provinces_new_per_week: PROVINCE.merge({ model: :mortalities, eval: :total, rename: {created_at: :semana}, keep: [:provincia, :created_at]}).merge(WEEKLY),
      mortalities_provinces_accumulated_per_week: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, rename: {created_at: :semana}, new: :acumuladas, keep: [:provincia, :created_at]}).merge(WEEKLY),
      mortalities_provinces_new_per_month: PROVINCE.merge({ model: :mortalities, eval: :total, rename: {created_at: :mes}, keep: [:provincia, :created_at]}).merge(MONTHLY),
      mortalities_provinces_accumulated_per_month: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, rename: {created_at: :mes}, new: :acumuladas, keep: [:provincia, :created_at]}).merge(MONTHLY),
      mortalities_provinces_new_per_day_tabulated: PROVINCE.merge({ model: :mortalities, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_provinces_accumulated_per_day_tabulated: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular }).merge(DAILY),
      mortalities_provinces_new_per_week_tabulated: PROVINCE.merge({ model: :mortalities, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_provinces_accumulated_per_week_tabulated: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: WEEKLY_FORMAT}).merge(WEEKLY),
      mortalities_provinces_new_per_month_tabulated: PROVINCE.merge({ model: :mortalities, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
      mortalities_provinces_accumulated_per_month_tabulated: PROVINCE.merge({ model: :mortalities, reduce: Ecuacovid::Table::ACC, eval: :total, form: :tabular, format: MONTHLY_FORMAT}).merge(MONTHLY),
    }

    CASES = {colors: ['774444']}
    LINE = {kind: :line}
    PLAIN_LINE = {kind: :raw_line}
    BAR = {kind: :bar}
    STACKBAR = {kind: :stacked_bar}
    PIE_DOUGHNUT = {kind: :pied}

    OLD_CHARTS = {
      highest_weekly_mortalities_bigger: LINE.merge(height: 250, width: 500, x_labels: "SEMANAS -desde Junio 2020-", by: :week, target: :type, eval: :value, line_styles: "chls=3|2", markers: "chm=b,f4aaa3,0,0,0", colors: [ "cf3f51", "4a3e41", "cccccc", "cccccc", "cccccc", "cccccc", "cccccc"]),
      highest_weekly_mortalities: LINE.merge(format: ->(name) { "S-#{name}" }, by: :week, target: :type, eval: :value, line_styles: "chls=3|2", markers: "chm=b,f4aaa3,0,0,0", colors: [ "cf3f51", "4a3e41", "cccccc", "cccccc", "cccccc", "cccccc", "cccccc"]),
      highest_daily_mortalities_larger: LINE.merge(height: 250, width: 999, by: :day, target: :type, eval: :value, line_styles: "chls=1|4", markers: "chm=b,f4aaa3,0,0,0", colors: ["ffcccb", "cf3f51", "4a3e41", "cccccc", "cccccc", "cccccc", "cccccc", "cccccc"])
    }

    CHARTS = {
      highest_daily_mortalities: LINE.merge(height: 500, width: 999, by: :day, target: :type, eval: :value, line_styles: "chls=1|4", markers: "chm=b,f4aaa3,0,0,0", colors: ["ffcccb", "cf3f51", "4a3e41", "cccccc", "cccccc", "cccccc", "cccccc", "cccccc"]),
      mortalities_per_year: BAR.merge(by: :year, eval: :value),
      mortalities_per_year_by_weeks: BAR.merge(by: :year, target: :week, eval: :value, line_styles: "chls=3|3|2,3,3",  colors: ["cf3f51"]),
      highest_weekly_mortalities: LINE.merge(y_labels: true, by: :week, target: :type, eval: :value, line_styles: "chls=3|2", markers: "chm=b,f4aaa3,0,0,0", colors: [ "cf3f51", "4a3e41", "cccccc", "cccccc", "cccccc", "cccccc"]),
      highest_weekly_all_cause_mortalities: LINE.merge(by: :week, target: :type, eval: :value, line_styles: "chls=1", markers: "chm=b,f4aaa3,0,0,0", colors: [ "cf3f51", "cccccc", "cccccc", "cccccc", "cccccc", "cccccc"]),
      positives_cities_new_per_week: LINE.merge(CASES.merge(REPORTS[:positives_cities_new_per_week])),
      positives_cities_accumulated_per_week: LINE.merge(CASES.merge(REPORTS[:positives_cities_accumulated_per_week])),
      positives_cities_new_per_month: LINE.merge(CASES.merge(REPORTS[:positives_cities_new_per_month])),
      positives_cities_accumulated_per_month: LINE.merge(CASES.merge(REPORTS[:positives_cities_accumulated_per_month])),
      provinces_monthly_positive_cases: BAR.merge(format: MONTHY_ABRV_FORMAT, by: :month, target: :province, eval: :total, corners: "chbr=5", colors: ["774444"]),
      monthly_positive_cases: BAR.merge(format: MONTHY_ABRV_FORMAT, by: :month, target: :province, eval: :total, corners: "chbr=5", colors: ["774444"]),
      positives_cities_new_per_day: LINE.merge({y_labels: true, x_labels: "Ultimos 60 días", line_styles: "chls=1|3", colors: ['774444'], target: :type, eval: :value}).merge(DAILY),
      positives_provinces_new_per_day: LINE.merge({y_labels: true, x_labels: "Ultimos 60 días", line_styles: "chls=1|3", colors: ['774444'], target: :type, eval: :value, keep: [:provincia, :created_at]}).merge(DAILY),
      daily_vaccinated_doses_per_day: PLAIN_LINE.merge({no_labels: true, width: 700, line_styles: "chls=1|2", colors: [ "fff9f5", "0571B0"], target: :type, eval: :value}).merge(DAILY),
      daily_vaccinated_per_doses_per_day: BAR.merge(corners: "chbr=2", no_labels: true, width: 700, x_labels: "_", y_labels: "_", target: :type, eval: :value, line_styles: "chls=3|2", markers: "chm=b,f4aaa3,0,0,0", colors: [ "92C5DE", "0571B0"]).merge(DAILY),
      vaccination_coverage: PIE_DOUGHNUT.merge(colors: ["92C5DE", "0571B0", "777777"], height: 120, width: 120, by: :type, eval: :value),
      province_vaccination_coverage: PIE_DOUGHNUT.merge(colors: ["6b4442", "d0c3c0", "ebe4d3"], height: 120, width: 120, by: :type, eval: :value),
      province_first_dose_vaccination_coverage: PIE_DOUGHNUT.merge(colors: ["6b4442", "d0c3c0", "d0c3c0"], height: 120, width: 120, by: :type, eval: :value),
      province_fully_vaccination_coverage: PIE_DOUGHNUT.merge(colors: ["d0c3c0", "6b4442", "d0c3c0"], height: 120, width: 120, by: :type, eval: :value),
      positives_provinces_new_per_month: LINE.merge(REPORTS[:positives_provinces_new_per_month]),
      positives_provinces_new_per_week: LINE.merge(REPORTS[:positives_provinces_new_per_week]),
      positives_provinces_accumulated_per_month: LINE.merge(REPORTS[:positives_provinces_accumulated_per_month]),
      positives_provinces_accumulated_per_week: LINE.merge(REPORTS[:positives_provinces_accumulated_per_week]),
      positives_provinces_accumulated_per_day: LINE.merge(REPORTS[:positives_provinces_accumulated_per_day])
    }
    
    def initialize(options={})
      @client = options[:client] || Client.new
      @data = {}
      @view = options[:view]
      @report = options[:reporter] || Table.new
    end

    def reports_available
      REPORTS.keys.map(&:to_s).sort
    end

    def reporting_ready(view)
      @view = view unless view.nil?
      load_data
      @view.data_loaded
    end

    def charting_ready(view)
      @view = view unless view.nil?
      @view.chart_ready
    end

    def entities_ready(view)
      @view = view
      load_data
    end

    require 'ecuacovid/viz'

    def load_chart(which)
      options = CHARTS[which]
      load_data([options[:model]])
      report = @report.construct(@data[options[:model]], options)
      @view.display_chart(Viz.new.build_url(options[:kind], options.merge(report)))
    end

    def with_model_load_chart(which)
      options = CHARTS[which]
      report = @report.construct(@view.model, options)
      @view.display_chart(Viz.new.build_url(options[:kind], options.merge(report)))
    end

    def load_report(which)
      options = REPORTS[which]

      load_data([options[:model]], options)    
      summary = @report.wrap_up(options.merge(datum: @data[options[:model]]))
      @view.display_report(summary)
    end

    def entities(model, options = {})
      default_filters = {
        daily_province_vaccinated: [[:year, :eq, 2021]],
        daily_vaccinated: [[:year, :eq, 2021]],
        arrived_vaccines: [[:year, :eq, 2021]],
        daily_positives: [[:year, :eq, 2021]],
        monthly_mortalities: [[:area, :eq, :cities], [:ano, :eq, 2021], [:group, :by, :monthly]],
        weekly_mortalities: [[:area, :eq, :cities], [:ano, :eq, 2021], [:group, :by, :weekly]]
      }
      load_model(model, filters: options[:filters] || default_filters[model] || {})
      @view.display_report(@data[model])
    end

    private
    def load_data(models = [], options = {})
      default_filters = {
        positives: {filters: [[:area, :eq, options.fetch(:filters) { :cantonal }]]},
        deaths: {filters: [[:area, :eq, :province]]},
        mortalities: {filters: [[:area, :eq, :cities], [:ano, :eq, 2021]]}
      }
      
      (!models.empty? && models || [:positives, :deaths, :mortalities]).each do |model|
        load_model(model, default_filters[model] || {})
      end
    end

    def load_model(model, options={})
      @data[model] = @client.send(model, filters: options[:filters]) unless @data[model]
    end

  end

end

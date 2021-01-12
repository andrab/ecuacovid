require 'ecuacovid/utils/objectable'
require 'csv'

module EcuacovidData

  class LocalFastStore
      
    def prepare(query)
      plan = query.compile

      Class.new do
        define_method :pull do
          plan.years
              .map {|year| CSV.read(sources.fetch(year), headers: true, converters: :numeric)}
              .flatten
              .map do |data|
                offset_days = 6

                data.by_col[0]
                    .zip(data.by_col[2])
                    .zip(data.by_col[offset_days..])
                    .map do |(province, city), days|
                      base = {provincia: province, canton: city}
                      base_total = 0

                      days.map.with_index do |day, idx|
                        base_total += day

                        base.merge(plan.model == :positives ? {:total => base_total, :nuevas => day} : {:total => day, acumuladas: base_total})
                            .merge(created_at: data.headers[idx + offset_days])
                            .to_objectable
                      end
                    end
              end
              .flatten
              .select {|caso| plan.select(caso)}
              .map {|r| r.merge!(created_at: DateTime.new(*r[:created_at].split('/').map(&:to_i).reverse))}
        end

        define_method :sources do
          LocalFastStore.const_get(plan.model.to_s.capitalize).sources
        end
      end.new
    end

    class Positives
      class << self
        def sources
          {2020 => File.expand_path("../../../datos_crudos/positivas/2020/por_fecha/cantones_por_dia.csv", File.dirname(__FILE__)),
           2021 => File.expand_path("../../../datos_crudos/positivas/por_fecha/cantones_por_dia.csv", File.dirname(__FILE__))}
        end
      end
    end

    class Mortalities
      class << self
        def sources
          {2020 => File.expand_path("../../../datos_crudos/defunciones/2020/por_fecha/lugar_cantones_por_dia.csv", File.dirname(__FILE__)),
           2021 => File.expand_path("../../../datos_crudos/defunciones/por_fecha/cantones_por_dia.csv", File.dirname(__FILE__))}
        end
      end
    end

  end

end

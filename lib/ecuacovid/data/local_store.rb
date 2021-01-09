require 'ecuacovid/utils/objectable'

module EcuacovidData

  class LocalStore
      
    def prepare(query)
      plan = query.compile

      Class.new do
        define_method :pull do
          plan.years
              .map {|year| JSON.load(File.read(sources.fetch(year)))}
              .flatten
              .map {|caso| caso.transform_keys(&:to_sym).to_objectable}
              .select {|caso| plan.select(caso)}
              .map {|r| r.merge!(created_at: DateTime.new(*r[:created_at].split('/').map(&:to_i).reverse))}
        end

        define_method :sources do
          LocalStore.const_get(plan.model.to_s.capitalize).sources
        end
      end.new
    end

    class Positives
      class << self
        def sources
          {2020 => File.expand_path("../../../datos_crudos/positivas/2020/cantones.json", File.dirname(__FILE__)),
           2021 => File.expand_path("../../../datos_crudos/positivas/cantones.json", File.dirname(__FILE__))}
        end
      end
    end

  end

end

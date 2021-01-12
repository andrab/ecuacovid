module EcuacovidData

  class Connection
  
    require 'json'
    
    def initialize(service)
      @service = service
    end
    
    def positives(options={})
      query = Query::Builder.new
      query.model = :positives
      query.filters = [options[:filters] || []]
    
      @service.prepare(query).pull
    end

    def deaths(options={})
      []
    end

    def mortalities(options={})
      query = Query::Builder.new
      query.model = :mortalities
      query.filters = [options[:filters] || []]
  
      @service.prepare(query).pull
    end
    
  end
  
end

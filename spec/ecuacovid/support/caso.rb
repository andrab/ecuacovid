require_relative "testeable"

module Caso
  include Testeable
  
  def self.included(klass)
    klass.extend(ClassMethods)
  end
  
  module ClassMethods
    def en(source)
      self.new(source)
    end
  
    def para(fecha)
      self.new.para(fecha)
    end
  
    def todos_los_cantones(&block)
      self.new.cantones(&block)
    end
  
    def todas_las_provincias(&block)
      self.new.provincias(&block)
    end
  end
  
  DIRECTORY = File.join(File.dirname(__FILE__), '../../../datos_crudos/')
  
  def para(fecha)
    @fecha = fecha
    self
  end
  
  def command
    @command
  end
end
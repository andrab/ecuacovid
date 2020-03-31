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
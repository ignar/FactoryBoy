require "factory_boy/version"

class User
  attr_accessor :name, :email
end

module FactoryBoy

  @factories = []

  def self.define_factory(klass_name)
    klass = FactoryBuilder.new(klass_name).build_to_class
    @factories << klass
  end

  def self.build(klass_name)
    klass = FactoryBuilder.new(klass_name).build_to_class
    raise "Factory wasn't defined" unless @factories.include?(klass)
    klass.new
  end
end

class FactoryBuilder
  def initialize(klass_name)
    @klass_name = klass_name
  end

  def build_to_class
    @klass_name.is_a?(Class) ? @klass_name : Object.const_get(@klass_name.to_s.split('_').collect(&:capitalize).join)
  end
end

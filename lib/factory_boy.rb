require "factory_boy/version"

class User
  attr_accessor :name, :email
end

module FactoryBoy

  @factories = {}

  def self.define_factory(name, opts={})
    klass = FactoryBuilder.new(opts[:class] || name).build_to_class
    @factories[name] = klass
  end

  def self.build(klass_name)
    raise "Factory wasn't defined" unless @factories.has_key?(klass_name)
    @factories[klass_name].new
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

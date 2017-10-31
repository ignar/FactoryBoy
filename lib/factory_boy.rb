require "factory_boy/version"

class User
  attr_accessor :name, :email
end

module FactoryBoy

  @factories = {}

  def self.define_factory(name, opts={})
    klass = FactoryBuilder.new(opts.delete(:class) || name).build_to_class
    @attr = opts
    @factories[name] = klass
  end

  def self.build(klass_name, attr={})
    raise FactoryNotDefinedError unless @factories.has_key?(klass_name)
    object = @factories[klass_name].new
    attributes = attr.empty? ? @attr : attr
    attributes.each do |key, value|
      object.send("#{key}=", value)
    end
    object
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

class FactoryNotDefinedError < StandardError; end

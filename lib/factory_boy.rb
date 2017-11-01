require "factory_boy/version"

module FactoryBoy
  @factories = {}

  def self.define_factory(name, opts={}, &block)
    builder = FactoryBuilder.new(opts.delete(:class) || name, block)
    @attr = opts
    @factories[name] = builder
  end

  def self.build(klass_name, attr={})
    raise FactoryNotDefinedError unless @factories.has_key?(klass_name)
    builder_object = @factories[klass_name]
    object = builder_object.build_to_class.new

    builder_object.set_instance(object)
    attributes = attr.empty? ? @attr : attr
    attributes.each do |key, value|
      object.send("#{key}=", value)
    end

    object
  end
end

class FactoryBuilder
  def initialize(klass_name, block)
    @klass_name = klass_name
    @block = block
  end

  def build_to_class
    @klass_name.is_a?(Class) ? @klass_name : Object.const_get(@klass_name.to_s.split('_').collect(&:capitalize).join)
  end

  def set_instance(object)
    @object = object
    instance_eval(&@block) if @block
  end

  def method_missing(method, *args, &block)
    @object.send("#{method}=", args.first)
  end
end

class FactoryNotDefinedError < StandardError; end

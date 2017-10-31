require "factory_boy/version"

class User
  attr_accessor :name, :email
end

module FactoryBoy

  @factories = []

  def self.define_factory(klass_name)
    @factories << klass_name
  end

  def self.build(klass_name)
    raise "Factory wasn't defined" unless @factories.include?(klass_name)
    klass = klass_name.is_a?(Class) ? klass_name : Object.const_get(klass_name.to_s.split('_').collect(&:capitalize).join)
    klass.new
  end
end

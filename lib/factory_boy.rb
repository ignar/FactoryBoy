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
    klass_name.new
  end
end

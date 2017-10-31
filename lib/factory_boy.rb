require "factory_boy/version"

module FactoryBoy

  def self.define_factory(klass_name)
    @factory = klass_name
  end

  def self.build(klass_name)
    klass_name.new
  end
end

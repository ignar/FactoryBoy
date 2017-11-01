require 'spec_helper'

RSpec.describe FactoryBoy do
  class User
    attr_accessor :name, :email
  end

  before :each do
    FactoryBoy.instance_variable_set(:@factories, {})
  end

  describe '#define_factory' do
    let :factories { FactoryBoy.instance_variable_get(:@factories) }

    context 'with NO arrguments' do
      it 'should define by User class' do
        FactoryBoy.define_factory(User)
        expect(factories.keys).to include(User)
      end

      it 'should define by :user symbol' do
        FactoryBoy.define_factory(:user)
        expect(factories.keys).to include(:user)
      end

      it 'should keep only uniq class name' do
        FactoryBoy.define_factory(User)
        FactoryBoy.define_factory(User)
        expect(factories.size).to eql(1)
      end

    end

    context 'with arrguments' do
      let :attr { FactoryBoy.instance_variable_get(:@attr) }

      it 'should define with class arg' do
        FactoryBoy.define_factory(:admin, class: User)
        expect(factories.keys).to include(:admin)
      end

      it 'should define with name arg' do
        FactoryBoy.define_factory(:user, name: 'John')
        expect(factories.keys).to include(:user)
        expect(attr[:name]).to eq 'John'
      end

      it 'should accept block' do
        FactoryBoy.define_factory(User){ name 'John' }
        block = factories[User].instance_variable_get(:@block)
        expect(factories[User]).to be_kind_of(FactoryBuilder)
        expect(block).to be_kind_of(Proc)
      end
    end

  end

  describe '#build' do
    context 'factory has not been defined' do
      it 'should raise FactoryNotDefinedError' do
        expect{ FactoryBoy.build(:user) }.to raise_error(FactoryNotDefinedError)
      end
    end

    context 'with NO arrguments' do
      before :each { FactoryBoy.define_factory(User) }
      it 'should return User object' do
        object = FactoryBoy.build(User)
        expect(object).to be_a(User)
      end
    end

    context 'with arrguments' do
      context 'pass name param in #define_factory' do
        it 'should return object with a name attribute' do
          FactoryBoy.define_factory(:user, name: 'John')
          object = FactoryBoy.build(:user)

          expect(object).to be_a(User)
          expect(object.name).to eql('John')
        end
      end

      context 'pass name param in #build factory' do
        it 'should return object with a name attribute' do
          FactoryBoy.define_factory(:user)
          object = FactoryBoy.build(:user, name: 'Max')

          expect(object).to be_a(User)
          expect(object.name).to eql('Max')
        end
      end

      context 'pass name param in #build factory' do
        it 'should return object with a email attribute' do
          FactoryBoy.define_factory(:user)
          object = FactoryBoy.build(:user, email: 'john@test.com')

          expect(object).to be_a(User)
          expect(object.email).to eql('john@test.com')
        end
      end

      context 'pass block with params in #define_factory' do
        it 'should return object with name and email attributes' do
          FactoryBoy.define_factory(User) do
            name 'John'
          end
          object = FactoryBoy.build(User, email: 'john@gmail.com')

          expect(object).to be_a(User)
          expect(object.name).to eql('John')
          expect(object.email).to eql('john@gmail.com')
        end
      end
    end
  end
end

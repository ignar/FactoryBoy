# FactoryBoy

It is simple implementation of FactoryGirl.

## How to use

Define factory and build it.
```ruby
FactoryBoy.define_factory(User)
user = FactoryBoy.build(User) # => #<User:0x007fb99a8d41d0>
```

You allow use symbol or string.
```ruby
FactoryBoy.define_factory(:user)
user = FactoryBoy.build(:user) # => #<User:0x007fb99a81c1c0>
```

You can pass factory name trought class name.
```ruby
FactoryBoy.define_factory(:admin, class: User)
user = FactoryBoy.build(:admin) # => #<User:0x007fb99a271db0>
```

Define class attributes through `#define_factory`
```ruby
FactoryBoy.define_factory(:user, name: 'John')
user = FactoryBoy.build(:user) # => #<User:0x007fb99a278908 @name="John">
```
or
```ruby
user = FactoryBoy.build(:user, name: 'Franklin') # => #<User:0x007fb99b8495c0 @name="Franklin">
```

Or you can pass attributes using block:
```ruby
FactoryBoy.define_factory(:user) do
  name 'John'
end

user = FactoryBoy.build(:user, email: 'john@gmail.com') # => #<User:0x007fb99b860a68 @name="John", @email="john@gmail.com">
```

## Test

Run `rake spec` to run the Rspec tests.

## Contributing

This repo was created for fan. No contribution is needed.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


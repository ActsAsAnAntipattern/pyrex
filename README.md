# Pyrex - Strong types for Ruby

## Syntax 

To use Pyrex, have your class inherit from `Pyrex::Glass` (get it?) and you will now be required to utilize the `pdef` keyword instead of `def`.

```ruby
class Pancake < Pyrex::Glass
  pdef initialize: { returns: NilClass}, toastiness: Integer do |toastiness|
    @toastiness = toastiness
  end

  pdef is_cooked?: { returns: [TrueClass, FalseClass] }, toasty_level: Integer do |toasty_level|
    return @toastiness >= toasty_level 
  end
end
```

## Guide

Make an argument optional
```ruby
pdef say_hello: { returns: [TrueClass, FalseClass] }, name: String, age: [Integer, NilClass] do |name, age|
  puts "hello #{name}, you look young for #{age}"
end

say_hello("Mark")
```

Set a default value
```ruby
pdef say_hello: { returns: [TrueClass, FalseClass] }, name: String, age: [Integer, NilClass] do |name, age = 100|
  puts "Oh hi #{name}\n" * age
end

say_hello("Mark")
```

Using keyword parameters
```ruby
pdef say_hello: { returns: [TrueClass, FalseClass] }, name: String, age: [Integer, NilClass] do |name:, age: 100|
  puts "Oh hi #{name}, you look young for #{age}"
end

say_hello(name: "Mark")
```

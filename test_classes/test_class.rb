require_relative '../glass'

class TestClass < Pyrex::Glass[:superclass]
  self_pdef say_hello: { returns: NilClass }, name: String, formal: [TrueClass, FalseClass] do |name, formal|
    if formal
      puts "Hello honourable #{name}"
    else
      puts "Hello dishonourable #{name}"
    end
  end

  self_pdef say_hello_with_age: { returns: [TrueClass, FalseClass] }, name: String, age: [Integer, NilClass] do |name:, age: 100|
    puts "Oh hi #{name}, you look young for #{age}"

    true
  end
end

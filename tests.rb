require_relative 'glass'

class TestClass < Pyrex::Glass
  pdef say_hello: { return: NilClass }, name: String, formal: [TrueClass, FalseClass] do |name, formal|
    if formal
      puts "Hello honourable #{name}"
    else
      puts "Hello dishonourable #{name}"
    end
  end

  pdef say_hello_with_age: { returns: [TrueClass, FalseClass] }, name: String, age: [Integer, NilClass] do |name:, age: 100|
    puts "Oh hi #{name}, you look young for #{age}"
  end
end

class Pancake < Pyrex::Glass
  pdef initialize: { returns: NilClass }, toastiness: Integer do |toastiness|
    @toastiness = toastiness
  end

  pdef is_cooked?: { returns: [TrueClass, FalseClass] }, toastiness: Integer do |toastiness|
    return @toastiness >= 5
  end
end

TestClass.say_hello('Julie', true)
TestClass.say_hello('Mark', false)

TestClass.say_hello_with_age(name: 'Mark')

# Should raise type error
begin
  TestClass.say_hello(10, false)
  puts "Test Failed!"
rescue StandardError => e
  puts "Test Passed: #{e}"
end

begin
  class TestClass < Pyrex::Glass
    def cant_use_a_def
      puts 'You shouldnt see this'
    end
  end
  puts "Test Failed!"
rescue StandardError => e
  puts "Test passed: #{e.message}"
end

Pancake.new(3).is_cooked?(5)

require_relative 'glass'
require_relative 'lil_test'

require_relative "test_classes/test_class"
require_relative "test_classes/pancake"
#only_focus

LilTest.sit('says hello to Julie').expect_no_error do
  TestClass.say_hello('Julie', true)
end

LilTest.sit('says hello to mark').expect_no_error do
  TestClass.say_hello('Mark', false)
end

LilTest.sit('says hello to mark with keyword args, optional values').expect_no_error do
  TestClass.say_hello_with_age(name: 'Mark')
end

LilTest.sit('raises type error').expect_error(error_class: Pyrex::Errors::InvalidArgumentType) do
  TestClass.say_hello(10, false)
end

LilTest.sit('protects against using def').expect_error(error_class: Pyrex::Errors::PreventDefUsage) do
  class TestClass < Pyrex::Glass
    def cant_use_a_def
      puts 'You shouldnt see this'
    end
  end
end

LilTest.sit('allows creating init method', focus: true).expect_no_error do
  Pancake.new(3).is_cooked?(5)
end

LilTest.prep('allow returning from block')

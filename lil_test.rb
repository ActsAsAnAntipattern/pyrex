DEBUG_WITH_PUTS = true
$only_run_focused = false

def puts message, use_system_puts = false
  if DEBUG_WITH_PUTS && !use_system_puts
    $puts_hold << message
  else
    super(message)
  end

  return nil
end

def only_focus
  $only_run_focused = true
end

class LilTest
  def self.sit(name, focus: false)
    $puts_hold = [] 
    new(name, focus: focus)
  end

  def self.prep(name)
    print "⏱  #{name}\n\n"
  end

  def initialize test_name, focus: false
    @test_name = test_name
    @focused = focus 
  end

  def print_test_result passed:, message: nil
    if passed
      print "✅ #{@test_name}\n"
    else
      print "❌ #{@test_name} | #{message}\n"
    end

    if $puts_hold
      $puts_hold.each do |statement|
        print " -> #{statement}\n"
      end
    end

    print "\n"
  end

  def expect_no_error
    # FIXME: Only focuses output, not tests being run
    return if !@focused && $only_run_focused

    yield
    print_test_result(
      passed:  true
    )
  rescue StandardError => e
    print_test_result(
      passed:  false,
      message: "Expected no error but received: #{e.message}."
    )
  end

  def expect_error error_class: StandardError
    # FIXME: Only focuses output, not tests being run
    return if !@focused && $only_run_focused

    yield
    print_test_result(
      passed: false,
      message: "Expected #{error} but no error was raised."   
    )
  rescue StandardError => e
    if e.is_a?(error_class)
      print_test_result(
        passed:  true
      )
    else
      print_test_result(
        passed:  false,
        message: "Expected #{error_class} but #{e.class} was raised."
      )
    end
  end
end

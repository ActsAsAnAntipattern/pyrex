require_relative "../glass"

class Pancake < Pyrex::Glass
  pdef init: { returns: Integer }, toastiness: Integer do |toastiness|
    @toastiness = toastiness
  end

  pdef is_cooked?: { returns: [TrueClass, FalseClass] }, toastiness: Integer do |toastiness|
    @toastiness >= 5
  end
end


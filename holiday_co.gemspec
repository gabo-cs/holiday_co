require_relative "lib/holiday_co/version"

Gem::Specification.new do |spec|
  spec.name          = "holiday_co"
  spec.version       = HolidayCo::VERSION
  spec.summary       = "Colombian Holidays"
  spec.description   = "A simple gem to handle holidays in Colombia"
  spec.authors       = ["Gabriel Coronado"]
  spec.email         = ["gabrielomar2809@gmail.com"]
  spec.homepage      = "https://github.com/gabo-cs/holiday_co"
  spec.license       = "MIT"
  spec.files = Dir["lib/**/*.rb"]
end

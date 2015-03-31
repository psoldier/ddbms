ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join('init'))

Capybara.app = Seghini::Base
Capybara.default_driver = :webkit

class AcceptanceTest < MiniTest::Spec
  include Capybara::DSL
  register_spec_type(/acceptance$/, self)
  Capybara.app = Seghini::Base
end

class ModelTest < MiniTest::Spec
  register_spec_type(/models$/, self)
  Capybara.app = Seghini::Base
end
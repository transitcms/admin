require 'rails'

module Transit
  module Admin
    class Engine < ::Rails::Engine
      paths['app/helpers'] << File.expand_path("../../../../app/helpers", __FILE__)
    end
  end
end
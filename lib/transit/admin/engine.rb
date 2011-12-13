require 'rails'

module Transit
  module Admin
    class Engine < ::Rails::Engine
      paths['app/helpers'] << File.expand_path("../../../../app/helpers", __FILE__)
      
      initializer "transit.enable_managers", :after => :eager_load! do
        require 'transit/admin/defaults'
      end
      
    end
  end
end
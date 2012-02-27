class Transit::PagesController < AdminController
  inherit_resources
  respond_to :js, :json, :html
end
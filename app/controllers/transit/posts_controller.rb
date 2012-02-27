class Transit::PostsController < AdminController
  inherit_resources
  respond_to :js, :json, :html
end
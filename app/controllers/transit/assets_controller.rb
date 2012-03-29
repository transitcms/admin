class Transit::AssetsController < AdminController
  before_filter :find_deliverable
  respond_to :js, :json, :html
  helper_method :parent, :resource
  layout false
  
  def index
    respond_with(parent.assets)
  end
  
  def new
    @asset = parent.assets.build({})
    respond_with(@asset)
  end
  
  def destroy    
    resource.destroy
    respond_with(resource)
  end
  
  def parent
    @deliverable
  end
  
  def resource
    @asset ||= parent.assets.where(:_id => params[:id]).first
  end
  
  protected
  
  def find_deliverable
    @deliverable = params[:deliverable_class].to_s.constantize.find(params[:deliverable_id])
  end
  
end
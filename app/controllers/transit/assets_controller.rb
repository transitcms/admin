class Transit::AssetsController < AdminController
  before_filter :find_deliverable
  respond_to :js, :json, :html
  helper_method :parent, :resource
  layout false
  
  def index
    respond_with(parent.contexts)
  end
  
  def new
    @context = parent.assets.build({})
    respond_with(@context)
  end
  
  def destroy    
    @context.destroy
    respond_with(@context)
  end
  
  def parent
    @deliverable
  end
  
  def resource
    @context ||= parent.contexts.where(:_id => params[:id]).first
  end
  
  protected
  
  def find_deliverable
    @deliverable = params[:deliverable_class].to_s.constantize.find(params[:deliverable_id])
  end
  
end
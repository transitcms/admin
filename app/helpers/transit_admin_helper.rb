module TransitAdminHelper
  
  def new_context_path(resource, type)
    new_transit_context_path(:deliverable_class => resource.class.name, :deliverable_id => resource.id.to_s, :type => type.to_s.classify)
  end
  
  def context_path(context)
    transit_context_path(context, :deliverable_class => context.deliverable.class.name,  :deliverable_id => context.deliverable.id.to_s)
  end

end
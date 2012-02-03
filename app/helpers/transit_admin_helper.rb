module TransitAdminHelper
  
  def new_context_path(resource, type)
    new_transit_context_path(:deliverable_class => resource.class.name, :deliverable_id => resource.id.to_s, :type => type.to_s.classify)
  end
  
  def manage_resource(resource, options = {})
    manager = Transit::Admin.manager.fetch(resource.class.name.underscore.to_sym)
    manager.tableize(self)
  end
  
  def manage_delivery(resource, form_name = nil, options = {}, &block)   
    manager = Transit::Delivery.new(resource, self)
    if form_name
      manager.object_name = form_name 
    end
    manager.current_index = 0
    response = ""
    resource.contexts.ascending(:position).each do |context|
      response << manage_delivery_for(context, manager).to_s.html_safe
    end
    content_tag(:div, response.to_s.html_safe, { :id => 'manage_resource_delivery', :data => { :resource_id => resource.id.to_s } })
  end
  
  def manage_delivery_for(context, manager = nil)
    manager ||= Transit::Delivery.new(context.deliverable, self)
    delivery_template(context, manager.manage_context(context))
  end
  
  def delivery_template(context, content)

    link_path  = "#"
    link_attrs = {}
  
    if context.persisted?
      link_path = transit_context_path(context, :deliverable_class => resource.class.name,  :deliverable_id => resource.id.to_s)
      link_attrs.merge!(:remote  => true, :method => :delete)
    end
    
    resource = context.deliverable
    content << "\n"
    content << link_to('Delete', link_path, 
      :class    => 'delete-context-link', 
      :method   => :delete, 
      :remote   => true, 
      :confirm  => "Are you sure you want to delete this item?",
      :data     => { :persisted => context.persisted?.to_s })
    content_tag(:div, content, { 
      :class => "manage-context manage-#{context.class.name.to_s.underscore}-context", 
      :data => { :context_id => context.id.to_s } 
    })
  end
  
end
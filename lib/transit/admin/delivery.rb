require 'transit/delivery'
require 'active_model'

module Transit
  module Admin
    ##
    # Extends the core delivery class to include functionality for managing 
    # context data and attributes.
    # 
    module Delivery
      extend ActiveSupport::Concern
      
      included do
        attr_accessor :current_index
      end
      
      
      ##
      # Ensures the form/fields object name matches the current form being 
      # used by the active template.
      # 
      def object_name
        @object_name ||= ActiveModel::Naming.param_key(resource)
      end
      
      ##
      # Allows overriding the model name for cases where :as may be used within a form.
      # 
      def object_name=(name)
        @object_name = name.to_s
      end
      
      ##
      # Renders a partial from transit/admin to display form/fields for a particular context
      # @param [Class] context An instance of a context class
      # 
      def manage_context(context)
        klass = context.class.name.to_s.underscore
        index = self.current_index ||= Time.now.to_i
        template.fields_for("#{object_name}[contexts_attributes][#{index}]", context) do |context_fields|
          self.current_index = self.current_index + 1
          result = ""
          result << context_fields.hidden_field(:id, :value => context.id)
          result << context_fields.hidden_field(:_type, :value => context.class.name.to_s)
          result << template.render(:partial => "transit/admin/#{klass}", :locals => { :form => context_fields, :resource => resource, :context => context }).to_s   
          result.to_s.html_safe
        end
      end      
      
    end # Delivery
  end # Admin
end # Transit

Transit::Delivery.send(:include, Transit::Admin::Delivery)
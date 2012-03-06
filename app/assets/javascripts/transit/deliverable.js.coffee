# #= depend_on ../transit
# #= require ./context
# 
# class Transit.Deliverable extends Backbone.Model
# 	idAttribute: '_id'
# 	contexts: []
# 	managed: false
# 	
# 	initialize: ()->
# 		@contexts = new Transit.Contexts()
# 		@contexts.deliverable = @
# 		@parse(@attributes)
# 		delete @attributes['contexts']
# 		
# 	parse: (response)->
# 		contexts  = response.contexts || []
# 		@contexts ||= new Transit.Contexts()
# 		@contexts.deliverable = @
# 		@contexts.reset(contexts)
# 		delete response.contexts if response.contexts
# 		Backbone.Model.prototype.parse.call(@, response)
# 		@
# 	
# #class Transit.Delivery extends Backbone.View
# 	
# 	
# $.fn.deliverable = (options = {})->
# 	del = $(@)
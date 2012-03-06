# #= require_self
# #= require_tree ./contexts
# 
# class Transit.Context extends Backbone.Model
# 	idAttribute: '_id'
# 	deliverable_id: null,
# 	deliverable_type: null
# 	url: ()->
# 		resp = super
# 		console.log(@collection, @collection.deliverable)
# 		resp + $.param({ deliverable_id: @collection.deliverable.get('id'), deliverable_class: @collection.deliverable.get('_type') })
# 
# class Transit.Contexts extends Backbone.Collection
# 	deliverable: null
# 	url: ()->
# 		base = if _.isFunction(@deliverable.url) then @deliverable.url() else @deliverable.url
# 		base + "/contexts"
# 	
# 	comparator: (cxt)->
# 		return parseInt(cxt.get("position"))
# 		
# 	model: (attrs, options) ->		
# 		klass = Transit[attrs['_type']] || Transit.Context
# 		options.deliverable = options.collection.deliverable
# 		return new klass(attrs, options)
(function($, undefined){
	
	var transit = window.transit;
	
	if( typeof transit == 'undefined' ){
		transit        = jQuery.sub();
		window.transit = transit;
	}
	
	
	transit.fn.plugin = function(name, store){
		var plugin;
		
		if( store ){
			this.each(function(i, element){
				transit(element).data('transit-plugin-' + name, store);
			});
		}
		
		// if a single node was passed, return the plugin for
		// easier api access.
		plugin = transit(this).data('transit-plugin-' + name);
		
		if( plugin ) return plugin;		
		return undefined;
	};
	
})(jQuery);

(function(){
	
	String.prototype.capitalize = function() {
	    return this.charAt(0).toUpperCase() + this.slice(1);
	};

	
	if( Object.prototype.__defineGetter__ && !Object.defineProperty ){
	   Object.defineProperty = function( obj, prop, desc ){
	      if( "get" in desc ) obj.__defineGetter__(prop,desc.get);
	      if( "set" in desc ) obj.__defineSetter__(prop,desc.set);
	   };
	}
	
})();
//------------------------------------------- Suppression Code ------------------------------------------------
	
if(death[0] = 0){
	
	var CheckSuppression = timer_tick(suppression_check_timer,0);
	var ResetSuppression = timer_tick(suppression_reset_timer,0);
	if(CheckSuppression) {
		var List = ds_list_create();
		collision_circle_list(x,y,2000,[o_bullet,o_explosion_scalable,o_fragment,o_suppressionghost],false,false,List,true);
		var ListSize = ds_list_size(List);
		if(ListSize > 0){
			var i = 0;
			while (i < (ListSize-1)){
				var Item = ds_list_find_value(List,i);
				if(Item.object_index = o_suppressionghost) {
					if(Item.IFF != IFF) {
					suppression_level = clamp(suppression_level+1,0,35)
					};
				};
			i++;
			};
		};
	
	ds_list_destroy(List);	
	timer_reset(suppression_check_timer,1);
	};
	
	if(ResetSuppression) {
		if(suppression_level > 0) {suppression_level -= 1}; 
		timer_reset(suppression_reset_timer,1);
	};
};
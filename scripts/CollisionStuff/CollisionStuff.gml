// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collision_line_proximity(x1,y1,x2,y2,obj,prec,notme,nearest=1){
	
	var Target_Toggle = 1;
	var Col_List = ds_list_create();
	
	var _num = collision_line_list(x1,y1,x2,y2,obj,prec,notme,Col_List,1);
	
	if((_num > 0) && Target_Toggle) {	
		
		Target_Toggle=0;
		if(nearest=1) {var Target = Col_List[| 0]}; 
		else{var Target = Col_List[| ds_list_size(Col_List)]};
	
	} else {return 0};
	
	ds_list_destroy(Col_List);
	return Target;
}
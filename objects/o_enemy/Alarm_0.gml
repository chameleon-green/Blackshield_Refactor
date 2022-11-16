

if(StartNode != -1 and TargetNode != -1){
	var PathText = nodes_calculate_cost_array(StartNode,600,TargetNode,999);
	ds_list_read(PathList,PathText);
};
alarm[0] = 60;
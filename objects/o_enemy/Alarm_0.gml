
/*
if(StartNode != -1 and TargetNode != -1){
	
	var IsOnList = ds_list_find_index(o_IC.AILine,id);
	if(IsOnList = -1) {ds_list_add(o_IC.AILine,id)};
	else{
		if(o_IC.AICounter = IsOnList){
			ds_list_delete(o_IC.AICounter,IsOnList);
			var PathText = nodes_calculate_cost_array(StartNode,600,TargetNode,999);
			ds_list_read(PathList,PathText);
		};
	};
};
*/


/*
if(StartNode != -1 && TargetNode != -1 && leader = 1 && !firing){	
	var PathText = nodes_calculate_cost_array(StartNode,600,TargetNode,999);
	ds_list_read(PathList,PathText);
	
	var i = 0;
	while (i < ds_list_size(MySquad)){
		var Member = ds_list_find_value(MySquad,i);
		var MemberListSize = ds_list_size(Member.PathList);
		//if(MemberListSize = 0) {Member.PathList = PathList};
		i++;
	};
};

alarm[0] = timer;
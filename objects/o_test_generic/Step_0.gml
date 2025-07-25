

var NewNode = timer_tick(StartNodeTimer);

if(NewNode) {
	timer_reset(StartNodeTimer);
	
	var LOSList = ds_list_create();
	var NodesInLos = nodes_in_los(600,o_platform,o_navnode,x,y-50,-1);
	if(NodesInLos != -1) {
		ds_list_read(LOSList,NodesInLos);	
		StartNode = ds_list_nearest(LOSList,x,y-50,0);
	};
	ds_list_destroy(LOSList);
	
};
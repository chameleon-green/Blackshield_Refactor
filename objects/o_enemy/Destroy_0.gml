ds_list_destroy(PathList);
ds_priority_destroy(OpenList);
ds_list_destroy(ClosedList);
ds_list_destroy(ClosedParentList);
	
ds_list_destroy(collisions_list);

ds_map_destroy(torsomap);
ds_map_destroy(headmap);
ds_map_destroy(front_bicep_map);
ds_map_destroy(rear_bicep_map);
	

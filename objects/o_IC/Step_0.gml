	
	view_wport[0] = 1366;
	view_hport[0] = 786;
	camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	
	var F = keyboard_check(ord("F")); 
	if(F) {if(mouse_mult < 12) {mouse_mult+=1}} else{pl_mult = 1 mouse_mult = 2};
	
	
	var total_mult = pl_mult+mouse_mult;
	var ply = o_player.bbox_top - o_player.bbox_bottom + o_player.y;
	
	
	x = (o_player.x*pl_mult + mouse_x*mouse_mult)/total_mult;
	y = (ply*pl_mult + mouse_y*mouse_mult)/total_mult;
	
	//var track = obj_player.id
	var track = id;
	var XX = (view_wport[0] / 2);
	var YY = (view_hport[0] / 2);
	//camera_set_view_border(view_camera[0], 600, 300);
	//camera_set_view_target(view_camera[0],track);	
	camera_set_view_pos(view_camera[0],x-XX,y-YY);
	
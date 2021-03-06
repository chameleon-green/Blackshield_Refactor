	

//camera_xspd = camera_x - camera_xprev;

//cancel zoom momentum if inventory is brought up
if(visible) {view_momentum = 0};

if(abs(view_momentum) > 0) {view_momentum *= 0.95};
if(abs(view_momentum) < 0.2) {view_momentum = 0};

xx += view_momentum;
yy += view_momentum/1.78;

if(xx > 2732) {xx = 2732};
if(xx < 683) {xx = 683};
if(yy > 1536) {yy = 1536};
if(yy < 384) {yy = 384};

view_wport[0] = xx; view_hport[0] = yy;
camera_set_view_size(view_camera[0],view_wport[0],view_hport[0]);
camera_set_view_border(view_camera[0],xx/2,yy/2);

//view_multiplier = xx/1366;

if(equalize = 1) { 
	if(xx > 1366) {view_momentum = -1*(abs(xx-1366)/4)};
	if(xx < 1366) {view_momentum = 1*(abs(xx-1366)/4)};
	
	if(yy > 768) {view_momentum = -(1*(abs(yy-768)/4))/1.78};
	if(yy < 768) {view_momentum = (1*(abs(yy-768)/4))/1.78};
	
	if(xx > 1361 and
	   xx < 1371 and
	   yy > 763 and
	   yy < 773
	  )
	{view_momentum = 0; equalize = 0};
};

//---------------------------------------------- camera tracking --------------------------------------------


if(!visible and gui_close_toggle){	
	var F = keyboard_check(ord("F")); 
	if(F) {if(mouse_mult < 12) {mouse_mult+=1}} else{pl_mult = 1 mouse_mult = 2};
	
	var total_mult = pl_mult+mouse_mult;
	var ply = o_player.bbox_top - o_player.bbox_bottom + o_player.y;
		
	x = (o_player.x*pl_mult + mouse_x*mouse_mult)/total_mult;
	y = (ply*pl_mult + mouse_y*mouse_mult)/total_mult;
	
	var track = id;
	var XX = (view_wport[0] / 2);
	var YY = (view_hport[0] / 2);

	//camera_set_view_pos(view_camera[0],0,0);

	camera_set_view_target(view_camera[0],track);
};
	
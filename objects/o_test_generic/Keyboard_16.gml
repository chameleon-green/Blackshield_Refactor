


//text = BeamBullet(x,y,point_direction(x,y,o_xhair.x,o_xhair.y),5000,o_masterParent,-1);


if(timer_tick(RayTimer)) {
	
	timer_reset(RayTimer,0);
	
	var CoordArray = BeamBullet(x,y,point_direction(x,y,o_xhair.x,o_xhair.y),5000,o_masterParent,-1);
	
	XXX = CoordArray[0];
	YYY = CoordArray[1];
	
	with(instance_create_depth(XXX,YYY,depth-1,oprt_smoke)) {
		image_blend = c_gray;
		speed = random_range(4,7)
		mass = 9;
		max_scale = 1.25;
	};
};
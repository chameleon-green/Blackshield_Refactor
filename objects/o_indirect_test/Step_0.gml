var Dist = point_distance(TargetX,TargetY,target.x,target.y);

if(Dist < 1000) {
	if(scatter_angle > 0) {var Fire = timer_tick(adjust_timer)}
	else {var Fire = timer_tick(ffe_timer)};
	
	if(Fire) {
		timer_reset(adjust_timer);
		timer_reset(ffe_timer);
		var Dist = distance_to_object(target);
		var XX = 0;
		var YY = 50; //ORIGIN IS TOP LEFT CORNER OF ROOM
		if(target.x <= x) {XX = x-(Dist/2)}
		else if(target.x > x) {XX = x+(Dist/2)};
		var AimDir = point_direction(XX,YY,target.x,target.y) + random_range(-scatter_angle,scatter_angle); //point_direction(x,y,target.x,target.y);

		instance_create_depth(XX,YY,depth,o_bullet,{
			type : ammo_active, 
			IFF : "none",
			damage : 200,
			damage_type : "PHYS", //other.ammo_active.damage_type[0],
			hspd : 0,
			vspd : 0,
			direction : AimDir,
			image_angle : AimDir,
			speed : 50//other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod
		});
		
		if(scatter_angle > 0) {scatter_angle -= 1};
	};
}

else if(Dist >= 1000) {
	var Deflected = timer_tick(deflection_timer);
	scatter_angle = scatter_angle_base;
	if(Deflected) {
		TargetX = target.x;
		TargetY = target.y;
		timer_reset(deflection_timer);
	};
}
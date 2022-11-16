// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Infantry create event generic

function InfantryCreateGeneric() {
	StartNode = -1;
	TargetNode = -1;
	OpenList = ds_list_create();
	ClosedList = ds_list_create();
	PathList = ds_list_create();

	vspd = 0;
	vspd_readonly = 0;
	hspd = 0;
	
	MyTarget = o_player;
	firing = 0;
	
	TargetNodeTimer = [0,irandom_range(45,60)];
			
}; //function end bracket

#endregion

#region Infantry step event generic

function InfantryStepGeneric() {
	
	//hspd = 5;
	TargetNodeTimer[0] += 1;
	if(firing or (TargetNodeTimer[0] > (TargetNodeTimer[1]+60) )) {TargetNodeTimer[0] = 0};
	
	vspd_readonly = vspd;

	if (place_free(x,y+sign(vspd))) {
        vspd += 1
	};

	if(place_meeting(x, y+vspd, o_platform)) { //vertical collisions
		if(vspd < 0) {move_outside_solid(270,vspd)}; //if we are going up and hit something, try to get out of ceiling collision
		else{move_contact_solid(270,10)}; //if we are going down and hit something, touch down on the floor
		vspd = 0; //kill our vertical momentum in either case
	};

	if(place_meeting(x+hspd*2,y,o_platform)){
		var MaxGrade = 3;
		var Hspd2 = hspd*+(sign(hspd)*2);
		var climb = 2; //our variable used to attempt to find a clear position to ascend to
		while(place_meeting(x+Hspd2,y-climb,o_platform) && (climb <= clamp(abs(MaxGrade*hspd),12,9100)) ) {climb += 1}; //attempts to find a clear position to ascend to, the maximum height of which is determined by our speed and maxgrade value
		if(place_meeting(x+Hspd2,y-climb+vspd,o_platform) or (vspd != 0)) { //if we fail to find a position in range of our maximum climb, the player moves forward horizontally until it hits the wall			
			move_outside_solid(180,100);
			move_outside_solid(0,100);
			hspd = 0
		};
		else{ //if we succeed in finding a clear position, move to it
			y -= climb;
			vspd_readonly = (vspd - climb);
		};
	};
	
	x += hspd;
	
	
	// Downward slopes
	if (!place_meeting(x,y,o_platform) && (vspd >= 0) && place_meeting(x,y+2+abs(hspd),o_platform)) {
		while(!place_meeting(x,y+1,o_platform)) {y += 1; vspd_readonly+=1}
	};
	
	y += vspd; //change our Y by effects of gravity and climb values
	
}; //function end bracket

#endregion
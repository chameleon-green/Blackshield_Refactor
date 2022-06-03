// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerMovement() {
	
//++++++++++++++++++++++++++++++++++++++++++ VARIABLES ++++++++++++++++++++++++++++++++++++++++++++++++
	
	//var anim_array2 = wpn_melee[wpn_melee.Animations];
	var ranged_animgrp = wpn_active.animation_group;
	var sprint = "sprint_full_rifle";
	var walk = "walk_rifle";
	var backwalk = "backwalk_rifle";
	//if(LegsCrippled = 1) {walk = "walk_crawl"};
	
	var W = keyboard_check_pressed(ord("W")); 
	var D = keyboard_check(ord("D")); 
	var A = keyboard_check(ord("A"));
	var S = keyboard_check(ord("S"));
	var Shift = keyboard_check(vk_shift) * CanSprint;
	
	col_bot = place_meeting(x,y+1,o_platform);
	
//++++++++++++++++++++++++++++++++++++ BASIC MOVEMENT +++++++++++++++++++++++++++++++++++++++++++++++

if(CanMove) {
	
	hspd = 0;
	sprinting = 0;
	var face_left = mouse_x < x;
	var face_right = mouse_x > x;
	var mouse_facing = sign((mouse_x*1.01) - x); //prevents our mouse_facing from equaling 0, hiding the player
	image_xscale = mouse_facing;

	var move = (D - A) * MoveSpeed;
	
	if(D) {
		if(face_left) {hspd = (move*CanMove)*0.5; if(col_bot) {skeleton_anim_set_step(backwalk,2)} };
		if(face_right) {
			if(Shift) {hspd = (move*CanMove)*1.5; if(col_bot) {skeleton_anim_set_step(sprint,2); sprinting = 1} };
			else {hspd = move*CanMove; if(col_bot) {skeleton_anim_set_step(walk,2)} };
		};		
	};
	
	if(A) {
		if(face_right) {hspd = (move*CanMove)*0.5; if(col_bot) {skeleton_anim_set_step(backwalk,2)} };
		if(face_left) {
			if(Shift) {hspd = (move*CanMove)*1.5; if(col_bot) {skeleton_anim_set_step(sprint,2); sprinting = 1} };
			else {hspd = move*CanMove; if(col_bot) {skeleton_anim_set_step(walk,2)} };
		};	
	};
	
//--------------------------------------------- Vertical collisions and gravity --------------------

    if (place_free(x,y+sign(vspd))) {
        vspd += 1
    };

    if (place_meeting(x, y+vspd, o_platform)) {
        vspd = 0;
		move_contact_solid(270,10)
		move_outside_solid(90,1)
     };


	if place_meeting(x+hspd,y,o_platform)
	{
		var MaxGrade = 0.5;
		var climb = 0; //our variable used to attempt to find a clear position to ascend to
			while ( place_meeting(x+hspd,y-climb,o_platform) && (climb <= abs(MaxGrade*hspd)) ) {climb += 1}; //attempts to find a clear position to ascend to, the maximum height of which is determined by our speed and maxgrade value
			if (place_meeting(x+hspd,y-climb,o_platform)) { //if we fail to find a position in range of our maximum climb, the player moves forward horizontally until it hits the wall
					hspd = 0
			};
			else { //if we succeed in finding a clear position, move to it
				y -= climb
			};
	};
	x += hspd;

	// Downward slopes
	if (!place_meeting(x,y,o_platform) && vspd >= 0 && place_meeting(x,y+2+abs(hspd),o_platform)) {
		while(!place_meeting(x,y+1,o_platform)) {y += 1;}
	};

//------------------------------------- Jumping and affect of gravity/climb --------------------------------------

	if(W and place_meeting(x, y+5, o_platform)) {vspd = -20 * (1+(Shift/3))};

	y += vspd; //change our Y by effects of gravity and climb values

}; //canmove check bracket







	
	if (hspd = 0) {
		{skeleton_animation_clear(2)}
	};
	
	if(col_bot = 0) {
			skeleton_animation_clear(2)
			skeleton_anim_set_step("idle_air",2)
	};
	
	if (wpn_active.weapon_slot = "primary") {
		skeleton_anim_set_step(ranged_animgrp.idle,1)
	};
	
	//initiate crouching anim when we press S
	if (S) {skeleton_animation_set_ext("crouch", 2) crouching = 1}

/*		
	 
 //++++++++++++++++++++++++++++++++++++++++++++++++ JUMPING ++++++++++++++++++++++++++++++++

	if(keyboard_check_pressed(ord("W")) ) {

		if(col_bot and canmove and !rolling and canjump) {
			vsp -= (JumpHeight + 7*sprinting)
			skeleton_animation_clear(9)
			skeleton_animation_set_ext("jump_normal",9)
			alarm[9] = skeleton_animation_get_frames("jump_normal")/1.2
		}
	
	}

	if(col_top) {vsp = 0}

	y += vsp;

*/

}; //function end bracket
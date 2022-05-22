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
	
	var D = keyboard_check(ord("D")) and !keyboard_check(ord("A"));
	var A = keyboard_check(ord("A")) and !keyboard_check(ord("D"));
	var S = keyboard_check(ord("S"));
	var Shift = keyboard_check(vk_shift);
	
//++++++++++++++++++++++++++++++++++++ BASIC MOVEMENT +++++++++++++++++++++++++++++++++++++++++++++++

	if(CanMove > 0) {
		
		var face_left = mouse_x < x;
		var face_right = mouse_x > x;
		var mouse_facing = sign(mouse_x - x);
		image_xscale = mouse_facing;
		
		var MSpeed = MoveSpeed;
		hspeed = 0; walking = 0; crouching = 0; sprinting = 0; crawling = 0;

		//----------------move right
		if (D and !col_right) {
					
			if(face_left) {
				MSpeed = MoveSpeed/4;
				hspeed = MSpeed; sprinting = 0; walking = 1;
				if (col_bot) {skeleton_anim_set_step(backwalk,2)};
			};
			
			if(face_right) {
				if(Shift) {MSpeed = MoveSpeed*1.1; var Anim = sprint} else{MSpeed = MoveSpeed/2; var Anim = walk};
				hspeed = MSpeed; sprinting = Shift; walking = !sprinting;
				if (col_bot) {skeleton_anim_set_step(Anim,2)};
			};
		};
		
		//-----------------------move left
		if (A and !col_left) {
					
			if(face_right) {
				MSpeed = MoveSpeed/4;
				hspeed = -MSpeed; sprinting = 0; walking = 1;
				if (col_bot) {skeleton_anim_set_step(backwalk,2)};
			};
			
			if(face_left) {
				if(Shift) {MSpeed = MoveSpeed*1.1; var Anim = sprint} else{MSpeed = MoveSpeed/2; var Anim = walk};
				hspeed = -MSpeed; sprinting = Shift; walking = !sprinting;
				if (col_bot) {skeleton_anim_set_step(Anim,2)};
			};
		};
		
	};//---------canmove end bracket
		

		/*	

	else if(hspeed = 0 and !col_bot or !col_bot and !stunned) {
			air_timer += 1 //adds a slight delay to the air idle animation transition, was causing weird stuff when climbing slopes
			if(air_timer >= 10) {
				skeleton_animation_clear(2)
				skeleton_anim_set_step("idle_air",2)
			}		
		}

	//initiate crouching anim when we press S
	if S {skeleton_animation_set_ext("crouch", 2) crouching = 1}

	*/
	//--------------sets idles
	
	if (hspeed = 0 and col_bot) {
		skeleton_animation_clear(2)
	};
	
	if (wpn_active.weapon_slot = "primary") {
		skeleton_anim_set_step(ranged_animgrp.idle,1)
	};

/*		
//+++++++++++++++++++++++++++++++++++++++++++++++++++ gravity ++++++++++++++++++++++++++++++++++++++++++++++++

	//moved to begin step event

//++++++++++++++++++++++++++++++++++++++++++++++++ SLOPES ++++++++++++++++++++++++++++++++++++++++++++++

//SEE BEGIN STEP EVENT FOR GRAVITY AND OTHER SLOPE STUFF

  if(col_slope) {
	
	var Grade = abs(col_slope.image_yscale)/abs(col_slope.image_xscale)//determines slope of slope
	Climb = ceil(abs(hspeed))*ceil(Grade*1.6) + grav*2 //calculates climb amount via slope*1.6 and gravity*2 and movespeed
	y -= Climb 

	//mask_index = 1
  } 
	 
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
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerMovement() {
	
//++++++++++++++++++++++++++++++++++++++++++ VARIABLES ++++++++++++++++++++++++++++++++++++++++++++++++
	
	//var anim_array2 = wpn_melee[wpn_melee.Animations];
	var ranged_animgrp = wpn_active.animation_group;
	var melee_animgrp = wpn_active_melee.animation_group;
	var IsRanged = string_count("ranged",wpn_active.item_type);
	var sprint = "Basic Movement/sprint_full_rifle";
	var walk = "Basic Movement/walk_rifle";
	var backwalk = "Basic Movement/backwalk_rifle";
	if(variable_struct_exists(ranged_animgrp,"sprint")) {var sprint = ranged_animgrp.sprint};
	if(variable_struct_exists(ranged_animgrp,"walk")) {var walk = ranged_animgrp.walk};
	if(variable_struct_exists(ranged_animgrp,"backwalk")) {var backwalk = ranged_animgrp.backwalk};
	//if(LegsCrippled = 1) {walk = "walk_crawl"};
	
	var W = keyboard_check_pressed(ord("W")); 
	var D = keyboard_check(ord("D")); 
	var A = keyboard_check(ord("A"));
	var S = keyboard_check(ord("S"));
	var Q = keyboard_check(ord("Q"));
	var Shift = keyboard_check(vk_shift) * CanSprint;
	var Space = keyboard_check_pressed(vk_space);
		
	col_bot = place_meeting(x,y+1,o_platform);
	
//------------------------------- Weapon idle scripts ---------------------------------------------------

var TwoHanded = (wpn_active_melee.weapon_slot[1] = 2);

if (wpn_active.weapon_slot[0] = "primary") {
	skeleton_anim_set_step(ranged_animgrp.idle,1)
	if(aud_melee_idle != 0) {audio_stop_sound(aud_melee_idle); aud_melee_idle = 0};
};

else if ((wpn_active.weapon_slot[0] = "secondary")) {
	skeleton_anim_set_step(ranged_animgrp.idle,1);		
	if(!reloading and !TwoHanded) {skeleton_anim_set_step(melee_animgrp.idle,5)};
};

else if ((wpn_active.weapon_slot[0] = "melee")) {
	skeleton_anim_set_step(ranged_animgrp.idle,1);		
	if(!reloading and !TwoHanded) {skeleton_anim_set_step(melee_animgrp.idle_alternate,5)};
};

if(sprinting && (hspd != 0) && !switch_toggle) {
	if( (wpn_active.weapon_slot[0] = "melee") ) {
		skeleton_animation_clear(1)
	};
	skeleton_animation_clear(5);
};

if(rolling && (wpn_active.weapon_slot[0] = "melee") && (wpn_active.weapon_slot[1] = 3) ) {
	skeleton_animation_clear(5); skeleton_animation_clear(1);
};

//+++++++++++++++++++++++++++++++++++++++ Control Inputs +++++++++++++++++++++++++++++++++++++++++++++++

	//if(!rolling and !swinging) {hspd = hspd*0.95};
	if(!rolling and !swinging) {hspd = 0};
	sprinting = 0;
	crouching = 0;
	var face_left = mouse_x < x;
	var face_right = mouse_x > x;
	var mouse_facing = sign((mouse_x*1.01) - x); //prevents our mouse_facing from equaling 0, hiding the player
	var move = (D - A) * MoveSpeed;

if(CanMove) {
	
	image_xscale = mouse_facing*image_yscale;
		
	if(D) {
		if(face_left) {
			hspd = (move*CanMove)*0.5; 			
			if(col_bot) {
				if( (wpn_active.weapon_slot[0]="melee") && (wpn_active.weapon_slot[1]=3) ) {skeleton_animation_clear(5)};
				skeleton_anim_set_step(backwalk,2)
			}; 
		};
		if(face_right) {
			if(Shift) {hspd = (move*CanMove)*1.5; if(col_bot) {skeleton_anim_set_step(sprint,2); sprinting = 1} };
			else {
				hspd = move*CanMove; 
				if(col_bot) {
					if( (wpn_active.weapon_slot[0]="melee") && (wpn_active.weapon_slot[1]=3) ) {skeleton_animation_clear(5)};
					skeleton_anim_set_step(walk,2)
				}; 
			};
		};		
	};
	
	if(A) {
		if(face_right) {
			hspd = (move*CanMove)*0.5; 
			skeleton_anim_set_step(backwalk,2);
			if(col_bot) {
				if( (wpn_active.weapon_slot[0]="melee") && (wpn_active.weapon_slot[1]=3) ) {skeleton_animation_clear(5)};
				skeleton_anim_set_step(backwalk,2);
			}; 
		};
		if(face_left) {
			if(Shift) {hspd = (move*CanMove)*1.5; if(col_bot) {skeleton_anim_set_step(sprint,2); sprinting = 1} };
			else {
				hspd = move*CanMove; 
				if(col_bot) {
					if( (wpn_active.weapon_slot[0]="melee") && (wpn_active.weapon_slot[1]=3) ) {skeleton_animation_clear(5)};
					skeleton_anim_set_step(walk,2)
				}; 
			};
		};	
	};
				
	//Jump with W, force aided by sprinting
	if(W && place_meeting(x, y+10, o_platform)) {vspd = -20 * (1+(Shift/3))};

	//initiate crouching anim when we press S
	if (S) {skeleton_animation_set_ext("Basic Movement/crouch", 2) crouching = 1};
	
	if(Space && CanRoll && col_bot) { //roll when pressing spacebar
		rolling = 1;
		hspd = MoveSpeed*1.3*image_xscale;
		sprinting = 0;
		skeleton_animation_clear(4); 
		if(IsRanged) {
			if(is_array(wpn_active.animation_group.fire)) {
				audio_stop_sound(aud_spoolup); aud_spoolup = 0;
				audio_stop_sound(aud_spooldown); aud_spooldown = 0;
				if(spindown_toggle) {
					skeleton_animation_clear(3);
					skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
				};
			};
		};
		reloading = 0;
		if(reloading) {skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment)};
		skeleton_animation_clear(2);
		skeleton_anim_set_step("Basic Movement/roll_fast",2);
	};		
}; //canmove check end bracket	

//+++++++++++++++++++++++++++++++++++++ collisions and gravity +++++++++++++++++++++++++++++++++++++

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
	var Hspd2 = hspd+(sign(hspd)*2);
	var climb = 0; //our variable used to attempt to find a clear position to ascend to
	while ( place_meeting(x+Hspd2,y-climb,o_platform) && (climb <= abs(MaxGrade*hspd)) ) {climb += 1}; //attempts to find a clear position to ascend to, the maximum height of which is determined by our speed and maxgrade value
		if (place_meeting(x+Hspd2,y-climb+vspd,o_platform) or (vspd != 0)) { //if we fail to find a position in range of our maximum climb, the player moves forward horizontally until it hits the wall			
			move_outside_solid(180,100);
			move_outside_solid(0,100);
			hspd = 0
		};
		else { //if we succeed in finding a clear position, move to it
			y -= climb;
			vspd_readonly = (vspd - climb)
		};
};

if (!A && !D && (abs(hspd) <= 6) && !rolling and !crouching) {
	skeleton_animation_clear(2)
};

if(col_bot = 0 && !rolling) {
	skeleton_animation_clear(2);
	skeleton_anim_set_step("Basic Movement/idle_air",2);
	
	if( (wpn_active.weapon_slot[0] = "melee") && (wpn_active.weapon_slot[1] = 3) ) {
		skeleton_animation_clear(5)
	};
};
	
x += hspd;
		
// Downward slopes
if (!place_meeting(x,y,o_platform) && vspd >= 0 && place_meeting(x,y+2+abs(hspd),o_platform)) {
	while(!place_meeting(x,y+1,o_platform)) {y += 1; vspd_readonly+=1}
};
	
y += vspd; //change our Y by effects of gravity and climb values
switch_toggle = 0;

}; //function end bracket <--------
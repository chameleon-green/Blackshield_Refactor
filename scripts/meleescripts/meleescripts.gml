
#region melee damage calculator function
//calculates damage, given an entity and a weapon
function MeleeDamageCalculator(entity,weapon){
	
	var ScalingArray = weapon.scalings //where are we getting our scalings?
	var ScalingCount = array_length(ScalingArray); //how many scalings do we have?
	var BaseDamage = weapon.damage;
	var DamageMod = 0;
	
	for(var i=0; i<ScalingCount; i++) {
		var Scaling = ScalingArray[i]; //what is our scaling string?
		var ScalingStat = (string_char_at(Scaling,1) + string_char_at(Scaling,2) + string_char_at(Scaling,3) ); //what is the stat string?
		var ScalingValue = real(string_digits(Scaling))/100; //what percentage does this scaling scale by?
		var EntityStat = variable_instance_get(entity,ScalingStat); //what is our stat to boost damage with?
		
		DamageMod += EntityStat*ScalingValue
	};
	
	return(BaseDamage + DamageMod);
		
}; //damage calc end bracket
#endregion

#region melee striking function
//note that methods must be defined before time sources can be called, so some of this may seem backwards
function PlayerMeleeControl(){
	
	if(swinging) {};
	else{skeleton_animation_clear(8)};
	
	//---------------------------------- Initial Swing -----------------------------------------------
	
	if(!rolling && mouse_check_button_released(mb_right)) {
		
		var InputState = time_source_get_state(melee_input_check_timer);
		var Queued = (InputState = time_source_state_active);
		
		if(!Queued) {
			CanMove = 0; CanShoot = 0; CanReload = 0; CanRoll = 0; //we can't do anything while swinging
			hspd = 9*image_xscale; reloading = 0; //interrupt movement and reloading while swinging
						
			skeleton_animation_clear(2);skeleton_animation_clear(3);skeleton_animation_clear(4);
			skeleton_animation_clear(5);skeleton_animation_clear(6);skeleton_animation_clear(7);
			
			//spoolgun related stuff. end spool or spooldown when we swing
			if(is_array(wpn_active.animation_group.fire)) {
			audio_stop_sound(aud_spoolup); aud_spoolup = 0;
			audio_stop_sound(aud_spooldown); aud_spooldown = 0;
			if(spindown_toggle) {
				skeleton_animation_clear(3);
				skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
				};
			};
			
			swinging = 1; 
		
			var Attack_Array = wpn_active_melee.animation_group;
			var Animation = Attack_Array.light_attack[0+attack_sequence];
			var AnimationLength = skeleton_animation_get_frames(Animation);
		
			var _EndMelee = function(){
				swinging = 0;
				skeleton_animation_clear(6);
				skeleton_animation_clear(8);
				hspd = 0;				
			};
			
			var _ClearInputBuffer = function(){
				time_source_reset(melee_input_check_timer);
				attack_sequence = 0;
			};
		
			skeleton_anim_set_step(Animation,6);
			skeleton_anim_set_step(Attack_Array.strike,8);
			attack_sequence += 1;
			time_source_reconfigure(melee_reset_timer,AnimationLength,time_source_units_frames,_EndMelee);
			time_source_start(melee_reset_timer);
			time_source_reconfigure(melee_input_check_timer,AnimationLength+15,time_source_units_frames,_ClearInputBuffer);
			time_source_start(melee_input_check_timer);
			exit;
		};//swinging check bracket 
	
	//----------------------------------------queue up next attack
	
		if(Queued && attack_sequence_toggle && (attack_sequence < array_length(wpn_active_melee.animation_group.light_attack))) {
		
			attack_sequence_toggle = 0;
			var TimeLeft = time_source_get_time_remaining(melee_reset_timer) //get time until current anim is done
			time_source_reset(melee_reset_timer); //reset our melee end timer so we have time to set it for our next attack
		
			var _NextAttack = function(){
				var Attack_Array = wpn_active_melee.animation_group; //our array of animations
				var Animation = Attack_Array.light_attack[0+attack_sequence]; //find our next attack to animate
				var AnimationLength = skeleton_animation_get_frames(Animation); //how long is the attack in frames
				
				swinging = 1; //we are swinging a sword
				hspd = 9*image_xscale;
				
				skeleton_animation_clear(6); //clear our current attack, as it is done
				skeleton_anim_set_step(Animation,6); //animate our next attack	
				skeleton_anim_set_step(Attack_Array.strike,8);
				
				attack_sequence += 1; //increment attack sequence by 1 to play next animation if another attack is qeued
				
				var _EndMelee = function(){ //function to end melee when our reset time runs out
					swinging = 0;
					skeleton_animation_clear(6);
					skeleton_animation_clear(8);
					hspd = 0;
					};
					
				var _ClearInputBuffer = function(){
					time_source_reset(melee_input_check_timer);
					attack_sequence = 0;		
				};
					
				time_source_reconfigure(melee_reset_timer,AnimationLength,time_source_units_frames,_EndMelee); //reconf our reset timer to use our new attack length
				time_source_start(melee_reset_timer); //start the reset timer
				time_source_reconfigure(melee_input_check_timer,AnimationLength+15,time_source_units_frames,_ClearInputBuffer);
				time_source_start(melee_input_check_timer);
				
				attack_sequence_toggle = 1;
			};
		
			time_source_reconfigure(melee_sequence_timer,TimeLeft,time_source_units_frames,_NextAttack); //qeue up our next attack when our current one is done
			time_source_start(melee_sequence_timer); //start our timer to qeue up next attack and use _NextAttack method
			
		};//swinging check bracket
	};//mb released check bracket	
}; //melee strike function
#endregion
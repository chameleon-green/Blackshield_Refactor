
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
	
	var InputState = time_source_get_state(melee_input_check_timer);
	var Queued = (InputState = time_source_state_active);
	var IsRanged = string_count("ranged",wpn_active.item_type);
	
	if(!swinging) {skeleton_animation_clear(8)};
	
	//---------------------------------- Initial Swing -----------------------------------------------
	
	if(!rolling && mouse_check_button_released(mb_right)) {
		
		if( (melee_charge < 13) && !Queued && light_melee_toggle) {
			attack_sequence = 0;
			CanMove = 0; CanShoot = 0; CanReload = 0; CanRoll = 0; //we can't do anything while swinging
			reloading = 0; //interrupt movement and reloading while swinging hspd = 9*image_xscale; 
						
			skeleton_animation_clear(2);skeleton_animation_clear(3);skeleton_animation_clear(4);
			skeleton_animation_clear(5);skeleton_animation_clear(6);skeleton_animation_clear(7);
			
			//spoolgun related stuff. end spool or spooldown when we swing
			if(IsRanged){
				if(is_array(wpn_active.animation_group.fire)) {
				audio_stop_sound(aud_spoolup); aud_spoolup = 0;
				audio_stop_sound(aud_spooldown); aud_spooldown = 0;
				if(spindown_toggle) {
					skeleton_animation_clear(3);
					skeleton_anim_set_step(wpn_active.animation_group.fire[2],3)
					};
				};
			};
			
			swinging = 1; 
			melee_charge = 0;
			if(wpn_active_melee.weapon_slot[1] = 2) {skeleton_attachment_set("slot_gun magazine",-1)};
			hspd = 0;
		
			var Attack_Array = wpn_active_melee.animation_group;
			var Animation = Attack_Array.light_attack[0+attack_sequence];
			var AnimationLength = skeleton_animation_get_frames(Animation);
		
			skeleton_anim_set_step(Animation,6);
			skeleton_anim_set_step(Attack_Array.strike,8);
			attack_sequence += 1;
			time_source_reconfigure(melee_reset_timer,AnimationLength,time_source_units_frames,Func_EndMelee);
			time_source_start(melee_reset_timer);
			time_source_reconfigure(melee_input_check_timer,AnimationLength+7,time_source_units_frames,Func_ClearInputBuffer);
			time_source_start(melee_input_check_timer);
			exit;
		};//----------swinging check bracket 
	
	//----------------------------------------queue up next attack
	
		if((melee_charge < 13) && Queued && attack_sequence_toggle && (attack_sequence < array_length(wpn_active_melee.animation_group.light_attack))) {
		
			attack_sequence_toggle = 0;
			var TimeLeft = time_source_get_time_remaining(melee_reset_timer) //get time until current anim is done
			time_source_reset(melee_reset_timer); //reset our melee end timer so we have time to set it for our next attack
		
			var _NextAttack = function(){
				var Attack_Array = wpn_active_melee.animation_group; //our array of animations
				var Animation = Attack_Array.light_attack[0+attack_sequence]; //find our next attack to animate
				var AnimationLength = skeleton_animation_get_frames(Animation); //how long is the attack in frames
				
				swinging = 1; //we are swinging a sword
				melee_charge = 0;
				if(wpn_active_melee.weapon_slot[1] = 2) {skeleton_attachment_set("slot_gun magazine",-1)};
				hspd = 0;
				
				skeleton_animation_clear(6); //clear our current attack, as it is done
				skeleton_anim_set_step(Animation,6); //animate our next attack	
				skeleton_anim_set_step(Attack_Array.strike,8);
				
				attack_sequence += 1; //increment attack sequence by 1 to play next animation if another attack is qeued
					
				time_source_reconfigure(melee_reset_timer,AnimationLength,time_source_units_frames,Func_EndMelee); //reconf our reset timer to use our new attack length
				time_source_start(melee_reset_timer); //start the reset timer
				time_source_reconfigure(melee_input_check_timer,AnimationLength+7,time_source_units_frames,Func_ClearInputBuffer);
				time_source_start(melee_input_check_timer);
				
				attack_sequence_toggle = 1;
			};
		
			time_source_reconfigure(melee_sequence_timer,TimeLeft,time_source_units_frames,_NextAttack); //qeue up our next attack when our current one is done
			time_source_start(melee_sequence_timer); //start our timer to qeue up next attack and use _NextAttack method
			
		};//Already currently swinging check (qeued check)
		
	//---------------------------------------------------------- HEAVY ATTACK CODE --------------------------------------------------------
	
		if( (melee_charge >= 35) && heavy_melee_toggle) {Func_HeavyAttack()};
		else if ( (skeleton_animation_get_ext(6) = wpn_active_melee.animation_group.windup) && (melee_charge < 35) ) {time_source_reset(melee_reset_timer); Func_EndMelee()};
		
		heavy_melee_toggle = 1;
		
	};//------------mb released check bracket	
	
	//charge up melee by holding RMB
	if(mouse_check_button(mb_right) and !Queued) {melee_charge += 1} else{melee_charge = 0};
	
	//set us into windup anim if we are holding RMB
	if(melee_charge >= 13 && heavy_melee_toggle) {		
		
		reloading = 0;
		
		skeleton_animation_clear(2);skeleton_animation_clear(3);skeleton_animation_clear(4);
		skeleton_animation_clear(5);skeleton_animation_clear(7);
		
		Func_ClearInputBuffer();
		
		time_source_reset(melee_input_check_timer); time_source_reset(melee_sequence_timer);
		
		swinging = 1;
		skeleton_anim_set_step(wpn_active_melee.animation_group.windup,6);
		skeleton_anim_set_step(wpn_active_melee.animation_group.strike,8);
		if(wpn_active_melee.weapon_slot[1] = 2) {skeleton_attachment_set("slot_gun magazine",-1)};
		hspd = 0;
		
		var AnimLength = skeleton_animation_get_frames(wpn_active_melee.animation_group.windup);
		var InputState = time_source_get_state(melee_reset_timer);
		
		if(InputState != 1) {
			time_source_reconfigure(melee_reset_timer,AnimLength,time_source_units_frames,Func_HeavyAttack); //reconf our reset timer to use our new attack length
			time_source_start(melee_reset_timer) //start the reset timer
		};
		
	};	
	
}; //------------melee strike function
#endregion
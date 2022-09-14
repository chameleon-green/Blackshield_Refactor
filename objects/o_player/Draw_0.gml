
audio_listener_set_position(0,x,y,0);




//------------------------------------------- STATE TOGGLES --------------------------------------------

var IsRanged = string_count("ranged",wpn_active.item_type);
CanShoot = (!MyIC.visible && !sprinting && !rolling && !reloading && !swinging && IsRanged);
CanReload = (!rolling && !reloading && !swinging);
CanMove = (!rolling && !swinging);
CanRoll = (!rolling && !swinging);

//------------------------------------------- MOVEMENT STUFF -----------------------------------------------

PlayerMovement();
draw_self();

//-------------------------------------------- SHOOTY STUFF --------------------------------------------------

if(IsRanged){
	
	if(spread_angle > (wpn_active.spread)) {spread_angle = spread_angle*0.97};
	if(spread_angle < (wpn_active.spread)) {spread_angle = wpn_active.spread};
	var HeatReduction = clamp(1/wpn_active_heat,2/wpn_active.heat_capacity,2);
	if(wpn_active_heat > 0) {wpn_active_heat -= HeatReduction};
	if(wpn_active_heat < 0) {wpn_active_heat = 0};
	
};
PlayerWeaponControl();

//--------------------------------------------- MELEE STUFF ----------------------------------------------------

PlayerMeleeControl()

//--------------------------------------------- DEBUG STUFF ------------------------------------------------

//draw_text(x,bbox_top-100,wpn_active.name);
//draw_text(x,bbox_top-120,wpn_secondary.name);

draw_text(x,bbox_top-100,magazine_active);
draw_text(x,bbox_top-120,magazine_primary);
draw_text(x,bbox_top-130,magazine_secondary);
draw_text(x,bbox_top-140,skeleton_animation_get_ext(4));





audio_listener_set_position(0,x,y,0);




//------------------------------------------- STATE TOGGLES --------------------------------------------

CanShoot = (!sprinting && !rolling && !reloading && !swinging);
CanReload = (!rolling && !reloading && !swinging);
CanMove = (!rolling && !swinging);
CanRoll = (!rolling && !swinging);

//------------------------------------------- MOVEMENT STUFF -----------------------------------------------

PlayerMovement();
draw_self();

//-------------------------------------------- SHOOTY STUFF --------------------------------------------------

if(spread_angle > (wpn_active.spread)) {spread_angle = spread_angle*0.97};
var HeatReduction = clamp(1/wpn_active_heat,2/wpn_active.heat_capacity,2);
if(wpn_active_heat > 0) {wpn_active_heat -= HeatReduction};
if(wpn_active_heat < 0) {wpn_active_heat = 0};
PlayerWeaponControl();

//--------------------------------------------- MELEE STUFF ----------------------------------------------------

PlayerMeleeControl()

//--------------------------------------------- DEBUG STUFF ------------------------------------------------

var state = time_source_get_state(melee_reset_timer)
var anim = skeleton_animation_get_ext(5)

draw_text(x,bbox_top-100,state);
draw_text(x,bbox_top-120,aud_melee_idle);





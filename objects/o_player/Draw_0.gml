
audio_listener_set_position(0,x,y,0);




//------------------------------------------- STATE TOGGLES --------------------------------------------

CanShoot = (!MyIC.visible && !sprinting && !rolling && !reloading && !swinging );
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

//draw_text(x,bbox_top-100,ammo_primary.name);
//draw_text(x,bbox_top-120,aud_melee_idle);





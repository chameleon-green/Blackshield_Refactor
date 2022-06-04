
CanShoot = 1;
CanReload = 1;
audio_listener_set_position(0,x,y,0);

PlayerMovement();

if(sprinting or rolling or reloading) {CanShoot = 0};

if(spread_angle > (wpn_active.spread)) {spread_angle = spread_angle*0.97};

PlayerWeaponControl();

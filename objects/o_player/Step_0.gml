
CanShoot = 1;

PlayerMovement();

if(sprinting or rolling) {CanShoot = 0};

if(spread_angle > (wpn_active.spread)) {spread_angle = spread_angle*0.97};




target = o_player;
ammo_active = o_IC.Ammo_Mortar_90mm;

TargetX = target.x;
TargetY = target.y;

adjust_timer = timer_create(600);
ffe_timer = timer_create(100);
deflection_timer = timer_create(1000);

scatter_angle_base = 6;
scatter_angle = scatter_angle_base;
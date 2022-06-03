

if(cycle and !sprinting) {

cycle = 0;

var RPM = wpn_active.ROF * ammo_active.ROF_mod;
var time = ( 1000/(RPM/60) )/16.7;
alarm[0] = time;
alarm[1] = 2;

var Max_Spread = wpn_active.spread*10;
var Spread_Divisor = irandom_range(1,5) * choose(-1,1)
if(spread_angle < Max_Spread) {spread_angle += wpn_active.spread};
instant_spread = (spread_angle/Spread_Divisor);

instance_create_depth(flash_x,flash_y,depth+1,o_bullet,{
		type : other.ammo_active, 
		IFF : other.IFF,
		damage : other.wpn_active.damage,
		direction : other.AimAngle2 + other.instant_spread,
		speed : other.wpn_active.muzzle_velocity * other.ammo_active.velocity_mod
		});

skeleton_animation_set_ext(wpn_active.animation_group.fire,3)

var flash = irandom(3);

if(ammo_active.flash_color != "none") {skeleton_slot_color_set("slot_flash",ammo_active.flash_color[0],1)};
else {skeleton_slot_color_set("slot_flash",wpn_active.flash_color[0],1)};

skeleton_attachment_set("slot_flash",wpn_active.flash_type[flash]);
skeleton_attachment_set("slot_flash_core",wpn_active.flash_type[flash] + " core");

var ejection_map = ds_map_create();
skeleton_bone_state_get("gun_anim", ejection_map);
var EjectX = ds_map_find_value(ejection_map, "worldX");
var EjectY = ds_map_find_value(ejection_map, "worldY");
var EjectAng = ds_map_find_value(ejection_map, "worldAngleX");

instance_create_depth(EjectX,EjectY,depth-1,o_gib,{
	sprite_index : other.ammo_active.casing_type[0],
	image_index : other.ammo_active.casing_type[1],
	hspd : -irandom_range(8,12)*other.image_xscale,
	vspd : -random_range(3,5),
	angspeed : irandom_range(-25,25)
});

ds_map_destroy(ejection_map);

};

AnimationsFlashesSoundGroups();
WeaponStructs();


//----------------------------------- MOVEMENT VARIABLES -----------------------------------

//movement toggles
CanMove = 1;
CanShoot = 1;
CanRoll = 1;
CanSprint = 1;

//movement values
MoveSpeed = 6; //11 = max agil
JumpHeight = 20;
hspd = 0;
vspd = 0;

//movement statuses
rolling = 0;
crouching = 0;
jumping = 0;
crawling = 0;
walking = 0;
sprinting = 0;

//collision statuses
col_bot = 1;
col_right = 0;
col_left = 0;

//----------------------------------- EQUIPMENT VARIABLES ----------------------------------

wpn_active = Boltgun_Phobos;
skeleton_animation_set(wpn_active.animation_group.idle);
skeleton_attachment_set("slot_gun",wpn_active.weapon_attachment);
skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment);

selector = wpn_active.firemodes[0]; //selector switch setting
cycle = 1; //weapon ROF cycle check
spread_angle = wpn_active.spread;

//---------------------------------- INSTANCE CREATION --------------------------------

xhair = instance_create_depth(x,y,depth,o_xhair);
with (xhair) {owner = other.id};







	
	




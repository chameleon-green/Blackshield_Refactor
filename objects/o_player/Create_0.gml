AnimationsFlashesSoundGroups();
AmmoStructs();
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

//equipment statuses
reloading = 0;
spooled = 0;
spindown_toggle = 0;

//equipment sound stuff
aud_fireloop = 0; //loop for guns with loop sounds

wpn_active = Shotgun_Astartes;
ammo_active = wpn_active.default_ammo_type;
magazine_active = wpn_active.capacity;
skeleton_animation_set(wpn_active.animation_group.idle);
skeleton_attachment_set("slot_gun",wpn_active.weapon_attachment);
skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment);

selector_real = 0
selector = wpn_active.firemodes[selector_real]; //selector switch setting
cycle = 1; //weapon ROF cycle check
burst_count = 0; //count of rounds fired in burst, if this weapon is burstfire
spread_angle = wpn_active.spread; //accumulating spread
instant_spread = 0; //spread to add to animations when firing

flash_x = 0;
flash_y = 0;
flash_angle = 0;

IFF = "player:"+string(id); 

//---------------------------------- INSTANCE CREATION --------------------------------

xhair = instance_create_depth(x,y,depth,o_xhair);
with (xhair) {owner = other.id};







	
	




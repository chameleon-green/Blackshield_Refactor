AnimationsFlashesSoundGroups();
AmmoStructs();
WeaponStructs();
var _mymethod = function(){};

image_xscale = 1;
image_yscale = 1;
//----------------------------------- MOVEMENT VARIABLES -----------------------------------

//movement toggles
CanMove = 1;
CanShoot = 1;
CanRoll = 1;
CanSprint = 1;

//movement values
MoveSpeed = 10; //11 = max agil
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

//----------------------------------- find weapons and armor ------------------------------------

wpn_primary = Unarmed_Fists; wpn_secondary = Unarmed_Fists; wpn_active = wpn_primary;
wpn_primary_id = -2; wpn_secondary_id = -3; wpn_active_id = wpn_primary_id;
magazine_primary = 0; magazine_secondary = 0; magazine_active = 0;
ammo_primary = 0; ammo_secondary = 0; ammo_primary_id = -1; ammo_secondary_id = -1; 

var WpnGrid = MyIC.grd_inv_wepn;
var AmmoGrid = MyIC.grd_inv_ammo;

var WeaponKey = SearchForItem(WpnGrid,"primary","weapon_slot",0);
if(WeaponKey != -1) {
	wpn_primary = ds_grid_get(WpnGrid,0,WeaponKey); wpn_primary_id = ds_grid_get(WpnGrid,8,WeaponKey);	
	wpn_active = wpn_primary; wpn_active_id = wpn_primary_id;
	ammo_primary = wpn_primary.default_ammo_type; ammo_active = ammo_primary;
	magazine_primary = wpn_primary.capacity; magazine_active = magazine_primary;		
	selector_real = 0; //numerical value for selector, used to access array of selector option strings
	selector = wpn_active.firemodes[selector_real]; //selector switch setting	
	skeleton_attachment_set("slot_gun",wpn_active.weapon_attachment);
	skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment);
};

var AmmoKey1 = ds_grid_value_y(AmmoGrid,0,0,10,MyIC.InventorySize,wpn_primary.default_ammo_type);
if(AmmoKey1 != -1) {
	ammo_primary_id = ds_grid_get(AmmoGrid,8,AmmoKey1);
	ammo_active_id = ammo_primary_id;
};

//----------------------------------- EQUIPMENT VARIABLES ----------------------------------



//equipment statuses
reloading = 0;
spooled = 0;
spindown_toggle = 0;
wpn_active_heat = 0;

//equipment sound stuff
aud_fireloop = 0; //loop for guns with loop sounds
aud_chargeloop = 0; //loop for guns with charging
aud_spoolup = 0; //sound for spooling up
aud_spooldown = 0; //sound for spooling down

/*
wpn_primary = Shotgun_Astartes;
wpn_primary_id = 0;
ammo_primary = wpn_primary.default_ammo_type;
magazine_primary = wpn_primary.capacity
*/

//wpn_secondary = -1;//Bolt_Pistol_Tigrus;
//wpn_secondary_id = 0;
//ammo_secondary = wpn_secondary.default_ammo_type;
//magazine_secondary = wpn_secondary.capacity


skeleton_animation_set(wpn_active.animation_group.idle);

cycle = 1; //weapon ROF cycle check
burst_count = 0; //count of rounds fired in burst, if this weapon is burstfire
spread_angle = 0; //accumulating spread
instant_spread = 0; //spread to add to animations when firing

charge_toggle = 1;
charge_scale = 1;

flash_x = 0;
flash_y = 0;
flash_angle = 0;

burst_timer = time_source_create(time_source_game,0,time_source_units_frames,_mymethod);

IFF = "player:"+string(id); 

//------------------------------------------- Melee related stuff --------------------------

swing = [0,0,0,0]; //x,y,angle,killvalue


aud_melee_idle = 0;

wpn_active_melee = Unarmed_Fists;
wpn_melee_id = 0;

melee_reset_timer = time_source_create(time_source_game,0,time_source_units_frames,_mymethod);
melee_input_check_timer = time_source_create(time_source_game,0,time_source_units_frames,_mymethod); 
melee_sequence_timer = time_source_create(time_source_game,0,time_source_units_frames,_mymethod);

attack_sequence = 0; //what attack we are at in our combo. used to navigate array of attack animations
attack_sequence_toggle = 1; //toggle to prevent input from interrupting combos
swinging = 0; //are we swinging a weapon?
melee_charge = 0; //our charge amount for heavy attacks
heavy_melee_toggle = 1; //allow us to heavy attack once we have released RMB again
light_melee_toggle = 1; //allow us to make a light melee attack 

#region Melee time related functions
Func_EndMelee = function(){ //function to end melee when our reset time runs out
	
	swing[3] = 0; //kill our blade object
	swinging = 0; hspd = 0;
	skeleton_animation_clear(6); skeleton_animation_clear(8);		
	if(string_count("weapon_ranged",wpn_active.item_type)){
		skeleton_attachment_set("slot_gun",wpn_active.weapon_attachment);
		skeleton_attachment_set("slot_gun magazine",wpn_active.magazine_attachment);
	};
};
					
Func_ClearInputBuffer = function(){
	time_source_reset(melee_input_check_timer);
	attack_sequence = 0;		
};

Func_HeavyAttack = function(){

	swinging = 1; //we are swinging a sword
	melee_charge = 0;
	if(wpn_active_melee.weapon_slot[1] = 2) {skeleton_attachment_set("slot_gun magazine",-1)};
	hspd = 0;
	var AnimFrames = skeleton_animation_get_frames(wpn_active_melee.animation_group.heavy_attack);
	attack_sequence = 0;
	heavy_melee_toggle = 0;
	skeleton_animation_clear(6);
	skeleton_anim_set_step(wpn_active_melee.animation_group.heavy_attack,6);
	time_source_reconfigure(melee_reset_timer,AnimFrames,time_source_units_frames,Func_EndMelee);
	time_source_start(melee_reset_timer);
};
#endregion				

//------------------------------------------- STATS STRUCTS ------------------------------------------------

#region Base stats, stats and stat modifier structs
Base = {		
	AGI : 100, 
	CHR : 100,
	DEX : 100, 
	END : 100,
	INT : 100, 
	LCK : 100,
	PER : 100, 
	STR : 100,		
	WIL : 100						
	};
	
Mod = {		
	AGI : 00, 
	CHR : 00,
	DEX : 00, 
	END : 00,
	INT : 00, 
	LCK : 00,
	PER : 00, 
	STR : 00,		
	WIL : 00						
	};
#endregion
PlayerStatsCalculator();

//---------------------------------- INSTANCE CREATION --------------------------------

var IC_ID = -1;
if(variable_instance_exists(id,"MyIC")) {IC_ID = MyIC};
xhair = instance_create_depth(x,y,depth,o_xhair,{
	owner : other.id,
	MyIC : IC_ID	
});










	
	




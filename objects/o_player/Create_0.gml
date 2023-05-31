AnimationsFlashesSoundGroups();
AmmoStructs();
WeaponStructs();
var _mymethod = function(){}; 

image_xscale = 1;
image_yscale = 1;
//----------------------------------- MOVEMENT VARIABLES -----------------------------------

cover = 0;

//movement toggles
CanMove = 1;
CanShoot = 1;
CanRoll = 1;
CanSprint = 1;

//movement values
MoveSpeed = 11; //11 = max agil
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

//------------------------------------------- STATS STRUCTS AND HITBOXES ------------------------------------------------

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
	AGI : 0, 
	CHR : 0,
	DEX : 0, 
	END : 0,
	INT : 0, 
	LCK : 0,
	PER : 0, 
	STR : 0,		
	WIL : 0						
	};
#endregion

resist_base = [0,0,0,0,0,0,0,0,0];
resist_head = [0,0,0,0,0,0,0,0,0]; //phys0, ther1, cryo2, corr3, radi4, elec5, hazm6, warp7
resist_torso = [0,0,0,0,0,0,0,0,0];
resist_armL = [0,0,0,0,0,0,0,0,0];
resist_armR = [0,0,0,0,0,0,0,0,0];
resist_legL = [0,0,0,0,0,0,0,0,0];
resist_legR = [0,0,0,0,0,0,0,0,0];

hbox_head = [20,146,-20,176];
hbox_torso = [30,85,-30,146];
hbox_legs = [30,0,-30,85];

PlayerStatsCalculator();

HP = MaxHP;
Stamina = MaxStamina;
Will = MaxWill;

hp_body_head = hp_body_head_max;
hp_body_torso = hp_body_torso_max;
hp_body_armL = hp_body_armL_max;
hp_body_armR = hp_body_armR_max;
hp_body_legL = hp_body_legL_max;
hp_body_legR = hp_body_legR_max;

collisions_list_timer = time_source_create(time_source_game,60,time_source_units_frames,_mymethod);
collisions_list = ds_list_create(); //collisions list for bullets to prevent them from continuously colliding
alarm[2] = 20;

BuffList = ds_list_create();

//----------------------------- Set equipment variables to default, then find weapons/armor ------------------------------------

//set base animation
skeleton_animation_set("Basic Movement/blank");

//set equipment to empty, initialize item IDs as -1, equip us with fists
wpn_primary = Unarmed_Fists; wpn_secondary = Unarmed_Fists; wpn_active = wpn_primary;
wpn_primary_id = -2; wpn_secondary_id = -3; wpn_active_id = wpn_primary_id;
magazine_primary = 0; magazine_secondary = 0; magazine_active = 0;
ammo_active = 0; ammo_active_id = -1; ammo_primary = 0; ammo_secondary = 0; ammo_primary_id = -1; ammo_secondary_id = -1; 

/*initialize armor item and ratio arrays. 
0 = item struct, 
1 = item uniqueid, 
2 = armor ratio (clamped), used for minimum armor effectiveness at 0 durability 
3 = armor ratio (unclamped), raw ratio used for UI 
4 = limb per frame damage (for amputations)
5 = limb is amputated (true or false)
*/
armor_head = ["none",-1,1,0,0,false];
armor_torso = ["none",-1,1,0,0,false];
armor_armL = ["none",-1,1,0,0,false];
armor_armR = ["none",-1,1,0,0,false];
armor_legL = ["none",-1,1,0,0,false];
armor_legR = ["none",-1,1,0,0,false];

var IC_ID = -1;
if(variable_instance_exists(id,"MyIC")) {
	
	IC_ID = MyIC;

	var WpnGrid = MyIC.grd_inv_wepn;
	var AmmoGrid = MyIC.grd_inv_ammo;
	var ArmorGrid = MyIC.grd_inv_armr;

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

}; //IC exists check

//----------------------------------- EQUIPMENT VARIABLES ----------------------------------
#region set armor cosmetic attachments to blank
skeleton_attachment_set("slot_head" , "0000_head") 
skeleton_attachment_set("slot_eyes" , "blank")

skeleton_attachment_set("slot_torso" , "0000_torso") 
skeleton_attachment_set("slot_collar" , "blank")
skeleton_attachment_set("slot_backpack" , "blank")
skeleton_attachment_set("slot_backpack trim" , "blank")
skeleton_attachment_set("slot_pelvis" , "0000_pelvis")

skeleton_attachment_set("slot_front bicep" , "0000_bicep")  
skeleton_attachment_set("slot_front forearm" , "0000_forearm")
skeleton_attachment_set("slot_pauldron" , "blank")  
skeleton_attachment_set("slot_pauldron trim" , "blank") 
skeleton_attachment_set("slot_front hand", "0000_hand")
		
skeleton_attachment_set("slot_rear bicep" , "0000_bicep") 
skeleton_attachment_set("slot_rear forearm" , "0000_forearm")
skeleton_attachment_set("slot_rear pauldron" , "blank") 
skeleton_attachment_set("slot_holding hand", "0000_holding hand")
	
skeleton_attachment_set("slot_front thigh" , "0000_thigh")  
skeleton_attachment_set("slot_front thigh_trim1" , -1) 
skeleton_attachment_set("slot_front knee" , "blank")  
skeleton_attachment_set("slot_front shin" , "0000_shin")  
skeleton_attachment_set("slot_front foot" , "0000_foot")  
	
skeleton_attachment_set("slot_rear thigh" , "0000_thigh")  
skeleton_attachment_set("slot_rear knee" , "blank") 
skeleton_attachment_set("slot_rear shin" , "0000_shin")  
skeleton_attachment_set("slot_rear foot" , "0000_foot")  
#endregion

//equipment statuses
reloading = 0;
spooled = 0;
spindown_toggle = 0;
wpn_active_heat = 0;
switch_toggle = 0;

//equipment sound stuff
aud_fireloop = 0; //loop for guns with loop sounds
aud_chargeloop = 0; //loop for guns with charging
aud_spoolup = 0; //sound for spooling up
aud_spooldown = 0; //sound for spooling down

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

//---------------------------------- INSTANCE CREATION --------------------------------

xhair = instance_create_depth(x,y,depth-3,o_xhair,{
	owner : other.id,
	MyIC : IC_ID	
});






/* 
//debug stuff for stress testing
wpn_primary = Boltgun_Phobos;
wpn_active = wpn_primary;
ammo_active = wpn_primary.default_ammo_type;
selector = "Auto";

	
	




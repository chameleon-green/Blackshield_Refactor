audio_group_load(audiogroup1);


global.debug = 1;
global.Selected = ["none","none"];
AIQ = ds_list_create();

//audio_debug(global.debug);
FPS = 0;

if(global.debug = 1) {
	alarm[0] = 15
};

visible = 0;
depth = 0;
alarm[1] = 30;

window_set_cursor(cr_none);

//----------------------------------------- UI functionality --------------------------------

CL_Yellow = make_color_rgb(247,191,2);
CL_Orange = make_color_rgb(255,121,0);
CL_Red = make_color_rgb(255,60,40);
CL_Screen = make_color_rgb(40,25,0); //CL_Screen = make_color_rgb(40,25,0);
CL_Outline = make_colour_rgb(192,158,2);

ChooseColor = function(Ratio,ColorLock=0,LockInput=false){
	//Color lock allows us to lock color to red unless condition is filled
	if(Ratio <= 0 ) {
		if(!ColorLock) {return CL_Screen}
		else if(ColorLock && (LockInput=false)) {return CL_Red}
		else if(ColorLock && (LockInput=true)) {return CL_Screen}
	}
	else if(Ratio > 0 and Ratio <= 0.33) {return CL_Red}
	else if(Ratio > 0.33 and Ratio <= 0.75) {return CL_Orange}
	else if(Ratio > 0.75) {return CL_Yellow};
};


active = 0;
scale = 1.5;
bg_subimage = 0;
enable_mouseaim = 1;
pos_at_close = [0,0,0,0];
Tab = "items";
SubTab = "weapons";
refresh = 0;

Mouse_X = 0; 
Mouse_Y = 0;

MyScrollbar = 0;

Xoffset = 0; 
Yoffset = 0;

//------------------------------------------ Inventory functionality -------------------------------------------

global.IDList = ds_list_create();

AnimationsFlashesSoundGroups();
AmmoStructs();
WeaponStructs();
ArmorStructs();
ConsumableStructs();

incrementor_weapons = 0;
incrementor_armor = 0;
incrementor_aid = 0;
incrementor_ammo = 0;
incrementor_crafting = 0;

counter_weapons = 0;
counter_armor = 0;
counter_aid = 0;
counter_ammo = 0;
counter_crafting = 0;

InventorySize = 101;
grd_inv_wepn = ds_grid_create(10,InventorySize); //weapon inventory
grd_inv_armr = ds_grid_create(10,InventorySize); //armor inventory
grd_inv_aidd = ds_grid_create(10,InventorySize); //aid inventory
grd_inv_ammo = ds_grid_create(10,InventorySize); //ammo inventory
grd_inv_crft = ds_grid_create(10,InventorySize); //crafting inventory

AddItem(Boltgun_Phobos,1,grd_inv_wepn,InventorySize);
AddItem(Lasgun_Kantrael,1,grd_inv_wepn,InventorySize);
AddItem(Meltagun_Proteus,1,grd_inv_wepn,InventorySize);
AddItem(Shotgun_Astartes,1,grd_inv_wepn,InventorySize);
AddItem(Rotorcannon_Proteus,1,grd_inv_wepn,InventorySize);

AddItem(Ammo_Bolt_Standard,1000,grd_inv_ammo,InventorySize);
AddItem(Ammo_Bolt_Kraken,100,grd_inv_ammo,InventorySize);
AddItem(Ammo_Shotgun_Buckshot,3,grd_inv_ammo,InventorySize);
AddItem(Ammo_Shotgun_Slug,30,grd_inv_ammo,InventorySize);
AddItem(Ammo_Flamer_Standard,300,grd_inv_ammo,InventorySize);
AddItem(Ammo_Flamer_Balefire,300,grd_inv_ammo,InventorySize);
AddItem(Ammo_Plasma_Standard,300,grd_inv_ammo,InventorySize);
AddItem(Ammo_Melta_Standard,300,grd_inv_ammo,InventorySize);
AddItem(Ammo_Auto_Ball,1000,grd_inv_ammo,InventorySize);
AddItem(Ammo_Autocannon_Ball,300,grd_inv_ammo,InventorySize);
AddItem(Ammo_Autocannon_HE,300,grd_inv_ammo,InventorySize);
AddItem(Ammo_Laser_Pack_Standard,300,grd_inv_ammo,InventorySize);


AddItem(Armor_Torso_2000,1,grd_inv_armr,InventorySize);
AddItem(Armor_Head_2000,1,grd_inv_armr,InventorySize);
AddItem(Armor_ArmL_2000,1,grd_inv_armr,InventorySize);
AddItem(Armor_ArmR_2000,1,grd_inv_armr,InventorySize);
AddItem(Armor_LegL_2000,1,grd_inv_armr,InventorySize);
AddItem(Armor_LegR_2000,1,grd_inv_armr,InventorySize);

AddItem(Drug_Combat_Somatogen,10,grd_inv_aidd,InventorySize);
AddItem(Drug_Combat_Satrophine,5,grd_inv_aidd,InventorySize);

//----------------------------------------- Create Player ---------------------------------------

MyPlayer = instance_create_depth(x,y,-14,o_player,{MyIC : id});
MyHPbar = instance_create_depth(x,y,depth+1,o_HPbar, {MyIC : id, scale : 1.33, MyPlayer : other.MyPlayer});
//repeat (1) {instance_create_depth(x,y,depth,o_enemy,{leader : 1})};

//------------------------------------- INITIAL EQUIP ------------------------------------

scr_equip_armor_initial(MyPlayer);

//----------------------------------------- Zoom Functionality ------------------------------

view_momentum = 0;
xx = 1366;
yy = 768;
equalize = 0;
camera_x = 0;
camera_xprev = 0;

//-------------------------------------- terrain seed -----------------------
terrain_seed = "";
for(var i=0;i<6;i++){
	var temp = irandom(9)
	terrain_seed += string(temp)
};

//------------------------------------ depth ----------------------------------------

DepthLayer = {

	cover : -50,
	explosions : -16,
	player : -14,
	
	vehicles : -12,
	humans : -11,
	
	shells : -9,
	buildings : -6

};

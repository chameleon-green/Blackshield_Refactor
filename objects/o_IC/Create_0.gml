global.debug = 1;
//audio_debug(global.debug);
FPS = 0;

if(global.debug = 1) {
	alarm[0] = 15
};

visible = 0;

//window_set_cursor(cr_none);

//----------------------------------------- UI functionality --------------------------------

scale = 1.75;
bg_subimage = 0;
gui_close_toggle = 1;
Tab = "items";
SubTab = "weapons";

Mouse_X = 0; 
Mouse_Y = 0;

MyScrollbar = 0;


//------------------------------------------ Inventory functionality -------------------------------------------

global.IDList = ds_list_create();
global.Selected = undefined;

AnimationsFlashesSoundGroups();
AmmoStructs();
WeaponStructs();

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

InventorySize = 100;
grd_inv_wepn = ds_grid_create(10,InventorySize); //weapon inventory
grd_inv_armr = ds_grid_create(10,InventorySize); //armor inventory
grd_inv_aidd = ds_grid_create(10,InventorySize); //aid inventory
grd_inv_ammo = ds_grid_create(10,InventorySize); //ammo inventory
grd_inv_crft = ds_grid_create(10,InventorySize); //crafting inventory

AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);
AddItem(Boltgun_Phobos,1,grd_inv_wepn);

//----------------------------------------- Zoom Functionality ------------------------------

view_momentum = 0;
xx = 1366;
yy = 768;
equalize = 0;
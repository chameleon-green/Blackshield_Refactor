
var wx = (x - camera_get_view_x(view_camera[0]) );
var wy = (y - camera_get_view_y(view_camera[0]) );
var off_x_percent = wx / camera_get_view_width(view_camera[0]);
var off_y_percent = wy / camera_get_view_height(view_camera[0]);
var gui_x = off_x_percent * display_get_gui_width();
var gui_y = off_y_percent * display_get_gui_height();

//------------------------------------------ roundcount, icon and heatbar --------------------------------------


var IsRanged = (string_count("ranged",owner.wpn_active.item_type));
var Owner_Distance = point_distance(x,y,owner.x,owner.y);
var Owner_Spread = degtorad(clamp(owner.spread_angle,0,89));

if(IsRanged) {
	
	if(string_count("scatter",owner.ammo_active.guidance)) { //accounts for spray pattern of scatter ammo
	Owner_Spread = degtorad(clamp(owner.spread_angle + owner.wpn_active.spread*2.5,0,89));
	};
	
	var Firemode = owner.selector;
	var Firemode_Icon = 2;
	if(Firemode = "Burst (2)") {Firemode_Icon = 3};
	else if(Firemode = "Burst (3)") {Firemode_Icon = 4};
	else if(Firemode = "Auto") {Firemode_Icon = 5};
	else if(Firemode = "Supercharge" or Firemode = "Overcharge") {Firemode_Icon = 6};
	var Selector_Text = owner.selector;

	var AmmoID = owner.ammo_active_id;
	var AmmoCount = 0;
	if(AmmoID != -1) {
		var AmmoGrid = owner.MyIC.grd_inv_ammo;
		var AmmoYVal = ds_grid_value_y(AmmoGrid,0,0,10,ds_grid_height(AmmoGrid),AmmoID)
		var AmmoCount = ds_grid_get(AmmoGrid,1,AmmoYVal);
	};

	if(owner.wpn_active.heat_generation > 0) {
		var HeatRatio = owner.wpn_active_heat/owner.wpn_active.heat_capacity;
		var Bar_Color = c_white;
		if(HeatRatio > 1) {Selector_Text = "OVERHEATING!"; Bar_Color = c_red; Firemode_Icon = 6};	
	
		draw_sprite_ext(sp_xhair_heatbar,0,gui_x+13,gui_y+53,1,1,0,c_white,1);
		draw_sprite_ext(sp_xhair_heatbar,1,gui_x+13,gui_y+53,clamp(HeatRatio,0,1),1,0,Bar_Color,1);
	};

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(gui_x+8,gui_y+8,string(owner.magazine_active) + "/" + string(AmmoCount)); //ammo count
	draw_text(gui_x+28,gui_y+26,Selector_Text); //selector switch setting
	draw_sprite_ext(sp_xhair,Firemode_Icon,gui_x+14,gui_y+36,1,1,0,c_white,1); //firemode icon draw
}

var HairOffset = clamp(tan(Owner_Spread)*Owner_Distance,6,130);
var HairScale = clamp(45/HairOffset,0.5,1.2);

draw_sprite_ext(sp_xhair,0,gui_x,gui_y,1,1,0,c_white,1); //dot
draw_sprite_ext(sp_xhair,1,gui_x,gui_y-HairOffset,1,HairScale,0,c_white,1); //upper hair
draw_sprite_ext(sp_xhair,1,gui_x,gui_y+HairOffset,1,HairScale,180,c_white,1); //lower hair
draw_sprite_ext(sp_xhair,1,gui_x+HairOffset,gui_y,1,HairScale,-90,c_white,1); //right hair
draw_sprite_ext(sp_xhair,1,gui_x-HairOffset,gui_y,1,HairScale,90,c_white,1); //left hair



draw_text(gui_x,gui_y,FPS);









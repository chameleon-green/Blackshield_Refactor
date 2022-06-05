
x = mouse_x; 
y = mouse_y;

if(owner.CanShoot) {
//var dist = point_distance(x,y,owner.flash_x,owner.flash_y);
//x = owner.flash_x + lengthdir_x(dist,-owner.flash_angle);
//y = owner.flash_y + lengthdir_y(dist,-owner.flash_angle);

x = mouse_x-(owner.x - owner.flash_x)
y = mouse_y-(owner.y - owner.flash_y)
};


var Owner_Distance = point_distance(x,y,owner.x,owner.y);
var Owner_Spread = degtorad(clamp(owner.spread_angle,0,89));

if(string_count("scatter",owner.ammo_active.guidance)) { //accounts for spray pattern of scatter ammo
	Owner_Spread = degtorad(clamp(owner.spread_angle + owner.wpn_active.spread*5,0,89));
};

var HairOffset = clamp(tan(Owner_Spread)*Owner_Distance,6,130);
var HairScale = clamp(HairOffset/20,1,10);

draw_self();

draw_sprite_ext(sp_xhair,1,x,y-HairOffset,1,HairScale,0,c_white,1); //upper hair
draw_sprite_ext(sp_xhair,1,x,y+HairOffset,1,HairScale,180,c_white,1); //lower hair
draw_sprite_ext(sp_xhair,1,x+HairOffset,y,1,HairScale,-90,c_white,1); //right hair
draw_sprite_ext(sp_xhair,1,x-HairOffset,y,1,HairScale,90,c_white,1); //left hair


//------------------------------------------ roundcount and icon --------------------------------------

var Firemode = owner.selector;
var Firemode_Icon = 2;
if(Firemode = "Burst (2)") {Firemode_Icon = 3};
else if(Firemode = "Burst (3)") {Firemode_Icon = 4};
else if(Firemode = "Auto") {Firemode_Icon = 5};
else if(Firemode = "Supercharge" or Firemode = "Overcharge") {Firemode_Icon = 6};

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(x+8,y+8,string(owner.magazine_active) + "/" + string(owner.wpn_active.capacity)); //ammo count
draw_text(x+28,y+26,owner.selector); //selector switch setting
draw_sprite_ext(sp_xhair,Firemode_Icon,x+14,y+36,1,1,0,c_white,1); //firemode icon draw

if( !is_struct(item) ) {instance_destroy(self)}; //crashproofing

image_index = 1
scale = creator.scale;
image_xscale = scale;
image_yscale = scale;

Mouse_X = creator.Mouse_X;
Mouse_Y = creator.Mouse_Y;
var Xcent = display_get_gui_width()/2;
var Ycent = display_get_gui_height()/2; 
var YoffS = Yoffset*scale;
var XoffS = Xoffset*scale;
var Click = mouse_check_button_pressed(mb_left);

var Color = c_dkgray;

if( (creator.SubTab != MySubTab) or (creator.Tab != MyTab) or !creator.visible) {instance_destroy(self)};

var IsEquipped = ( (MyPlayer.wpn_primary_id = unique_id) or 
				   (MyPlayer.wpn_secondary_id = unique_id) or
				   (MyPlayer.wpn_melee_id = unique_id) or
				 //(MyPlayer.ammo_primary_id = unique_id) or
				 //(MyPlayer.ammo_primary = item) or 
				 //(MyPlayer.ammo_secondary = item) or 
				 //(MyPlayer.ammo_active = item) or
				   (MyPlayer.armor_head[1] = unique_id) or
				   (MyPlayer.armor_torso[1] = unique_id) or
				   (MyPlayer.armor_armL[1] = unique_id) or
				   (MyPlayer.armor_armR[1] = unique_id) or
				   (MyPlayer.armor_legL[1] = unique_id) or
				   (MyPlayer.armor_legR[1] = unique_id)
				 );
var IsEquippedAmmoPrimary = (MyPlayer.ammo_primary = item);
var IsEquippedAmmoSecondary = (MyPlayer.ammo_secondary = item);
var IsEquippedAmmoBoth = (IsEquippedAmmoPrimary & IsEquippedAmmoSecondary);

//------------------------------------------ Coordinate Stuff -------------------------------------------------

var BaseY = Ycent + YoffS - (133*scale) + (yoffset*36*scale);
x = Xcent + XoffS -(132*scale);  
y = BaseY - (scrollbar.Offset + (120*scale) ) * scrollbar.DisplacementMod + (scrollbar.item_count)/(4*scale)

//------------------------------------------ Mouse interactions ----------------------------------------

var Selected = (global.Selected[0] = unique_id);
var touching = point_in_rectangle(Mouse_X,Mouse_Y,bbox_left,bbox_top,bbox_right,bbox_bottom);
if( (touching && Interactable) or Selected or IsEquipped or IsEquippedAmmoPrimary or IsEquippedAmmoSecondary or IsEquippedAmmoBoth) {image_index = 0; Color = c_yellow};
if(Click && touching && Interactable) {global.Selected = [unique_id,item]};

//----------------------------------------- Drawing Stuff -------------------------------------------------

draw_set_font(fnt_caslonSB);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

var MyDisplacement = ((Ycent - y)/scale)+ Yoffset
//var GridYValue = ds_grid_value_y(grid,0,0,ds_grid_width(grid),ds_grid_height(grid),unique_id);
var Quantity = ds_grid_get(grid,1,GridYValue);
var TitleText = item.name;

var IType = item.item_type
var IsAmmo = string_count("ammo",IType);
var IsRangedWeapon = string_count("weapon_ranged",IType);
var IsMeleeWeapon = string_count("weapon_melee",IType);
var IsArmor = string_count("armor",IType);
var IsConsumable = string_count("consumable",IType);

if(GridYValue = -1) {creator.refresh = 1};

if(IsAmmo or IsConsumable) {TitleText = item.name + " (" + string(Quantity) + ")"};
if(IsEquipped) {TitleText = TitleText + " (equipped)"};
if(IsEquippedAmmoPrimary & !IsEquippedAmmoBoth) {TitleText = TitleText + " (primary)"};
if(IsEquippedAmmoSecondary & !IsEquippedAmmoBoth) {TitleText = TitleText + " (secondary)"};
if(IsEquippedAmmoBoth) {TitleText = TitleText + " (primary/secondary)"};



if ( (MyDisplacement >= -158) and (MyDisplacement <= 138) ){
	
	Interactable = 1;	
	draw_self();	
	draw_text_ext_transformed_color(x,y+(10*scale),TitleText,1,99999,scale*0.9,scale*1,0,Color,Color,Color,Color,1);

};


#region cutoff for text and shadows
//bottom cutoff
if ( (MyDisplacement < -156) and (MyDisplacement > -192) ){
	
	Interactable = 0;
	
	var BottomBound = Ycent + YoffS + (188*scale);
	var Difference = (y+(36*scale)) - BottomBound;
	var Height = 36-(Difference/scale);
	draw_sprite_general(sprite_index,image_index,0,0,313,Height,bbox_left,y,scale,scale,0,c_white,c_white,c_dkgray,c_dkgray,1)
	
	if( abs(Height) > 30 ) {
		draw_text_ext_transformed_color(x,y+(10*scale),TitleText,1,99999,scale*0.9,scale*1,0,Color,Color,Color,Color,1)
		Interactable = 1;
	};
	
};

//top cutoff
if ( (MyDisplacement > 138) and (MyDisplacement < 166) ){
	
	Interactable = 0;
	
	var TopBound = Ycent + YoffS - (135*scale);
	var Difference = TopBound - y;
	var Height = 36-(Difference/scale);
	draw_sprite_general(sprite_index,image_index,0,36,313,-Height,bbox_left,y+(36*scale),scale,scale,0,c_white,c_white,c_dkgray,c_dkgray,1) 
	
	if( abs(Height) > 30 ) {
		draw_text_ext_transformed_color(x,y+(10*scale),TitleText,1,99999,scale*0.9,scale*1,0,Color,Color,Color,Color,1)
		Interactable = 1;
	};
};
#endregion

draw_text(x,y,MyDisplacement)

if(Selected = 1) {
	
	var Image = item.inventory_subimage;
	
	//scaling sprite to fit in the draw area
	var DrawAreaX = scale*251;
	var DrawAreaY = scale*133;
	
	var SpriteArray = sprite_get_uvs(Image[0],Image[1]);
	var TexW = 1/texture_get_texel_width(sprite_get_texture(Image[0],Image[1]));
	var TexH = 1/texture_get_texel_height(sprite_get_texture(Image[0],Image[1]));
	
	var SpriteWidth = abs(SpriteArray[0] - SpriteArray[2])*TexW*scale*3;
	var SpriteHeight = abs(SpriteArray[1] - SpriteArray[3])*TexH*scale*3;
	
	if(SpriteWidth > SpriteHeight) {
		var OffsetScaleFactor = SpriteWidth/DrawAreaX;
		var ScaleFactor = DrawAreaX/SpriteWidth;	
		var ImageScale = ScaleFactor*scale*3*0.5;
		}
		else {
		var OffsetScaleFactor = SpriteHeight/DrawAreaY;
		var ScaleFactor = DrawAreaY/SpriteHeight;
		var ImageScale = ScaleFactor*scale*3*0.8;
		};
	
	//draw the inventory image and its outline on the screen
	var _Color = make_color_rgb(164,128,2);
	gpu_set_fog(1,_Color,1,1);
	var OutlineOffset = 1.25*ScaleFactor;
	draw_sprite_ext(Image[0],Image[1],Xcent+((Xoffset + 158-OutlineOffset)*scale),Ycent-((Yoffset + 62+OutlineOffset)*scale),ImageScale,ImageScale,0,c_white,1);
	draw_sprite_ext(Image[0],Image[1],Xcent+((Xoffset + 158-OutlineOffset)*scale),Ycent-((Yoffset + 62-OutlineOffset)*scale),ImageScale,ImageScale,0,c_white,1);
	draw_sprite_ext(Image[0],Image[1],Xcent+((Xoffset + 158+OutlineOffset)*scale),Ycent-((Yoffset + 62-OutlineOffset)*scale),ImageScale,ImageScale,0,c_white,1);
	draw_sprite_ext(Image[0],Image[1],Xcent+((Xoffset + 158+OutlineOffset)*scale),Ycent-((Yoffset + 62+OutlineOffset)*scale),ImageScale,ImageScale,0,c_white,1);
	gpu_set_fog(0,_Color,1,1);
	draw_sprite_ext(item.inventory_subimage[0],item.inventory_subimage[1],Xcent+XoffS+(158*scale),Ycent+YoffS-(62*scale),ImageScale,ImageScale,0,c_white,1);
	
	if(IsRangedWeapon) {
		if(IsEquipped) {creator.TriButtonText[0] = "Unequip"};		
		var Ammo = ds_grid_get(grid,3,GridYValue);		
		var AmmoCap = item.capacity;
		var AmmoLeft = ds_grid_get(grid,4,GridYValue);	
		if(unique_id = MyPlayer.wpn_active_id) {AmmoLeft = MyPlayer.magazine_active};	
		var _String = Ammo.name+" ("+string(AmmoLeft)+"/"+string(AmmoCap)+")";
		var _Color = c_yellow;
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_text_ext_transformed_color(Xcent+XoffS+(158*scale),Ycent-(9*scale),_String,1,40000,scale*0.75,scale*0.75,0,_Color,_Color,_Color,_Color,1);
		draw_set_halign(fa_left);
		draw_text_ext_transformed_color(Xcent+XoffS+(72*scale),Ycent+YoffS+(60*scale),item.damage,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(72*scale),Ycent+YoffS+(94*scale),item.ROF,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(72*scale),Ycent+YoffS+(128*scale),item.spread,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(72*scale),Ycent+YoffS+(162*scale),item.range,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);		
		draw_text_ext_transformed_color(Xcent+XoffS+(151*scale),Ycent+YoffS+(60*scale),item.capacity,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(151*scale),Ycent+YoffS+(94*scale),"40404",1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(151*scale),Ycent+YoffS+(128*scale),item.weight,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(151*scale),Ycent+YoffS+(162*scale),item.durability_max,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
	};
	
	if(IsMeleeWeapon) {

		var _Color = c_yellow;
		var ArmorPen = string(item.penetration*100) + "%";
		var Damage = string(item.damage) + "(" + string(MeleeDamageCalculator(MyPlayer,item)) + ")";
		
		//draw correct stats readout for melee weapons
		draw_sprite_ext(sp_inventory_wep_stats,3,Xcent+XoffS+160*scale,Ycent+YoffS+102*scale,scale,scale,0,c_white,1);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		//draw_text_ext_transformed_color(Xcent+(158*scale),Ycent-(9*scale),_String,1,40000,scale*0.75,scale*0.75,0,_Color,_Color,_Color,_Color,1);
		draw_set_halign(fa_left);
		draw_text_ext_transformed_color(Xcent+XoffS+(68*scale),Ycent+YoffS+(63.5*scale),Damage,1,40000,scale*0.97,scale*1.1,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(70*scale),Ycent+YoffS+(98*scale),ArrayToString(item.scalings,1),1,40000,scale*0.96,scale*1.05,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(70*scale),Ycent+YoffS+(134*scale),ArrayToString(item.damage_type,2),1,40000,scale*0.96,scale*1.05,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(70*scale),Ycent+YoffS+(163*scale),item.durability_max,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);		
		draw_text_ext_transformed_color(Xcent+XoffS+(155*scale),Ycent+YoffS+(62*scale),ArmorPen,1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(155*scale),Ycent+YoffS+(163*scale),item.weight,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(238*scale),Ycent+YoffS+(62*scale),item.force,1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(238*scale),Ycent+YoffS+(163*scale),item.force,1,40000,scale*1.33,scale*1.33,0,_Color,_Color,_Color,_Color,1);
		
	};
	
	if(IsAmmo) {
		var _Color = c_yellow;
		draw_set_halign(fa_left);
		var PenString = string(item.armor_penetration*100) + "%"
		draw_text_ext_transformed_color(Xcent+XoffS+(71*scale),Ycent+YoffS+(61*scale),string(item.damage_mod),1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(71*scale),Ycent+YoffS+(96*scale),string(item.ROF_mod),1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(156*scale),Ycent+YoffS+(61*scale),item.damage_type[1],1,40000,scale*1.125,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(156*scale),Ycent+YoffS+(96*scale),item.weight,1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);	
		draw_text_ext_transformed_color(Xcent+XoffS+(240*scale),Ycent+YoffS+(61*scale),PenString,1,40000,scale*1.125,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(240*scale),Ycent+YoffS+(96*scale),AmmoCost(item),1,40000,scale*1.125,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		
	};
	
	if(IsArmor) {
		var _Color = c_yellow;
		var _Durability = ds_grid_get(grid,2,GridYValue);
		var _RawDuraRatio = round((_Durability/item.durability_max)*100);
		var _DuraRatio = clamp(_RawDuraRatio,20,100);
		draw_set_halign(fa_left);
		draw_text_ext_transformed_color(Xcent+XoffS+(68*scale),Ycent+YoffS+(61*scale),string(item.rPHYS) + "(" + string(round((item.rPHYS*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(68*scale),Ycent+YoffS+(94*scale),string(item.rTHER) + "(" + string(round((item.rTHER*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(68*scale),Ycent+YoffS+(127*scale),string(item.rCRYO) + "(" + string(round((item.rCRYO*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(68*scale),Ycent+YoffS+(160*scale),string(item.rELEC) + "(" + string(round((item.rELEC*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(152*scale),Ycent+YoffS+(61*scale),string(item.rCORR) + "(" + string(round((item.rCORR*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(152*scale),Ycent+YoffS+(94*scale),string(item.rHAZM) + "(" + string(round((item.rHAZM*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);	
		draw_text_ext_transformed_color(Xcent+XoffS+(152*scale),Ycent+YoffS+(127*scale),string(item.rRADI) + "(" + string(round((item.rRADI*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(152*scale),Ycent+YoffS+(160*scale),string(item.rWARP) + "(" + string(round((item.rWARP*_DuraRatio/100))) + ")",1,40000,scale*1.0,scale*1.125,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(236*scale),Ycent+YoffS+(61*scale),string(item.poise),1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(236*scale),Ycent+YoffS+(94*scale),string(_RawDuraRatio) + "%",1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(236*scale),Ycent+YoffS+(127*scale),string(item.weight),1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		draw_text_ext_transformed_color(Xcent+XoffS+(236*scale),Ycent+YoffS+(160*scale),string(404),1,40000,scale*1.25,scale*1.25,0,_Color,_Color,_Color,_Color,1);
		
	};
};

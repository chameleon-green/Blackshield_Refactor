var Mouse_X = MyIC.Mouse_X;
var Mouse_Y = MyIC.Mouse_Y;
var Click = mouse_check_button_pressed(mb_left);
//var Ycent = window_get_height()/2; var Xcent = window_get_width()/2;

scale = 1.33;

draw_set_halign(fa_center);
draw_set_valign(fa_center);

var Powered = 0;

var XOffset = 0; 

if(Powered = 1) {
	XOffset = 85;
	draw_sprite_ext(sprite_index,1,53*scale,80*scale,scale,scale,0,c_white,1);
	draw_sprite_ext(sprite_index,2,53*scale,80*scale,scale,scale,0,c_white,1);	
};

draw_sprite_ext(sprite_index,0,(200+XOffset)*scale,80*scale,scale,scale,0,c_white,1);

ChooseColor(MyPlayer.hp_body_head/MyPlayer.hp_body_head_max)

draw_sprite_ext(sp_status_body,18,(64+XOffset)*scale,35*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_head/MyPlayer.hp_body_head_max),1); //head
draw_sprite_ext(sp_status_body,24,(64+XOffset)*scale,35*scale,scale,scale,0,ChooseColor(MyPlayer.armor_head[3]),1); //head armor
draw_sprite_ext(sp_status_body,19,(64+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_torso/MyPlayer.hp_body_torso_max),1); //torso
draw_sprite_ext(sp_status_body,25,(64+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.armor_torso[3]),1); //torso armor
draw_sprite_ext(sp_status_body,20,(37+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_armL/MyPlayer.hp_body_armL_max),1); //armL
draw_sprite_ext(sp_status_body,26,(37+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.armor_armL[3]),1); //armL armor
draw_sprite_ext(sp_status_body,21,(90+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_armR/MyPlayer.hp_body_armR_max),1); //armR
draw_sprite_ext(sp_status_body,27,(90+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.armor_armR[3]),1); //armR armor
draw_sprite_ext(sp_status_body,22,(47+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_legL/MyPlayer.hp_body_legL_max),1); //legL
draw_sprite_ext(sp_status_body,28,(47+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.armor_legL[3]),1); //legL armor
draw_sprite_ext(sp_status_body,23,(81+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_legR/MyPlayer.hp_body_legR_max),1); //legR
draw_sprite_ext(sp_status_body,29,(81+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.armor_legR[3]),1); //legR armor

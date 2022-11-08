var Mouse_X = MyIC.Mouse_X;
var Mouse_Y = MyIC.Mouse_Y;
var Click = mouse_check_button_pressed(mb_left);
//var Ycent = window_get_height()/2; var Xcent = window_get_width()/2;

scale = 1.4;

draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(fnt_caslonSB);

var Powered = 0;

var XOffset = 0; 

if(Powered = 1) {
	XOffset = 85;
	draw_sprite_ext(sp_health_ui,1,53*scale,80*scale,scale,scale,0,c_white,1);
	draw_sprite_ext(sp_health_ui,2,53*scale,80*scale,scale,scale,0,c_white,1);	
};

#region drawing bars, status body and main element

//draw actual bars
var HPGlassScale = (BarHPMax/800)*MaxBarScale; var StamGlassScale = (BarStaminaMax/300)*MaxBarScale; var WillGlassScale = (BarWillMax/300)*MaxBarScale;
var HPBarScale = (BarHP/BarHPMax)*HPGlassScale; var StamBarScale = (BarStamina/BarStaminaMax)*StamGlassScale; var WillBarScale = (BarWill/BarWillMax)*WillGlassScale;
draw_sprite_ext(sp_healthbars,0,(126+XOffset)*scale,38*scale,HPBarScale*scale,scale,0,c_white,1);
draw_sprite_ext(sp_healthbars,1,(126+XOffset)*scale,59*scale,StamBarScale*scale,scale,0,c_white,1);
draw_sprite_ext(sp_healthbars,2,(126+XOffset)*scale,76*scale,WillBarScale*scale,scale,0,c_white,1);

//draw three bar glasses
draw_sprite_ext(sp_healthbars,3,(126+XOffset)*scale,38*scale,HPGlassScale*scale,scale,0,c_white,1);
draw_sprite_ext(sp_healthbars,4,(126+XOffset)*scale,59*scale,StamGlassScale*scale,scale,0,c_white,1);
draw_sprite_ext(sp_healthbars,4,(126+XOffset)*scale,76*scale,WillGlassScale*scale,scale,0,c_white,1);

//draw bar glass caps
draw_sprite_ext(sp_health_ui,4,((HPGlassScale*250)+120+XOffset)*scale,38*scale,scale,scale,0,c_white,1);
draw_sprite_ext(sp_health_ui,5,((StamGlassScale*250)+120+XOffset)*scale,59*scale,scale,scale,0,c_white,1);
draw_sprite_ext(sp_health_ui,5,((WillGlassScale*250)+120+XOffset)*scale,76*scale,scale,scale,0,c_white,1);

//draw main element
draw_sprite_ext(sp_health_ui,0,(14+XOffset)*scale,80*scale,scale,scale,0,c_white,1);

//draw text for bars
var HPTextOffset = (HPGlassScale*125); var HPText = string(BarHP) + "/" + string(BarHPMax);
var StamTextOffset = (StamGlassScale*125); var StamText = string(BarStamina) + "/" + string(BarStaminaMax);
var WillTextOffset = (WillGlassScale*125); var WillText = string(BarWill) + "/" + string(BarWillMax);
draw_text_ext_transformed((HPTextOffset+XOffset+130)*scale,36*scale,HPText,10,9999999,scale*0.8,scale*0.8,0);
draw_text_ext_transformed((StamTextOffset+XOffset+130)*scale,57*scale,StamText,10,9999999,scale*0.7,scale*0.6,0);
draw_text_ext_transformed((WillTextOffset+XOffset+130)*scale,74*scale,WillText,10,9999999,scale*0.7,scale*0.6,0);

//draw mini status body
draw_sprite_ext(sp_status_body,18,(64+XOffset)*scale,35*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_head/MyPlayer.hp_body_head_max,1,MyPlayer.armor_head[5]),1); //head
draw_sprite_ext(sp_status_body,24,(64+XOffset)*scale,35*scale,scale,scale,0,ChooseColor(MyPlayer.armor_head[3]),1); //head armor
draw_sprite_ext(sp_status_body,19,(64+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_torso/MyPlayer.hp_body_torso_max,1,MyPlayer.armor_torso[5]),1); //torso
draw_sprite_ext(sp_status_body,25,(64+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.armor_torso[3]),1); //torso armor
draw_sprite_ext(sp_status_body,20,(37+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_armL/MyPlayer.hp_body_armL_max,1,MyPlayer.armor_armL[5]),1); //armL
draw_sprite_ext(sp_status_body,26,(37+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.armor_armL[3]),1); //armL armor
draw_sprite_ext(sp_status_body,21,(90+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_armR/MyPlayer.hp_body_armR_max,1,MyPlayer.armor_armR[5]),1); //armR
draw_sprite_ext(sp_status_body,27,(90+XOffset)*scale,60*scale,scale,scale,0,ChooseColor(MyPlayer.armor_armR[3]),1); //armR armor
draw_sprite_ext(sp_status_body,22,(47+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_legL/MyPlayer.hp_body_legL_max,1,MyPlayer.armor_legL[5]),1); //legL
draw_sprite_ext(sp_status_body,28,(47+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.armor_legL[3]),1); //legL armor
draw_sprite_ext(sp_status_body,23,(81+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.hp_body_legR/MyPlayer.hp_body_legR_max,1,MyPlayer.armor_legR[5]),1); //legR
draw_sprite_ext(sp_status_body,29,(81+XOffset)*scale,101*scale,scale,scale,0,ChooseColor(MyPlayer.armor_legR[3]),1); //legR armor
#endregion
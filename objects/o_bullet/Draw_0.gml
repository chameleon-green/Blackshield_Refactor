image_angle = direction;

//------------------------------------------- Special projectile code -------------------------

if(Flames){
	var xoffset = lengthdir_x(2*image_xscale,direction);
	var yoffset = lengthdir_y(2*image_xscale,direction);
	draw_sprite_ext(sprite_index,image_index,x+xoffset,y+yoffset,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-xoffset,y-yoffset,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}; 

if(IsBeam) {
	var XscaleFactor = 128;
	var YscaleFactor = type.projectile_type[2]		
	image_xscale = beamLength/XscaleFactor;
	image_yscale = YscaleFactor;
};

//--------------------------------------------- drawing self ---------------------------------------------------------------


draw_self();
//draw core of bullet
if(sprite_index = sp_bullet) {draw_sprite_ext(sp_bullet,1,x,y,image_xscale,image_yscale,image_angle,type.projectile_color[1],1)};
if(sprite_index = sp_beam) {draw_sprite_ext(sp_beam,1,x,y,image_xscale,image_yscale*0.3,direction,type.projectile_color[1],1)};
draw_text(x,y,Flames);

if(kill = 1) {	
	time_source_start(kill_timer);
}

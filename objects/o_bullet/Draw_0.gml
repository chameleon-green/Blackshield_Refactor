
VisualCulling();

image_angle = direction;
draw_self();

//draw core of bullet
if(sprite_index = sp_bullet) {draw_sprite_ext(sp_bullet,1,x,y,1,1,direction,type.projectile_color[1],1)};


//------------------------------------------- Special projectile code -------------------------

if(Flames){
	var xoffset = lengthdir_x(2*image_xscale,direction);
	var yoffset = lengthdir_y(2*image_xscale,direction);
	draw_sprite_ext(sprite_index,image_index,x+xoffset,y+yoffset,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	draw_sprite_ext(sprite_index,image_index,x-xoffset,y-yoffset,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}; 
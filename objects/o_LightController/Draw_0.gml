

var Width = camera_get_view_width(view_camera[0])/3;
var Height = camera_get_view_height(view_camera[0])/3;

if( !surface_exists(srf_light) ) {srf_light = surface_create(Width,Height)}; 


surface_set_target(srf_light);
var ViewX = camera_get_view_x(view_camera[0]);
var ViewY = camera_get_view_y(view_camera[0]);

draw_clear_alpha(make_color_rgb(8,8,8),0.75);

with(o_player) {
		
	//gpu_set_blendmode(bm_add);
	//draw_sprite_ext(sp_light, 0, (x/3)-(ViewX/3), (y/3)-(ViewY/3), 1/3, 1/3, 0, c_red, 0.5);
	//gpu_set_blendmode_ext(bm_one,bm_inv_src_color);
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(sp_light, 0, (x/3)-(ViewX/3), ((bbox_top+90)/3)-(ViewY/3), 1/5, 1/2, 0, c_white, 0.12);
	draw_sprite_ext(sp_NODcone, 0, (x/3)-(ViewX/3), (bbox_top/3)-(ViewY/3), 3, 2, AimAngleBullet, c_green, 0.75);
};


with(o_bullet) {
		
	//gpu_set_blendmode(bm_add);
	//draw_sprite_ext(sp_light, 0, (x/3)-(ViewX/3), (y/3)-(ViewY/3), 1/3, 1/3, 0, c_red, 0.5);
	//gpu_set_blendmode_ext(bm_one,bm_inv_src_color);
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(sp_light, 0, (x/3)-(ViewX/3), (y/3)-(ViewY/3), 1/2, 1/2, 0, c_yellow, 1);
};



gpu_set_blendmode_ext(bm_dest_color,bm_zero);
//gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface_ext(srf_light,ViewX,ViewY,3,3,0,c_white,1);
gpu_set_blendmode(bm_normal);

//draw_sprite_ext(sp_light, 0, x, y, 1, 1, 0, c_red, 1);
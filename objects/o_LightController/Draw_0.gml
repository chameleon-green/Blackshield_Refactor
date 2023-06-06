
var SurfScale = 1;
var Width = camera_get_view_width(view_camera[0])/SurfScale;
var Height = camera_get_view_height(view_camera[0])/SurfScale;

if( !surface_exists(srf_light) ) {srf_light = surface_create(Width,Height)}; 


surface_set_target(srf_light);
var ViewX = camera_get_view_x(view_camera[0]);
var ViewY = camera_get_view_y(view_camera[0]);

draw_clear_alpha(make_color_rgb(5,5,5),1);

with(o_player) {
		
	//gpu_set_blendmode(bm_add);
	//draw_sprite_ext(sp_light, 0, (x/3)-(ViewX/3), (y/3)-(ViewY/3), 1/3, 1/3, 0, c_red, 0.5);
	//gpu_set_blendmode_ext(bm_one,bm_inv_src_color);
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), ((bbox_top+90)/SurfScale)-(ViewY/SurfScale), 1/5, 1/2, 0, c_white, 0.75);
	draw_sprite_ext(sp_NODcone, 0, (x/SurfScale)-(ViewX/SurfScale), (bbox_top/SurfScale)-(ViewY/SurfScale), 3, 2, AimAngleBullet, c_green, 0.75);
};


with(o_lightParent) {
	
	gpu_set_blendmode(bm_normal);
	
	switch(object_index) {
			case o_bullet:
			if(IsBeam) {
			var XscaleFactor = 128;	
			draw_sprite_ext(sp_lightoffset, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), (beamLength/XscaleFactor), 1, image_angle, type.projectile_color[0], 0.5)
			};
			else{draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), 1/2, 1/2, 0, type.projectile_color[0], 1)};
			break;
		case oprt_light:
			draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), 1, 1, 0, c_white, 1)
			break;
		};
};



gpu_set_blendmode_ext(bm_dest_color,bm_zero);
//gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface_ext(srf_light,ViewX,ViewY,SurfScale,SurfScale,0,c_white,1);
gpu_set_blendmode(bm_normal);

//draw_sprite_ext(sp_light, 0, x, y, 1, 1, 0, c_red, 1);
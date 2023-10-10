
var SurfScale = 1;
var Width = camera_get_view_width(view_camera[0])/SurfScale;
var Height = camera_get_view_height(view_camera[0])/SurfScale;

if( !surface_exists(srf_light) ) {srf_light = surface_create(Width,Height)}; 


surface_set_target(srf_light);
var ViewX = camera_get_view_x(view_camera[0]);
var ViewY = camera_get_view_y(view_camera[0]);

//draw_clear_alpha(make_color_rgb(10,10,10),1);
draw_clear_alpha(make_color_rgb(254,254,254),1);
/*
with(o_player) {
		
	//gpu_set_blendmode(bm_add);
	//draw_sprite_ext(sp_light, 0, (x/3)-(ViewX/3), (y/3)-(ViewY/3), 1/3, 1/3, 0, c_red, 0.5);
	//gpu_set_blendmode_ext(bm_one,bm_inv_src_color);
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), ((bbox_top+45)/SurfScale)-(ViewY/SurfScale), 1/3, 3/4, 0, c_white, 0.25);
	//draw_sprite_ext(sp_NODcone, 0, (x/SurfScale)-(ViewX/SurfScale), (bbox_top/SurfScale)-(ViewY/SurfScale), 12, 4, AimAngleBullet, c_green, 0.75);
};


with(o_lightParent) {
	
	gpu_set_blendmode(bm_normal);
	
	switch(object_index) {
		
		case o_bullet:
			if(IsBeam) {
				var XscaleFactor = 260;	
				var BeamXscale = (beamLength/XscaleFactor); //changing this to a fixed value prevents visual artifact with neam ends for some reason
				var CenterX = x + lengthdir_x(beamLength/2,direction);
				var CenterY = y + lengthdir_y(beamLength/2,direction);
				
				//draw_sprite_ext(sp_lightoffsetend, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), 1/2, 1/2, direction+180, type.projectile_color[0], .5)
				draw_sprite_ext(sp_lightoffset43, 0, (CenterX/SurfScale)-(ViewX/SurfScale), (CenterY/SurfScale)-(ViewY/SurfScale), BeamXscale, 1/2, direction, type.projectile_color[0], 1);	
			};
			else if (light_enable > 0) {		
				draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), 1/2, 1/2, 0, type.projectile_color[0], 1)};
			break;
			
		case oprt_light:
			draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), 1, 1, 0, c_white, 1)
			break;
		
		case o_explosion_scalable:
			if(image_index >= 0) {
				draw_sprite_ext(sp_light, 0, (x/SurfScale)-(ViewX/SurfScale), (y/SurfScale)-(ViewY/SurfScale), 1, 1, 0, c_white, 1)
			};
			break;
		};
};

*/

gpu_set_blendmode_ext(bm_dest_color,bm_zero);
//gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface_ext(srf_light,ViewX,ViewY,SurfScale,SurfScale,0,c_white,1);
gpu_set_blendmode(bm_normal);

//draw_sprite_ext(sp_light, 0, x, y, 1, 1, 0, c_red, 1);

function skeleton_anim_set_step(animation,track,loop=true){
	
	if(skeleton_animation_get_ext(track) != animation){
		skeleton_animation_set_ext(animation,track,loop)
	};

};//func end bracket
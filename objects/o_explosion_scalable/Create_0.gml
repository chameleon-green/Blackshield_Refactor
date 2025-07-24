smoke = 0; //trigger for smoke expulsion
image_angle = irandom(360);
//depth = -16;

size = 5;
counter = 0;

creator = undefined;
damage = 0;
damage_type = 0;
explosion_type = undefined;
exploded = 0;
final_dir = 0;

audio_falloff_set_model(audio_falloff_linear_distance);

	exp_scalable_frag_huge[4] = snd_explode_small1;
	exp_scalable_frag_huge[3] = 3; //explosion size
	exp_scalable_frag_huge[2] = 40; //frag lifetime
	exp_scalable_frag_huge[1] = c_gray; //smoke color
	exp_scalable_frag_huge[0] = 10; //frag count

explosion_type = exp_scalable_frag_huge;
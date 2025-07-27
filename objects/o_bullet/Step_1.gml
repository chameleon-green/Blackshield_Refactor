if(kill) {
	if(IsBeam) {time_source_start(kill_timer)}
	else{instance_destroy(self)};
};

if(kill) {
	var KillMe = 0;
	if(IsBeam) {KillMe = timer_tick(kill_timer,1)};
	else{instance_destroy(self)};
	if(KillMe) {instance_destroy(self)};
};
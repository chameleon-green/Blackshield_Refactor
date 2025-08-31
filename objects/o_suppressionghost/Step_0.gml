var Kill = 0;

if(instance_exists(Creator)) {x = Creator.x; y = Creator.y}

if(StartKill) {Kill = timer_tick(killtimer)};
if(Kill) {instance_destroy(self)};
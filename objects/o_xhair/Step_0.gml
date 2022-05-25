

/*
if(ownercheck = 1 && owner != -1) {
	ownercheck = 0
	if(instance_exists(owner)){
		if(owner.object_index != o_player) {
			instance_destroy(self)
		};
	};
	else {instance_destroy(self)}	
};
else {instance_destroy(self)};

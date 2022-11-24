CreateScript = InfantryCreateGeneric;
StepScript = InfantryStepGeneric;

CreateScript();

timer = irandom_range(55,75)
alarm[0] = timer;

/*
if(leader) {
	
	MySquad = ds_list_create();
	repeat (9) {
		var NewMember = instance_create_depth(x,y,depth,o_enemy,{leader : 0});
		ds_list_add(MySquad,NewMember);
	};

};
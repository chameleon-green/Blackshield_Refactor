CreateScript = InfantryCreateGeneric;
StepScript = InfantryStepGeneric;
AnimScript = InfantryAnimGeneric;

CreateScript();

/*
if(leader) {
	
	MySquad = ds_list_create();
	repeat (9) {
		var NewMember = instance_create_depth(x,y,depth,o_enemy,{leader : 0});
		ds_list_add(MySquad,NewMember);
	};

};
alarm[1] = 10;


var AIsToProcess = ds_list_size(AIQ);

if(AIsToProcess > 0){
	
	var i = 0;
	var Amount = clamp(AIsToProcess,0,5); //max number of AIs to process in one frame
	while(i < Amount) {
		var AI = AIQ[| i];
		if((typeof(AI) = "ref") && instance_exists(AI)) {
			//if(AI.firing = 0) {AI.ClearToProcess = 1};	
			AI.ClearToProcess = 1;
		};
		ds_list_delete(AIQ,i);
		i++
	};
};
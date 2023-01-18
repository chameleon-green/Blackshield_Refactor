alarm[1] = 3;

var AIsToProcess = ds_list_size(global.AIQueue);

if(AIsToProcess > 0){
	
	var i = 0;
	var Amount = clamp(AIsToProcess,0,8);
	while(i < Amount) {
		var AI = global.AIQueue[| i];
		if((typeof(AI) = "ref") && instance_exists(AI)) {
			//if(AI.firing = 0) {AI.ClearToProcess = 1};	
			AI.ClearToProcess = 1;
		};
		ds_list_delete(global.AIQueue,i);
		i++
	};
};
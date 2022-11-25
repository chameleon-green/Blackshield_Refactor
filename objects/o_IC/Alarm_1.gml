alarm[1] = 2;


var AIsToProcess = ds_list_size(global.AIQueue);

if(AIsToProcess > 0){
	
	var i = 0;
	while(i < 20) {
		var AI = global.AIQueue[| i];
		if(instance_exists(AI)){AI.ClearToProcess = 1};
		ds_list_delete(global.AIQueue,i);
		i++
	};
};
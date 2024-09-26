//+++++++++++++++++++++++++++++++++++++++++++++++ TIMERS +++++++++++++++++++++++++++++++++++++++++++++++++++++
/*

1. Use the timer_create function in create event of object to store the timer array
2. Use the timer_tick function in the step event (or similar) to constantly tick timer. Once duration is hit
	(defined in timer_create), timer_tick will output 1. The toggle option will decide wether or not this
	output is constant. With toggle on, the timer will continuously output 1 until it is reset. Toggle off means
	it will output 1 for one frame when it expires, and then 0 until it reaches its max again.
3. Use timer_reset to reset the time of the timer to 0.

-----------------------------------------------EXAMPLE USAGE:------------------------------------------------

timer_create(MYTIMER,100) //creates timer with 100 frame duration

if(timer_tick(MYTIMER,false) = 1){
DoStuff = 1
timer_reset(MYTIMER)
}

//This code creates a 100 count timer that activates DoStuff. Upon reaching 100 frames, it resets itself using timer_reset

---------------------------------------------------------------------------------------------------------

timer_create(MYTIMER,100) //creates timer with 100 frame duration

if(timer_tick(MYTIMER,false) = 1){
DoStuff = 1
}

if(reset) {timer_reset(MYTIMER)}

//This code creates a 100 count timer that activates DoStuff. It will only reset itself when variable reset is triggered
*/

//------------------------------------------------- CREATE TIMER --------------------------------------
//creates a timer with a given duration in frames. store it in a variable in creation event
function timer_create(duration,histart=0){ 

	var Timer = [0,duration];
	if(histart) {Timer[0] = duration+1};
	
	return Timer;
};

//------------------------------------------------- TICK TIMER --------------------------------------
//ticks timer every frame, use in step event or similar. returns 1 when duration is reached
function timer_tick(timer,toggle) {
	
	var array = timer;
	
	if(!toggle) {if(array[0] > array[1]) {return 0}}; //if not toggle mode, array will output 1 once and then 0

	array[0] += 1;
	if(array[0] <= (array[1]) ) {array[0]++};
	if(array[0] > array [1]) {return 1} else{return 0};

};

//------------------------------------------------- RESET TIMER --------------------------------------
/*resets timer current time (entry 0) to 0 frames. interrupt allows us to reset at any time, if false then
will only reset if timer is currently at max time. generally want this set to false, to prevent resets from looping
and continuously setting timer to 0 and not allowing it to tick at all.
*/
function timer_reset(timer,interrupt){

	if(interrupt) {timer[0] = 0}
	else if(timer[0] > timer[1]) {timer[0] = 0};

};
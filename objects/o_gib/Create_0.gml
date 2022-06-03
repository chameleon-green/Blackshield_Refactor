angle = 0;
count = instance_number(o_gib);
max_gibs = 150;

var multiplier =  ( 1-(count/max_gibs) );
kill = clamp(multiplier,0.1,1)*500;
kill_toggle = 1;
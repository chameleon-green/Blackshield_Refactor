damage = 5000;
damage_type = "thermal";
penetration = 0;
fuseval = 0.9;
hp = clamp(damage,0,2000);
fuse = damage-(damage*fuseval);
IFF = "none";
IsBeam = 0;
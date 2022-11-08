if(MyIC != -1) {visible = !MyIC.visible};


x = mouse_x; 
y = mouse_y;

if(owner.CanShoot) {
x = mouse_x-(owner.x - owner.flash_x)
y = mouse_y-(owner.y - owner.flash_y)
};

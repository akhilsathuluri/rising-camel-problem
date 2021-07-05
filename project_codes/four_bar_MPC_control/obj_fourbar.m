function [J] = obj_fourbar(a,Hp)
 obj1 = 0;
for i =0:Hp-1
    obj1 = obj1 +(a(Hp+4*i+3))^2;
end
 J = obj1;
end
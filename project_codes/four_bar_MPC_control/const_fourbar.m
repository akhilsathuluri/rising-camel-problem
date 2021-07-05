function  [cineq, ceq] = const_fourbar(xini,a,Hp,Hc)

cineq = [];
ceq(1,1) = a(Hp+1)-xini(1);
ceq(2,1) = a(Hp+2)-xini(2);
ceq(3,1)  = a(Hp+3)-xini(3);
ceq(4,1)  = a(Hp+4)-xini(4);

for j=Hc:Hp
  a(j) = a(Hc);  
end

for k =1:Hp
    cineq(end+1) = a(k)-25;
      cineq(end+1) = -a(k)-25;
    end
   
for i=1:Hp-1
    
     x1= a(4*(i-1)+Hp+1);
      x2 = a(4*(i-1)+Hp+2);
     x3 = a(4*(i-1)+Hp+3);
       x4 = a(4*(i-1)+Hp+4); 
    u = a(i);
  [t,y] = ode45(@(t,y) ballbeam(y,u), [0 0.1],[x1 x2 x3 x4]);
    

% cineq(end+1) = a(4*(i-1)+Hp+1)-0.5;
%      cineq(end+1) = -a(4*(i-1)+Hp+1)-0.5;
      
      
  ceq(end+1,1) = a(Hp+i*4+1)-y(end,1);
   ceq(end+1,1) = a(Hp+i*4+2)-y(end,2);
   ceq(end+1,1) = a(Hp+i*4+3)-y(end,3);
ceq(end+1,1) = a(Hp+i*4+4)-y(end,4);
  
end
end
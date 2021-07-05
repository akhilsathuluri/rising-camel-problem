%MPC Parameters
clear all
Hc = 8;
Hp = 15;
x1 = [0 0 0.5 0]; %Change initial ball position here 0.5 can be changed
u0 = 0*ones(Hp,1);
x0 = zeros(4*Hp,1);

a0 = [u0;x0];
optNLP = optimset('Display','iter','TolX',1e-5,'TolFun', 1e-5, 'TolCon', 1e-5,...
        'MaxFunEval', 1000000,'MaxIter', 10000);
for i=1:3000
    i;
    xini(1) = x1(1);
    xini(2) = x1(2);
    xini(3) = x1(3);
    xini(4) =  x1(4);
    
   [opt,fval] = fmincon(@(a)obj_fourbar(a,Hp),a0,[],[],[],[],[],[],@(a)const_fourbar(x1,a,Hp,Hc));
 u = opt(1)
  [t,y] = ode45(@(t,y) ballbeam(y,u), [0 0.1],[xini(1) xini(2) xini(3) xini(4)]);
 
  x1(1) = y(end,1);
  x1(2) = y(end,2);
  x1(3) = y(end,3);
  x1(4) = y(end,4);
  x1(3)
  x_pos(i) = x1(3);
  x_ang(i) = x1(1);
end

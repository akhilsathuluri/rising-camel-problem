%simple shooting
%initial conditions and final time condition
a = [0;0];
b = [pi/3;0];
tf = 20;
%initial guesses of all the costates and the change factor
temp = 2+10^-7;
delta = temp-2;
si = [0.1;0.2];
e = sqrt(eps);
Fi = [1;1;1];
%propagation in time
while Fi(1)>e || Fi(2)>e 
[t,y] = ode45(@(t,y) manidyn(y),[0,tf],[a(1),a(2),si(1),si(2)]);
%Change in the final y due to perturbation of the guesses
[ts1,ys1] = ode45(@(t,y) manidyn(y),[0,tf],[a(1),a(2),si(1)+delta,si(2)]);
[ts2,ys2] = ode45(@(t,y) manidyn(y),[0,tf],[a(1),a(2),si(1),si(2)+delta]);
%Finding the chage in each of functions for an approximation of the
%gradient
Fi = [y(end,1);y(end,2)]-b;
Fs1 = [ys1(end,1);ys1(end,2)]-b;
Fs2 = [ys2(end,1);ys2(end,2)]-b;
%Gradiant method to change initial guesses of each costate
dFs1 = (Fs1-Fi)/delta;
dFs2 = (Fs2-Fi)/delta;
dFsi = [dFs1 dFs2];
si = si-inv(dFsi)*Fi;
end
%Optimal trajectory obtained through simple shooting method
plot(y(:,1),y(:,2));
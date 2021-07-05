function dydt = manidyn(y)

%Dynamics-states and costates
dydt(:,1) = y(2);
dydt(:,2) = y(4);
dydt(:,3) = 0;
dydt(:,4) = y(3);

dydt = dydt(:);
%dydt = [(y(4)*cos(y(3))+y(5)*sin(y(3)))*0.5*cos(y(3));(y(4)*cos(y(3))+y(5)*sin(y(3)))*0.5*sin(y(3));y(6)/2;0;0;(y(4)^2-y(5)^2)*0.25*sin(2*y(3))-(y(4)*y(5)*0.5)*cos(2*y(3))];
end
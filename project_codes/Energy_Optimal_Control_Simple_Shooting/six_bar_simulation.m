%lengths of the manipulator
l1 = 1;
l2 = 1;
r1 = 0.75;
r2 = 0.75;
h = 2;
b = 2;
y = ph1;
%The coordinates of the links of each of the manipulator
x1 = l1*cos(ph1);
y1 = l1*sin(ph1);
x2 = l1*cos(ph1)+r1*cos(th3);
y2 = l1*sin(ph1)+r1*sin(th3);
x3 = l1*cos(ph1)+r1*cos(th3)+h*cos(th1);
y3 = l1*sin(ph1)+r1*sin(th3)+h*sin(th1);
x4 = b+l2*cos(ph2);
y4 = l2*sin(ph2);
x5 = b*ones(size(y,1),1);
y5 = zeros(size(y,1),1);
tic;
for i=1:size(y,1)
    A = [0 x1(i)]; 
    B = [0 y1(i)]; 
   
    A2 = [x1(i) x2(i)]; 
    B2 = [y1(i) y2(i)]; 
    
    A3 = [x2(i) x3(i)];
    B3 = [y2(i) y3(i)];
    
    A4 = [x3(i) x4(i)];
    B4 = [y3(i) y4(i)];
    
    A5 = [x4(i) x5(i)];
    B5 = [y4(i) y5(i)];
    
    axis([-2.5 2.5 -2.5 2.5])
    hold on
    A2end = [0 0.5*(x2(i)+x3(i))]; 
    B2end = [0 0.5*(y2(i)+y3(i))]; 
    plot(A2end,B2end,'.')
   % line(A2,B2,'Color','red')
    % hold on
   lines = plot(A,B,'b',A2,B2,'b',A3,B3,'b',A4,B4,'b',A5,B5,'b');
   %lines = plot(A,B,A2,B2);
   %hold on;
   %plot(A3,B3,A4,B4);
     pause(0.1);
     set(lines,'Visible','off')
     toc
     i
end
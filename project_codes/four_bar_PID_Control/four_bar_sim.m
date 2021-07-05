%lengths of the manipulator
l1 = 4;
l2 = 4;
l3 = 4;
thp = th+pi/3*(ones(size(th)));
%The coordinates of the links of each of the manipulator
x1 = l1*cos(thp);
y1 = l1*sin(thp);
x2 = l1*cos(thp)+l2*cos(ph1);
y2 = l1*sin(thp)+l2*sin(ph1);
x3 = 8*ones(size(th,1),1);
y3 = zeros(size(th,1),1);
tic;
pause(1)
for i=1:2:size(th,1)
    A = [0 x1(i)]; 
    B = [0 y1(i)]; 
   
    A2 = [x1(i) x2(i)]; 
    B2 = [y1(i) y2(i)]; 
    
    A3 = [x2(i) x3(i)];
    B3 = [y2(i) y3(i)];
    
    axis([0 9 0 5])
    hold on
    A2end = [0 0.5*(x1(i)+x2(i))+2*pos(i)*cos(ph1(i))]; 
    B2end = [0 0.5*(y1(i)+y2(i))+2*pos(i)*sin(ph1(i))]; 
    p2=plot(A2end,B2end,'ro');
   % line(A2,B2,'Color','red')
    % hold on
   lines = plot(A,B,'b',A2,B2,'b',A3,B3,'b');
   %lines = plot(A,B,A2,B2);
   %hold on;
   %plot(A3,B3,A4,B4);
     pause(0.001);
     set(lines,'Visible','off')
     toc
     i
     delete(p2)
end
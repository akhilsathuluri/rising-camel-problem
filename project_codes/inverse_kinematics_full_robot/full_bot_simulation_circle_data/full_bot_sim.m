%Run data extractor before this so that the data will be loaded.
tic;
%Define the link parameters
w = 1;
h = 2.5;
d = 1;
L = 1;
%Define all ground points
b1 = [0, w/2 + d, -h];
b2 = [0, -w/2 - d, -h];
b3 = [-L, w/2 + d, -h];
b4 = [-L, -w/2 - d, -h];
for i=1:3:size(h1yl1,1)
% for i=1:2
    %leg-1
    Al1 = [b1(1) kpxl1(i)]; 
    Bl1 = [b1(2) kpyl1(i)]; 
    Cl1 = [b1(3) kpzl1(i)];
    
    A1l1 = [kpxl1(i) h1xl1(i)]; 
    B1l1 = [kpyl1(i) h1yl1(i)]; 
    C1l1 = [kpzl1(i) h1zl1(i)]; 
    
    A2l1 = [h1xl1(i) tpxl1(i)]; 
    B2l1 = [h1yl1(i) tpyl1(i)]; 
    C2l1 = [h1zl1(i) tpzl1(i)]; 
       %leg-2
    Al2 = [b2(1) kpxl2(i)]; 
    Bl2 = [b2(2) kpyl2(i)]; 
    Cl2 = [b2(3) kpzl2(i)];
    
    A1l2 = [kpxl2(i) h1xl2(i)]; 
    B1l2 = [kpyl2(i) h1yl2(i)]; 
    C1l2 = [kpzl2(i) h1zl2(i)]; 
    
    A2l2 = [h1xl2(i) tpxl2(i)]; 
    B2l2 = [h1yl2(i) tpyl2(i)]; 
    C2l2 = [h1zl2(i) tpzl2(i)]; 
          %leg-3
    Al3 = [b3(1) kpxl3(i)]; 
    Bl3 = [b3(2) kpyl3(i)]; 
    Cl3 = [b3(3) kpzl3(i)];
    
    A1l3 = [kpxl3(i) h1xl3(i)]; 
    B1l3 = [kpyl3(i) h1yl3(i)]; 
    C1l3 = [kpzl3(i) h1zl3(i)]; 
    
    A2l3 = [h1xl3(i) tpxl3(i)]; 
    B2l3 = [h1yl3(i) tpyl3(i)]; 
    C2l3 = [h1zl3(i) tpzl3(i)]; 
              %leg-4
    Al4 = [b4(1) kpxl4(i)]; 
    Bl4 = [b4(2) kpyl4(i)]; 
    Cl4 = [b4(3) kpzl4(i)];
    
    A1l4 = [kpxl4(i) h1xl4(i)]; 
    B1l4 = [kpyl4(i) h1yl4(i)]; 
    C1l4 = [kpzl4(i) h1zl4(i)]; 
    
    A2l4 = [h1xl4(i) tpxl4(i)]; 
    B2l4 = [h1yl4(i) tpyl4(i)]; 
    C2l4 = [h1zl4(i) tpzl4(i)]; 
    
    axis([-5 5 -3 3 -3 3])
    hold on
     %plotting the frame
    F34x = [tpxl3(i) tpxl4(i)]; 
    F34y = [tpyl3(i) tpyl4(i)]; 
    F34z = [tpzl3(i) tpzl4(i)]; 
    
    F31x = [tpxl3(i) tpxl1(i)]; 
    F31y = [tpyl3(i) tpyl1(i)]; 
    F31z = [tpzl3(i) tpzl1(i)]; 

    F21x = [tpxl2(i) tpxl1(i)]; 
    F21y = [tpyl2(i) tpyl1(i)]; 
    F21z = [tpzl2(i) tpzl1(i)]; 

    F24x = [tpxl2(i) tpxl4(i)]; 
    F24y = [tpyl2(i) tpyl4(i)]; 
    F24z = [tpzl2(i) tpzl4(i)]; 
    
    plot3(cx(i),cy(i),cz(i),'r*')
    frame = plot3(F34x,F34y,F34z,'k',F31x,F31y,F31z,'k',F24x,F24y,F24z,'k',F21x,F21y,F21z,'k');
    lines = plot3(Al1,Bl1,Cl1,'b',A1l1,B1l1,C1l1,'b',A2l1,B2l1,C2l1,'b',Al2,Bl2,Cl2,'r',A1l2,B1l2,C1l2,'r',A2l2,B2l2,C2l2,'r',Al3,Bl3,Cl3,'b',A1l3,B1l3,C1l3,'b',A2l3,B2l3,C2l3,'b',Al4,Bl4,Cl4,'g',A1l4,B1l4,C1l4,'g',A2l4,B2l4,C2l4,'g');
    
    pause(0.001);
    set(lines,'Visible','off')
    set(frame,'Visible','off')
     
    toc
    i
end
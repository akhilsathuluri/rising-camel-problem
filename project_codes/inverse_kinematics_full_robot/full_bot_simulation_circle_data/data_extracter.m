%Importing data from the saved csv files
%Extract trajectory list
cx = load('cx.csv');
cy = load('cy.csv');
cz = load('cz.csv');
%leg-1 data
ml1 = load('hjl1.csv');
nl1 = load('hl1.csv');
pl1 = load('kl1.csv');

tpxl1 = ml1(:,1);
tpyl1 = ml1(:,2);
tpzl1 = ml1(:,3);

h1xl1 = nl1(:,1);
h1yl1 = nl1(:,2);
h1zl1 = nl1(:,3);

kpxl1 = pl1(:,1);
kpyl1 = pl1(:,2);
kpzl1 = pl1(:,3);

%leg-2 data
ml2 = load('hjl2.csv');
nl2 = load('hl2.csv');
pl2 = load('kl2.csv');

tpxl2 = ml2(:,1);
tpyl2 = ml2(:,2);
tpzl2 = ml2(:,3);

h1xl2 = nl2(:,1);
h1yl2 = nl2(:,2);
h1zl2 = nl2(:,3);

kpxl2 = pl2(:,1);
kpyl2 = pl2(:,2);
kpzl2 = pl2(:,3);

%leg-3
ml3 = load('hjl3.csv');
nl3 = load('hl3.csv');
pl3 = load('kl3.csv');

tpxl3 = ml3(:,1);
tpyl3 = ml3(:,2);
tpzl3 = ml3(:,3);

h1xl3 = nl3(:,1);
h1yl3 = nl3(:,2);
h1zl3 = nl3(:,3);

kpxl3 = pl3(:,1);
kpyl3 = pl3(:,2);
kpzl3 = pl3(:,3);

%leg-4 data
ml4 = load('hjl4.csv');
nl4 = load('hl4.csv');
pl4 = load('kl4.csv');

tpxl4 = ml4(:,1);
tpyl4 = ml4(:,2);
tpzl4 = ml4(:,3);

h1xl4 = nl4(:,1);
h1yl4 = nl4(:,2);
h1zl4 = nl4(:,3);

kpxl4 = pl4(:,1);
kpyl4 = pl4(:,2);
kpzl4 = pl4(:,3);
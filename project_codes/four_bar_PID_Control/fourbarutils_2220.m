(* ::Package:: *)

BeginPackage["fourbarutils`",{"mathutils`"}]

fourbarutils::usage ="'fourbarutils' package provides some utilities which come handy in 
when working with four-bar mechanisms 


1) fourbarPlotter
			Plots the four-bar mechanism.

2) couplerCurve  
			Provides the equation of the coupler curve of a four-bar mechanism.

3) couplerCurveNumeric  
			Returns the list plot of the four-bar coupler curve. The numeric values of the four-bar parameters must be provided.

4) fourBarFK  
			Solves the forward kinematic problem of the four-bar mechanism.

P.S : Type '?<function_name>' for more details.
"


fourBarPlotter::usage          = "fourBarPlotter[{b1x,b1y},{b2x,b2y},{l1,l2,l3},{xc,yc},{\[Theta]1,\[Phi]2,\[Phi]3}]: Returns the graphics handle for the plot. All inputs must be numeric."

fourBarFK::usage               = "fourBarFK[{b1x,b1y},{b2x,b2y},{l1,l2,l3},{\[Theta]1,\[Phi]2,\[Phi]3},br]: Returns the forward kinematic solution of the four-bar mechanism. Inputs can be symbolic. Set br to 1 or 2 to select between the branches. To get both the branches use any other value for br, e.g 0."

couplerCurve::usage            = "couplerCurve[{b1x,b1y},{b2x,b2y},{l1,l2,l3},{xc,yc},{x,y}]: Return the four-bar coupler curve equation. The inputs can be symbolic."

couplerNumeric::usage          = "couplerNumeric[{b1x,b1y},{b2x,b2y},{l1,l2,l3},{xc,yc}]: Return the handle of the plot of the four-bar coupler curve. All inputs must be numeric."


Begin["Private`"]

(*****************************************************)
(* Four-bar plotter function                        *)
(* Plots the four-bar mechanism when all the      *)
(* parameters are specified (numeric values)       *)
(*****************************************************)
fourBarPlotter[{b1x_, b1y_}, {b2x_, b2y_}, {l1_, l2_, l3_}, {xc_, yc_}, {\[Theta]1_, \[Phi]2_, \[Phi]3_}] := 
  Module[{l0, smallest, largest, medium1, medium2, b1, b2, p1, p, 
    pleft, pright, pdiff, EPS, pc, link0, link1, link2, link3, rjoint, 
    circbase, circjoint, plot, checkflag, boundingBox},
   
   (* Check for validity of the input arguments *)
   checkflag = True;
   If[VectorQ[#, NumericQ] != True, 
      Print[StringForm[
        "fourbarPlotter::error: The input argument `` is not valid.", #]]; checkflag = False;
      ] & /@ {{b1x, b1y}, {b2x, b2y}, {l1, l2, 
      l3}, {\[Theta]1, \[Phi]2, \[Phi]3}};
   If[checkflag == False, Return[];];
   
   l0 = Sqrt[(b2x - b1x)^2 + (b2y - b1y)^2];
   {smallest, medium1, medium2, largest} = Sort[{l0, l1, l2, l3}];
   
   If[largest > smallest + medium1 + medium2,
    Print[
     StringForm[
      "fourbarPlotter::error: Invalid link lengths to assemble. The largest link length (``) is not less than the sum of remaining link lengths (``)", largest, smallest + medium1 + medium2]]; Return[];
    ];
   
   
   b1 = {b1x, b1y};
   b2 = {b2x, b2y};
   p1 = b1 + l1 {Cos[\[Theta]1], Sin[\[Theta]1]};
   pleft = p1 + l2 {Cos[\[Phi]2], Sin[\[Phi]2]};
   pright = b2 + l3 {Cos[\[Phi]3], Sin[\[Phi]3]};
   pc = p1 + rot2D[\[Phi]2].{xc, yc};
   pdiff = pleft - pright;
   
   (* Check if the link length and the joint variable data is valid *)
   EPS=10^-10;
	If[zeroQ[pdiff[[1]], EPS] && 
     zeroQ[pdiff[[2]], EPS],
    (*if  pleft \[NotEqual] pright*)
    (* Graphics elements *)
    p = pleft;
    link0 = Graphics[{Thickness[0.008], Black, Line[{b1, b2}]}];
    link1 = Graphics[{Thickness[0.005], Red, Line[{b1, p1}]}];
    link2 = 
     Graphics[{Thickness[0.005], Green, 
       Line[{{p1, p}, {p, pc}, {pc, p1}}], Opacity[0.4, Green], 
       Triangle[{p1, p, pc}],Black,PointSize[0.001]}];
    link3 = Graphics[{Thickness[0.005], Blue, Line[{b2, p}]}];
    
   rjoint = (largest + smallest)/60;
    circbase = 
     Graphics[{EdgeForm[Thickness[0.005]], White, Disk[b1, rjoint], 
       Disk[b2, rjoint]}];
    circjoint = 
     Graphics[{EdgeForm[Thickness[0.005]], White, Disk[p1, rjoint], 
       Disk[p, rjoint]}];
        
    plot = Show[{link0, link1, link2, link3, circbase, circjoint}];
    Return[plot];,
    
	(*else if  pleft \[NotEqual] pright*)
    Print["fourbarPlotter::error: Invalid joint variables"]; 
    Return[];
    ];
   ];



(***********************************************************)
(* Four-bar forward-kinematic solver                      *)
(* Returns the forward kinematic solution of the         *)
(* four-bar. Inputs can be numeric or symbolic.          *)
(* Set br to '1' or '2' to obtaing the solutions       *)
(* of the respective branches. Set it to any other     *)
(* value (0) to get the solution of both the branches. *)
(***********************************************************)
fourBarFK[{b1x_, b1y_}, {b2x_, b2y_}, {l1_, l2_, 
    l3_}, {\[Theta]1_, \[Phi]2_, \[Phi]3_}, br_: 0] :=
  
  Module[{\[Eta]a, \[Eta]b, sol\[Phi]2, f1t, f1, sol\[Phi]3, soln, retsol},
   (* Loop closure equations *)
   {\[Eta]a, \[Eta]b} = {b1x, b1y} + 
     l1*{Cos[\[Theta]1], Sin[\[Theta]1]} + 
     l2*{Cos[\[Phi]2], Sin[\[Phi]2]} - {b2x, b2y} - 
     l3*{Cos[\[Phi]3], Sin[\[Phi]3]};
   
   (* Eliminate \[Phi]2 *)
   {sol\[Phi]2, f1t} = solveLinTrig2[{\[Eta]a, \[Eta]b}, \[Phi]2];
   f1 = TrigExpand[f1t];
   
   (* Solve for \[Phi]3*)
   sol\[Phi]3 = solveLinTrig1[f1, \[Phi]3];
   
   (* Combine the solutions *)   
   soln = Union[sol\[Phi]2 /. #, #] & /@ sol\[Phi]3;
   retsol = Switch[br,1, soln[[1]], 2, soln[[2]],_,soln];

   Return[retsol];
   ];



(*****************************************************)
(* Four-bar coupler curve function                   *)
(* Returns the equation of the coupler curve.      *)
(* Inputs can be numeric or symbolic                *)
(*****************************************************)
couplerCurve[{b1x_, b1y_}, {b2x_, b2y_}, {l1_, l2_, l3_}, {xc_, 
    yc_}, {x_, y_}] :=
  
  Module[{\[Theta]1, \[Phi]2, \[Phi]3, pleft, pright, f1, f2, f3, f4, 
    solnleft, solnright, solnlocus},
   
   (*Expression for point p from the left side*)
   
   pleft = {b1x, b1y} + l1*{Cos[\[Theta]1], Sin[\[Theta]1]} + 
     rot2D[\[Phi]2].{xc, yc};
   
   (*Similarly, expression for point p from the right side*)
   
   pright = {b2x, b2y} +    l3*{Cos[\[Phi]3], Sin[\[Phi]3]} + 
     rot2D[\[Phi]2].{-l2 + xc, yc};
   
   (*pleft and pright are simply the position of the point p in the \
   two paths that we have chosen. To close the loop, 
   and be able to give it as input for the solveLinTrig2 function, 
   we need to include x and y coordinates of point p, in the expression*)
   {f1, f2} = pleft - {x, y};
   {f3, f4} = pright - {x, y};
   
   (*We use the solveLinTrig2 function to find the eliminant after \
removing \[Theta]1 from the equations*)
   
   solnleft = TrigExpand[solveLinTrig2[{f1, f2}, \[Theta]1][[2]]];
   
   (*We use the solveLinTrig2 function to find the eliminant after \
removing \[Phi]3 from the equations*)
   
   solnright = TrigExpand[solveLinTrig2[{f3, f4}, \[Phi]3][[2]]];
   
   (*We use the solveLinTrig2 function to find the eliminant after \
removing \[Phi]2 from the equations, 
   to yield a locus in purely x and y*)
   
   solnlocus = solveLinTrig2[{solnleft, solnright}, \[Phi]2][[2]];
   Return[solnlocus];
   ];



(*******************************************************)
(* Four-bar coupler curve function                   *)
(* Returns the handle of the coupler curve plot.   *)
(* All inputs must be numeric. The plot points are *)
(* obtained by solving the forward kinematics for   *)
(* multiple values of the input angle.              *)
(******************************************************)

couplerNumeric[{b1x_, b1y_}, {b2x_, b2y_}, {l1_, l2_, l3_}, {xc_, yc_}] :=
  Module[{p1, pc, fksol, curve1, curve2, list1, list2, plot1, plot2, \[Theta]1, \[Phi]2, \[Phi]3},

	(* Check that the inputs are all numbers *)
	If[!VectorQ[{b1x,b1y,b2x,b2y,l1,l2,l3,xc,yc},NumericQ],Print["couplerNumeric::error: One or more of the inputs provided are not numbers."]; Return[{}];];   

   (* Solve the forward kinematics of the four-bar*)
	fksol = fourBarFK[{b1x, b1y}, {b2x, b2y}, {l1, l2, l3}, {\[Theta]1, \[Phi]2, \[Phi]3}];

	(* Coupler point pc *)
	p1 = {b1x, b1y} + l1*{Cos[\[Theta]1], Sin[\[Theta]1]};
    pc = p1 + rot2D[\[Phi]2].{xc, yc};

	(* Create a list of points of the coupler for \[Theta]1 ranging from 0 to 2\[Pi] and plot the points *)
   curve1 = (pc /. fksol[[1]]);
   curve2 = (pc /. fksol[[2]]);
   plot1=ParametricPlot[curve1,{\[Theta]1,0,2\[Pi]},PlotStyle->Red];
   plot2=ParametricPlot[curve2,{\[Theta]1,0,2\[Pi]},PlotStyle->Blue];

   Return[Show[plot1, plot2]];
   ];



End[]
EndPackage[]

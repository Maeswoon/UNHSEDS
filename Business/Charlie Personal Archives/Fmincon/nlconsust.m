function [c,ceq] = nlconsust(x)
% Constrains only the initial caliber of the sustainer

Lebay                 = 0.10;
Lsust                 = 0.32;
Ldrogueparachute      = 0.04; 
Lmainparachute        = 0.08; 
LcouplerBodyTubeEbay  = 0.02;
LcouplerBodyTubeStage = 0.02;

Dnosecone        = x(1)*.666; % Must change for Von Nose Cone
Dshoulder        = x(1) + x(2)/2;
Debay            = Dshoulder + x(2)/2  + LcouplerBodyTubeEbay/2;
Dsustbodytube    = Debay + LcouplerBodyTubeEbay/2 + x(3)/2;
Dforwardfins     = Dsustbodytube + x(3)/2 - x(8)/2;
Dstagingcoupler  = Dsustbodytube + x(3)/2 + LcouplerBodyTubeStage/2;
Dsust            = Dstagingcoupler - LcouplerBodyTubeStage/2 - Lsust/2 + x(6);


xmainparachute       = 0.12;       % From forward Shoulder Forward
xdrogueparachute      = 0.10;    % From aft of E-Bay Bulk Plate



Ddrogueparachute    = Debay + Lebay/2 + xdrogueparachute + Ldrogueparachute/2 - .07;                                                                % Offset from Nosecone Forward
Dmainparachute      = x(1) + xmainparachute + Lmainparachute/2;                                                % Offset from E-bay Aft

Diameter=.0473;
Rbodytube = Diameter/2;     % Radius of Bodytube


BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts

Mnosecone                = .150;
Mshoulder                = x(2)*BT;
Mebay                    = .400;                    % Whole E-Bay, Must find Value
Msustbodytube            = x(3)*BT;
Mforwardfins             = PL * .5* Cr*Ct*Ss;
Msustcasingtuberetainer  = .110 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Msustinit                = .349;                    % Initial mass of sustainer 

Mdrogueparachute         = .024;
Mmainparachute           = .071;

Mcenteringring           = 0;       % Do we want to add this?

% Center of Gravity of booster during flight

CGSust  = Msustinit*Dsust;

Mtot2   = Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins...                          % Total mass of sustainer through flight
        + Msustcasingtuberetainer + Mdrogueparachute + Mmainparachute + 2*Mcenteringring;                                                % after booster seperation
              
CG2     = (CGSust + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Mbattery*Dbattery...
        + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...                                           % Center of gravity of sustainer through flight
        + Mdrogueparachute*Ddrogueparachute + Mmainparachute*Dmainparachute)./Mtot2;   
    
    
    
    
    
%Cp

Xb  = Dforwardfins - x(8)/2;  % Length of nosecone tip to beginning of root chord

cnn = 2;                 % Co-efficient for the type of nose cone 
xn  = .666 * x(1);       % Location of the center of pressure for an ogive
cnt = 0;                 % Cnt would change if rocket diameter changed
xt  = 0;                 % Not applicable
nf  = 3;                 % Number of Fins    
Lf=sqrt(((x(8)/2)-(x(8)-x(11)-x(9)+(x(9)/2)))^2+(x(10))^2);
Lf2=sqrt(((x(12)/2)-(x(12)-x(15)-x(13)+(x(13)/2)))^2+(x(14))^2);
% Fin Calculations
x1=1.0+(Rbodytube/(x(10)+Rbodytube));                                          % The following variables allow cnf, a coefficent, to be calculated
x2=4.0*nf*(x(10)*x(10)/(Rbodytube*Rbodytube*4));
x3a=2.0*Lf;
x3b=x(8)+x(9);
x3=x3a/x3b;
x4=1.0+sqrt(1.0+x3^2);
cnf=x1*x2/x4;                                                               % A coefficient needed to find center of pressure
xf = (1.0/6.0)*(x(8)+x(9)-(x(8)*x(9)/(x(8)+x(9))))+(x(11)/3.0)*((x(8)+2.0*x(9))/(x(8)+x(9)))+Xb;   % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
                                                                            % distance from the tip of the nose cone to the root chord of the fin
% Calculation for CP (sustainer)

cnr=cnn+cnt+cnf;  
cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);   % Center of Pressure equation for just sustainer 
    

c=[];
ceq=1.5-((cp-CG2)/(2*Rbodytube));
end
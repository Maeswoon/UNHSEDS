

% Parameters

res = 1000; % Timestep resolution




% Mass in kilograms
% Distance in meters
% Time in seconds

% Booster and Sustainer Time Values

 
Tsust      = 3;   

%% Lengths: In Meters (m)
% Main Components:
Lnosecone        = .240;  
Lshoulder        = .505;
Lebay            = .140;
Lsustbodytube    = .355; 
Lforwardfins     = .100;  
Lsust            = .187;

% Internal electronics (m)  
Lbattery       = 0.0265;      
Laltimeter     = 0.0996;
Lswitch        = 0.01;

% Internal pieces (m)
Ldrogueparachute  = 0.04;
Lmainparachute    = 0.06;  

% Coupler BodyTube Pieces
LcouplerBodyTube = .02;  %(m)

% Motor Hang
motorhang = .02; 

%% Distances: Centroid Calculations from the Tip of Nosecone


% Main Components:
Dnosecone        = Lnosecone*.666;
Dshoulder        = Lnosecone + Lshoulder/2;
Debay            = Dshoulder + Lshoulder/2  + LcouplerBodyTube/2;
Dsustbodytube    = Debay + LcouplerBodyTube/2 + Lsustbodytube/2;
Dforwardfins     = Dsustbodytube + Lsustbodytube/2 - Lforwardfins/2;                     % Not exact Centroid
Dsust            = Dforwardfins + Lforwardfins - Lsust/2 + motorhang;

% Internal Components: Marks the beginning of the Component
xbattery            = 0.14;    % From forward of E-Bay
xaltimeter          = 0.03;    % From forward of E-Bay
xswitch             = 0.02;    % From forward of E-Bay

xmainparachute      = 0.30;    % From forward of Nosecone
xdrogueparachute    = 0.05;    % From aft of E-Bay


xcenteringring1     = -0.15;    % From aft of Sustainer Body Tube (-)
xcenteringring2     = -0.01;    % From aft of Sustainer Body Tube (-)

% Internal Electronics:
Dbattery       = Lnosecone + Lshoulder - Lebay/2 + xbattery + Lbattery/2;      
Daltimeter     = Lnosecone + Lshoulder - Lebay/2 + xaltimeter + Laltimeter/2;
Dswitch        = Lnosecone + Lshoulder - Lebay/2 + xswitch + Lswitch/2;

% Recovery Components:
Dmainparachute        = xmainparachute + Lmainparachute;
Ddrogueparachute      = Lnosecone + Lshoulder + LcouplerBodyTube + (Lebay-2)/2 + xdrogueparachute + Ldrogueparachute/2;


% Engine Retainment:
Dcenteringring1      = Dsustbodytube + Lsustbodytube/2 + xcenteringring1;
Dcenteringring2      = Dsustbodytube + Lsustbodytube/2 + xcenteringring2;

% CHARLIE EDITED AND VERIFIED. -Charlie

%           ***RESUME EDITING HERE***





%% Masses 
% Mass of Components (kg)     NEED TO STILL DO THIS FOR AETHER 2
Mnosecone        = .107;
Mshoulder        = .105;
Mebay            = .120;
Msustbodytube    = .073;
Mforwardfins     = .036;
Msustinit        = .1982;    % Initial mass of sustainer 
Msustprop        = .0865;    % Mass of propellant



% Internal pieces (kg)
Mdrogueparachute    = 0.010;
Mmainparachute      = 0.020;  
Mcenteringring      = 0.005;

Mrecovery = Mdrogueparachute + Mmainparachute + Mcenteringring;

ts     = linspace(0,Tsust,res);             % 1000 different times of flight from 0 to 1.4 seconds
Msust  = Msustinit - (Msustprop/Tsust)*ts;  % Mass of sustainer through flight
CGSust = Msust.*Dsust;                      % Center of Gravity of sustainer through flight
Mtot  = Msust + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mrecovery;   % Total mass of sustainer through flight
CG    = (CGSust+Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins + Mdrogueparachute*Ddrogueparachute + Mmainparachute*Dmainparachute + Mcenteringring*Dcenteringring1 + Mcenteringring*Dcenteringring2)./Mtot;


hold on

plot(ts,CG)


%% CP (m)  % MUST START HERE FOR AETHER ONE FINS AND RBODYTUBE CHANGE

Cr  = .100;      %Lrootchord   
Ct  = .015;      %Ltipchord 
Ss  = .055;      %Lsemispan 
Lf  = .060;      %Lmidchordline
Xr  = .070;      %Lfinrootleadtofintiplead

Xb  = Dforwardfins - Lforwardfins/2;  %Lnosetiptorootchord

Rbodytube = .0570/2; 

cnn = 2;                 % For nose cone
xn  = .666 * Lnosecone;  % Center of Pressure for conical nose cone
cnt = 0;                 % Same diameter rocket throughout
xt  = 0;                 % Not applicable
nf  = 3;                 % Number of Fins

% Nose Cone Calcs
x1=1.0+(Rbodytube/(Ss+Rbodytube));
x2=4.0*nf*(Ss*Ss/(Rbodytube*Rbodytube*4));
x3a=2.0*Lf;
x3b=Cr+Ct;
x3=x3a/x3b;
x4=1.0+sqrt(1.0+x3*x3);
cnf=x1*x2/x4;
xf = (1.0/6.0)*(Cr+Ct-(Cr*Ct/(Cr+Ct)))+(Xr/3.0)*((Cr+2.0*Ct)/(Cr+Ct))+Xb;

% Calculation for CP (sustainer)

cnr=cnn+cnt+cnf;
cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);



% Plotting Caliber

cal = (cp-CG)/(2*Rbodytube);
plot(ts,cal)



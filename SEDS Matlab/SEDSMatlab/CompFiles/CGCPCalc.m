
% Parameters

res = 1000; % Timestep resolution

% Mass in kilograms (kg)
% Distance in meters (m)
% Time in seconds (s)

% Booster and Sustainer Time Values

Tboost     = .7;   
Tsust      = 1.7;   

%% Lengths: In Meters (m)
% Main Components:
Lnosecone        = .500;  
Lshoulder        = .090;
Lebay            = .200;
Lsustbodytube    = .660; 
Lforwardfins     = .200;
Lstagingcoupler  = .200;
Lboosterbodytube = .600;
Laftfins         = .110;
Lboost           = .320;    
Lsust            = .320;

% Internal electronics (m)  
Lbattery       = 0.0265;      
Laltimeter     = 0.0996;
LSEDSaltimeter = 0.06985;
Lswitch        = 0.01;

% Internal pieces (m)
Ldrogueparachute  = 0.04;
Lmainparachute    = 0.06;  
Lboosterparachute = 0.05;

% Coupler BodyTube Pieces
LcouplerBodyTube = .02;  %(m)

% Motor Hang
motorhang = .03; 

%% Distances: Centroid Calculations from the Tip of Nosecone


% Main Components:
Dnosecone        = Lnosecone*.666;
Dshoulder        = Lnosecone + Lshoulder/2;
Debay            = Dshoulder + Lshoulder/2  + LcouplerBodyTube/2;
Dsustbodytube    = Debay + LcouplerBodyTube/2 + Lsustbodytube/2;
Dforwardfins     = Dsustbodytube + Lsustbodytube/2 - Lforwardfins/2;
Dstagingcoupler  = Dforwardfins + Lforwardfins/2 + LcouplerBodyTube/2;
Dsust            = Dstagingcoupler - LcouplerBodyTube/2 - Lsust/2 + motorhang;
Dboosterbodytube = Dstagingcoupler + LcouplerBodyTube/2 + Lboosterbodytube/2;
Daftfins         = Dstagingcoupler + LcouplerBodyTube/2 + Lboosterbodytube - Laftfins/2;
Dboost           = Dstagingcoupler + LcouplerBodyTube/2 + Lboosterbodytube - Lboost/2 + motorhang; 

% Internal Components: Marks the beginning of the Component
xbattery            = 0.14;    % From forward of E-Bay
xaltimeter          = 0.03;    % From forward of E-Bay
xswitch             = 0.02;    % From forward of E-Bay
xSEDSaltimeter      = 0.22;    % From forward of Nosecone

xdrogueparachute    = 0.45;    % From forward of Nosecone
xmainparachute      = 0.00;    % From aft of E-Bay
xboosterparachute   = 0.00;    % From aft of Coupler

xcenteringring1     = -0.25;   % From aft of Sustainer Body Tube (-)
xcenteringring2     = -0.08;   % From aft of Sustainer Body Tube (-)
xcenteringring3     = -0.01;   % From aft of Booster Body Tube (-)
xcenteringring4     = -0.12;   % From aft of Booster Body Tube (-)

% Internal Electronics:
Dbattery       = Lnosecone + xbattery + Lbattery/2;      
Daltimeter     = Lnosecone + xaltimeter + Laltimeter/2;
DSEDSaltimeter = xSEDSaltimeter + LSEDSaltimeter/2;
Dswitch        = Lnosecone + xswitch + Lswitch/2;

% Recovery Components:

Ddrogueparachute    = xdrogueparachute + Ldrogueparachute/2;
Dmainparachute      = Lnosecone + Lebay + xmainparachute + Lmainparachute/2;                                                % The offset from E-bay is intentional because parachute placement is referenced from that part. 
Dboosterparachute   = Dstagingcoupler + LcouplerBodyTube/2 + Lstagingcoupler/2 + xboosterparachute + Lboosterparachute/2;   % Was incorrect but it is intentiona that placement is referenced from the coupler bulk plate


% Engine Retainment:
Dcenteringring1      = Dsustbodytube + Lsustbodytube/2 + xcenteringring1;   
Dcenteringring2      = Dsustbodytube + Lsustbodytube/2 + xcenteringring2;
Dcenteringring3      = Dboosterbodytube + Lsustbodytube/2 + xcenteringring3;
Dcenteringring4      = Dboosterbodytube + Lsustbodytube/2 + xcenteringring4;

% CHARLIE EDITED AND VERIFIED. -Charlie
% RE-EDITED AND RE-VARIFIED (discussion pending before changes) - Nick



%           ***RESUME EDITING HERE***





%% Masses
% Mass of Components (kg)
Mnosecone        = .063;
Mshoulder        = 0;
Mebay            = .120;
Msustbodytube    = .169;
Mforwardfins     = .104;
Mstagingcoupler  = .045;    % With 1 bulkhead = 9g
Mboosterbodytube = .165;    % need to add mass of 2 centering rings for both motors soon, need their own centroid 
Maftfins         = .084;   
Mboostinit       = .294;    % Initial mass of booster
Msustinit        = .349;    % Initial mass of sustainer 
Mboostprop       = .132;    % Mass of propellant 
Msustprop        = .185;    % Mass of propellant


% Internal electronics (kg)  
Mbattery       = 0.045;      
Maltimeter     = 0.0017;
MSEDSaltimeter = 0.0158;
Mswitch        = 0;

% Internal pieces (kg)
Mdrogueparachute    = 0;
Mmainparachute      = 0;
Mboosterparachute   = 0;   
Mcenteringring      = 0;


tb      = linspace(0,Tboost,res); % 1000 different times of flight from 0 to .7 seconds
Mboost  = Mboostinit-(Mboostprop/Tboost)*tb; % Mass of the booster during flight
CGBoost = Mboost.*Dboost;
Mtot    = Mboost + Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube + Maftfins + Mbattery + Maltimeter + MSEDSaltimeter + Mswitch + Mdrogueparachute + Mboosterparachute + Mmainparachute + 4*Mcenteringring; 
CG      = (CGBoost + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins + Dstagingcoupler*Mstagingcoupler + Dsust*Msustinit + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins + Mbattery*Dbattery + Maltimeter*Daltimeter + MSEDSaltimeter*DSEDSaltimeter + Mswitch*Dswitch + Mdrogueparachute*Ddrogueparachute + Mboosterparachute*Dboosterparachute + Mmainparachute*Dmainparachute + Mcenteringring*Dcenteringring1 + Mcenteringring*Dcenteringring2 + Mcenteringring*Dcenteringring3 + Mcenteringring*Dcenteringring4)./Mtot;   

plot(tb,CG)

ts     = linspace(0,Tsust,res);             % 1000 different times of flight from 0 to 1.4 seconds
Msust  = Msustinit - (Msustprop/Tsust)*ts;  % Mass of sustainer through flight
CGSust = Msust.*Dsust;                      % Center of Gravity of sustainer through flight
Mtot2  = Msust + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mbattery + Maltimeter + MSEDSaltimeter + Mswitch + Mdrogueparachute + Mmainparachute + 2*Mcenteringring;;   % Total mass of sustainer through flight
CG2      = (CGSust + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins + Maltimeter*Daltimeter + MSEDSaltimeter*DSEDSaltimeter + Mswitch*Dswitch + Mdrogueparachute*Ddrogueparachute + Mmainparachute*Dmainparachute + Mcenteringring*Dcenteringring1 + Mcenteringring*Dcenteringring2)./Mtot2;   


hold on
ts     = linspace(Tboost,Tboost+Tsust,res);% 1000 different times of flight from .7 to 2.4 seconds
plot(ts,CG2)


%% CP (m)

Cr  = .1;   %Lrootchord   
Ct  = .1;   %Ltipchord 
Ss   = .0563;  %Lsemispan 
Lf  = .114;   %Lmidchordline
Xr  = .1;   %Lfinrootleadtofintiplead

Xb  = Dforwardfins - Lforwardfins/2;  %Lnosetiptorootchord

Rbodytube = .0474/2; 

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


%% Booster & Sustainer

% Fin Parameters
Cr2  = .11;   %Lrootchord   
Ct2  = .05;   %Ltipchord 
Ss2  = .053;  %Lsemispan 
Lf2  = .053;   %Lmidchordline
Xr2  = .03;   %Lfinrootleadtofintiplead
Xb2  = Daftfins - Laftfins/2;

% Equations for CP (full rocket)
x12=1.0+(Rbodytube/(Ss2+Rbodytube));
x22=4.0*nf*(Ss2*Ss2/(Rbodytube*Rbodytube*4)); % Diameter of Bodytube
x3a2=2.0*Lf2;
x3b2=Cr2+Ct2;
x32=x3a2/x3b2;
x42=1.0+sqrt(1.0+x32*x32);


xf2 = (1.0/6.0)*(Cr2+Ct2-(Cr2*Ct2/(Cr2+Ct2)))+(Xr2/3.0)*((Cr2+2.0*Ct2)/(Cr2+Ct2))+Xb2;
cnf2=x12*x22/x42;
cnr2=cnn+cnt+cnf+cnf2;
cp2 = ((cnn*xn+cnt*xt+cnf*xf+cnf2*xf2)/cnr2);


% Plotting Caliber

cal1 = (cp2-CG)/(2*Rbodytube);
plot(tb,cal1)
cal2 = (cp-CG2)/(2*Rbodytube);
hold on
plot(ts,cal2)


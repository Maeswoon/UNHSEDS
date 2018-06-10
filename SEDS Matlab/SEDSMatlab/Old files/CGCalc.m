
% Openrocket on drive


% Parameters

res = 1000; % Timestep resolution


%%%% Distance is from tip of Nose Cone
% Mass in kg
% Distance in meters
% Time in Seconds

% Booster and Sustainer Time Values

Tboost     = .7;   
Tsust      = 1.7;   

%% Lengths
% Lengths (m)
Lnosecone        = .500;  % Nosecone and Forward Body Tube
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
couplerBodyTube = .02;  %(m)

% Motor Hang
motorhang = .03; 

%% Distances

%Distance from tip of Nose Cone (Never have to Change) (Centroid) check

% CHECK CALCULATIONS***

Dnosecone        = Lnosecone*.666;
Dshoulder        = Lnosecone + Lshoulder/2;
Debay            = Dshoulder + Lshoulder/2  + couplerBodyTube/2;
Dsustbodytube    = Debay + couplerBodyTube/2 + Lsustbodytube/2;
Dforwardfins     = Dsustbodytube + Lsustbodytube/2 - Lforwardfins/2;                     % This might need work finding a better centroid distance  
Dstagingcoupler  = Dforwardfins + Lforwardfins/2 + couplerBodyTube/2;
Dsust            = Dstagingcoupler - couplerBodyTube/2 - Lsust/2 + motorhang;
Dboosterbodytube = Dstagingcoupler + couplerBodyTube/2 + Lboosterbodytube/2;
Daftfins         = Dstagingcoupler + couplerBodyTube/2 + Lboosterbodytube - Laftfins/2;  % This might need work finding a better centroid distance  
Dboost           = Dstagingcoupler + couplerBodyTube/2 + Lboosterbodytube - Lboost/2 + motorhang; 

% Internal Components: OpenRocket offsets from parent part (m)
xbattery       = 0.14; % from aft end of nosecone
xaltimeter     = 0.03; % from aft end of nosecone
xSEDSaltimeter = 0.22; % from tip of nose cone
xswitch        = 0.02; % from aft end of nosecone

xdrogueparachute    = 0.45; % from tip of nose cone
xmainparachute      = 0.12; % from forward end of sustainer body tube
xboosterparachute   = 0.12; % from forward end of booster body tube 
xcenteringring1     = 0;
xcenteringring2     = 0;
xcenteringring3     = 0;
xcenteringring4     = 0;

% Internal Electronics: Distances from Tip of Nose Cone
Dbattery       = Lnosecone + xbattery + Lbattery/2;      
Daltimeter     = Lnosecone + xaltimeter + Laltimeter/2;
DSEDSaltimeter = xSEDSaltimeter;
Dswitches      = Lnosecone + xswitch + Lswitch/2;

% Internal Components: Distances from Tip of Nose Cone
Ddrogueparachute    = xdrogueparachute;
Dmainparachute      = Lnosecone + xmainparachute + Lmainparachute/2;
Dboosterparachute   = Lnosecone + Lebay - Lshoulder + Lsustbodytube + xboosterparachute + Lboosterparachute/2 ;   
Dcenteringring      = 0;




%           ***RESUME EDITING HERE***





%% Masses
% Mass of Components (kg)
Mnosecone        = .063;
% Mshoulder        = .089;
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
Mtot    = Mboost + Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube + Maftfins; 
CG      =  (CGBoost + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins + Dstagingcoupler*Mstagingcoupler + Dsust*Msustinit + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins)./Mtot;   

plot(tb,CG)

ts     = linspace(0,Tsust,res);             % 1000 different times of flight from 0 to 1.4 seconds
Msust  = Msustinit - (Msustprop/Tsust)*ts;  % Mass of sustainer through flight
CGSust = Msust.*Dsust;                      % Center of Gravity of sustainer through flight
Mtot2  = Msust + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins;   % Total mass of sustainer through flight
CG2    = (CGSust+Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins)./Mtot2;


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


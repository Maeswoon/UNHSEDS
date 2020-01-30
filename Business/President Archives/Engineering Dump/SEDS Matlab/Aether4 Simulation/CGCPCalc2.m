% Calculated the CG, CP and plots the caliber of a 2 stage rocket

% Mass in kilograms (kg)
% Distance in meters (m)
% Time in seconds (s)


% Time Resolution
res = 1000;

% Booster and Sustainer Time Values
Tboost     = 1.3;   
Tsust      = 3.0;   

%% Lengths: In Meters (m)
% Main Components:
Lnosecone        = .240;  
Lshoulder        = .310;
Lebay            = .200;
Lsustbodytube    = .330; 
Lforwardfins     = .130;
Lstagingcoupler  = .135;
Lboosterbodytube = .448;
Laftfins         = .115;
Lboost           = .187;    
Lsust            = .187;

% Internal electronics (m)  
Lbattery       = 0.0265;      
%Laltimeter     = 0.0996;
%LSEDSaltimeter = 0.06985;
%Lswitch        = 0.01;

% Internal pieces (m)
Ldrogueparachute  = 0.04;
Lmainparachute    = 0.08;  
Lboosterparachute = 0.06;

% Coupler BodyTube Pieces
LcouplerBodyTubeEbay  = .025;  %(m)
LcouplerBodyTubeStage = .025;
% Motor Hang
sustmotorhang  = .0458;
boostmotorhang = .0359; 

%% Distances: Centroid Calculations from the Tip of Nosecone to the middle of the component


% Main Components: 
Dnosecone        = Lnosecone*.666;
Dshoulder        = Lnosecone + Lshoulder/2;
Debay            = Dshoulder + Lshoulder/2  + LcouplerBodyTubeEbay/2;
Dsustbodytube    = Debay + LcouplerBodyTubeEbay/2 + Lsustbodytube/2;
Dforwardfins     = Dsustbodytube + Lsustbodytube/2 - Lforwardfins/2 - .015;
Dstagingcoupler  = Dsustbodytube + Lsustbodytube/2 + LcouplerBodyTubeStage/2;
Dsust            = Dstagingcoupler - LcouplerBodyTubeStage/2 - Lsust/2 + sustmotorhang;
Dboosterbodytube = Dstagingcoupler + LcouplerBodyTubeStage/2 + Lboosterbodytube/2;
Daftfins         = Dstagingcoupler + LcouplerBodyTubeStage/2 + Lboosterbodytube - Laftfins/2 - .005;
Dboost           = Dstagingcoupler + LcouplerBodyTubeStage/2 + Lboosterbodytube - Lboost/2 + boostmotorhang; 

% Internal Components: Marks the beginning of the Component
xbattery            = 0.02;    % From forward of E-Bay Bulk Plate
%xaltimeter          = 0.03;    % From forward of E-Bay Bulk Plate
%xswitch             = 0.02;    % From forward of E-Bay Bulk Plate
%xSEDSaltimeter      = 0.22;    % From forward of Nosecone

xmainparachute       = 0.12;       % From forward Shoulder Forward
xdrogueparachute      = 0.10;    % From aft of E-Bay Bulk Plate
xboosterparachute     = 0.12 - .085;      % From aft of Coupler Bulk Plate

%xcenteringring1     = 0.25;   % From aft of Sustainer Body Tube (-)
%xcenteringring2     = 0.08;   % From aft of Sustainer Body Tube (-)
%xcenteringring3     = 0.01;   % From aft of Booster Body Tube (-)
%xcenteringring4     = 0.12;   % From aft of Booster Body Tube (-)

% Internal Electronics:
Dbattery       = Debay - Lebay/2 + xbattery + Lbattery/2;       % Offset from E-Bay Forward Bulk Plate 
%Daltimeter     = Lnosecone + xaltimeter + Laltimeter/2;   % Offset from E-Bay Forward Bulk Plate
%Dswitch        = Lnosecone + xswitch + Lswitch/2;         % Offset from E-Bay Forward Bulk Plate
%DSEDSaltimeter = xSEDSaltimeter + LSEDSaltimeter/2;       % Offset from Nose Cone Forward

% Recovery Components:

Ddrogueparachute    = Debay + Lebay/2 + xdrogueparachute + Ldrogueparachute/2 - .07;                                                                % Offset from Nosecone Forward
Dmainparachute      = Lnosecone + xmainparachute + Lmainparachute/2;                                                % Offset from E-bay Aft
Dboosterparachute   = Dstagingcoupler + LcouplerBodyTubeStage/2 + Lstagingcoupler/2 + xboosterparachute + Lboosterparachute/2;   % Offset from Staging Coupler Aft


% Engine Retainment:
%Dcenteringring1      = Dsustbodytube + Lsustbodytube/2 - xcenteringring1;       % Offset from Sustainer Body Tube Aft
%Dcenteringring2      = Dsustbodytube + Lsustbodytube/2 - xcenteringring2;       % Offset from Sustainer Body Tube Aft
%Dcenteringring3      = Dboosterbodytube + Lsustbodytube/2 - xcenteringring3;    % Offset from Booster Body Tube Aft
%Dcenteringring4      = Dboosterbodytube + Lsustbodytube/2 - xcenteringring4;    % Offset from Booster Body Tube Aft


%% Masses (kg)
% Mass of Components
Mnosecone        = .113;
Mshoulder        = .125;
Mebay            = .401; % With a payload of 4 bolts at 180 grams total

Msustbodytube    = .080;
Mforwardfins     = .030;
Mstagingcoupler  = .083;    
Mboosterbodytube = .114;    
Maftfins         = .030;   
Mboostinit       = .194 + .077;    % Initial mass of booster
Msustinit        = .198 + .081;    % Initial mass of sustainer 
Mboostprop       = .082;    % Mass of total propellant
Msustprop        = .087;    % Mass of total propellant


% Internal electronics (kg)  
Mbattery       = 0.045;      
Maltimeter     = 0.000;
MSEDSaltimeter = 0.000;
Mswitch        = 0.000;

% Internal pieces (kg)
Mdrogueparachute    = .025;
Mmainparachute      = .078;
Mboosterparachute   = .043;   

Mcenteringring      = 0;

%% Create a vector of values of the Center of Gravity through the entire flight

% Create array CG that follows the whole 
% rocket from launch till booster seperation

tb      = linspace(0,Tboost,res);             % 1000 different times of flight from 0 to .7 seconds
Mboost  = Mboostinit-(Mboostprop/Tboost)*tb;  % Mass of the booster during flight
CGBoost = Mboost.*Dboost;                     % Center of Gravity of booster during flight


Mtot    = Mboost + Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube...               % Total mass of sustainer and
    + Maftfins + Mbattery + Maltimeter + MSEDSaltimeter + Mswitch + Mdrogueparachute + Mboosterparachute + Mmainparachute + 4*Mcenteringring;     % booster through flight

CGboostsust      = (CGBoost + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...         % Center of gravity of entire rocket
        + Dstagingcoupler*Mstagingcoupler + Dsust*Msustinit + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins + Mbattery*Dbattery...        % through flight before seperation
        + Mdrogueparachute*Ddrogueparachute + Mboosterparachute*Dboosterparachute...
        + Mmainparachute*Dmainparachute)./Mtot;   

% Create vector CGsust that follows the sustainer after booster
% seperation until sustainer burnout when mass stops changing

ts      = linspace(0,Tsust,res);              % 1000 different times of flight from 0 to 1.4 seconds
Msust   = Msustinit - (Msustprop/Tsust)*ts;   % Mass of sustainer during flight
CGSust  = Msust.*Dsust;                       % Center of Gravity of sustainer during flight

Mtot2   = Msust + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mbattery + Maltimeter...                                 % Total mass of sustainer through flight
        + MSEDSaltimeter + Mswitch + Mdrogueparachute + Mmainparachute + 2*Mcenteringring;                                                % after booster seperation
              
CG2     = (CGSust + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Mbattery*Dbattery + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...  % Center of gravity of sustainer through flight
        + Mdrogueparachute*Ddrogueparachute + Mmainparachute*Dmainparachute)./Mtot2;   

%% CP (m) Calculate Center of Pressure of the entire rocket and after booster seperation

% Fin parameters
Cr  = .130;                             % Length of root chord   
Ct  = .015;                             % Length of tip chord 
Ss  = .050;                         % Length of semi-span 
Lf  = .055;                           % Length of mid-chord line
Xr  = .100;                             % Length of fin root lead to fin tip lead
Xb  = Dforwardfins - Lforwardfins/2;  % Length of nosecone tip to beginning of root chord

Rbodytube = .0574/2;     % Radius of Bodytube

cnn = 2;               % Co-efficient for the type of nose cone - conical
xn  = .466 * Lnosecone;  % Location of the center of pressure for a conical nose cone
cnt = 0;                 % Cnt would change if rocket diameter changed
xt  = 0;                 % Not applicable
nf  = 3;                 % Number of Fins

% Fin Calculations
x1=1.0+(Rbodytube/(Ss+Rbodytube));                                          % The following variables allow cnf, a coefficent, to be calculated
x2=4.0*nf*(Ss*Ss/(Rbodytube*Rbodytube*4));
x3a=2.0*Lf;
x3b=Cr+Ct;
x3=x3a/x3b;
x4=1.0+sqrt(1.0+x3^2);
cnf=x1*x2/x4;                                                               % A coefficient needed to find center of pressure
xf = (1.0/6.0)*(Cr+Ct-(Cr*Ct/(Cr+Ct)))+(Xr/3.0)*((Cr+2.0*Ct)/(Cr+Ct))+Xb;   % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
                                                                            % distance from the tip of the nose cone to the root chord of the fin
% Calculation for CP (sustainer)
cnr=cnn+cnt+cnf;
cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);   % Center of Pressure equation for a rocket 
                                     
                                   

%% Booster & Sustainer

% Fin Parameters
Cr2   = .115;                             % Length of root chord   
Ct2   = .060;                             % Length of tip chord 
Ss2   = .048;                             % Length of semi-span 
Lf2   = .050;                             % Length of mid-chord line
Xr2   = .045;                             % Length of fin root lead to fin tip lead

Xb2  = Daftfins - Laftfins/2 - .02;            % Length of nosecone tip to beginning of aft fins root chord

% Equations for CP (full rocket)
x12=1.0+(Rbodytube/(Ss2+Rbodytube));             % The following variables allow cnf, a coefficent, to be calculated
x22=4.0*nf*(Ss2*Ss2/(Rbodytube*Rbodytube*4)); 
x3a2=2.0*Lf2;
x3b2=Cr2+Ct2;
x32=x3a2/x3b2;
x42=1.0+sqrt(1.0+x32*x32);

cnf2=x12*x22/x42;                                                                         % A coefficient needed to find center of pressure
xf2 = (1.0/6.0)*(Cr2+Ct2-(Cr2*Ct2/(Cr2+Ct2)))+(Xr2/3.0)*((Cr2+2.0*Ct2)/(Cr2+Ct2))+Xb2;    % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
                                                                                          % distance from the tip of the nose cone to the root chord of the fin

% Calculation for CP (sustainer)
cnr2=cnn+cnt+cnf+cnf2;
cp2 = ((cnn*xn+cnt*xt+cnf*xf+cnf2*xf2)/cnr2);   % Center of Pressure equation for a rocket 

%%
% Plotting Caliber

%BoosterOpenRocket = 'CalOpenRocketBooster.csv';
%SustainerOpenRocket = 'CalOpenRocketSustainer.csv';



L  = 'linewidth';
D  = 'displayname';

figure;
cal1 = (cp2-CGboostsust)/(2*Rbodytube);
plot(tb,cal1,D,'Entire Rocket Stability Caliber',L,1)
cal2 = (cp-CG2)/(2*Rbodytube);
hold on
coast = .3;                                            % Coast period between seperation
ts      = linspace(Tboost+coast,Tsust+Tboost,res);     % 1000 different times of flight from 0 to 1.4 seconds
plot(ts,cal2,D,'Sustainer Stability Caliber',L,1) % Plot caliber through the flight
xlabel('Time (s)','fontsize',14)
ylabel('Caliber','fontsize',14)
title('In-Flight Stabilty')
legend('show')
axis([0 5 0 3])
grid minor


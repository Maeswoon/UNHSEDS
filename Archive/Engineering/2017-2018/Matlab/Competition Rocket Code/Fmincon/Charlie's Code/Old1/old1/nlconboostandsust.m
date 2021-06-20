function [c,ceq] = nlconboostandsust(x)
% for now this is only constraining for initial caliber before launch=1.5
Lebay=0.10;
Lboost=0.32;
Lsust=0.32;
Lbattery=0.04827;
Ldrogueparachute=0.04; %CHANGE
Lmainparachute=0.08; %CHANGE
Lboosterparachute=0.06; %CHANGE
LcouplerBodyTubeEbay=0.02;
LcouplerBodyTubeStage=0.02;

Dnosecone        = x(1)*.666; %CHANGE
Dshoulder        = x(1) + x(2)/2;
Debay            = Dshoulder + x(2)/2  + LcouplerBodyTubeEbay/2;
Dsustbodytube    = Debay + LcouplerBodyTubeEbay/2 + x(3)/2;
Dforwardfins     = Dsustbodytube + x(3)/2 - x(8)/2 - .015;
Dstagingcoupler  = Dsustbodytube + x(3)/2 + LcouplerBodyTubeStage/2;
Dsust            = Dstagingcoupler - LcouplerBodyTubeStage/2 - Lsust/2 + x(6);
Dboosterbodytube = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(5)/2;
Daftfins         = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(5) - x(12)/2 - .005;
Dboost           = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(5) - Lboost/2 + x(7);

xbattery            = 0.02;    % From forward of E-Bay Bulk Plate
xmainparachute       = 0.12;       % From forward Shoulder Forward
xdrogueparachute      = 0.10;    % From aft of E-Bay Bulk Plate
xboosterparachute     = 0.12 - .085;      % From aft of Coupler Bulk Plate
Dbattery       = Debay - Lebay/2 + xbattery + Lbattery/2;       % Offset from E-Bay Forward Bulk Plate 

Ddrogueparachute    = Debay + Lebay/2 + xdrogueparachute + Ldrogueparachute/2 - .07;                                                                % Offset from Nosecone Forward
Dmainparachute      = x(1) + xmainparachute + Lmainparachute/2;                                                % Offset from E-bay Aft
Dboosterparachute   = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(4)/2 + xboosterparachute + Lboosterparachute/2;   % Offset from Staging Coupler Aft
Diameter=.0574;
Thickness=.0016;
Rbodytube = Diameter/2;     % Radius of Bodytube
finthickness=.00321;
rhocf=1800; %kg/m3
rhobt=1120;
rhofg=1500;

Mnosecone        = .1;%(((pi/3)*((Rbodytube^2*x(1))-((Rbodytube-.01)^2*(x(1)-.01))))+pi*.05*(Rbodytube^2-(Rbodytube-Thickness)^2)*rhobt)*rhobt;%.113; %CHANGE
Mshoulder        = pi*x(2)*(Rbodytube^2-(Rbodytube-Thickness)^2)*rhobt;
Mebay            = .401; % With a payload of 4 bolts at 180 grams total
Msustbodytube    = pi*x(3)*(Rbodytube^2-(Rbodytube-Thickness)^2)*rhobt;%.080;
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
%for now we are optimizing for fixed initial caliber=1.5
%tb      = linspace(0,Tboost,res);             % 1000 different times of flight from 0 to .7 seconds
%Mboost  = Mboostinit-(Mboostprop/Tboost)*tb;  % Mass of the booster during flight
CGBoost = Mboostinit*Dboost;                     % Center of Gravity of booster during flight


Mtot    = Mboostinit + Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube...               % Total mass of sustainer and
    + Maftfins + Mbattery + Maltimeter + MSEDSaltimeter + Mswitch + Mdrogueparachute + Mboosterparachute + Mmainparachute + 4*Mcenteringring;     % booster through flight

CGboostsust      = (CGBoost + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...         % Center of gravity of entire rocket
        + Dstagingcoupler*Mstagingcoupler + Dsust*Msustinit + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins + Mbattery*Dbattery...        % through flight before seperation
        + Mdrogueparachute*Ddrogueparachute + Mboosterparachute*Dboosterparachute...
        + Mmainparachute*Dmainparachute)./Mtot;  
%Cp
Xb  = Dforwardfins - x(8)/2;  % Length of nosecone tip to beginning of root chord

cnn = 2;               % Co-efficient for all continious nosecones 
xn  = .666 * x(1);  % Location of the center of pressure for a ogive nose cone
cnt = 0;                 % Cnt would change if rocket diameter changed
xt  = 0;                 % Not applicable
nf  = 3;                 % Number of Fins    
Lf=sqrt(((x(8)/2)-(x(8)-x(11)-x(9)+(x(9)/2)))^2+(x(10))^2);
Lf2=sqrt(((x(12)/2)-(x(12)-x(15)-x(13)+(x(13)/2)))^2+(x(14))^2);
% Fin Calculations
x1=1.0+(Rbodytube/(x(10)+Rbodytube));                    % The following variables allow cnf, a coefficent, to be calculated
x2=4.0*nf*(x(10)*x(10)/(Rbodytube*Rbodytube*4));
x3a=2.0*Lf;
x3b=x(8)+x(9);
x3=x3a/x3b;
x4=1.0+sqrt(1.0+x3^2);
cnf=x1*x2/x4;                                                               % A coefficient needed to find center of pressure
xf = (1.0/6.0)*(x(8)+x(9)-(x(8)*x(9)/(x(8)+x(9))))+(x(11)/3.0)*((x(8)+2.0*x(9))/(x(8)+x(9)))+Xb;   % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
                                                                            % distance from the tip of the nose cone to the root chord of the fin

%cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);   % Center of Pressure equation for just sustainer 
    
%boost
Xb2  = Daftfins - x(12)/2 - .02;            % Length of nosecone tip to beginning of aft fins root chord

% Equations for CP (full rocket)
x12=1.0+(Rbodytube/(x(14)+Rbodytube));             % The following variables allow cnf, a coefficent, to be calculated
x22=4.0*nf*(x(14)*x(14)/(Rbodytube*Rbodytube*4)); 
x3a2=2.0*Lf2;
x3b2=x(12)+x(13);
x32=x3a2/x3b2;
x42=1.0+sqrt(1.0+x32*x32);

cnf2=x12*x22/x42;                                                                         % A coefficient needed to find center of pressure
xf2 = (1.0/6.0)*(x(12)+x(13)-(x(12)*x(13)/(x(12)+x(13))))+(x(15)/3.0)*((x(12)+2.0*x(13))/(x(12)+x(13)))+Xb2;    % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
   
% Calculation for CP 
cnr2=cnn+cnt+cnf+cnf2;
cp2 = ((cnn*xn+cnt*xt+cnf*xf+cnf2*xf2)/cnr2);   % Center of Pressure equation for a rocket 


c=[];%1.5-((cp2-CGboostsust)/(2*Rbodytube));
ceq=1.5-((cp2-CGboostsust)/(2*Rbodytube));
end


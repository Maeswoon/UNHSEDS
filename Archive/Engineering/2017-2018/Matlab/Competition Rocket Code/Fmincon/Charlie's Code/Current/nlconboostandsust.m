function [c,ceq] = nlconboostandsust(x)
% Constrains only the initial caliber of launch

Lebay                 = 0.10;
Lboost                = 0.32;
Lsust                 = 0.32;
Ldrogueparachute      = 0.04; 
Lmainparachute        = 0.08; 
Lboosterparachute     = 0.06; 
LcouplerBodyTubeEbay  = 0.02;
LcouplerBodyTubeStage = 0.02;

Dnosecone        = x(1)*.666; % Must change for Von Nose Cone
Dshoulder        = x(1) + x(2)/2;
Debay            = Dshoulder + x(2)/2  + LcouplerBodyTubeEbay/2;
Dsustbodytube    = Debay + LcouplerBodyTubeEbay/2 + x(3)/2;
Dforwardfins     = Dsustbodytube + x(3)/2 - x(8)/2;
Dstagingcoupler  = Dsustbodytube + x(3)/2 + LcouplerBodyTubeStage/2;
Dsust            = Dstagingcoupler - LcouplerBodyTubeStage/2 - Lsust/2 + x(6);
Dboosterbodytube = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(5)/2;
Daftfins         = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(5) - x(12)/2;
Dboost           = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(5) - Lboost/2 + x(7);


xmainparachute       = 0.12;       % From forward Shoulder Forward
xdrogueparachute      = 0.10;    % From aft of E-Bay Bulk Plate
xboosterparachute     = 0.12 - .085;      % From aft of Coupler Bulk Plate


Ddrogueparachute    = Debay + Lebay/2 + xdrogueparachute + Ldrogueparachute/2 - .07;                                                                % Offset from Nosecone Forward
Dmainparachute      = x(1) + xmainparachute + Lmainparachute/2;                                                % Offset from E-bay Aft
Dboosterparachute   = Dstagingcoupler + LcouplerBodyTubeStage/2 + x(4)/2 + xboosterparachute + Lboosterparachute/2;   % Offset from Staging Coupler Aft

Diameter=.0473;
Rbodytube = Diameter/2;     % Radius of Bodytube
%rhocf=1800; %kg/m3
%rhobt=1120;
%rhofg=1500;

BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts



Mnosecone                = .150;
Mshoulder                = x(2)*BT;
Mebay                    = .400; % Whole E-Bay, Must find Value
Msustbodytube            = x(3)*BT;
Mforwardfins             = PL * .5* Cr*Ct*Ss;
Mstagingcoupler          = CP*.1;    
Mboosterbodytube         = x(5) * BT;
Maftfins                 = PL * .5*Cr2*Ct2*Ss2; 
Msustcasingtuberetainer  = .110 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .110 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Mboostinit               = .294;                    % Initial mass of booster
Msustinit                = .349;                    % Initial mass of sustainer 

Mdrogueparachute         = .024;
Mmainparachute           = .071;
Mboosterparachute        = .036;

Mcenteringring           = 0;                       % Do we want to add this?


CGBoost = Mboostinit*Dboost;                   % Center of Gravity of booster during flight
CGSust  = Msustinit*Dsust;

Mtot    = Mboostinit + Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube...               % Total mass of sustainer and
    + Maftfins + Msustcasingtuberetainer + Mboostcasingtuberetainer + Mdrogueparachute + Mboosterparachute + Mmainparachute + 4*Mcenteringring;     % booster through flight

CGboostsust      = (CGBoost + CGSust + Dnosecone*Mnosecone + Dshoulder*Mshoulder + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...         % Center of gravity of entire rocket
        + Dstagingcoupler*Mstagingcoupler + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins...        % through flight before seperation
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


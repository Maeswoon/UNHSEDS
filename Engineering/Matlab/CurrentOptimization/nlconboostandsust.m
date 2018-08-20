function [c,ceq] = nlconboostandsust(x,Aether)
% for now this is only constraining for initial caliber before launch=1.5

Lboosterparachute     =0.06;
Ldrogueparachute      =0.04;
Lmainparachute        =0.08;

Dnosecone        = x(1)*.666; % Must calculate CG for our custom part... 
Debay            = x(1) + + x(2)  + Aether.EbayCoupler.length/2;
Debay            = x(1) + x(2)  + Aether.EbayCoupler.length/2;
Dsustbodytube    = Debay + Aether.EbayCoupler.length/2 + x(3)/2;
Dforwardfins     = Dsustbodytube + x(3)/2 - x(8)/2 ;  
Dstagingcoupler  = Dsustbodytube + x(3)/2 + Aether.StagingCoupler.length/2;
Dsust            = Dstagingcoupler - Aether.StagingCoupler.length/2 - Aether.SustainerMotor.length/2 + x(6);
Dboosterbodytube = Dstagingcoupler + Aether.StagingCoupler.length/2 + x(5)/2;
Daftfins         = Dstagingcoupler + Aether.StagingCoupler.length/2 + x(5) - x(12)/2;
Dboost           = Dstagingcoupler + Aether.StagingCoupler.length/2 + x(5) - Aether.BoosterMotor.length/2 + x(7);
Dstagingcoupler  = Dsustbodytube + x(3)/2 + x(11)/2;
Dsust            = Dstagingcoupler - x(11)/2 - Aether.SustainerMotor.length/2 + x(6);
Dboosterbodytube = Dstagingcoupler + x(11)/2 + x(5)/2;
Daftfins         = Dstagingcoupler + x(11)/2 + x(5) - x(12)/2;
Dboost           = Dstagingcoupler + x(11)/2 + x(5) - Aether.BoosterMotor.length/2 + x(7);

% Parachute Placements
xmainparachute        = 0.12;    % From forward Shoulder Forward
xdrogueparachute      = 0.10;    % From aft of E-Bay Bulk Plate
xboosterparachute     = 0.12;    % From aft of Coupler Bulk Plate

Ddrogueparachute    = Debay + Aether.EbayCoupler.length/2 + xdrogueparachute + Ldrogueparachute/2;                                       % Offset from Nosecone Forward
Dmainparachute      = x(1) + xmainparachute + Lmainparachute/2;                                                      % Offset from E-bay Aft
Dboosterparachute   = Dstagingcoupler + Aether.StagingCoupler.length/2 + x(4)/2 + xboosterparachute + Lboosterparachute/2;  % Offset from Staging Coupler Aft
Dboosterparachute   = Dstagingcoupler + x(11)/2 + x(4)/2 + xboosterparachute + Lboosterparachute/2;  % Offset from Staging Coupler Aft
Diameter=Aether.SustainerBodytube.OD;  
Rbodytube = Diameter/2;     % Radius of Bodytube

% Linear Weights
PL = 4.882; % 4882 grams per square meter for Plate Parts
BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube, NOT NEEDED - Estimated


Maftfins         = PL * .5*x(12)*x(13)*x(14); 
Mforwardfins     = PL * .5*x(8)*x(9)*x(10);
Mnosecone        = .200;   % Needs to be accuratly estimated with shoulder factored in
Mebay            = Aether.Electronics.mass;   % Constant that needs to be measured when built
Msustbodytube    = x(5)*BT;
Mstagingcoupler  = .08 * CP;    
Mboosterbodytube = x(12) * BT;    
Mboostinit       = .294 + .110 + ET*.35;   % Initial mass of booster plus casing and tube
Msustinit        = .349 + .125 + ET*.35;   % Initial mass of sustainer plus casing and tube

% Internal pieces (kg)
Mdrogueparachute    = .025;    % MEASURE THESE 
Mmainparachute      = .078;
Mboosterparachute   = .043;   


%for now we are constraining to a fixed initial caliber=1.5
CGBoost = Mboostinit*Dboost;             % Center of Gravity of booster during flight

Mtot    = Mboostinit + Msustinit + Mnosecone + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube...    % Total mass of sustainer and
Mtot    = Mboostinit + Msustinit + Aether.Nosecone.mass + Aether.Electronics.mass + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube...    % Total mass of sustainer and
    + Maftfins + Mdrogueparachute + Mboosterparachute + Mmainparachute;     % booster through flight

CGboostsust      = (CGBoost + Dnosecone*Mnosecone + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...   % Center of gravity of entire rocket
CGboostsust      = (CGBoost + Dnosecone*Aether.Nosecone.mass + Debay*Aether.Electronics.mass + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...   % Center of gravity of entire rocket
        + Dstagingcoupler*Mstagingcoupler + Dsust*Msustinit + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins ...        % through flight before seperation
        + Mdrogueparachute*Ddrogueparachute + Mboosterparachute*Dboosterparachute + Mmainparachute*Dmainparachute)./Mtot;  
%Cp
Xb  = Dforwardfins - x(8)/2;  % Length of nosecone tip to beginning of root chord

cnn = 2;                 % Co-efficient for all continious nosecones 
xn  = .666 * x(1);       % Location of the center of pressure for a ogive nose cone
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
c=[];
ceq=1.5-((cp2-CGboostsust)/(2*Rbodytube));
end


function [c,ceq] = nlconboostandsust(x,Aether)
% for now this is only constraining for initial caliber before launch=1.5


Dnosecone        = x(1)*.666; % Estimate with electronics and shoulder
Dforwardcoupler  = x(1) + x(2)  + Aether.ForwardCoupler.lipLength/2;
Dsustbodytube    = Dforwardcoupler + Aether.ForwardCoupler.lipLength/2 + x(3)/2;
Dforwardfins     = Dsustbodytube + x(3)/2 - x(4)/2 ;  
Dstagingcoupler  = Dsustbodytube + x(3)/2 + Aether.AftCoupler.lipLength/2;
Dsust            = Dstagingcoupler - Aether.AftCoupler.lipLength/2 + x(8) - Aether.SustainerMotor.length/2 ;
Dboosterbodytube = Dstagingcoupler + Aether.AftCoupler.lipLength/2 + x(9)/2;
Daftfins         = Dboosterbodytube + x(9)/2 - x(10)/2;
Dboost           = Dboosterbodytube + x(9)/2 + x(14) - Aether.BoosterMotor.length ;


% Parachute Placements
Ldrogueparachute      =0.04;
Lmainparachute        =0.08;
Lboosterparachute     =0.06;
xmainparachute        = 0.05;    % From forward sustainer body tube
xdrogueparachute      = 0.02;    % From middle of forward coupler
xboosterparachute     = 0.05;    %
Ddrogueparachute    = Dforwardcoupler + xdrogueparachute + Ldrogueparachute/2;   % From the middle of forward coupler                                  
Dmainparachute      = Dsustbodytube -  x(3)/2 + xmainparachute +Lmainparachute/2;% From the forward of sustainer body tube                                             
Dboosterparachute   = Dstagingcoupler + Aether.AftCoupler.length/2 + xboosterparachute + Lboosterparachute/2;  % From aft of staging coupler


Diameter=Aether.SustainerBodytube.OD;  
Rbodytube = Diameter/2;     % Radius of Bodytube

% Linear Weights for CF
BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts


Msustcoupler             = Aether.ForwardCoupler.length * CP + Aether.ForwardCoupler.lipLength * BT;  % Whole E-Bay, Must find Value
Msustbodytube            = x(3) * BT;
Mforwardfins             = PL * .5*x(4)*x(6) * 3;
Msustcasingtuberetainer  = .120 + ET*.3; % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .120 + ET*.3; % Mass of the Engine Casing, Engine Tube and Retainer
Mstagingcoupler          = Aether.AftCoupler.length * CP;
Mboosterbodytube         = x(9) * BT;    
Maftfins                 = PL * .5*x(10)*x(12) * 3; 

% Parachutes
Mdrogueparachute         = .030; % Guesses, but good enough.
Mmainparachute           = .070;
Mboosterparachute        = .050;



Mtot   = Aether.SustainerMotor.mass + Msustcasingtuberetainer + Aether.Nosecone.mass...
    + Msustcoupler + Msustbodytube + Mforwardfins + Mdrogueparachute + Mmainparachute...
    + Mstagingcoupler + Mboosterbodytube + Aether.BoosterMotor.mass + Mboostcasingtuberetainer + Maftfins + Mboosterparachute;
              
CGboostsust     = ((Aether.SustainerMotor.mass + Msustcasingtuberetainer)*Dsust + Dnosecone*Aether.Nosecone.mass + Dforwardcoupler*Msustcoupler + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...  % Center of gravity of sustainer through flight
        + Mdrogueparachute*Ddrogueparachute + Mmainparachute*Dmainparachute + (Aether.BoosterMotor.mass + Mboostcasingtuberetainer)*Dboost + Mstagingcoupler*Dstagingcoupler + Mboosterbodytube*Dboosterbodytube...
        + Maftfins * Daftfins + Mboosterparachute*Dboosterparachute)./Mtot;   

    

%Cp
Xb  = Dforwardfins - x(4)/2;  % Length of nosecone tip to beginning of root chord

cnn = 2;                 % Co-efficient for all continious nosecones 
xn  = .666 * x(1);       % Location of the center of pressure for a ogive nose cone
cnt = 0;                 % Cnt would change if rocket diameter changed
xt  = 0;                 % Not applicable
nf  = 3;                 % Number of Fins    
Lf =sqrt(((x(4)/2)-(x(4)-x(7)-x(5)+(x(5)/2)))^2+(x(6))^2);
Lf2=sqrt(((x(10)/2)-(x(10)-x(13)-x(11)+(x(11)/2)))^2+(x(12))^2);
% Fin Calculations for Sustainer
x1=1.0+(Rbodytube/(x(6)+Rbodytube));                    % The following variables allow cnf, a coefficent, to be calculated
x2=4.0*nf*(x(6)*x(6)/(Rbodytube*Rbodytube*4));
x3a=2.0*Lf;
x3b=x(4)+x(5);
x3=x3a/x3b;
x4=1.0+sqrt(1.0+x3^2);
cnf=x1*x2/x4;                                                               % A coefficient needed to find center of pressure
xf = (1.0/6.0)*(x(4)+x(5)-(x(4)*x(5)/(x(4)+x(5))))+(x(7)/3.0)*((x(4)+2.0*x(5))/(x(4)+x(5)))+Xb;   % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
                                                                            % distance from the tip of the nose cone to the root chord of the fin

%cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);   % Center of Pressure equation for just sustainer 
    
%boost
Xb2  = Daftfins - x(10)/2;            % Length of nosecone tip to beginning of aft fins root chord

% Fin calculation for booster
x12=1.0+(Rbodytube/(x(12)+Rbodytube));             % The following variables allow cnf, a coefficent, to be calculated
x22=4.0*nf*(x(12)*x(12)/(Rbodytube*Rbodytube*4)); 
x3a2=2.0*Lf2;
x3b2=x(10)+x(11);
x32=x3a2/x3b2;
x42=1.0+sqrt(1.0+x32*x32);

cnf2=x12*x22/x42;                                                                         % A coefficient needed to find center of pressure
xf2 = (1.0/6.0)*(x(10)+x(11)-(x(10)*x(11)/(x(10)+x(11))))+(x(13)/3.0)*((x(10)+2.0*x(11))/(x(10)+x(11)))+Xb2;    % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
   
% Calculation for CP with booster and sustainer
cnr2=cnn+cnt+cnf+cnf2;
cp2 = ((cnn*xn+cnt*xt+cnf*xf+cnf2*xf2)/cnr2);   % Center of Pressure equation for a rocket 


c=[];
ceq=1.5-((cp2-CGboostsust)/(2*Rbodytube));
end


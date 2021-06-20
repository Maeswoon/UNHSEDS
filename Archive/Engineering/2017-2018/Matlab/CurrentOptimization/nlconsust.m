function [c,ceq] = nlconsust(x,Aether)
% for now this is only constraining for initial caliber before launch=1.5

Ldrogueparachute      =0.04;
Lmainparachute        =0.08;

Dnosecone        = x(1)*.666; % For nosecone and Shoulder, estimate
Dforwardcoupler  = x(1) + Aether.Nosecone.ShoulderLength+ Aether.ForwardCoupler.lipLength/2;
Dsustbodytube    = Dforwardcoupler + Aether.ForwardCoupler.lipLength/2 + x(3)/2;
Dforwardfins     = Dsustbodytube + x(3)/2 - x(4)/2 ;  
Dstagingcoupler  = Dsustbodytube + x(3)/2 + Aether.AftCoupler.lipLength/2;
Dsust            = Dstagingcoupler - Aether.AftCoupler.lipLength/2 + x(8) - Aether.SustainerMotor.length/2 ;

% Parachute Placements
xmainparachute        = 0.02;    % From forward sustainer body tube
xdrogueparachute      = 0.05;    % From middle of forward coupler

Ddrogueparachute    = Dforwardcoupler + xdrogueparachute + Ldrogueparachute/2;         
Dmainparachute      = Dsustbodytube -  x(3)/2 + xmainparachute +Lmainparachute/2;                                              
Diameter=Aether.SustainerBodytube.OD;  
Rbodytube = Diameter/2;     % Radius of Bodytube

% Linear Weights for CF
BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts


Mforwardcoupler             = Aether.ForwardCoupler.length * CP + Aether.ForwardCoupler.lipLength * BT;  % Whole E-Bay, Must find Value
Msustbodytube            = x(3) * BT;
Mforwardfins             = PL * x(4)*x(6) * 3;
Msustcasingtuberetainer  = .120 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer

Mdrogueparachute         = .030; % Guesses, but good enough.
Mmainparachute           = .070;


% CG calculations

Mtot   = Aether.SustainerMotor.mass + Msustcasingtuberetainer + Aether.Nosecone.mass...
    + Mforwardcoupler + Msustbodytube + Mforwardfins + Mdrogueparachute + Mmainparachute;
              
CG2     = ((Aether.SustainerMotor.mass + Msustcasingtuberetainer)*Dsust + Dnosecone*Aether.Nosecone.mass + Dforwardcoupler*Mforwardcoupler + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins...  % Center of gravity of sustainer through flight
        + Mdrogueparachute*Ddrogueparachute + Mmainparachute*Dmainparachute)./Mtot;   
%Cp
Xb  = Dforwardfins - x(4)/2;  % Length of nosecone tip to beginning of root chord

cnn = 2;             % Co-efficient for the type of nose cone 
xn  = x(1)*.666;     % Location of the center of pressure, estimate for Von
cnt = 0;             % Cnt would change if rocket diameter changed
xt  = 0;             % Not applicable
nf  = 3;             % Number of Fins    
Lf=sqrt(((x(4)/2)-(x(4)-x(7)-x(5)+(x(5)/2)))^2+(x(6))^2);

% Fin Calculations
x1=1.0+(Rbodytube/(x(6)+Rbodytube));                                          % The following variables allow cnf, a coefficent, to be calculated
x2=4.0*nf*(x(6)*x(6)/(Rbodytube*Rbodytube*4));
x3a=2.0*Lf;
x3b=x(4)+x(5);
x3=x3a/x3b;
x4=1.0+sqrt(1.0+x3^2);
cnf=x1*x2/x4;                                                               % A coefficient needed to find center of pressure
xf = (1.0/6.0)*(x(4)+x(5)-(x(4)*x(5)/(x(4)+x(5))))+(x(7)/3.0)*((x(4)+2.0*x(5))/(x(4)+x(5)))+Xb;   % cnf and xf are coefficeints that take the parameters of the fins. and factors in the 
                                                                            % distance from the tip of the nose cone to the root chord of the fin
% Calculation for CP (sustainer)
cnr=cnn+cnt+cnf; %for just sustainer
cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);   % Center of Pressure equation for just sustainer 

c=[];%1.5-((cp2-CGboostsust)/(2*Rbodytube));
ceq=1.5-((cp-CG2)/(2*Rbodytube));
end
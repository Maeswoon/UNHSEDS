% Parameters (These are all dummy variables)   %NEED TO MAKE BOOSTER NOT
% LOSE ALL MASS

res=1000; % timestep resolution


% Distance is from tip of Nose Cone
% Mass in kg
% Distance in meters
% Time in Seconds

% Lengths (cm)
Lnosecone        = .458; 
Lforwardbodytube = .282;
Lebay            = .208;
Lsustbodytube    = .546; 
Lforwardfins      = .20;
Lstagingcoupler  = .20;
Lboosterbodytube = .635;
Laftfins         = .11;
Lboost           = .32;    
Lsust            = .32;

%Distance from Nose Cone (Never have to Change)
Dnosecone        = Lnosecone*.666; 
Dforwardbodytube = Lnosecone + Lforwardbodytube/2;
Debay            = Dforwardbodytube +Lforwardbodytube/2;
Dsustbodytube    = Debay + Lsustbodytube/2; 
Dforwardfins     = Debay + Lsustbodytube - Lforwardfins/2;   
Dstagingcoupler  = Dforwardfins + Lforwardfins/2;
Dsust            = Dstagingcoupler - Lsust/2;
Dboosterbodytube = Dstagingcoupler + Lforwardbodytube/2;
Daftfins         = Dstagingcoupler + Lboosterbodytube - Laftfins/2;
Dboost           = Dstagingcoupler + Lboosterbodytube - Lboost/2; 

% Booster and Sustainer Time Values

Tboost     = .7;   
Tsust      = 1.7;   



% Mass of Components (kg)
Mnosecone        = .082; 
Mforwardbodytube = .107;
Mebay            = .120;
Msustbodytube    = .142; 
Mforwardfins     = .104;
Mstagingcoupler  = .036;
Mboosterbodytube = .165;
Maftfins         = .084; 
Mboostinit       = .294;    % Initial mass of booster
Msustinit        = .349;    % Initial mass of sustainer 
Mboostprop       = .132;
Msustprop        = .185;



tb      = linspace(0,Tboost,res); % 1000 different times of flight from 0 to .7 seconds
Mboost  = Mboostinit-(Mboostprop/Tboost)*tb; % Mass of the booster during flight
CGBoost = Mboost.*Dboost;
Mtot    = Mboost + Msustinit + Mnosecone + Mforwardbodytube + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube + Maftfins; 
CG      =  (CGBoost + Dnosecone*Mnosecone + Dforwardbodytube*Mforwardbodytube + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins + Dstagingcoupler*Mstagingcoupler + Dsust*Msustinit + Dboosterbodytube*Mboosterbodytube + Daftfins*Maftfins)./Mtot;   
plot(tb,CG)

ts     = linspace(0,Tsust,res);  % 1000 different times of flight from 0 to 1.4 seconds
Msust  = Msustinit - (Msustprop/Tsust)*ts;
CGSust = Msust.*Dsust;
Mtot2  = Msust + Mnosecone + Mforwardbodytube + Mebay + Msustbodytube + Mforwardfins; 
CG2    =  (CGSust+Dnosecone*Mnosecone + Dforwardbodytube*Mforwardbodytube + Debay*Mebay + Dsustbodytube*Msustbodytube + Dforwardfins*Mforwardfins)./Mtot2;   


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

Rbodytube = .02352; 

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

% Calculation for CP

cnr=cnn+cnt+cnf;
cp = ((cnn*xn+cnt*xt+cnf*xf)/cnr);


%% Booster

% Fin Parameters
Cr2  = .11;   %Lrootchord   
Ct2  = .05;   %Ltipchord 
Ss2  = .053;  %Lsemispan 
Lf2  = .053;   %Lmidchordline
Xr2  = .03;   %Lfinrootleadtofintiplead
Xb2  = Daftfins - Laftfins/2;

% Equations for CP
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


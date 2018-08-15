function [out,history,searchdir] = Fmincon
%All units are SI unless otherwise stated
%We have to be careful with the constant we give the parameters. We cant lose
%track that the engine mass doesnt include the casing, retainer etc... 
%We need to make sure that we arent losing mass and miscalculating CG CP.
%You might be handling this, but passing in new values might screw the functions previously made.
%We also have to change some of the constants used in get mass because things will be heavier and lighter
%then the Aether models we were doing last year.

Aether.Nosecone.material='CarbonFiber';
Aether.Nosecone.dims= [struct('dimName',"Length",        'lowBound',0.1,'initGuess',0.2,'upBound',0.3),...%1
               struct('dimName',"ShoulderLength",'lowBound',0.04,'initGuess',0.05,'upBound',0.1)];  %2
           
Aether.EbayCoupler.material='CarbonFiber';
Aether.EbayCoupler.length=0.05; %(lip length)Check
Aether.EbayCoupler.dims=struct('dimName',"Length",'lowBound',0.1,'initGuess',0.2,'upBound',0.3);    %3

Aether.Electronics.mass=0.200;  %this mass is a complete guess
Aether.Electronics.material='Plastic'; %this is a filler
Aether.Electronics.dims=struct('dimName',"CruiseTime",'lowBound',0.1,'initGuess',1.0,'upBound',2);     %4

Aether.SustainerBodytube.OD=.0474;
Aether.SustainerBodytube.material='CarbonFiber';
Aether.SustainerBodytube.dims= struct('dimName',"Length",'lowBound',0.4,'initGuess',0.55,'upBound',0.7);    %5

Aether.SustainerFins.material='Aluminum';
Aether.SustainerFins.dims=[struct('dimName',"RootChord",  'lowBound',0.04,'initGuess',0.06,'upBound',0.12),...%6
              struct('dimName',"TipChord",   'lowBound',0.03,'initGuess',0.05,'upBound',0.1),...%7
              struct('dimName',"SemiSpan",   'lowBound',0.03,'initGuess',0.05,'upBound',0.1),...%8
              struct('dimName',"SweepLength",'lowBound',0.00,'initGuess',0.05,'upBound',0.1)];  %9

Aether.SustainerMotor.material='I204';
Aether.SustainerMotor.mass=0.349;
Aether.SustainerMotor.length=0.32; %CHECK
Aether.SustainerMotor.burnTime=1.7;
Aether.SustainerMotor.dims=struct('dimName',"Overhang",'lowBound',0,'initGuess',0.015,'upBound',0.03);    %10

Aether.StagingCoupler.material='CarbonFiber';
Aether.StagingCoupler.length=0.05; %Check (lip length)
Aether.StagingCoupler.dims= struct('dimName',"Length",'lowBound',0.06,'initGuess',0.1,'upBound',0.14);   %11

Aether.BoosterBodytube.material='CarbonFiber';
Aether.BoosterBodytube.OD=.0474;
Aether.BoosterBodytube.dims=struct('dimName',"Length",'lowBound',0.49,'initGuess',0.5,'upBound',0.7);      %12

Aether.BoosterFins.material='Aluminum';
Aether.BoosterFins.dims=[struct('dimName',"RootChord",  'lowBound',0.04,'initGuess',0.06,'upBound',0.12),...%13
              struct('dimName',"TipChord",   'lowBound',0.03,'initGuess',0.05,'upBound',0.1),...%14
              struct('dimName',"SemiSpan",   'lowBound',0.03,'initGuess',0.05,'upBound',0.1),...%15
              struct('dimName',"SweepLength",'lowBound',0.00,'initGuess',0.05,'upBound',0.1)];  %16

Aether.BoosterMotor.material='H340';
Aether.BoosterMotor.mass=0.391;
Aether.BoosterMotor.length=0.32; %CHECK
Aether.BoosterMotor.burnTime=0.9;
Aether.BoosterMotor.dims=struct('dimName',"Overhang",'lowBound',0,'initGuess',0.015,'upBound',0.03);  %17
lbCount=1;
x0Count=1;
ubCount=1;
dNamesCount=1;
fn=fieldnames(Aether);

for i = 1:numel(fn)
  for j=1:length(Aether.(fn{i}).dims)
        lb(lbCount)=Aether.(fn{i}).dims(j).lowBound;
        lbCount=lbCount+1;
        x0(x0Count)=Aether.(fn{i}).dims(j).initGuess;
        x0Count=x0Count+1;
        ub(ubCount)=Aether.(fn{i}).dims(j).upBound;
        ubCount=ubCount+1;
        dNames(dNamesCount)=strcat(fn{i},Aether.(fn{i}).dims(j).dimName);
        dNamesCount=dNamesCount+1;
  end
end

cfDensity=1800;  %1.75-2.00 g/cm3
fgDensity=2550;  %2.55-2.68 g/cm3
alDensity=2700;

for i=1:length(fn)
    if strcmp(Aether.(fn{i}).material,'CarbonFiber')
        Aether.(fn{i}).density=cfDensity;
    elseif strcmp(Aether.(fn{i}).material,'FiberGlass')
        Aether.(fn{i}).density=fgDensity;
    elseif strcmp(Aether.(fn{i}).material,'Aluminum')
        Aether.(fn{i}).density=alDensity;
    end
end

%{
D  = [0.1,   0.24,   0.3 ;  %1 Length of the nosecone
      0.1,   0.31,   0.7 ;  %2 Length of the shoulder
      0.45,  0.46,   0.7 ;  %3 Length of the sustainer bodytube
      0.02,  0.135, 0.5 ;   %4 Length of the staging coupler
      0.49,  0.50,   0.7 ;  %5 Length of the booster bodytube
      0,     0.002,  0.01;  %6 Length of the sustainer motorhang
      0,     0.0359, 0.07;  %7 Length of the booster motorhang
      0.04,  0.13,   0.2 ;  %8 Fin Root Chord, Cr
      0.005, 0.015,  0.2 ;  %9 Fin Tip Chord, Ct
      0.02,  0.05,   2   ;  %10 Fin Semi-Span, Height, Ss
      0.01,  0.1,    0.2 ;  %11 Fin Root Leading Edge to Fin Tip Leading Edge,Xr 
      0.04,  0.115,  0.2 ;  %12 Fin Root Chord, Cr2, Booster
      0.005, 0.06,   0.2 ;  %13 Fin Tip Chord, Ct2, Booster
      0.02,  0.048   0.2 ;  %14 Fin Semi-Span, Height, Ss2, Booster
      0.01,  0.045,  0.2 ;  %15 Fin Root Leading Edge to Fin Tip Leading Edge, Xr2, Booster
      0.1,   1,      2   ;  %16 Cruise Time
      ];
%}
  
% Set up shared variables with OUTFUN
history.x = [];
history.fval = [];
searchdir = [];
fstore= [];
% call optimization

options=optimoptions(@fmincon,'OutputFcn',@outfun);

A=[];
b=[];
Aeq=[];
beq=[];
it=0;
fun=@FminLaunchSimulation;

nonlincon=@supernonlincon;

[xsol,fsol,exitflag,output]= fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlincon,options);
%I made this a nested function so I can pass through more variables than
%just x
    function [oneoverh,tx,height] = FminLaunchSimulation(x)

    % ~ AETHER Launch Simulation ~

    L  = 'linewidth';
    D  = 'displayname';
    a  = 0;
    v  = 0;             % initial velocity
    h  = 0.5;           % initial height
    d  = 0;             % initial drag
    sf = 0;             % initial skin friction drag
    pd = 0;             % initial pressure drag
    bd = 0;             % initial base drag
    tstart      = 0;    % start time
    dt          = 0.1; % time step
    tstop       = 160;  % endtime

    %Initial Vectors (Maybe contain these in the structure? might reduce
    %speed though)
    height       = []; % Sustainer height
    velocity     = []; % Sustainer velocity
    acceleration = []; % Sustainer acceleration
    drag         = []; % Sustainer drag
    sfd          = []; % Skin Friction Drag
    pressured    = []; % Pressure Drag
    based        = []; % Base Drag
    tx           = []; % Used to keep track of time

    for t = tstart:dt:tstop

        height(end + 1)       = h;
        velocity(end + 1)     = v;
        acceleration(end + 1) = a;
        drag(end + 1)         = d;
        sfd(end + 1)          = sf;
        pressured(end + 1)    = pd;
        based(end + 1)        = bd;
        tx(end + 1)            = t;
        [a, d] = FminGetAcceleration(t,v,h,x,Aether); % get current acceleration
        v = v + dt*a ; % update velocity
        h = h + dt*v ; % update height

        if h < 0
            break
        end
    end

    oneoverh=1/max(height);


    end
    function [c,ceq] = supernonlincon(x)
    [c1, ceq1] = nlconboostandsust(x,Aether);
    [c2, ceq2] = nlconsust(x,Aether);
    c = [c1; c2];
    ceq = [ceq1; ceq2];
    end

 function stop = outfun(x,optimValues,state)
     stop = false;
 
     switch state
         case 'init'
             hold on
         case 'iter'
           it=it+1;
           x1s(it)=x(1);
           x2s(it)=x(2);
           x3s(it)=x(3);
           x4s(it)=x(4);
           x5s(it)=x(5);
           x6s(it)=x(6);
           x7s(it)=x(7);
           x8s(it)=x(8);
           x9s(it)=x(9);
           x10s(it)=x(10);
           x11s(it)=x(11);
           x12s(it)=x(12);
           x13s(it)=x(13);
           x14s(it)=x(14);
           x15s(it)=x(15);
           fstore(it)=1./optimValues.fval;
         case 'done'
             hold off
         otherwise
     end
 end
itstore=[1:it];
color1=[0 .6 0];
color2=[1 .35 .05];
color3=[.7 0 .7];
set(groot,'DefaultLineLineWidth',1.25)
plot(itstore,x1s./xsol(1),'b')
set(gca,'FontSize',14)

hold on
plot(itstore,x3s./xsol(3),'Color',color2);
plot(itstore,x4s./xsol(4),'k');
plot(itstore,x8s./xsol(8),'Color',color3);
plot(itstore,x12s./xsol(12),'Color',color1);
plot(0,1,'r:','LineWidth',4);
plot(it,1,'kx')
%text(102.35,1.12,'\downarrow','Fontsize',13,'fontweight','bold')
%text(102.35,1.24,'Convergence','fontweight','bold')
%text(102.35,4.92,'\downarrow','Fontsize',13,'fontweight','bold')
%text(102.35,5.04,'Optimized Apogee','fontweight','bold')

plot(itstore,x6s./xsol(6),'k');
plot(itstore,x7s./xsol(7),'k');

plot(itstore,x9s./xsol(9),'Color',color3);
plot(itstore,x10s./xsol(10),'Color',color3);
plot(itstore,x11s./xsol(11),'Color',color3);

plot(itstore,x13s./xsol(13),'Color',color1);
plot(itstore,x14s./xsol(14),'Color',color1);
plot(itstore,x15s./xsol(15),'Color',color1);
plot(itstore,x2s./xsol(2),'b')
plot(itstore,x5s./xsol(5),'Color',color2)
ylabel('$\frac{DIM_{iteration}}{DIM_{optimized}}$','Interpreter','latex','FontSize',24)
%axis([0 120 0 5.5])
yyaxis right
plot(itstore,fstore,'r:','LineWidth',4);

hleg=legend('Nosecone Geometry','Body Tubes','Couplers','Forward Fins','Aft Fins','Apogee','location','NorthWest');
htitle=get(hleg,'Title');
set(htitle,'String','Dimension Groups');
get(htitle)
hleg.NumColumns=4;
xlabel('Iteration Number')
ylabel('Predicted Apogee [m]','Color','r')
set(gca,'ycolor','r') 

title('Convergence of Rocket Dimensions to Maximize Altitude')
grid on
hold off
% Launch sim
[scoobertdoobert,tgraph,hgraph]=FminLaunchSimulation(xsol);

figure(2);

hold on

plot(tgraph,hgraph,'r','displayname','Sustainer: MATLAB Model','linewidth',1)
%plot(x2,height2,'b',D,'Booster: MATLAB Model',L,1)
%colortri = [0 .6 0];
%plot(nan,nan,'^','color',colortri,'MarkerSize',13);
%plot(8.39,277.8,'^','color',colortri,'MarkerSize',16);
%plot(15.98,1044,'^','color',colortri,'MarkerSize',16);
%plot(28.94,839.6,'^','color',colortri,'MarkerSize',16);

title('MATLAB Flight Model Verification','Fontsize',14)
xlabel('Time (s)','fontsize',14)
ylabel('Height (m)','fontsize',14)
%axis([0 150 0 1200])
leg = legend('Sustainer: MATLAB Model','Sustainer: OpenRocket','Booster: MATLAB Model','Booster: OpenRocket','Flight Data','Parachute Deployment');
set(leg,'fontsize',11)
grid minor
hold off
out=table(dNames',xsol');
%xsol'
%dNames'
1/fsol
end




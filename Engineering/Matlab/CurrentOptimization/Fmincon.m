function [Part,history,searchdir] = Fmincon
%All units are SI unless otherwise stated

Part(1,:)=struct('name','Nosecone','material','CarbonFiber','mass',[],'dims',...
        {struct('dimName','Length','lowBounds',0.1,'initGuess',0.24,'upBounds',0.3),...
        struct('dimName','ShoulderLength','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct([]),struct([])});

Part(2,:)=struct('name','Ebay Coupler','material','CarbonFiber','mass',[],'dims',...
        struct('dimName','Length','lowBounds',0.02,'initGuess',0.135,'upBounds',0.5));

Part(3,:)=struct('name','Electronics','material',[],'mass',0.20,'dims',... %this mass is a complete guess
        struct('dimName','CruiseTime','lowBounds',0.1,'initGuess',1.0,'upBounds',2));

Part(4,:)=struct('name','Sustainer Bodytube','material','CarbonFiber','mass',[],'dims',...
        struct('dimName','Length','lowBounds',0.45,'initGuess',0.46,'upBounds',0.7));

Part(5,:)=struct('name','Sustainer Fins','material','FiberGlass','mass',[],'dims',...
        {struct('dimName','RootChord','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct('dimName','TipChord','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct('dimName','SemiSpan','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct('dimName','SweepLength','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7)});

Part(6,:)=struct('name','Sustainer Motor','material','I204','mass',0.349,'dims',...
        struct('dimName','Overhang','lowBounds',0,'initGuess',0.002,'upBounds',0.01));

Part(7,:)=struct('name','Staging Coupler','material','CarbonFiber','mass',[],'dims',...
        struct('dimName','Length','lowBounds',0.02,'initGuess',0.135,'upBounds',0.5));

Part(8,:)=struct('name','Booster Bodytube','material','CarbonFiber','mass',[],'dims',...
        struct('dimName','Length','lowBounds',0.49,'initGuess',0.5,'upBounds',0.7));

Part(9,:)=struct('name','Booster Fins','material','FiberGlass','mass',[],'dims',...
        {struct('dimName','RootChord','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct('dimName','TipChord','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct('dimName','SemiSpan','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7),...
        struct('dimName','SweepLength','lowBounds',0.1,'initGuess',0.31,'upBounds',0.7)});

Part(10,:)=struct('name','Booster Motor','material','H340','mass',0.391,'dims',...
        struct('dimName','Overhang','lowBounds',0,'initGuess',0.0359,'upBounds',0.07));






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

[xsol,fsol,exitflag,output]= fmincon(fun,D(:,2),A,b,Aeq,beq,D(:,1),D(:,3),nonlincon,options);
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
    tseperation = 1.9;  % booster seperation

    %Initial Vectors
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
        [a, d] = FminGetAcceleration(t,v,h,x); % get current acceleration
        v = v + dt*a ; % update velocity
        h = h + dt*v ; % update height

        if h < 0
            break
        end
    end

    oneoverh=1/max(height);


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
text(102.35,1.12,'\downarrow','Fontsize',13,'fontweight','bold')
text(102.35,1.24,'Convergence','fontweight','bold')
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
axis([0 120 0 5.5])
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
tgraph
hgraph
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

xsol(1)
fsol
end




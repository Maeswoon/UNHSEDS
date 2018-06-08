function [history,searchdir] = Fmincon
x1  = .24   ;  %Length of the nosecone
x2  = .31   ;  %Length of the shoulder
x3  = .46   ;  %Length of the sustainer bodytube
x4  = .135  ;  %Length of the staging coupler
x5  = .50   ;  %Length of the booster bodytube
x6  = .002  ;  %Length of the sustainer motorhang
x7  = .0359 ;  %Length of the booster motorhang
x8  = .13   ;  %Fin Root Chord, Cr
x9  = .015  ;  %Fin Tip Chord, Ct
x10 = .05   ; %Fin Semi-Span, Height, Ss
x11 = .1    ; %Fin Root Leading Edge to Fin Tip Leading Edge,Xr 
x12 = .115  ; %Fin Root Chord, Cr2, Booster
x13 = .06   ; %Fin Tip Chord, Ct2, Booster
x14 = .048  ; %Fin Semi-Span, Height, Ss2, Booster
x15 = .045  ; %Fin Root Leading Edge to Fin Tip Leading Edge, Xr2, Booster
x16 = 1     ; %Cruise Time
% Set up shared variables with OUTFUN
history.x = [];
history.fval = [];
searchdir = [];
fstore= [];

% call optimization
x0=[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16];

%[cal,blah]=nlcon(x);
options=optimoptions(@fmincon,'OutputFcn',@outfun);

%Bounds of each variable
x1b  = [.1,.3];   %Length of the nosecone
x2b  = [.1,.7];   %Length of the shoulder
x3b  = [.45,.7];  %Length of the sustainer bodytube
x4b  = [.02,.5];  %Length of the staging coupler
x5b  = [.49,.7];  %Length of the booster bodytube
x6b  = [0,.01];   %Length of the sustainer motorhang
x7b  = [0,.07];   %Length of the booster motorhang
x8b  = [.04,.2];  %Fin Root Chord, Cr
x9b  = [.005,.2]; %Fin Tip Chord, Ct
x10b = [.02,.2];  %Fin Semi-Span, Height, Ss
x11b = [.01,.2];  %Fin Root Leading Edge to Fin Tip Leading Edge,Xr 
x12b = [.04,.2];  %Fin Root Chord, Cr2, Booster
x13b = [.005,.2]; %Fin Tip Chord, Ct2, Booster
x14b = [.02,.2];  %Fin Semi-Span, Height, Ss2, Booster
x15b = [.01,.2];  %Fin Root Leading Edge to Fin Tip Leading Edge, Xr2, Booster

lb = [x1b(1),x2b(1),x3b(1),x4b(1),x5b(1),x6b(1),x7b(1),x8b(1),x9b(1),x10b(1),x11b(1),x12b(1),x13b(1),x14b(1),x15b(1),];
ub = [x1b(2),x2b(2),x3b(2),x4b(2),x5b(2),x6b(2),x7b(2),x8b(2),x9b(2),x10b(2),x11b(2),x12b(2),x13b(2),x14b(2),x15b(2),];


A=[];
b=[];
Aeq=[];
beq=[];
it=0;
fun=@FminLaunchSimulation;
nonlincon=@supernonlincon;

%Fmincon function
[xsol,fsol,exitflag,output]= fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlincon,options);






% Index Values for Graph
 function stop = outfun(x,optimValues,state)
     stop = false;
 
     switch state
         case 'init'
             hold on
         case 'iter'
           it=it+1;

         % Concatenate current point and objective function
         % value with history. x must be a row vector.
           %history.fval = [history.fval; optimValues.fval];
           %history.x = [history.x; x];
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
         % Concatenate current search direction with 
         % searchdir.
           %searchdir = [searchdir;... 
           %             optimValues.searchdirection'];
           %plot(it,x(1)/0.1016,'x',it,x(2)/0.1015,'o');
           
         % Label points with iteration number and add title.
         % Add .15 to x(1) to separate label from plotted 'o'
           %text(x(1)+.15,x(2),... 
           %     num2str(optimValues.iteration));
           %title('Sequence of Points Computed by fmincon');
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
end
%To Do:
%Make masses dependent on x for stability and GetMass
%Get correct constants for stability calc
%Have clegg change GetDrag to account for two different fin sets
%Limit bounds more
%Double check cp cg calc with barrowman
%Vary cruise time from .3 to 4 seconds
%Determine best ration of impulse between two engines
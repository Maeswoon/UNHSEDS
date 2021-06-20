function [history,searchdir] = Fmincon
%x1=Lnosecone, x2=Lshoulder, x3=Lsustbodytube, 
%x4=Lstagingcoupler, x5=Lboosterbodytube,x6=sustmotorhang,
%x7=boostmotorhang, x8=Cr, x9=Ct, x10=Ss, x11=Xr, x12=Cr2,
%x13=Ct2, x14=Ss2, x15=Xr2 #2 is booster

% Set up shared variables with OUTFUN
history.x = [];
history.fval = [];
searchdir = [];
fstore= [];
% call optimization
x0=[.24,.31,.46,.135,.50,.002,.0359,.13,.015,.05,.1,.115,.06,.048,.045];
%[cal,blah]=nlcon(x);
options=optimoptions(@fmincon,'OutputFcn',@outfun);
lb=[0.1,.1,.45,.02,.49,0,0,.04,.005,.02,.01,.04,.005,.02,.01];
ub=[0.3,.7,.7,.5,.7,.01,.07,.2,.2,2,.2,.2,.2,.2,.2];
A=[];
b=[];
Aeq=[];
beq=[];
it=0;
fun=@FminLaunchSimulation;

nonlincon=@supernonlincon;

[xsol,fsol,exitflag,output]= fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlincon,options);

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
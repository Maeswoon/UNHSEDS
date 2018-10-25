clear all;
close all;

% ~ AETHER4 Launch Simulation ~

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
dt          = 0.01; % time step
tstop       = 160;  % endtime
tseperation = 3.9;  % booster seperation

%Initial Vectors
height       = []; % Sustainer height
velocity     = []; % Sustainer velocity
acceleration = []; % Sustainer acceleration
drag         = []; % Sustainer drag
sfd          = []; % Skin Friction Drag
pressured    = []; % Pressure Drag
based        = []; % Base Drag
x            = []; % Used to keep track of time

for t = tstart:dt:tstop
    
    height(end + 1)       = h;
    velocity(end + 1)     = v;
    acceleration(end + 1) = a;
    drag(end + 1)         = d;
    sfd(end + 1)          = sf;
    pressured(end + 1)    = pd;
    based(end + 1)        = bd;
    x(end + 1)            = t;
    [a, d] = GetAcceleration(t,v,h); % get current acceleration
    v = v + dt*a ; % update velocity
    h = h + dt*v ; % update height
    
    if h < 0
        break
    end
end

% Booster (Starts Tracking at Seperation)
% Initial Values and Vectors for Booster Seperation

h = height(390); %(tseperation/dt);
v = velocity(390); %(tseperation/dt);
a = acceleration(390); %(tseperation/dt);
height2       = []; %height((tseperation-dt)/dt);
velocity2     = []; %velocity((tseperation-dt)/dt);
acceleration2 = []; %acceleration((tseperation-dt)/dt);
drag2         = []; %drag((tseparation-dt)/dt)
sfd2          = []; % Skin Friction Drag
pressured2    = []; % Pressure Drag
based2        = []; % Base Drag
x2 = []; %x((tseperation-dt)/dt);

for t = tseperation+dt:dt:tstop
    height2(end + 1)       = h;
    velocity2(end + 1)     = v;
    acceleration2(end + 1) = a;
    drag2(end + 1)         = d;
    sfd2(end + 1)          = sf;
    pressured2(end + 1)    = pd;
    based2(end + 1)        = bd;
    x2(end + 1)            = t;
    [a, d] = GetAcceleration2(v,h); % get current acceleration
    v = v + dt * a ; % update velocity
    h = h + dt * v ; % update height
   
    if h < 0
        break
    end
end

% Open Rocket Data
Aether3opendata = 'SustainerOpenRocket.csv';
Aether3opendataboost = 'BoosterOpenRocket.csv';
g = linspace(0,4,20);
TimeOpenSust    = xlsread(Aether3opendata,'A75:A532')-2.3;
TimeOpenBoost   = xlsread(Aether3opendataboost,'A1:A190')-1;
HeightOpenSust  = xlsread(Aether3opendata,'B75:B532')-140;
HeightOpenBoost = xlsread(Aether3opendataboost,'B1:B190')-30;
%TimeOpenSust2 = TimeOpenSust(end-20:end)+g;
%TimeOpenSust = horzcat(TimeOpenSust(1:end-20) + TimeOpenSust2

% Experimental Data
Aether4boosterexperimental = 'Aether4 Flight Data.csv';


TimeExperimentalBoost    = xlsread(Aether4boosterexperimental,'E66:E1284');
HeightExperimentalBoost  = xlsread(Aether4boosterexperimental,'K66:K1284');
TimeExperimentalBoost = TimeExperimentalBoost(1:1021);
HeightExperimentalBoost = HeightExperimentalBoost(1:1021);


figure;
subplot(3,1,1)
hold on
xpurp = x(1:230);
heightpurp = height(1:230);
x = x(231:end);
height = height(231:end);

plot(xpurp,heightpurp,'Color',[.5 0 .5],D,'Full Rocket',L,2)
plot(x,height,'r',D,'Sustainer',L,1)
plot(x2,height2,'b',D,'Booster',L,1)
title('MATLAB Flight Model')
% xlabel('Time (s)')
ylabel('Height (m)','fontsize',12)
axis([0 20 0 1200])
legend('show')
grid minor

subplot(3,1,2)
hold on
velocitypurp = velocity(1:230);
velocity = velocity(231:end);

plot(xpurp,velocitypurp,'Color',[.5 0 .5],D,'Full Rocket',L,2)

plot(x,velocity,'r',D,'Sustainer',L,1)
plot(x2,velocity2,'b',D,'Booster',L,1)
%title('MATLAB Flight Model')
% xlabel('Time (s)')
ylabel('Velocity (m/s)','fontsize',12)
axis([0 20 -100 200])
% legend('show')
grid minor

subplot(3,1,3)
hold on

accelerationpurp = acceleration(1:230);
acceleration = acceleration(231:end);

plot(xpurp,accelerationpurp,'Color',[.5 0 .5],D,'Full Rocket',L,2)

plot(x,acceleration,'r',D,'Sustainer Acceleration',L,1)
plot(x2,acceleration2,'b',D,'Booster Acceleration',L,1)
%title('Acceleration vs Time')
xlabel('Time (s)','fontsize',13)
ylabel('Acceleration (m/s^2)','fontsize',12)
axis([0 20 -100 200])
%  legend('show')
grid minor

figure;
hold on
plot(x,height,'r',D,'Sustainer: Matlab',L,1)
plot(TimeOpenSust,HeightOpenSust,'r--',D,'Sustainer: OpenRocket',L,1)
plot(x2,height2,'b',D,'Booster: Matlab',L,1)
plot(TimeOpenBoost,HeightOpenBoost,'b--',D,'Booster: OpenRocket',L,1)
plot(TimeExperimentalBoost,HeightExperimentalBoost,'k',D,'Booster: Experimental',L,1)

title('Height vs Time')
xlabel('Time (s)','fontsize',15)
ylabel('Height (m)','fontsize',15)
legend('show')
grid minor

% figure
% plot(x,drag,'r-',D,'Sustainer',L,1)
% hold on
% plot(x2,drag2,'b-',D,'Booster',L,1)
% title('F_D vs Time')
% xlabel('Time (s)')
% ylabel('Force of Drag (N)')
% legend('show')
% grid minor













% figure;
% subplot(3,1,1)
% hold on
% plot(x,height,'r',D,'Sustainer',L,1)
% plot(x2,height2,'b',D,'Booster',L,1)
% title('Height vs Time')
% % xlabel('Time (s)')
% ylabel('Height (m)')
% axis([0 25 0 1500])
% legend('show')
% grid minor
% 
% subplot(3,1,2)
% hold on
% plot(x,velocity,'r',D,'Sustainer Velocity',L,1)
% plot(x2,velocity2,'b',D,'Booster Velocity',L,1)
% title('Velocity vs Time')
% % xlabel('Time (s)')
% ylabel('Velocity (m/s)')
% axis([0 25 -200 600])
% % legend('show')
% grid minor
% 
% subplot(3,1,3)
% hold on
% plot(x,acceleration,'r',D,'Sustainer Acceleration',L,1)
% plot(x2,acceleration2,'b',D,'Booster Acceleration',L,1)
% title('Acceleration vs Time')
% xlabel('Time (s)')
% ylabel('Acceleration (m/s^2)')
% axis([0 25 -200 400])
% % legend('show')
% grid minor
% 
% figure;
% hold on
% plot(x,height,'r',D,'Sustainer',L,1)
% %plot(TimeOpenSust,HeightOpenSust,'r--',D,'OpenRocket Sustainer',L,1)
% 
% plot(x2,height2,'b',D,'Booster',L,1)
% %plot(TimeOpenBoost,HeightOpenBoost,'r',D,'OpenRocket Booster',L,1)
% 
% title('Height vs Time')
% xlabel('Time (s)')
% ylabel('Height (m)')
% legend('show')
% grid minor
% 
% figure
% plot(x,drag,'r-',D,'Sustainer',L,1)
% hold on
% plot(x2,drag2,'b-',D,'Booster',L,1)
% title('F_D vs Time')
% xlabel('Time (s)')
% ylabel('Force of Drag (N)')
% legend('show')
% grid minor




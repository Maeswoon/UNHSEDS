clear all;
close all;

% ~ BFR Launch Simulation ~

L  = 'linewidth';
D  = 'displayname';
a  = 0;             % initial acceleration
v  = 0;             % initial velocity
h  = .5;            % initial height
d  = 0;             % initial drag
sf = 0;             % initial skin friction drag
pd = 0;             % initial pressure drag
bd = 0;             % initial base drag
tstart      = 0;    % start time
dt          = 0.0001; % time step
tstop       = 200;  % endtime


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
    
    if h < -.5
        break
    end
end

figure(1) 
subplot(3,1,1)
plot(x,height,'k','LineWidth',1.3)
ylim([0,3250])
ylabel('Height (m)')
title('Predicted Flight Path of Hybrid Rocket')

subplot(3,1,2)
plot(x,velocity,'b','LineWidth',1.3)
ylim([-50,225])
ylabel('Velocity (m/s)')

subplot(3,1,3)
plot(x,acceleration,'r','LineWidth',1.3)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
ylim([-30,70])
%%
close all
figure(2)
subplot(3,1,1)
plot(x,height,'k','LineWidth',1.5)
hold on
plot(28,3036,'o')
text(22,2500,'Apogee = 3035 meters')
ylim([0,3250])
ylabel('Height (m)')
xlim([0,40])
plot([11,11],[0,3250],'g','LineWidth',1.1)
text(11.5,1000,'Hybrid Engine Cutoff')


subplot(3,1,2)
plot(x,velocity,'b','LineWidth',1.5)
hold on
plot([11,11],[-50,225],'g','LineWidth',1.1)
%text(11.5,0,'Hybrid Engine Cutoff')
ylim([-50,225])
ylabel('Velocity (m/s)')
xlim([0,40])

subplot(3,1,3)
plot(x,acceleration,'r','LineWidth',1.5)
hold on
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
xlim([0,40])
plot([11,11],[-20,40],'g','LineWidth',1.1)
%text(11.5,10,'Hybrid Engine Cutoff')






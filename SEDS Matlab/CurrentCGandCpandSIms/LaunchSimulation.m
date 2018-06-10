
%Simulation code looks good, need to make sure the functions being used are
%accurate

L = 'linewidth';
D = 'displayname';


a = 0;
v = 0;               % initial velocity
h = 0;               % initial height
tstart = 0;          % start time
dt = 0.01;           % time step
tstop = 120;           % endtime
tseperation = 2.3;     % booster seperation

%Initial Vectors
height       = []; % Sustainer height
velocity     = []; % Sustainer velocity
acceleration = []; % Sustainer acceleration
x = [];            % Used to keep track of time

for t = tstart:dt:tstop
    
    height(end+1)       = h;
    velocity(end+1)     = v;
    acceleration(end+1) = a;
    x(end+1)            = t;
    a = GetAcceleration(t,v); % get current acceleration
    v = v + dt * a ; % update velocity
    h = h + dt * v ; % update height
    
    if h < 0
        break
    end
end

% Booster (Starts Tracking at Seperation)
% Initial Values and Vectors for Booster Seperation

h = height(tseperation/dt);
v = velocity(tseperation/dt);
a = acceleration(tseperation/dt);
height2       = [height((tseperation-dt)/dt)];
velocity2     = [velocity((tseperation-dt)/dt)];
acceleration2 = [acceleration((tseperation-dt)/dt)];
x2 = [x((tseperation-dt)/dt)];

for t = tseperation+dt:dt:tstop
    
    height2(end+1)       = h;
    velocity2(end+1)     = v;
    acceleration2(end+1) = a;
    x2(end+1)            = t;
    a = GetAcceleration2(v); % get current acceleration
    v = v + dt * a ; % update velocity
    h = h + dt * v ; % update height
    
    if h < 0
        break
    end
end

figure;
subplot(3,1,1)
hold on
plot(x,height,'b',D,'Sustainer',L,1)
plot(x2,height2,'r',D,'Booster',L,1)
title('Height vs Time')
xlabel('Time (s)')
ylabel('Height (m)')
axis([0 25 0 3000])
legend('show')
grid minor

subplot(3,1,2)
hold on
plot(x,velocity,'b',D,'Sustainer Velocity',L,1)
plot(x2,velocity2,'r',D,'Booster Velocity',L,1)
title('Velocity vs Time')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
axis([0 25 -200 600])
% legend('show')
grid minor

subplot(3,1,3)
hold on
plot(x,acceleration,'b',D,'Sustainer Acceleration',L,1)
plot(x2,acceleration2,'r',D,'Booster Acceleration',L,1)
title('Acceleration vs Time')
xlabel('Time (s)')
ylabel('Acceleration (m/s)')
axis([0 25 -200 400])
% legend('show')
grid minor

figure;
hold on
plot(x,height,'b',D,'Sustainer Height',L,1)
plot(x2,height2,'r',D,'Booster Height',L,1)
title('Height vs Time')
xlabel('Time (s)')
ylabel('Height (m)')
legend('show')
grid minor

% plot(x,height,x,velocity,x,acceleration)

% Main Events
BoosterCutoff = .7;
SustainerIgnition = 1;
SustainerCutoff = 2.7;


%plot(vline(BoosterCutoff,'g'),vline(SustainerIgnition,'r'),vline(SustainerCutoff,'b'))


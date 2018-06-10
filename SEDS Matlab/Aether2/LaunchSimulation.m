
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


figure;
subplot(3,1,1)
hold on
plot(x,height,'b',D,'Sustainer',L,1)
title('Height vs Time')
xlabel('Time (s)')
ylabel('Height (m)')
axis([0 25 0 3000])
legend('show')
grid minor

subplot(3,1,2)
hold on
plot(x,velocity,'b',D,'Sustainer Velocity',L,1)
title('Velocity vs Time')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
axis([0 25 -200 600])
% legend('show')
grid minor

subplot(3,1,3)
hold on
plot(x,acceleration,'b',D,'Sustainer Acceleration',L,1)
title('Acceleration vs Time')
xlabel('Time (s)')
ylabel('Acceleration (m/s)')
axis([0 25 -200 400])
% legend('show')
grid minor

figure;
hold on
plot(x,height,'b',D,'Sustainer Height',L,1)
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


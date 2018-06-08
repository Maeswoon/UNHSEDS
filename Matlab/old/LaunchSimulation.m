v = 0;               % initial velocity
h = 0;               % initial height
tstart = 0;          % start time
dt = 0.01;           % time step
tstop = .6;          % endtime

height       = [];
velocity     = [];
acceleration = [];

for t = tstart:dt:tstop
    a = GetAcceleration(t,v); % get current acceleration

    h = h + dt * v ; % update height
    v = v + dt * a ; % update velocity
    height(end+1)       = h;
    velocity(end+1)     = v;
    acceleration(end+1) = a;
 
end
t= linspace(tstart,tstop,61);
plot(t,height)
clear all;
close all;

% ~ AETHER6 Launch Simulation ~

L  = 'linewidth';
D  = 'displayname';
a  = 0;             % initial acceleration
v  = 0;             % initial velocity
h  = .5;           % initial height
d  = 0;             % initial drag
sf = 0;             % initial skin friction drag
pd = 0;             % initial pressure drag
bd = 0;             % initial base drag
tstart      = 0;    % start time
dt          = 0.01; % time step
tstop       = 100;  % endtime


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


plot(x,height)






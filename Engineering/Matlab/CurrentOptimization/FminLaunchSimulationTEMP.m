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


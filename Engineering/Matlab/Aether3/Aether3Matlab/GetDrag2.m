function [drag] = GetDrag2 (v,h) %Need to incorporate fins, supersonic and the change in rho with altitude and such
% Drag for booster after seperation!
% calculate a quadratic drag

%THIS NEEDS TO BE FIXED
rho = 1.217*exp(-h/8500);   % Atmosphere Equation
if v < 0
    D = .3;
    k = .9;
    drag = -k * .5 * rho * v^2 * pi/4 *D^2;
else
    k = 1;
    D = .0574; % (m) Diameter of Nosecone
    drag = k * .5 * rho * v^2 * pi/4 *D^2;
end         
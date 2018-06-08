function [drag] = GetDrag2 (v) %Need to incorporate fins, supersonice and the change in rho with altitude and such

% calculate a quadratic drag
  
if v < 0
    D = .3;
    k = 1.4;
    drag = -k * .5 * 1.225 * v^2 * pi/4 *D^2;
else
    k = 1;
    D = .0435; % (m) Diameter of Nosecone
    drag = k * .5 * 1.225 * v^2 * pi/4 *D^2;
end         
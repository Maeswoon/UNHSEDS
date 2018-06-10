function [drag] = GetDrag (v) %Need to incorporate fins, supersonice and the change in rho with altitude and such
% calculate a quadratic drag
D = .0435;   % (m) Diameter of Nosecone
% NB ! When v is + ve ( up ) drag should be + ve ( down )
k =.6;
if v < 0
    D = .3;
    k = 1.4;
    drag = -k * .5 * 1.225 * v^2 * pi/4 *D^2;
else
    drag = k * .5 * 1.225 * v^2 * pi/4 *D^2;
end         
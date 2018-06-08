function [drag] = GetDrag (v)
% calculate a quadratic drag
D = .0435;   % (m) Diameter of Nosecone
% NB ! When v is + ve ( up ) drag should be + ve ( down )
k =.6;
drag = k * .5 * 1.225 * v^2 * pi/4 *D^2;
end         
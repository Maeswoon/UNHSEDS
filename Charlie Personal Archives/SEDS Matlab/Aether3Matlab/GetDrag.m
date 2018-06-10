function [drag] = GetDrag (v,h,t) %Need to incorporate fins, supersonic and the change in rho with altitude and such
% calculate a quadratic drag for the sustainer and booster, carries to
% sustainer then to falling down. NEEDS TO BE FIXED
D = .0574;   % (m) Diameter of Nosecone
% NB ! When v is + ve ( up ) drag should be + ve ( down )
rho = 1.217*exp(-h/8500);
if v < 0
    D = .3;
    k = 1.2;
    drag = -k * .5 * rho * v^2 * pi/4 *D^2;
    if h<300
        D=.74;
        k=1;
        drag = -k * .5 * rho * v^2 * pi/4 *D^2;
    end
else
    if t>2.3
        k =.55;
        drag = k * .5 * rho * v^2 * pi/4 *D^2;
    else
        k = .8;
        drag = k * .5 * rho * v^2 * pi/4 *D^2;
    end
end
end         
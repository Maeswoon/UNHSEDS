function [drag] = GetDrag (v,h,t)
% calculate total drag for the sustainer and booster, carries to
% sustainer then to recovery.
% NB ! When v is + ve (up) drag should be + ve (down)

% ~ AETHER4 ~

pi = 3.14;
mu = 1.79e-5;
rho = 1.217*exp(-h/8500);
kv = mu/rho;

if v >= 0
    if t <= 2.3
        l = 1.25; % length of full rocket (m)
    elseif t > 2.3
        l = 0.80; % length of sustainer body tube (m)
    end
    
    % ~ SKIN FRICTION DRAG ~
    D = .0574;   % (m) Diameter of Nosecone
    r = D/2;
    Re = (v*l)/kv;
    Rs = 60e-6; % roughness
    Rcrit = 51*(Rs/l)^-1.039;
    
    if Re < 1.0e4
        CDsf = 1.48e-2;
    elseif Re > 1.0e4 && Re < Rcrit
        CDsf = 1/(1.50*log(Re) - 5.6)^2;
    elseif Re > Rcrit
        CDsf = 0.032*(Rs/l)^0.2;
        
    end
    
    fb = l/D; % fineness ratio
    t = 0.003; % fin thickness
    c = 0.056; % aerodynamic cord length
    finbase = 0.056;
    finheight = 0.126;
    finarea_sf = 0.5*finbase*finheight;
    fin_totalarea_sf = finarea_sf*12;
    bodytube_area = 2*pi*r*l;   % surface area
    crosssection_area = pi*r^2; % cross-sectional area
    ref_area_sf = fin_totalarea_sf + bodytube_area;
    
    % Compressibility Effects
    a = 343; %m/s
    M = v/a;
    if M < 0.9
        Cfc = CDsf*(1 - 0.1*M^2);
    elseif M >= 0.9
        Cfc = CDsf/((1 + 0.15*M^2)^0.58);
    end
    
    CDsf = Cfc*((1 + 1/(2*fb))*(bodytube_area) + (1 + (2*t)/c)*fin_totalarea_sf)/ref_area_sf;
    
    Fdrag_sf = CDsf*(1/2)*rho*v^2*(ref_area_sf);
    
    % ~ PRESSURE DRAG ~
    % Nose Cone Pressure Drag
    % if M is less than 0.9...
    % CDpd_nc = 0.05; % ogive nose cone
    CDpd_nc = 0;
    Fpd_nosecone = CDpd_nc*(1/2)*rho*v^2*(crosssection_area);
    
    % Fin Pressure Drag
    LEA = 61.2; % leading edge angle
    if M < 0.9
        CDpd_fins = ((1 - M^2)^(-0.417) - 1)*cosd(LEA)^2;
    elseif M > 0.9 && M < 1
        CDpd_fins = (1 - 1.785*(M - 0.9))*cosd(LEA)^2;
    elseif M > 1.0
        CDpd_fins = (1.214 - 0.502/(M^2) + 0.1095/(M^4))*cosd(LEA)^2;
    end
    
    Fpd_fins = CDpd_fins*(1/2)*rho*v^2*(finarea_sf);
    
    Fpd_fins = Fpd_fins*6;
    Fdrag_pd = Fpd_nosecone + Fpd_fins;
    
    % ~ BASE DRAG ~
    
    if M < 1
        CDbd = 0.12 + 0.13*M^2 ;
    elseif M > 1
        CDbd = 0.25/M;
    end
    
    Fdrag_bd = CDbd*(1/2)*rho*v^2*(crosssection_area);
    
    % ~ TOTAL DRAG ~
    drag = Fdrag_sf + Fdrag_pd + Fdrag_bd;
        
        
    
% ~ RECOVERY ~
elseif v < 0
    D = 0.30; % diameter of parachute (m)
    k = 1.0;
    drag = -k * 0.5 * rho * v^2 * pi/4 * D^2;

    if h < 150
        D = 0.75;
        k = 1.0;
        drag = -k * 0.5 * rho * v^2 * pi/4 * D^2;
        
    end
    
end

end      
        
           
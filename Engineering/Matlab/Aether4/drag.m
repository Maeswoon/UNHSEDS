
%% Drag
clear all;
close all;

L = 'linewidth';
D = 'displayname';

% COMPETITION ROCKET
% alt = [0 200 400 600 800 1000 1200 1400 1600 1800 2000 2200 2400 2600 2800 3000]; % altitude (m)
% T = [15 13.7 12.4 11.1 9.8 8.5 7.2 5.9 4.6 3.3 2 0.7 -0.59 -1.89 -3.19 -4.49] + 273; % temperature of air (K)
% g = [9.807 9.806 9.805 9.805 9.804 9.804 9.803 9.802 9.802 9.801 9.8 9.8 9.799 9.799 9.798 9.797]; % force of gravity (m/s^2)
% mu = [1.79e-5 1.78e-5 1.775e-5 1.769e-5 1.763e-5 1.756e-5 1.75e-5 + additional values***]; % dynamic viscosity
% rho = [1.225 1.202 1.179 1.156 1.134 1.112 1.09 1.069 1.048 1.027 1.007 0.987 0.967 0.947 0.928 0.909]; % density of air (kg/m^3)
% v = mu/rho; % kinematic viscosity
% V = []; % velocity (m/s)

% AETHER4
h = [0 200 400 600 800 1000 1200]; % altitude (m)
T = [15 13.7 12.4 11.1 9.8 8.5 7.2] + 273; % temperature of air (K)
g = [9.807 9.806 9.805 9.805 9.804 9.804 9.803]; % force of gravity (m/s^2)
mu = 1.79e-5; % dynamic viscosity (N-s/m^2)
% dynamic viscosity found using...https://www.engineeringtoolbox.com/air-absolute-kinematic-viscosity-d_601.html
rho = [1.225 1.225 1.225 1.225 1.225 1.225 1.225]; % density of air (kg/m^3)
kv = mu./rho; % kinematic viscosity (m^2/s)
% V = [0.00000000001 102 155 165 125 86 44]; % velocity (m/s)
pi = 3.14;
v = [1 102 155 165 125 86 44]; % velocity (m/s)
l = 1.425; % characteristic dimension (m) length
D = .0574; % diameter (m)
r = D/2; % radius (m)
% l = 0.0571; % characteristic dimension (m) diameter
Re = (v*l)./kv; 
figure
plot(h,Re,'b',L,1)
title('Reynolds Number vs Altitude (Aether3)')
xlabel('Altitude (m)')
ylabel('Reynolds Number')
grid minor


%% OPEN ROCKET DRAG CALCS

%% Skin Friction
Rs = 200e-6; % roughness "Incorrectly sprayed aircraft paint"
Rcrit = 51*(Rs/l)^-1.039;

for i = 1:length(h)
    if Re(i) < 1.0e4
        CDsf(i) = 1.48e-2;
    elseif Re(i) > 1.0e4 && Re(i) < Rcrit
        CDsf(i) = 1/(1.50*log(Re(i)) - 5.6)^2;
    elseif Re(i) > Rcrit
        CDsf(i) = 0.032*(Rs/l)^0.2;
    end
end
    
fb = l/D; % fineness ratio
t = 0.003; % fin thickness
c = 0.056; % aerodynamic cord length
finbase = 0.056;
finheight = 0.126;
finarea_sf = 0.5*finbase*finheight;
fin_totalarea_sf = finarea_sf*12;
bodytube_area = 2*pi*r*l;
crosssection_area = pi*r^2;
ref_area_sf = fin_totalarea_sf + bodytube_area;

% Compressibility Effects
a = 343; %m/s
M = v./a;
for i = 1:length(h)
    if M(i) < 0.9
        Cfc(i) = CDsf(i)*(1 - 0.1*M(i)^2);
    elseif M(i) >= 0.9
        Cfc(i) = CDsf(i)/((1 + 0.15*M(i)^2)^0.58);
    end
end

for i = 1:length(h)
    CDsf(i) = Cfc(i)*((1 + 1/(2*fb))*(bodytube_area) + (1 + (2*t)/c)*fin_totalarea_sf)/ref_area_sf;
end

for i = 1:length(h)
    Fdrag_sf(i) = CDsf(i)*(1/2)*rho(i)*v(i)^2*(ref_area_sf);
end

%% PRESSURE DRAG 

% Nose Cone Pressure Drag
% if M is less than 0.9...
CDpd_nc = [0.05 0.05 0.05 0.05 0.05 0.05 0.05]; % ogive nose cone
for i = 1:length(h)
    Fpd_nosecone(i) = CDpd_nc(i)*(1/2)*rho(i)*v(i)^2*(crosssection_area);
end

% Fin Pressure Drag
LEA = 61.2; % leading edge angle
for i = 1:length(h)
    if M(i) < 0.9
        CDpd_fins(i) = ((1-M(i).^2)^(-.417)-1)*cosd(LEA)^2;
    elseif M(i) > 0.9 && M(i) < 1 
        CDpd_fins(i) = (1-1.785*(M(i)-.9))*cosd(LEA)^2;
    elseif M(i) > 1.0
        CDpd_fins(i) = (1.214-.502/(M^2)+.1095/(M^4))*cosd(LEA)^2;
    end
end

for i = 1:length(h)
    Fpd_fins(i) = CDpd_fins(i)*(1/2)*rho(i)*v(i)^2*(finarea_sf);
end

Fpd_fins = Fpd_fins*6;
Fdrag_pd = Fpd_nosecone + Fpd_fins;

%% BASE DRAG

for i = 1:length(h)
    if M(i) < 1 
        CDbd(i) = 0.12 + 0.13*M(i).^2 ;
    elseif M(i) > 1
        CDbd(i) = 0.25/M(i);
    end
end

for i = 1:length(h)
    Fdrag_bd(i) = CDbd(i)*(1/2)*rho(i)*v(i)^2*(crosssection_area);
end

%% Drag Forces vs Altitude
figure
subplot(3,1,1)
plot(h,Fdrag_sf,'b+-',L,1)
title('Skin Friction Drag vs Altitude (Aether4)')
xlabel('Altitude (m)')
ylabel('Force of Drag (N)')
grid minor
subplot(3,1,2)
plot(h,Fdrag_pd,'r+-',L,1)
title('Pressure Drag vs Altitude (Aether4)')
xlabel('Altitude (m)')
ylabel('Force of Drag (N)')
grid minor
subplot(3,1,3)
plot(h,Fdrag_bd,'k+-',L,1)
title('Base Drag vs Altitude (Aether4)')
xlabel('Altitude (m)')
ylabel('Force of Drag (N)')
grid minor

% Total Drag Force vs Altitude
for i = 1:length(h)
    FdragT(i) = Fdrag_sf(i) + Fdrag_pd(i) + Fdrag_bd(i);
end
figure
plot(h,FdragT,'m+-',L,1)
title('Total F_D vs Altitude (Aether4)')
xlabel('Altitude (m)')
ylabel('Force of Drag (N)')
grid minor



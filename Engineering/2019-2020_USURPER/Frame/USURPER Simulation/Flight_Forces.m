% Forces calculated on rocket
clear all
close all
clc
%% Calculations after ignition
% Force of weight
masswet=9.78; % kg (21.563 lb)
massdry=3.97; % kg (3.97 lb)
massvec=linspace(masswet,massdry);
accelgrav=9.81; % m/s^2
weight=massvec*accelgrav;

% Force of thrust
f_thrust= ; %get data from hotfire test!!!!!!!
accel1=f_thrust/massvec;

% Forces due to drag: nose cone, skin, base, and fin

% nose cone
cdnose=.15; %value chosen, we need to do more research!!!!!
rhoair=linspace(1.225,.9093); %density vector from 0 to 3000 meters kg/m^3
dia=7*.0254; % diameter of outside of rocket, meters
vel1= ; % m/s need to determine this thru physics and accel1 vec!!!!!!
drag_nose=.5*cdnose*rhoair*(pi*(dia^2)/4)*(vel1^2); %drag on nose, N

% skin friction force
length=2.15; % length of rocket in meters
dynvisc=1.198e-5;
Re1=(roeair*vel1*length)/dynvisc; % reynolds number, unitless
cfskin=1/((1.5*log(Re1)-5.6)^2); % friction coeff, unitless
cylsurf=pi*dia*length; % surface area outside of rocket, meters
finsurf= ; % surface area of one fin
fins=4; % number of fins on rocket
finsurftot= ; % surface area of all fins
totsurf=cylsurf+finsurftot; % total surface area of rocket
drag_skin=.5*cfskin*rhoair*totsurf*(vel1^2); % drag of skin friction, N

% base drag (vaccum created under rocket when combustion is over)
ltr=2.44; % overall length of rocket, meters
ln=.457; % length of nose cone, meters
db=.178; % diameter of body, meters
lb=1.98; % length of body, meters
lc=.102; % length of nozzle, meters
dd= .0762; % diameter of nozzle, meters
cdfb=(1+(60/(ltr/db)^3)+.0025*(lb/db))*((2.7*ln/db)+(4*lb/db)+(2*(1-(dd/db))*(lc/db)))*drag_skin;
cdbase=(.029*((dd/db)^3))/sqrt(cdfb); % drag coeff of base of rocket
drag_base=.5*cdbase*rhoair*(pi*(dia^2)/4)*(vel1^2); % drag of the base, N

% friction on fins (model as flat plates)
